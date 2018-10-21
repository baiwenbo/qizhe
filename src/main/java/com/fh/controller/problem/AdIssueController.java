package com.fh.controller.problem;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.qizhe.Audit;
import com.fh.entity.qizhe.Images;
import com.fh.entity.qizhe.ProjectAuditHelper;
import com.fh.service.problem.AdIssueService;
import com.fh.service.qizhe.QizheService;
import com.fh.service.system.user.UserService;
import com.fh.util.*;
import com.fh.util.redis.JiSuan;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 类名称：IssueController
 * 创建人：FH 
 * 创建时间：2017-05-27
 */
@Controller
@RequestMapping(value="/adIssue")
public class AdIssueController extends BaseController {
	
	String menuUrl = "adIssue/list.do"; //菜单地址(权限用)
	@Resource(name="adIssueService")
	private AdIssueService adIssueService;
	
	@Resource(name="userService")
	private UserService userService;


	@Resource(name="qizheService")
	private QizheService qizheService;

	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去启哲页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			List<PageData>	varList= (List<PageData>) qizheService.query(pd);
			mv.setViewName("problem/scpc");
			mv.addObject("varList", varList);
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	@RequestMapping("/auditPage")
	public ModelAndView auditPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("problem/auditPage");
		PageData pd = this.getPageData();
		PageData project = qizheService.findById(pd);
		pd.put("id", pd.get("ID"));
		pd.put("scpcid", pd.get("ID"));
		PageData audit2Info = qizheService.findAudit2(pd);
		List<PageData> images = qizheService.getImageDeal(pd);
		mv.addObject("project", project);
		mv.addObject("images", images);
		mv.addObject("pd", pd);
		mv.addObject("audit2Info", audit2Info);
		return mv;
	}

	@RequestMapping("saveAudit")
	public String saveAudit(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();

		PageData user=this.user(session);
		String scpc=user.get("scpcqx").toString();
		String ktype=user.get("ktype").toString();
		PageData sele = qizheService.findByscpcId(pd);
		String beiyong4=sele.get("beiyong4")==null? "":sele.get("beiyong4").toString();
		if (StringUtils.isEmpty(pd.getString("id"))) {
			// insert

			if(beiyong4.equals("开")){
				if(scpc.equals("0")) {
					pd.put("content1",pd.get("content1"));
					pd.put("content2","");
					pd.put("audit1","");
					pd.put("audit2","");
					pd.put("audit2","");
					pd.put("status1","待审核");
					sele.put("beiyong3","待审核");
					qizheService.saveAudit2(pd);
					qizheService.edit(sele);
				}

			}



		} else {
			PageData  audit=qizheService.findAudit2(pd);
			if(beiyong4.equals("开")){
				if(scpc.equals("0")) {
					audit.put("content1",pd.get("content1"));
					audit.put("status1","待审核");
					if(StringUtils.isNotBlank((String)pd.get("content2"))){
						audit.put("content2",pd.get("content2"));
						audit.put("status1","二次申诉待批复");
					}
					sele.put("beiyong3","待审核");
					qizheService.updateAudit2(audit);
					qizheService.edit(sele);
				}


				if(scpc.equals("3")) {
					sele.put("beiyong3","已最终回复");
					audit.put("status1","已最终回复");
					audit.put("audit2",pd.get("audit2"));
					qizheService.updateAudit2(audit);
					qizheService.edit(sele);
				}

			}
			if(scpc.equals("5")) {
				audit.put("status1","已回复");
				sele.put("beiyong3","已回复");
				audit.put("audit1",pd.get("audit1"));
				qizheService.updateAudit2(audit);
				qizheService.edit(sele);
			}


		}
		return "redirect:/adIssue/auditPage.do?projectName="+pd.get("projectName")+"&ID="+pd.get("scpcid")+"";

	}

	@RequestMapping(value="/goImageAdd")
	public ModelAndView goImageAdd(Integer id, String projectName) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("problem/imageAddPage");
		mv.addObject("id", id);
		mv.addObject("projectName", projectName);
		return mv;
	}

	@ResponseBody
	@RequestMapping("saveImages")
	public String saveImages(Images images) throws Exception {
		if (images != null && !CollectionUtils.isEmpty(images.getImages())) {
			for (String image : images.getImages()) {
				images.setImage(image);
				qizheService.saveImage(images);
			}
		}
		return "success";
	}

	@RequestMapping("auditAdd")
	public ModelAndView auditAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Audit audit = new Audit();
		long auditCount = 0;
		if (pd.get("id") != null) {
			audit = qizheService.getAuditById(pd.getString("id"));
			auditCount = qizheService.countAudit(pd);
		}
		mv.addObject("auditCount", auditCount);
		mv.addObject("audit", audit);
		mv.setViewName("problem/auditAdd");
		mv.addObject("pd", pd);
		return mv;
	}

	@ResponseBody
	@RequestMapping("auditSave")
	public void auditSave() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		if (StringUtils.isEmpty(pd.getString("id"))) {
			qizheService.saveAudit(pd);
			return ;
		}

		Audit audit = qizheService.getAuditById(pd.getString("id"));
		if (audit == null) {
			return ;
		}

		if (audit.getStatus().equals("1")) {
			//正在申诉 更新回复
			qizheService.updateAppealReply(pd);
		} else if (audit.getStatus().equals("3")) {
			//总公司回复
			qizheService.updateLastReply(pd);
		}



	}


	@RequestMapping("getImageDeal")
	public ModelAndView getImageDeal() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	varList = qizheService.getImageDeal(pd);
		mv.setViewName("problem/imageDealPage");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;

	}

	@ResponseBody
	@RequestMapping("getMonthList")
	public List<String> getMonthList() throws Exception {
		return qizheService.getMonthList();
	}
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增AdIssue");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData sele = qizheService.findByName(pd);
//		if(sele==null){
		PageData address=qizheService.saddress(pd);
		pd.put("qnamehao",address.get("qnamehao"));
		pd.put("qgongsi",address.get("qgongsi"));
		pd.put("address",address.get("address"));
		pd=JiSuan.save(pd);
		qizheService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
//		}else{
//			mv.addObject("msg","加油站名字重复");
//		}
		return mv;
	}





	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除Issue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//adIssueService.deleteAdIssueImage(pd);
			qizheService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(HttpSession session) throws Exception{
		logBefore(logger, "修改Issue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();


		PageData address=qizheService.saddress(pd);
		pd.put("qnamehao",address.get("qnamehao"));
		pd.put("qgongsi",address.get("qgongsi"));
		pd.put("address",address.get("address"));

		PageData user=this.user(session);
		String scpc=user.get("scpcqx").toString();
		String ktype=user.get("ktype").toString();

		PageData sele = qizheService.findById(pd);
		String beiyong3=sele.get("beiyong3")==null? "":sele.get("beiyong3").toString();
        String beiyong4=sele.get("beiyong4")==null? "":sele.get("beiyong4").toString();

		if(scpc.equals("5")){
			pd=JiSuan.save(pd);
			if(beiyong4.equals("开")){
				pd.put("beiyong4","开");
			}else{
				pd.put("beiyong4","关");
			}
			pd.put("beiyong3",beiyong3);
			qizheService.edit(pd);
		}

		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value="/monthList")
	public ModelAndView monthList(Page page,HttpSession session){
		logBefore(logger, "广告列表Issue");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String KEYW = pd.getString("keyword");
			if(null != KEYW && !"".equals(KEYW)){
				KEYW = KEYW.trim();
				pd.put("KEYW", KEYW);
			}
			PageData user=this.user(session);
			String userName=user.get("USERNAME").toString();
			String scpc=user.get("scpcqx").toString();
			pd.put("USERNAME",userName);
			page.setPd(pd);
			List<PageData>	varList=null;
			if(scpc.equals("5") || scpc.equals("3")){
				varList = qizheService.monthList(page);	//列出全部列表
			}
			if(scpc.equals("0")){
				varList = qizheService.qname(page);
			}
			if(scpc.equals("2")){
				varList = qizheService.qgongsi(page);
			}
			mv.setViewName("problem/manage");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 广告列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView adList(Page page,HttpSession session){
		logBefore(logger, "广告列表Issue");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String KEYW = pd.getString("keyword");
			if(null != KEYW && !"".equals(KEYW)){
				KEYW = KEYW.trim();
				pd.put("KEYW", KEYW);
			}
			PageData user=this.user(session);
           	String userName=user.get("USERNAME").toString();
           	String scpc=user.get("scpcqx").toString();
           	pd.put("USERNAME",userName);
			page.setPd(pd);
			List<PageData>	varList=null;
			if(scpc.equals("5") || scpc.equals("3")){
				varList = qizheService.listPdPageName(page);	//列出全部列表
			}
			if(scpc.equals("0")){
				varList = qizheService.qname(page);
			}
			if(scpc.equals("2")){
				varList = qizheService.qgongsi(page);
			}

			mv.setViewName("problem/manage");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	

	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改AdIssue页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = qizheService.findById(pd);	//根据ID读取
			Map<String, Audit> auditInfo = getAuditInfo(pd.get("ID"));
			mv.setViewName("problem/scpc");
			mv.addObject("auditInfo", auditInfo);
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}

	private Map<String,Audit> getAuditInfo(Object scpcid) throws Exception {
		List<Audit> audits = qizheService.getAuditByscpcid(scpcid.toString());
		Map<String, Audit> result = new HashMap<>();
		for (Audit audit : audits) {
			result.put(audit.getProjectName(), audit);
		}
		return result;
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除AdIssue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				//adIssueService.deleteAllAdIssueImage(ArrayDATA_IDS);
				adIssueService.editIsDeleteByList(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}



	/**
	 * 审核页面
	 */
	@RequestMapping(value="/check")
	public ModelAndView check(Page page,HttpSession session){
		logBefore(logger, "广告列表Issue");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String KEYW = pd.getString("keyword");
			if(null != KEYW && !"".equals(KEYW)){
				KEYW = KEYW.trim();
				pd.put("KEYW", KEYW);
			}
			String status1 = pd.getString("status1");

			if(status1 != null && !"".equals(status1)){

				pd.put("status1", status1);
			}


			PageData user=this.user(session);
			String userName=user.get("USERNAME").toString();
			String scpc=user.get("scpcqx").toString();
			pd.put("USERNAME",userName);
			page.setPd(pd);
			List<PageData>	varList=null;
			if(scpc.equals("5") || scpc.equals("3")){
				varList = qizheService.aduitScpc(page);	//列出全部列表
			}


			mv.setViewName("problem/check");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}







	/**
	 * 申诉开
	 */
	@RequestMapping(value="/shensukai")
	public void shensukai(){

		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			qizheService.shensukai(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 申诉关
	 */
	@RequestMapping(value="/shensuguan")
	public void shensuguan(){

		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			qizheService.shensuguan(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}




	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{

				//检索条件===
				String KEYW = pd.getString("KEYW");
				if(null != KEYW && !"".equals(KEYW)){
					KEYW = KEYW.trim();
					pd.put("KEYW", KEYW);
				}
				String dataMonth = pd.getString("dataMonth");

				if(dataMonth != null && !"".equals(dataMonth)){

					pd.put("dataMonth", dataMonth);
				}



				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();

				titles.add("月份"); 		//1
				titles.add("分公司");  		//2
				titles.add("所属片区");			//3
				titles.add("加油站名称");			//4
				titles.add("加油站编码");			//5
				titles.add("总得分");			//6
				titles.add("基础管理");		//7
				titles.add("加油现场");	//8
				titles.add("办公区"); 		//9
				titles.add("收银区");  		//10
				titles.add("非油业务");			//11
				titles.add("生活区");			//12
				titles.add("卫生间");			//13
				titles.add("检查日期");			//14
				titles.add("进站时间");		//15
				titles.add("离站时间");	//16
				titles.add("该站类型"); 		//17
				titles.add("工作日类别");  		//18
				titles.add("是否有洗手间");			//19
				titles.add("是否有便利店");			//20
				titles.add("访问员");			//21



				dataMap.put("titles", titles);
				Page page=new Page();
				page.setShowCount(10000);
				page.setPd(pd);
				List<PageData> scpcList = qizheService.listPdPageName(page);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<scpcList.size();i++){
					PageData vpd = new PageData();
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM");
					Date date= (Date) scpcList.get(i).get("dateMonth");
					vpd.put("var1",sdf.format(date));		//1
					vpd.put("var2", scpcList.get(i).getString("qgongsi"));		//2
					vpd.put("var3", scpcList.get(i).getString("bumen"));			//3
					vpd.put("var4", scpcList.get(i).getString("qname"));	//4
					vpd.put("var5", scpcList.get(i).getString("qnamehao"));		//5
					vpd.put("var6", scpcList.get(i).getString("qscore"));		//6
					vpd.put("var7", scpcList.get(i).getString("af"));	//7
					vpd.put("var8", scpcList.get(i).getString("bf"));			//8
					vpd.put("var9", scpcList.get(i).getString("cf"));		//1
					vpd.put("var10", scpcList.get(i).getString("df"));		//2
					vpd.put("var11", scpcList.get(i).getString("ef"));			//3
					vpd.put("var12", scpcList.get(i).getString("ff"));	//4
					vpd.put("var13", scpcList.get(i).getString("gf"));		//5
					vpd.put("var14", scpcList.get(i).getString("jinzhandate"));		//6
					vpd.put("var15", scpcList.get(i).getString("jinzhan"));	//7
					vpd.put("var16", scpcList.get(i).getString("lizhan"));			//8
					vpd.put("var17", scpcList.get(i).getString("type"));		//1
					vpd.put("var18", scpcList.get(i).getString("category"));		//2
					vpd.put("var19", scpcList.get(i).getString("wc"));			//3
					vpd.put("var20", scpcList.get(i).getString("bianli"));	//4
					vpd.put("var21", scpcList.get(i).getString("fname"));		//5
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);

		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	@RequestMapping(value="/exce2")
	public ModelAndView exportExce2(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{

			String KEYW = pd.getString("KEYW");
			if(null != KEYW && !"".equals(KEYW)){
				KEYW = KEYW.trim();
				pd.put("KEYW", KEYW);
			}
			String dataMonth = pd.getString("dataMonth");

			if(dataMonth != null && !"".equals(dataMonth)){

				pd.put("dataMonth", dataMonth);
			}



			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();

			titles.add("月份"); 		//1
			titles.add("分公司");  		//2
			titles.add("所属片区");			//3
			titles.add("加油站名称");			//4
			titles.add("加油站编码");			//5

			titles.add("考核项编号");			//6
			titles.add("考核内容");		//7
			titles.add("扣分");	//8
			titles.add("扣分说明"); 		//1
//			titles.add("扣分依据");  		//2
//			titles.add("考核说明");			//3
			titles.add("申诉情况");			//4
			titles.add("一次申诉");  		//2
			titles.add("二次申诉");			//3
			titles.add("审核回复");  		//2
			titles.add("省公司回复");
			Map<String, String> map=ProjectAuditHelper.PROJECT_INFO;

			dataMap.put("titles", titles);
				Page page=new Page();
				page.setShowCount(10000);
		//	List<PageData> scpcList = qizheService.excelScpc(pd);
				List<PageData> scpcList = qizheService.excelScpc(page);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<scpcList.size();i++){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM");
				Date date= (Date) scpcList.get(i).get("dateMonth");
				PageData vpd = new PageData();
				vpd.put("var1",sdf.format(date));		//1
				vpd.put("var2", scpcList.get(i).getString("qgongsi"));		//2
				vpd.put("var3", scpcList.get(i).getString("bumen"));			//3
				vpd.put("var4", scpcList.get(i).getString("qname"));	//4
				vpd.put("var5", scpcList.get(i).getString("qnamehao"));
				vpd.put("var6", scpcList.get(i).getString("projectName"));		//6
				vpd.put("var7", map.get(scpcList.get(i).getString("projectName")));	//7
				vpd.put("var8", scpcList.get(i).getString(scpcList.get(i).getString("projectName")));//8
				vpd.put("var9", scpcList.get(i).getString(scpcList.get(i).getString("projectName")+"sm"));//8
				vpd.put("var10", scpcList.get(i).getString("status1"));//8
				vpd.put("var11", scpcList.get(i).getString("content1"));//8
				vpd.put("var12", scpcList.get(i).getString("content2"));//8
				vpd.put("var13", scpcList.get(i).getString("audit1"));//8
				vpd.put("var14", scpcList.get(i).getString("audit2"));//8
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,dataMap);

		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

		 /*
		  获取当前用户
		  */
	public PageData user(HttpSession session) throws Exception {
		PageData pd = new PageData();
		String userName = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("USERNAME",userName);
		PageData user =userService.findByUId(pd);
		return user;
	}
	
	

	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

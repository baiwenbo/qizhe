package com.fh.controller.problem;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.problem.ReplyService;
import com.fh.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 类名称：ReplyController
 * 创建人：FH 
 * 创建时间：2017-06-01
 */
@Controller
@RequestMapping(value="/reply")
public class ReplyController extends BaseController {
	
	String menuUrl = "reply/list.do"; //菜单地址(权限用)
	@Resource(name="replyService")
	private ReplyService replyService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增Reply");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		replyService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * H5问题回复
	 */
	@RequestMapping(value="/addReply")
	@ResponseBody
	public Object addReply(HttpServletRequest request){
		logBefore(logger, "H5问题回复");
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		String issueId = request.getParameter("issueId");//问题ID
		String content = request.getParameter("content");
		try{
			if(issueId != null && !issueId.equals("")){
				pd.put("issueId", Integer.parseInt(issueId));
				pd.put("content", content);
				replyService.addReply(pd);
				map.put("code", Const.CODE_SUCCESS);
				map.put("msg", "success");
			}else{
				map.put("code", Const.CODE_FAIL);
				map.put("msg", "Request parameter exception");
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
			map.put("code", Const.CODE_EXCEPTION);
			map.put("msg", "System exception");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除Reply");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			replyService.delete(pd);
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
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改Reply");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		replyService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表Reply");
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
			page.setPd(pd);
			List<PageData>	varList = replyService.list(page);	//列出Reply列表
			mv.setViewName("problem/reply_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Reply页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("problem/reply_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改Reply页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = replyService.findById(pd);	//根据ID读取
			mv.setViewName("problem/reply_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除Reply");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				replyService.deleteAll(ArrayDATA_IDS);
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
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出Reply到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("回答内容");	//1
			titles.add("问题Id");	//2
			titles.add("回答问题的人");	//3
			titles.add("是否删除");	//4
			titles.add("创建时间");	//5
			titles.add("更新时间");	//6
			dataMap.put("titles", titles);
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			List<PageData> varOList = replyService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CONTENT"));	//1
				vpd.put("var2", varOList.get(i).get("ISSUEID").toString());	//2
				vpd.put("var3", varOList.get(i).get("USERID").toString());	//3
				vpd.put("var4", varOList.get(i).get("ISDELETED").toString());	//4
				
				java.sql.Timestamp cr= (java.sql.Timestamp) varOList.get(i).get("CREATE_TIME");  
			    if(cr != null && !cr.equals(cr)){
			    	String creaT=sdf.format(cr); 
			    	vpd.put("var5", creaT);
			    }else {
			    	vpd.put("var5", "00:00:00");
			    }
			    
			    java.sql.Timestamp ud= (java.sql.Timestamp) varOList.get(i).get("UPDATE_TIME");  
			    if(ud != null && !cr.equals(ud)){
			    	String creaT=sdf.format(ud); 
			    	vpd.put("var6", creaT);
			    }else {
			    	vpd.put("var6", "00:00:00");
			    }
				
				/*vpd.put("var5", varOList.get(i).getString("CREATE_TIME"));	//5
				vpd.put("var6", varOList.get(i).getString("UPDATE_TIME"));	//6
*/				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 打开上传EXCEL页面
	 */
	@RequestMapping(value="/goUploadExcel")
	public ModelAndView goUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("problem/uploadReplyexcel");
		return mv;
	}
	
	/**
	 * 下载模版
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Reply.xls", "Reply.xls");
		
	}
	
	/**
	 * 从EXCEL导入到数据库
	 */
	@RequestMapping(value="/readExcel")
	public ModelAndView readExcel(
			@RequestParam(value="excel",required=false) MultipartFile file
			) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "replyexcel");							//执行上传
			
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);	//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			
			//存入数据库操作======================================
			pd.put("ISDELETED", "0");						//是否删除
			pd.put("CREATE_TIME", new Date());					//创建时间
			pd.put("UPDATE_TIME", new Date());				//更新时间
			
			for(int i=0;i<listPd.size();i++){
				pd.put("CONTENT", listPd.get(i).getString("var0"));                          //创建问题的人
				pd.put("ISSUEID", listPd.get(i).getString("var1"));                            //类型
				pd.put("USERID", listPd.get(i).getString("var2"));						    //标题
				
				replyService.saveU(pd);
			}
			//存入数据库操作======================================
			
			mv.addObject("msg","success");
		}
		
		mv.setViewName("save_result");
		return mv;
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

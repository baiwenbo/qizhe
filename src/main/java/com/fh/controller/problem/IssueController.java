package com.fh.controller.problem;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.common.RequestMessage;
import com.fh.entity.system.User;
import com.fh.service.problem.IssueService;
import com.fh.service.problem.ReplyService;
import com.fh.service.system.user.UserService;
import com.fh.util.*;

import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
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
 * 类名称：IssueController
 * 创建人：FH 
 * 创建时间：2017-05-27
 */
@Controller
@RequestMapping(value="/issue")
public class IssueController extends BaseController {
	
	String menuUrl = "issue/list.do"; //菜单地址(权限用)
	@Resource(name="issueService")
	private IssueService issueService;
	
	private static LinkedList<FileMeta> files = new LinkedList();
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	/**
	 * 车百问登录接口
	 * @param password
	 * @param userName
	 * @return
	 */
	public JSONObject getCheBaiWenLogin(){
		String url = Const.baseUrl + "/app/login";
        Map<String, Object> params = new HashMap<String, Object>();
        Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		User userr = (User)session.getAttribute(Const.SESSION_USERROL);
		if(null == userr){
			try {
				user = userService.getUserAndRoleById(user.getUSER_ID());
			} catch (Exception e) {
				e.printStackTrace();
			}
			session.setAttribute(Const.SESSION_USERROL, user);
		}else{
			user = userr;
		}
        params.put("name", user.getNAME());
        params.put("password", user.getUSERNAME().equals("admin")?"abcd1234":"123");
        params.put("userName", user.getUSERNAME());
        JSONObject dataObject = (JSONObject) HttpUtils.getJson2Object(url, params);
        System.out.println("dataObject: " + dataObject);
        return dataObject;
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增Issue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		issueService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
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
			issueService.delete(pd);
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
		logBefore(logger, "修改Issue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		issueService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 问题列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表Issue");
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
			List<PageData>	varList = issueService.list(page);	//列出Issue列表
			mv.setViewName("problem/issue_list");
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
	@RequestMapping(value="/adList")
	public ModelAndView adList(Page page){
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
			page.setPd(pd);
			List<PageData>	varList = issueService.adList(page);	//列出广告ad列表
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
	 * H5广告列表
	 */
	@RequestMapping(value="/adProblemList", method=RequestMethod.GET)
	@ResponseBody
	public Object adProblemList(HttpServletRequest request,Page page,HttpServletResponse response) throws Exception{
		logBefore(logger, "H5列表Issue");
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		try{
			List<PageData>	varList = issueService.adProblemList(page);	//列出广告ad列表
			//查询问题下的图片
			if(varList != null && varList.size() > 0){
				for(int i=0;i<varList.size();i++){
					pd.put("id", Integer.parseInt(varList.get(i).get("id").toString()));
					List<PageData> urlList = issueService.urlList(pd);
					if(urlList != null && urlList.size()>0){
						String[] str = new String[urlList.size()];
						for(int j=0;j<urlList.size();j++){
							str[j] = "small/"+urlList.get(j).getString("url");
						}
						varList.get(i).put("url", str);
					}else{
						varList.get(i).put("url", "");
					}
				}
			}
			map.put("code", Const.CODE_SUCCESS);
			map.put("msg", "success");
			map.put("totalPage",page.getTotalPage());
			map.put("currentPage",page.getCurrentPage());
			map.put("showCount",page.getShowCount());
			map.put("list", varList);
		} catch(Exception e){
			logger.error(e.toString(), e);
			map.put("code", Const.CODE_EXCEPTION);
			map.put("msg", "System exception");
		}
		return AppUtil.returnObject(pd,map);
	}
	
	/**
	 * H5广告列表-查看单条问题详情
	 */
	@RequestMapping(value="/adProblemDetails")
	@ResponseBody
	public Object adProblemDetails(HttpServletRequest request){
		logBefore(logger, "问题详情");
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		String id = request.getParameter("id");
		try{
			if(id != null && !id.equals("")){
				pd.put("id", Integer.parseInt(id));
				PageData findOne = issueService.findById(pd);
				if(findOne != null){
					//加入图片地址
					List<PageData> urlList = issueService.urlList(pd);
					if(urlList != null && urlList.size()>0){
						String[] str = new String[urlList.size()];
						for(int j=0;j<urlList.size();j++){
							str[j] = "small/"+urlList.get(j).getString("url");
						}
						findOne.put("url", str);
					}else{
						findOne.put("url", "");
					}
					//加入回复问题列表数据
					List<PageData> replyList = replyService.findByReplyList(pd);
					if(replyList != null && replyList.size()>0){
						map.put("replyList", replyList);
					}else{
						map.put("replyList", "");
					}
					map.put("code", Const.CODE_SUCCESS);
					map.put("msg", "success");
				}else{
					map.put("code", Const.CODE_FAIL);
					map.put("msg", "Request parameter exception");
				}
				map.put("details", findOne);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
			map.put("code", Const.CODE_EXCEPTION);
			map.put("msg", "System exception");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * H5添加问题
	 */
	@RequestMapping(value="/addIssue")
	@ResponseBody
	public synchronized Object addIssue(RequestMessage request){
		logBefore(logger, "H5添加问题");
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		try{
			if(request != null){
				String title = request.getTitle();
				String content = request.getContent();
				String tags = request.getTags();
				pd.put("title", title);
				pd.put("content", content);
				pd.put("tags", tags);
				issueService.addIssue(pd);
				//查出新增的问题id
				pd = issueService.findByIssueId();
				//将问题id和图片id加入关联表
				if(request.getId() != null && Integer.parseInt(request.getId()) > 0){
					PageData pag = new PageData();
					pag.put("issueId", Integer.parseInt(pd.get("id").toString()));
					pag.put("imageId", Integer.parseInt(request.getId()));
					issueService.addIssueImage(pag);
				}
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
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Issue页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("problem/issue_edit");
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
		logBefore(logger, "去修改Issue页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = issueService.findById(pd);	//根据ID读取
			mv.setViewName("problem/issue_edit");
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
		logBefore(logger, "批量删除Issue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				issueService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出Issue到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("创建问题的人");	//1
			titles.add("问题标题");	//2
			titles.add("问题内容");	//3
			titles.add("标签");	//4
			titles.add("1-问题2-话题");	//5
			titles.add("来源");	//6
			titles.add("收藏数");	//7
			titles.add("回答数");	//8
			titles.add("是否删除");	//9
			titles.add("创建时间");	//10
			titles.add("更新时间");	//11
			dataMap.put("titles", titles);
			List<PageData> varOList = issueService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).get("USERID").toString());	//1
				vpd.put("var2", varOList.get(i).getString("TITLE"));	//2
				vpd.put("var3", varOList.get(i).getString("CONTENT"));	//3
				vpd.put("var4", varOList.get(i).getString("TAGS"));	//4
				vpd.put("var5", varOList.get(i).get("TYPE").toString());	//5
				vpd.put("var6", varOList.get(i).getString("SOURCE"));	//6
				vpd.put("var7", varOList.get(i).get("FAVORITES_RATE").toString());	//7
				vpd.put("var8", varOList.get(i).get("ANSWER_RATE").toString());	//8
				vpd.put("var9", varOList.get(i).get("ISDELETED").toString());	//9
				
				java.sql.Timestamp cr= (java.sql.Timestamp) varOList.get(i).get("CREATE_TIME");  
			    if(cr != null && !cr.equals(cr)){
			    	String creaT=sdf.format(cr); 
			    	vpd.put("var10", creaT);
			    }else {
			    	vpd.put("var10", "00:00:00");
			    }
			    
			    java.sql.Timestamp ud= (java.sql.Timestamp) varOList.get(i).get("UPDATE_TIME");  
			    if(ud != null && !cr.equals(ud)){
			    	String creaT=sdf.format(ud); 
			    	vpd.put("var11", creaT);
			    }else {
			    	vpd.put("var11", "00:00:00");
			    }
				
/*				vpd.put("var10", varOList.get(i).get("CREATE_TIME"));	//10
				vpd.put("var11", varOList.get(i).get("UPDATE_TIME"));	//11
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
		mv.setViewName("problem/uploadexcel");
		return mv;
	}
	
	/**
	 * 下载模版
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Problem.xls", "Problem.xls");
		
	}
	
	/**
	 * 从EXCEL导入到数据库
	 */
//	@RequestMapping(value="/readExcel")
//	public ModelAndView readExcel(
//			@RequestParam(value="excel",required=false) MultipartFile file
//			) throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
//		if (null != file && !file.isEmpty()) {
//			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
//			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");							//执行上传
//			
//			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);	//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
//			
//			/**
//			 titles.add("创建问题的人");	//1
//			titles.add("问题标题");	//2
//			titles.add("问题内容");	//3
//			titles.add("标签");	//4
//			titles.add("1-问题2-话题");	//5
//			titles.add("来源");	//6
//			titles.add("收藏数");	//7
//			titles.add("回答数");	//8
//			titles.add("是否删除");	//9
//			titles.add("创建时间");	//10
//			titles.add("更新时间");	//11
//			
//			#{USERID},	
//			#{TITLE},	
//			#{CONTENT},	
//			#{TAGS},	
//			#{TYPE},	
//			#{SOURCE},	
//			#{FAVORITES_RATE},	
//			#{ANSWER_RATE},	
//			#{ISDELETED},	
//			#{CREATE_TIME},	
//			#{UPDATE_TIME}
//			 */
//			
//			//存入数据库操作======================================
//			pd.put("ISDELETED", "0");						//是否删除
//			pd.put("CREATE_TIME", new Date());					//创建时间
//			pd.put("UPDATE_TIME", new Date());				//更新时间
//			
//			for(int i=0;i<listPd.size();i++){
//				pd.put("USERID", listPd.get(i).getString("var0"));                          //创建问题的人
//				pd.put("TYPE", listPd.get(i).getString("var1"));                            //类型
//				pd.put("TITLE", listPd.get(i).getString("var2"));						    //标题
//				pd.put("CONTENT", listPd.get(i).getString("var3"));							//内容
//				pd.put("TAGS", listPd.get(i).getString("var4"));							//标签
//				pd.put("SOURCE", listPd.get(i).getString("var5"));                          //来源
//				pd.put("FAVORITES_RATE", listPd.get(i).getString("var6"));                  //收藏数
//				pd.put("ANSWER_RATE", listPd.get(i).getString("var7"));                     //回答数
//				
//				issueService.saveU(pd);
//			}
//			//存入数据库操作======================================
//			
//			mv.addObject("msg","success");
//		}
//		
//		mv.setViewName("save_result");
//		return mv;
//	}
	
	
	
	/**
	 * 从EXCEL导入到数据库(导入到cbw_Issue ，用户表)
	 */
//	@RequestMapping(value="/readExcel")
//	public ModelAndView readExcel(
//			@RequestParam(value="excel",required=false) MultipartFile file
//			) throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
//		if (null != file && !file.isEmpty()) {
//			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
//			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");							//执行上传
//			
//			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);	//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
//			
//			/**
//			 titles.add("创建问题的人");	//1
//			titles.add("问题标题");	//2
//			titles.add("问题内容");	//3
//			titles.add("标签");	//4
//			titles.add("1-问题2-话题");	//5
//			titles.add("来源");	//6
//			titles.add("收藏数");	//7
//			titles.add("回答数");	//8
//			titles.add("是否删除");	//9
//			titles.add("创建时间");	//10
//			titles.add("更新时间");	//11
//			
//			#{USERID},	
//			#{TITLE},	
//			#{CONTENT},	
//			#{TAGS},	
//			#{TYPE},	
//			#{SOURCE},	
//			#{FAVORITES_RATE},	
//			#{ANSWER_RATE},	
//			#{ISDELETED},	
//			#{CREATE_TIME},	
//			#{UPDATE_TIME}
//			 */
//			
//			//存入数据库操作======================================
//			pd.put("ISDELETED", "0");						//是否删除
//			String d  ;
//			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			d = sdformat.format(new Date());
//			pd.put("CREATE_TIME", d);					//创建时间
//			pd.put("UPDATE_TIME", d);				//更新时间
//			
//			for(int i=0;i<listPd.size();i++){
//				//pd.put("id", listPd.get(i).getString("var0"));                          
//				pd.put("userid", listPd.get(i).getString("var0"));                          //创建问题的人   
//				pd.put("type", listPd.get(i).getString("var1")); 						    //类型
//				pd.put("title", listPd.get(i).getString("var2"));						    //标题
//				pd.put("content", listPd.get(i).getString("var3"));							//内容
//				pd.put("tags", listPd.get(i).getString("var4"));   							//标签
//				pd.put("source", listPd.get(i).getString("var5"));							//来源                 
//				pd.put("FAVORITES_RATE", listPd.get(i).getString("var6"));                  //收藏数
//				pd.put("ANSWER_RATE", listPd.get(i).getString("var7"));                     //回答数
//				
//				issueService.saveIssue(pd);
//			}
//			//存入数据库操作======================================
//			
//			mv.addObject("msg","success");
//		}
//		
//		mv.setViewName("save_result");
//		return mv;
//	}
	
	/**
	 * 从EXCEL导入到数据库(导入到cbw_reply ，用户表)
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
			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");							//执行上传
			
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);	//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			
			/**
			 titles.add("创建问题的人");	//1
			titles.add("问题标题");	//2
			titles.add("问题内容");	//3
			titles.add("标签");	//4
			titles.add("1-问题2-话题");	//5
			titles.add("来源");	//6
			titles.add("收藏数");	//7
			titles.add("回答数");	//8
			titles.add("是否删除");	//9
			titles.add("创建时间");	//10
			titles.add("更新时间");	//11
			
			#{USERID},	
			#{TITLE},	
			#{CONTENT},	
			#{TAGS},	
			#{TYPE},	
			#{SOURCE},	
			#{FAVORITES_RATE},	
			#{ANSWER_RATE},	
			#{ISDELETED},	
			#{CREATE_TIME},	
			#{UPDATE_TIME}
			 */
			
			//存入数据库操作======================================
			pd.put("ISDELETED", "0");						//是否删除
			String d  ;
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			d = sdformat.format(new Date());
			pd.put("CREATE_TIME", d);					//创建时间
			pd.put("UPDATE_TIME", d);				//更新时间
			
			for(int i=0;i<listPd.size();i++){
				//pd.put("id", listPd.get(i).getString("var0"));                          //创建问题的人
				pd.put("content", listPd.get(i).getString("var0"));                            //类型
				pd.put("issueId", listPd.get(i).getString("var1"));  
				pd.put("userId", listPd.get(i).getString("var2"));						    //标题
//				pd.put("content", listPd.get(i).getString("var3"));							//内容
//				pd.put("tags", listPd.get(i).getString("var4"));  
//				pd.put("source", listPd.get(i).getString("var5"));							//标签
//				pd.put("SOURCE", listPd.get(i).getString("var5"));                          //来源
//				pd.put("FAVORITES_RATE", listPd.get(i).getString("var6"));                  //收藏数
//				pd.put("ANSWER_RATE", listPd.get(i).getString("var7"));                     //回答数
				
				issueService.saveReply(pd);
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

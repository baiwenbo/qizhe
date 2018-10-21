package com.fh.controller.problem;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.problem.IssueService;
import com.fh.service.problem.ReplyService;
import com.fh.service.system.user.UserService;
import com.fh.util.*;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
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
@RequestMapping(value="/qizhe")
public class QizheController extends BaseController {
	
	String menuUrl = "qizhe/list.do"; //菜单地址(权限用)
	@Resource(name="issueService")
	private IssueService issueService;
	
	private static LinkedList<FileMeta> files = new LinkedList();
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="replyService")
	private ReplyService replyService;
	

	
	
	/**
	 * 去录入页面
	 */
	@RequestMapping(value="/add")
	public String add(Model model) {
		
		model.addAttribute("period", "period");
		
		return "qizhe/add";
	}
	
	
	
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增录入");
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

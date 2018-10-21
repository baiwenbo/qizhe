package com.fh.controller.customer;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.customer.UserInfoService;

/** 
 * 类名称：userInfoController
 * 创建人：FH 
 * 创建时间：2017-05-09
 */
@Controller
@RequestMapping(value="/userInfo")
public class UserInfoController extends BaseController {
	
	String menuUrl = "userInfo/list.do"; //菜单地址(权限用)
	@Resource(name="userInfoService")
	private UserInfoService userInfoService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增userInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		userInfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除userInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			userInfoService.delete(pd);
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
		logBefore(logger, "修改userInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		userInfoService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表userInfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			String name = pd.getString("name");
			String remark = pd.getString("remark");
			String lastLoginStart = pd.getString("lastLoginStart");
			String lastLoginEnd =  pd.getString("lastLoginEnd");
			
			if(null != name && !"".equals(name)){
				name = name.trim();
				pd.put("name", name);
			}
			if(null != remark && !"".equals(remark)){
				remark = remark.trim();
				pd.put("remark", remark);
			}
			if(null != lastLoginStart && !"".equals(lastLoginStart)){
				lastLoginStart = lastLoginStart.trim();
				pd.put("lastLoginStart", lastLoginStart);
			}
			if(null != lastLoginEnd && !"".equals(lastLoginEnd)){
				lastLoginEnd = lastLoginEnd.trim();
				pd.put("lastLoginEnd", lastLoginEnd);
			}
			page.setPd(pd);
			List<PageData>	varList = userInfoService.list(page);	//列出userInfo列表
			mv.setViewName("customer/userInfo_list");
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
		logBefore(logger, "去新增userInfo页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("customer/userInfo_edit");
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
		logBefore(logger, "去修改userInfo页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = userInfoService.findById(pd);	//根据ID读取
			mv.setViewName("customer/userInfo_edit");
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
		logBefore(logger, "批量删除userInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				userInfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出userInfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("活动类型");	//1
			titles.add("客户名称");	//2
			titles.add("客户联系方式");	//3
			titles.add("客户性别");	//4
			titles.add("客户城市地址");	//10
			titles.add("投放媒体");	//14
			titles.add("创建时间");	//19
			dataMap.put("titles", titles);
			String name = pd.getString("name");
			String remark = pd.getString("remark");
			String lastLoginStart = pd.getString("lastLoginStart");
			String lastLoginEnd =  pd.getString("lastLoginEnd");
			
			if(null != name && !"".equals(name)){
				name = name.trim();
				pd.put("name", name);
			}
			if(null != remark && !"".equals(remark)){
				remark = remark.trim();
				pd.put("remark", remark);
			}
			if(null != lastLoginStart && !"".equals(lastLoginStart)){
				lastLoginStart = lastLoginStart.trim();
				pd.put("lastLoginStart", lastLoginStart);
			}
			if(null != lastLoginEnd && !"".equals(lastLoginEnd)){
				lastLoginEnd = lastLoginEnd.trim();
				pd.put("lastLoginEnd", lastLoginEnd);
			}
			List<PageData> varOList = userInfoService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("ACTIVE_TYPE"));	//1
				vpd.put("var2", varOList.get(i).getString("CLIENT_NAME"));	//2
				vpd.put("var3", varOList.get(i).getString("CLIENT_MOBILEPHONE"));	//3
				vpd.put("var4", varOList.get(i).getString("CLIENT_SEX") == "1"?"男":"女");	//4
				vpd.put("var5", varOList.get(i).getString("CLIENT_ADDRESS_CITY"));	//10
				String from = varOList.get(i).getString("CLIENT_FROM");
				if(from == "1"){
					from = "个推";
				}else if(from == "2"){
					from = "百姓网";
				}else if(from == "3"){
					from = "百度";
				}else{
					from = "其他";
				}
				vpd.put("var6", from);	//14
				
				java.sql.Timestamp cr= (java.sql.Timestamp) varOList.get(i).get("CREATE_DATE");  
			    if(cr != null && !cr.equals(cr)){
			    	String creaT=sdf.format(cr); 
			    	vpd.put("var7", creaT);
			    }else {
			    	vpd.put("var7", "00:00:00");
			    }
				//vpd.put("var19", varOList.get(i).getString("CREATE_DATE"));	//19
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentuserInfo = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentuserInfo.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

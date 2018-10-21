package com.fh.controller.information.pictures;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.util.*;

import net.sf.json.JSONArray;
import com.google.gson.JsonArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 类名称：PicturesController
 * 创建人：FH 
 * 创建时间：2015-03-21
 */
@Controller
@RequestMapping(value="/pictures")
public class PicturesController extends BaseController {

	private static SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");
	private static final String PATH_IP= "http://localhost:8080/qizhe";
	// private static final String PATH_IP = "http://192.168.1.60";
	String menuUrl = "pictures/list.do"; // 菜单地址(权限用)


	@ResponseBody
	@RequestMapping("/save")
	public String save(
			@RequestParam(value="file",required=false)MultipartFile[] file,
			HttpServletRequest request){
		File targetFile=null;
		String msg="";//返回存储路径
		int code=1;
		List imgList=new ArrayList();
		if (file!=null && file.length>0) {
			for (int i = 0; i < file.length; i++) {
				String fileName=file[i].getOriginalFilename();//获取文件名加后缀
				if(fileName!=null&&fileName!=""){
					String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/"+"uploadFiles/uploadImgs/";//存储路径
					String path = request.getSession().getServletContext().getRealPath("uploadFiles/uploadImgs"); //文件存储位置
					String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
					//fileName=DateUtil.getDays()+"_"+new Random().nextInt(1000)+fileF;//新的文件名

					//先判断文件是否存在
					String fileAdd = DateUtil.getDays();
				//	File file1 =new File(path+"/"+fileAdd);
					File file1 =new File(path);
					//如果文件夹不存在则创建
					if(!file1 .exists()  && !file1 .isDirectory()){
						file1 .mkdirs();
					}
					targetFile = new File(file1, fileName);
					try {
						file[i].transferTo(targetFile);
						msg=returnUrl+"/"+fileName;
						imgList.add(msg);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return JSON.toJSONString(imgList);
	}


	@ResponseBody
	@RequestMapping("/save2")
	public Map<String, Object> save2(
			@RequestParam(value="file",required=false)MultipartFile[] file,
			HttpServletRequest request){
		Map<String, Object> result = new HashMap<>();
		File targetFile=null;
		String msg="";//返回存储路径
		int code=1;
		List imgList=new ArrayList();
		if (file!=null && file.length>0) {
			for (int i = 0; i < file.length; i++) {
				String fileName=file[i].getOriginalFilename();//获取文件名加后缀
				if(fileName!=null&&fileName!=""){
					String savePath = "/uploadFiles/uploadImgs/";
					String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/"+ savePath;//存储路径
					String path = request.getSession().getServletContext().getRealPath("uploadFiles/uploadImgs"); //文件存储位置
					String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
					String targetFileNmae = UUID.randomUUID().toString() + fileF;
					//fileName=DateUtil.getDays()+"_"+new Random().nextInt(1000)+fileF;//新的文件名

					//先判断文件是否存在
					String fileAdd = DateUtil.getDays();
					File file1 =new File(path);
					//如果文件夹不存在则创建
					if(!file1 .exists()  && !file1 .isDirectory()){
						file1 .mkdirs();
					}
					targetFile = new File(file1, targetFileNmae);
					try {
						file[i].transferTo(targetFile);
						imgList.add(savePath+"/"+targetFileNmae);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		result.put("images", imgList);
		result.put("code", 200);
		return result;
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/savePictures")
	@ResponseBody
	public Object savePictures(@RequestParam(required = false) MultipartFile file,
					   String imgurl, HttpSession session, HttpServletRequest request,
					   @RequestParam(required = false)Integer orderId)
			throws Exception {
		logBefore(logger, "新增Pictures");
		Map<String, Object> map = new HashMap<String, Object>();
		if (orderId == null || orderId == 0) {
			orderId = (Integer) session.getAttribute("orderId");
		}
		String img = imgurl;
		/*if (orderId == null) {
			map.put("code", ResponseMessage.CODE);
			return map;
		} else {
				img = imgurl;
		}*/
		String filePath = "";
		String ffile = (orderId==null?this.get32UUID():orderId+"");
		String fileName = "";
		if (null != file && !file.isEmpty()) {
			filePath = "/uploadFiles/uploadImgs/" +sim.format(new Date()) +"/"+ ffile + "/" + img;
			/*filePath = "/home/image/" + ffile + "/" + img;*/
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID()); // 执行上传
		} else {
			System.out.println("上传失败");
			map.put("code", "202");
			return map;
		}
		String url = PATH_IP + filePath + "/" + fileName;

		map.put("code", "200");
		map.put("imgurl", url);
		map.put("result", imgurl);
		Map<String, String> body = new HashMap<String, String>();
		body.put("imgurl", imgurl);
		JsonArray array = new JsonArray();
		map.put("body", JSONArray.fromObject(body));
		return map;

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

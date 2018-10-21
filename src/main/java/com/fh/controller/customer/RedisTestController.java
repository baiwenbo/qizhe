package com.fh.controller.customer;

import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.Bank;
import com.fh.service.problem.BankService;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.redis.ImportExcelUtil;
import com.fh.util.redis.LogUtil;
import com.fh.util.redis.RedisUtil;

import sun.applet.Main;

/** Title: 
 * Description: 
 * Company: 
 * @author kgc
 * @date Oct 31, 2017 10:00:13 AM
 */
@Controller
@RequestMapping("redis")
public class RedisTestController extends BaseController{
	
	@Autowired
	private BankService bankService;

	@RequestMapping(value = "test")
	public void set(HttpServletRequest request, HttpServletResponse response,String p) {
		String key = "20180101";
		String field = "test";
		String value = "123";
		try {
			RedisUtil.hset(key, field, value);
			LogUtil.debug("redis="+RedisUtil.hget(key, field));
		} catch (Exception e) {
			LogUtil.error(e.getMessage());
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "test1")
	public void get(HttpServletRequest request, HttpServletResponse response,String p) {
		String key = "20180101";
		String field = "test";
		String value = "name";
		try {
			String a=RedisUtil.get(value);
			System.out.println(a);
			//LogUtil.debug("redis="+RedisUtil.hget(key, field));
		} catch (Exception e) {
			LogUtil.error(e.getMessage());
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "user")
	public void user(HttpSession session,HttpServletRequest request) {
		
		String userName = (String) session.getAttribute(Const.SESSION_USERNAME);
		
		System.out.println(userName);
		
	}
	
	@RequestMapping(value = "excel")
	@ResponseBody
	public Map<String,Object> excel(HttpServletRequest request) throws Exception {
		Map<String,Object> map=new HashMap<String, Object>();
	
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
        System.out.println("通过传统方式form表单提交方式导入excel文件！");  
		
        InputStream in =null;  
        List<List<Object>> listob = null;  
        MultipartFile file = multipartRequest.getFile("excel");  
        if(file.isEmpty()){  
            throw new Exception("文件不存在！");  
        }  
        in = file.getInputStream();  
        listob = new ImportExcelUtil().getBankListByExcel(in,file.getOriginalFilename());  
        in.close();  
		
        for (int i = 0; i < listob.size(); i++) {  
        	  List<Object> lo = listob.get(i);
        	  Bank bank=new Bank();        	 
        	  bank.setName(String.valueOf(lo.get(0)));
        	  bank.setStatus(String.valueOf(lo.get(1)));
        	  bank.setAge(Integer.valueOf(lo.get(2).toString().substring(0,2)));
        	  
        	  DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        	  
        	  bank.setTime(format1.parse(lo.get(3).toString()));
        	  bankService.save(bank);
        }
     
       
		
		
		
		map.put("code", 200);
		
		return map;
		
	
	}

	
	
	
	
	
	
	/**
	 * 去编辑邮箱页面
	 */
	@RequestMapping(value="/baiwenbo")
	public String baiwenbo() {
		
		return "system/head/baiwenbo";
	}





	public static void main(String[] args) throws Exception {
		try {




		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}

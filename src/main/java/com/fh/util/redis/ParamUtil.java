package com.fh.util.redis;




public class ParamUtil {
	
	public static String addr = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.host","") ;
	public static String port = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.port","");
	public static String pass = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.pass","") ;
	public static String maxActive = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.maxActive","");
	public static String maxIdle = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.maxIdle","");
	public static String maxWait = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.maxWait","");
	public static String timeout = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.timeout","");
	public static String testOnBorrow = LoadPropertiesUtils.getPropertiesUTF8("redis").getProperty("redis.testOnBorrow","");
	
	
	public static String getAddr(){
		return addr;
	}
	
	public static String getPort(){
		return port;
	}
	
	public static String getPass(){
		return pass;
	}
	
	public static String getMaxActive(){
		return maxActive;
	}
	
	public static String getMaxIdle(){
		return maxIdle;
	}
	
	public static String getMaxWait(){
		return maxWait;
	}
	
	public static String getTimeout(){
		return timeout;
	}
	
	public static String getTestOnBorrow(){
		return testOnBorrow;
	}
}

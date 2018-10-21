package com.fh.util.redis;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

/**
 * <p>Title: 加载properties文件工具类，通过getProperties(String propertiesName)方法获取Properties对象</p>
 * <p>Description: </p>
 * <p>Company: </p>
 * @author kgc
 * @date Jan 9, 2018 11:40:56 AM
 */
public class LoadPropertiesUtils {
	public static final String COMMON_PROPERTIES_NAME = "common";
	private static Map<String, Properties> cachePropsMap = new ConcurrentHashMap();

	public static Properties getCommonProperties() {
		return getProperties(COMMON_PROPERTIES_NAME);
	}

	public static Properties getProperties(String propertiesName) {
		Properties properties = cachePropsMap.get(propertiesName);
		if (properties == null) {
			Properties loadProperties = loadProperties(propertiesName);
			cachePropsMap.put(propertiesName, loadProperties);
			return loadProperties;
		}

		return properties;
	}

	private static Properties loadProperties(String propertiesName) {
		Properties pros = new Properties();
		InputStream in = null;
		try {
			in = LoadPropertiesUtils.class.getResourceAsStream("/"
					+ propertiesName + ".properties");
			pros.load(in);
		} catch (Exception e) {
		} finally {
			try {
				if (null != in) {
					in.close();
				}
			} catch (Exception e) {
			}
		}
		return pros;
	}

	/**
	 * 中文识别
	 * @param propertiesName
	 * @return
	 */
	public static Properties getPropertiesUTF8(String propertiesName) {
		Properties properties = cachePropsMap.get(propertiesName);
		if (properties == null) {
			Properties loadProperties = loadPropertiesUTF8(propertiesName);
			cachePropsMap.put(propertiesName, loadProperties);
			return loadProperties;
		}

		return properties;
	}

	/**
	 * 中文识别
	 * @param propertiesName
	 * @return
	 */
	private static Properties loadPropertiesUTF8(String propertiesName) {
		Properties pros = new Properties();
		InputStreamReader in = null;
		try {
			in = new InputStreamReader(LoadPropertiesUtils.class.getClassLoader().getResourceAsStream("/"+propertiesName+ ".properties"), "UTF-8");
			pros.load(in);
		} catch (Exception e) {
		} finally {
			try {
				if (null != in) {
					in.close();
				}
			} catch (Exception e) {
			}
		}
		return pros;
	}
	
	public static void main(String[] args) {
		
		System.out.println(LoadPropertiesUtils.getPropertiesUTF8("nc").getProperty("bondCustId","1"));
	}
}

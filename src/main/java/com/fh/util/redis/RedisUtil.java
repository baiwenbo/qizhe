package com.fh.util.redis;

import org.apache.commons.lang.StringUtils;



import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;



/** Title: 
 * Description: 
 * Company: 
 * @author kgc
 * @date Nov 18, 2016 1:55:38 PM
 */
public class RedisUtil {
	//Redis服务器IP
    private static String ADDR = ParamUtil.getAddr()==null?"111.231.145.251":ParamUtil.getAddr();
    
    //Redis的端口号
    private static int PORT = Integer.parseInt(ParamUtil.getPort()==null?"6379":ParamUtil.getPort());

    //访问密码
    private static String PASS = ParamUtil.getPass()==null?"redistest":ParamUtil.getPass();
    
    //可用连接实例的最大数目，默认值为8；
    //如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
    private static int MAX_ACTIVE = Integer.parseInt(ParamUtil.getMaxActive()==null?"600":ParamUtil.getMaxActive());
    
    //控制一个pool最多有多少个状态为idle(空闲的)的jedis实例，默认值也是8。
    private static int MAX_IDLE = Integer.parseInt(ParamUtil.getMaxIdle()==null?"300":ParamUtil.getMaxIdle());
    
    //等待可用连接的最大时间，单位毫秒，默认值为-1，表示永不超时。如果超过等待时间，则直接抛出JedisConnectionException；
    private static int MAX_WAIT = Integer.parseInt(ParamUtil.getMaxWait()==null?"1000":ParamUtil.getMaxWait());
    
    private static int TIMEOUT = Integer.parseInt(ParamUtil.getTimeout()==null?"10000":ParamUtil.getTimeout());
    
    //在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
    private static boolean TEST_ON_BORROW = Boolean.valueOf(ParamUtil.getTestOnBorrow()==null?"true":ParamUtil.getTestOnBorrow()).booleanValue();
    
    private static JedisPool jedisPool = null;
    
    /**
     * 初始化Redis连接池
     */
    static {
        try {
            JedisPoolConfig config = new JedisPoolConfig();
            config.setMaxTotal(MAX_ACTIVE);
            config.setMaxIdle(MAX_IDLE);
            config.setMaxWaitMillis(MAX_WAIT);
            config.setTestOnBorrow(TEST_ON_BORROW);
            if(StringUtils.isNotBlank(PASS)) {
            	jedisPool = new JedisPool(config, ADDR, PORT, TIMEOUT, PASS);
            	LogUtil.debug("有密码:"+jedisPool);
            }else {
            	jedisPool = new JedisPool(config,ADDR,PORT, TIMEOUT);
            	LogUtil.debug("无密码:"+jedisPool);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 获取Jedis实例
     * @return
     */
    public synchronized static Jedis getJedis() {
        try {
            if (jedisPool != null) {
                Jedis resource = jedisPool.getResource();
                return resource;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 释放jedis资源
     * @param jedis
     */
    public static void returnResource(final Jedis jedis) {
        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
    }
    
    
    /**
     * @功能：通过Redis的key获取值，并释放连接资源
     * @参数：key，键值
     * @返回： 成功返回value，失败返回null
     */
    public static String get(String key){
        Jedis jedis = null;
        String value = null;
        try {
            jedis = jedisPool.getResource();
            value = jedis.get(key);
        } catch (Exception e) {
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
            LogUtil.error("get出错"+e.getMessage());
        } finally {
        	returnResource(jedis);
        }
        return value;
    }

    /**
     * @功能：向redis存入key和value（如果key已经存在 则覆盖），并释放连接资源
     * @参数：key，键
     * @参数：value，与key对应的值
     * @返回：成功返回“OK”，失败返回“0”
     */
    public static void set(String key,String value){
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.set(key, value);
//            jedis.bgsave();
        } catch (Exception e) {
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
        	LogUtil.error("set出错"+e.getMessage());
        } finally {
        	returnResource(jedis);
        }
    }

    /**
     * @功能：向redis存入key和value ,并设置过期时间（如果key已经存在 则覆盖），并释放连接资源
     * @参数：key，键
     * @参数：value，与key对应的值
     * @返回：成功返回“OK”，失败返回“0”
     */
    public static void set(String key,String value,int seconds){
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.setex(key,seconds, value);
//            jedis.bgsave();
        } catch (Exception e) {
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
            LogUtil.error("set出错"+e.getMessage());
        } finally {
            returnResource(jedis);
        }
    }
    
    /**
     * @功能：向redis存入自增1值，并释放连接资源
     * @参数：key，键
     * @参数：value，与key对应的值
     * @返回：成功返回“OK”，失败返回“0”
     */
    public static void incr(String key){
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.incr(key);
            jedis.bgsave();
        } catch (Exception e) {
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
        	LogUtil.error("incr出错"+e.getMessage());
        } finally {
        	returnResource(jedis);
        }
    }
    
    /**
     * 
     * @param key
     * @param field
     * @param value
     */
    public static void hincrset(String key,String field , int value){
        Jedis jedis = null;
        boolean success = true;
        try {
            jedis = jedisPool.getResource();
            jedis.hincrBy(key, field , value);
//            jedis.bgsave();
        } catch (Exception e) {
        	success  = false;
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
        	LogUtil.error("set出错:"+e.getMessage());
        } finally {
        	 if(success && jedis != null){
        		 returnResource(jedis);
        	 }
        }
    }
    
    /**
     * 
     * @param key
     * @param field
     * @param value
     */
    public static String hget(String key,String field){
        Jedis jedis = null;
        boolean success = true;
        try {
            jedis = jedisPool.getResource();
            return jedis.hget(key, field );
        } catch (Exception e) {
        	success  = false;
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
        	LogUtil.error("set出错"+e.getMessage());
        	return "0";
        } finally {
        	if(success && jedis != null){
       		 	returnResource(jedis);
       	 	}
        }
    }
    
    /**
     * 
     * @param key
     * @param field
     * @param value
     */
    public static void hset(String key,String field , String value){
        Jedis jedis = null;
        boolean success = true;
        try {
            jedis = jedisPool.getResource();
            jedis.hset(key, field , value);
//            jedis.bgsave();
        } catch (Exception e) {
        	success  = false;
        	if(jedis != null){
        		jedisPool.returnBrokenResource(jedis);
        	}
        	LogUtil.error("set出错:"+e.getMessage());
        } finally {
        	 if(success && jedis != null){
        		 returnResource(jedis);
        	 }
        }
    }
    
    
    
    
    /**
     * @功能：通过Redis的key获取值，并释放连接资源
     * @参数：key，键值
     * @返回： 成功返回value，失败返回null
     */
    public static byte[] get(byte[] key){
        Jedis jedis = null;
        byte[] value = null;
        try {
            jedis = jedisPool.getResource();
            value = jedis.get(key);
        } catch (Exception e) {
        	jedisPool.returnBrokenResource(jedis);
            LogUtil.error("get出错"+e.getMessage());
        } finally {
        	returnResource(jedis);
        }
        return value;
    }
    /**
     * @功能：向redis存入key和value ,并设置过期时间（如果key已经存在 则覆盖），并释放连接资源
     * @参数：key，键
     * @参数：value，与key对应的值
     * @返回：成功返回“OK”，失败返回“0”
     */
    public static void set(byte[] key,int seconds,byte[] value){
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.setex(key,seconds, value);
            jedis.bgsave();
        } catch (Exception e) {
            jedisPool.returnBrokenResource(jedis);
            LogUtil.error("set出错"+e.getMessage());
        } finally {
            returnResource(jedis);
        }
    }
    
    /**
     * 删除
     * @param key
     */
    public static void delete(String key){
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.del(key);
        } catch (Exception e) {
        	jedisPool.returnBrokenResource(jedis);
        	LogUtil.error("删除出错"+e.getMessage());
        } finally {
        	returnResource(jedis);
        }
    }
    
    
    
    public static String getLongKeyShortValueRedirUrlFromCache(String longUrl) {
        String url = "";
		try {
			url = RedisUtil.get("longUrl:" + longUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

	public static void setLongKeyShortValueRedirUrlFromCache(String longUrl, String shortUrl) {
        try {
            RedisUtil.set("longUrl:" + longUrl, shortUrl);//1小时
            LogUtil.debug("set key>>>longUrl:" + longUrl+"  value>>>"+shortUrl);
        } catch (Exception e) {
           e.printStackTrace();
        }
    }
    
	public static  String getShortKeyLongValueRedirUrlFromCache(String shortUrl) {
    	String url = "";
        try {
        	url = RedisUtil.get("shortUrl:" + shortUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

	public static void setShortKeyLongValueRedirUrlFromCache(String shortUrl, String longUrl) {
        try {
            RedisUtil.set("shortUrl:" + shortUrl, longUrl);//1小时
            LogUtil.debug("set key>>>shortUrl:" + shortUrl+"  value>>>"+longUrl);
        } catch (Exception e) {
           e.printStackTrace();
        }
    }
	
	public static  String getShortNoKeyLongValueRedirUrlFromCache(String shortNo) {
    	String url = "";
        try {
        	url = RedisUtil.get("shortNo:" + shortNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

	public static void setShortNoKeyLongValueRedirUrlFromCache(String shortNo, String longUrl) {
        try {
            RedisUtil.set("shortNo:" + shortNo, longUrl);//1小时
            LogUtil.debug("set key>>>shortNo:" + shortNo+"  value>>>"+longUrl);
        } catch (Exception e) {
           e.printStackTrace();
        }
    }
	
	
    
    
    
}

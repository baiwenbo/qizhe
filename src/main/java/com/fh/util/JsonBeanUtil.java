package com.fh.util;

import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * Json与javaBean转换工具类
 * 
 * @author: Abner
 */
public class JsonBeanUtil {

    /**
     * javaBean 转换Json
     * 
     * @param obj
     * @return
     * @throws JsonProcessingException
     * @return: String
     */
    public static String bean2Json(Object obj) throws JsonProcessingException {
        ObjectMapper m = new ObjectMapper();
        m.setSerializationInclusion(Include.NON_NULL);
        m.configure(DeserializationFeature.USE_BIG_DECIMAL_FOR_FLOATS, true);
        /*
         * m.configure(DeserializationFeature.
         * ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true) ;
         * m.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS,
         * false).setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
         * m.getDeserializationConfig().without(DeserializationFeature.
         * FAIL_ON_UNKNOWN_PROPERTIES);
         */
        return m.writeValueAsString(obj);
    }

    /**
     * Json转换javaBean
     * 
     * @param json
     * @param obj
     * @return
     * @throws IOException
     * @return: Object
     */
    public static Object json2Bean(String json, Class clazz) throws IOException {
        ObjectMapper m = new ObjectMapper();
        return m.readValue(json, clazz);
    }

    /**
     * Json转换javaBean,从指定节点开始读取
     * 
     * @param json
     * @param fieldName
     * @param obj
     * @return
     * @throws IOException
     * @return: Object
     */
    public static Object json2Bean(String json, String fieldName, Class obj) throws IOException {
        ObjectMapper m = new ObjectMapper();
        JsonNode node = m.readTree(json); // 将Json串以树状结构读入内存
        JsonNode contents = node.findValue(fieldName);// 得到fieldName这个节点下的信息
        String afterJson = contents.toString();
        return m.readValue(afterJson, obj);
    }

    /**
     * Json转换javaBean,可以指定从指定节点开始读取，如果fieldName不为null则从fieldName节点开始读取，
     * 此时fieldNameMap必须有fieldName对应的类型
     * 
     * @param json
     * @param fieldNameMap
     * @return
     * @throws Exception
     * @return: Map<String,Object>
     */
    public static Map<String, Object> getJson2Bean(String json, Map<String, Class> fieldNameMap, String fieldName)
            throws Exception {
        Map<String, Object> returnMap = new HashMap<String, Object>();
        ObjectMapper m = new ObjectMapper();
        JsonNode node = m.readTree(json); // 将Json串以树状结构读入内存
        if (fieldName != null) {
            if (fieldNameMap != null && fieldNameMap.size() > 0) {
                Class classType = fieldNameMap.get(fieldName);
                if (classType == null) {
                    return null;
                }
                node = node.findValue(fieldName);// 得到fieldName这个节点下的信息
                String afterJson = node.toString();
                returnMap.put(fieldName, m.readValue(afterJson, classType));
                return returnMap;
            }
        }
        Iterator<Map.Entry<String, Class>> it = fieldNameMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, Class> entry = it.next();
            String key = entry.getKey();
            Class classType = entry.getValue();
            JsonNode contents = node.findValue(key);// 得到fieldName这个节点下的信息
            if (contents == null) {
                continue;
            }
            if (isBaseDataType(classType) && !contents.isArray()) {// 基本类型
                if (contents.isInt()) {
                    returnMap.put(key, node.get(key).asInt());
                } else if (contents.isLong()) {
                    returnMap.put(key, node.get(key).asLong());
                } else if (contents.isDouble()) {
                    returnMap.put(key, node.get(key).asDouble());
                } else if (contents.isBoolean()) {
                    returnMap.put(key, node.get(key).asBoolean());
                } else {
                    returnMap.put(key, node.get(key).asText());
                }
            } else if (contents.isArray()) {
                List list = new ArrayList();
                if (isBaseDataType(classType)) {
                    for (JsonNode currentNode : contents) {
                        if (currentNode.isInt()) {
                            list.add(currentNode.asInt());
                        } else if (currentNode.isLong()) {
                            list.add(currentNode.asLong());
                        } else if (currentNode.isDouble()) {
                            list.add(currentNode.asDouble());
                        } else if (currentNode.isBoolean()) {
                            list.add(currentNode.asBoolean());
                        } else {
                            list.add(currentNode.asText());
                        }
                    }
                    returnMap.put(key, list);
                } else {
                    for (JsonNode currentNode : contents) {
                        list.add(m.readValue(currentNode.traverse(), classType));
                        // list.add(m.treeToValue(currentNode, classType));
                    }
                    returnMap.put(key, list);
                }
            } else {
                String afterJson = contents.toString();
                returnMap.put(key, m.readValue(afterJson, classType));
            }
        }
        return returnMap;
    }

    /**
     * 判断一个类是否为基本数据类型。
     * 
     * @param clazz
     *            要判断的类。
     * @return true 表示为基本数据类型。
     */
    private static boolean isBaseDataType(Class clazz) throws Exception {
        return (clazz.equals(String.class) || clazz.equals(Integer.class) || clazz.equals(Byte.class)
                || clazz.equals(Long.class) || clazz.equals(Double.class) || clazz.equals(Float.class)
                || clazz.equals(Character.class) || clazz.equals(Short.class) || clazz.equals(BigDecimal.class)
                || clazz.equals(BigInteger.class) || clazz.equals(Boolean.class) || clazz.equals(Date.class) ||
                // clazz.equals(DateTime.class) ||
                clazz.isPrimitive());
    }

    /**
     * json串转map
     * 
     * @param jsonString
     * @return
     * @return: Map<String,String>
     */
    public static Map<String, String> jsonToMap(String jsonString) {
        Type type = new TypeToken<Map<String, String>>() {
        }.getType();
        Gson gson = new Gson();
        return gson.fromJson(jsonString, type);
    }

    /**
     * json 转 map
     * 
     * @Title: jsonToObjectMap
     * @Description: TODO
     * @param jsonString
     * @return
     * @return: Map<String,Object>
     */
    public static Map<String, Object> jsonToObjectMap(String jsonString) {
        Type type = new TypeToken<Map<String, Object>>() {
        }.getType();
        Gson gson = new Gson();
        return gson.fromJson(jsonString, type);
    }

    /**
     * json 转 list
     * 
     * @Title: jsonToObjectList
     * @Description: TODO
     * @param jsonString
     * @return
     * @return: List<Map<String,Object>>
     */
    public static List<Map<String, Object>> jsonToObjectList(String jsonString) {
        Type type = new TypeToken<List<Map<String, Object>>>() {
        }.getType();
        Gson gson = new Gson();
        return gson.fromJson(jsonString, type);
    }
}

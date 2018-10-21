package com.fh.entity.common;

/**
 * 通用 Message
 * 
 * @author m2
 */
public class Message {

    /**
     * 消息代码
     */
    private String code = "200";

    /**
     * 消息内容
     */
    private String text = "操作成功";

    public Message() {
    }

    public Message(String code, String text) {
        this.code = code;
        this.text = text;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

}

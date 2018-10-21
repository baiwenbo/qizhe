package com.fh.entity.common;

/**
 * Title: 银行名称响应实体<br/>
 * Description: <br/>
 * Copyrignt: Copyright(c) 2015 by www.motor2.cn<br/>
 * Company: 上海安美途金融信息服务有限公司
 * 
 * @author M2
 * @version V1.0.0
 * @since 2016-01-14 14:46:53
 */
public class BankNameResponse {
    /**
     * 银行名称
     */
    private String bankName;

    /**
     * 操作结果
     */
    private Message message;

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

}

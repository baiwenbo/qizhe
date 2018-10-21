package com.fh.entity.qizhe;

import java.util.Date;

public class Audit {

    private Integer id;

    private Integer scpcid;

    private String projectName;

    private String status;

    private String appeal;

    private String appealReply;

    private String lastReply;

    private Date appealDate;

    private Date appealReplyDate;

    private Date lastReplyDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getScpcid() {
        return scpcid;
    }

    public void setScpcid(Integer scpcid) {
        this.scpcid = scpcid;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAppeal() {
        return appeal;
    }

    public void setAppeal(String appeal) {
        this.appeal = appeal;
    }

    public String getAppealReply() {
        return appealReply;
    }

    public void setAppealReply(String appealReply) {
        this.appealReply = appealReply;
    }

    public String getLastReply() {
        return lastReply;
    }

    public void setLastReply(String lastReply) {
        this.lastReply = lastReply;
    }

    public Date getAppealDate() {
        return appealDate;
    }

    public void setAppealDate(Date appealDate) {
        this.appealDate = appealDate;
    }

    public Date getAppealReplyDate() {
        return appealReplyDate;
    }

    public void setAppealReplyDate(Date appealReplyDate) {
        this.appealReplyDate = appealReplyDate;
    }

    public Date getLastReplyDate() {
        return lastReplyDate;
    }

    public void setLastReplyDate(Date lastReplyDate) {
        this.lastReplyDate = lastReplyDate;
    }
}

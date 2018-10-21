package com.fh.entity.system;

import java.util.List;

import com.fh.model.SysRole;
import com.fh.model.SysUser;

public class UserInfo extends SysUser {

    private String area;

    private String areaText;

    private List<SysRole> roles;

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAreaText() {
        return areaText;
    }

    public void setAreaText(String areaText) {
        this.areaText = areaText;
    }

    public List<SysRole> getRoles() {
        return roles;
    }

    public void setRoles(List<SysRole> roles) {
        this.roles = roles;
    }

}

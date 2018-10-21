package com.fh.entity.system;

/**
 * 角色查询请求
 * 
 * @author Abner
 */
public class RoleSearchRequest {
    private String roleId;
    private String roleName;
    private Integer status;

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}

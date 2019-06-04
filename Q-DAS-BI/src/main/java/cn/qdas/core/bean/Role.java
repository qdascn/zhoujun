package cn.qdas.core.bean;

import java.util.List;

import cn.qdas.bi.bean.QbProductLine;

public class Role {
	private String roleId;
	private String roleName;
	private String available;
	private String availableStr;
	private List<Permission> permissionList;
	private List<QbProductLine> qbProductLineList;
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
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public List<Permission> getPermissionList() {
		return permissionList;
	}
	public void setPermissionList(List<Permission> permissionList) {
		this.permissionList = permissionList;
	}
	public String getAvailableStr() {
		return availableStr;
	}
	public void setAvailableStr(String availableStr) {
		this.availableStr = availableStr;
	}
	public List<QbProductLine> getQbProductLineList() {
		return qbProductLineList;
	}
	public void setQbProductLineList(List<QbProductLine> qbProductLineList) {
		this.qbProductLineList = qbProductLineList;
	}
	
}

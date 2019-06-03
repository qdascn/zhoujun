package cn.qdas.core.bean;

import java.util.List;

public class Role {
	private String roleId;
	private String roleName;
	private String available;
	private String availableStr;
	private List<Permission> permissionList;
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
	
}

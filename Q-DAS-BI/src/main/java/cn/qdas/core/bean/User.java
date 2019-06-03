package cn.qdas.core.bean;

import java.util.List;

public class User {
	private String userId;
	private String userName;
	private String password;
	private String userAccount;
	private String locked;
	private String lockedStr;
	private List<Role> roleList;
	private String roleStr;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getLocked() {
		return locked;
	}
	public void setLocked(String locked) {
		this.locked = locked;
	}
	public List<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	public String getRoleStr() {
		return roleStr;
	}
	public void setRoleStr(String roleStr) {
		this.roleStr = roleStr;
	}
	public String getLockedStr() {
		return lockedStr;
	}
	public void setLockedStr(String lockedStr) {
		this.lockedStr = lockedStr;
	}
	
}

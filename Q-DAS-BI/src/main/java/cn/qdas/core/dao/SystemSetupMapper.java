package cn.qdas.core.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;
public interface SystemSetupMapper {
	/**
	 * 获取所有用户及用户对应的角色
	 * @return
	 */
	List<User> getAllUser();
	/**
	 * 添加用户
	 * @param user
	 */
	void addUser(User user);
	/**
	 * 修改用户信息
	 * @param user
	 */
	void editUser(User user);
	/**
	 * 删除用户
	 * @param user
	 */
	void delUser(User user);
	/**
	 * 根据用户ID删除用户-角色中间表中的信息
	 * @param userId
	 */
	void delUserRole(String userId);
	/**
	 * 给用户授权角色，一个用户对应多个角色
	 * @param roleIdArr
	 * @param userId
	 */
	void addUserRole(@Param("roleIdArr")Integer[] roleIdArr,@Param("userId")String  userId);
	/**
	 * 获取所有产线权限
	 * @return
	 */
	List<Permission> getAllProductLine();
	/**
	 * 添加产线权限
	 * @param pl
	 * @return
	 */
	int addProductLine(ProductLine pl);
	/**
	 * 修改产线权限信息
	 * @param pl
	 * @return
	 */
	int updateProdectLine(ProductLine pl);
	/**
	 * 删除产线权限
	 * @param pl
	 */
	void delProductLine(ProductLine pl);
	/**
	 * 根据权限ID删除角色-权限中间表
	 * @param pl
	 */
	void delPlRole(ProductLine pl);
	/**
	 * 获取所有角色
	 * @return
	 */
	List<Role> getAllRole();
	/**
	 * 添加角色
	 * @param role
	 */
	void addRole(Role role);
	/**
	 * 修改角色信息
	 * @param role
	 */
	void editRole(Role role);
	/**
	 * 删除角色
	 * @param role
	 */
	void delRole(Role role);
	/**
	 * 获取所有权限（包含产线和主菜单）
	 * @return
	 */
	List<Permission> getAllPermission();
	/**
	 * 根据角色ID获取已有权限，授权tree显示打勾
	 * @param role
	 * @return
	 */
	List<Role> getPermissionByRoleId(Role role);
	/**
	 * 删除角色时 同时删除角色-权限中间表中的数据
	 * @param roleId
	 */
	void delPermissionByRoleId(String roleId);
	/**
	 * 删除角色时 同时删除用户-角色中间表中的数据
	 * @param roleId
	 */
	void delUserRoleByRoleId(String roleId);
	/**
	 * 给角色授权权限
	 * @param roleId
	 * @param permissionIds
	 */
	void addPermissionById(@Param ("roleId")String roleId,@Param ("permissionIds")Integer[] permissionIds);
}

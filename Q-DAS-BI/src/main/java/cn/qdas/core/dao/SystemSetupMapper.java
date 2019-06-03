package cn.qdas.core.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;


public interface SystemSetupMapper {
	List<User> getAllUser();

	List getAllProductLine();
	int addProductLine(ProductLine pl);
	int updateProdectLine(ProductLine pl);

	void delProductLine(ProductLine pl);
	List<Role> getAllRole();
	void addRole(Role role);
	void editRole(Role role);
	void delRole(Role role);
	List<Permission> getAllPermission();
	List<Role> getPermissionByRoleId(Role role);
	void delPermissionByRoleId(String roleId);
	void addPermissionById(@Param ("roleId")String roleId,@Param ("permissionIds")Integer[] permissionIds);
}

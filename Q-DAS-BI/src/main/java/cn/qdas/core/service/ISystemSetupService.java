/**
 * 
 */
package cn.qdas.core.service;

import java.util.List;
import java.util.Map;

import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;
import cn.qdas.core.db.DataSource;

/**
 * @author leo.Zhou 周钧
 * 2019年7月15日
 */
public interface ISystemSetupService {
	@DataSource("sqliteDataSource")
	List getAllUser();
	@DataSource("sqliteDataSource")
	Map addOrEditUser(User user,String addoredit);
	@DataSource("sqliteDataSource")
	Map userAddRole(String userId,Integer[]  roleIdArr);
	@DataSource("sqliteDataSource")
	Map delUser(User user);
	@DataSource("sqliteDataSource")
	List getAllProductLine();
	@DataSource("sqliteDataSource")
	Map addProductLine(ProductLine pl,String index);
	@DataSource("sqliteDataSource")
	Map delProductLine(ProductLine pl);
	@DataSource("sqliteDataSource")
	List getAllRole();
	@DataSource("sqliteDataSource")
	Map addRole(Role role,String addoredit);
	@DataSource("sqliteDataSource")
	Map delRole(Role role);
	@DataSource("sqliteDataSource")
	List getPermissionByRoleId(Role role);
	@DataSource("sqliteDataSource")
	Map addRolePermission(String roleId, Integer[] permissionIds);
}

/**
 * 
 */
package cn.qdas.core.service;

import java.util.List;

import cn.qdas.core.bean.User;
import cn.qdas.core.db.DataSource;

/**
 * @author leo.Zhou 周钧
 * 2019年7月15日
 */

public interface IMainPageService {
	@DataSource("sqliteDataSource")
	User checkLogin(User user);
	@DataSource("sqliteDataSource")
	User getUserRole(User user);
	@DataSource("sqliteDataSource")
	List getPermissionByUser(User user);
}

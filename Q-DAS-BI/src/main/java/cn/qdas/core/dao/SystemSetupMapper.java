package cn.qdas.core.dao;

import java.util.List;

import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.User;


public interface SystemSetupMapper {
	List<User> getAllUser();

	List getAllProductLine();
	int addProductLine(ProductLine pl);
	int updateProdectLine(ProductLine pl);

	void delProductLine(ProductLine pl);
}

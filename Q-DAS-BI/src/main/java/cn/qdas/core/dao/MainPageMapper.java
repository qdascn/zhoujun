package cn.qdas.core.dao;


import cn.qdas.core.bean.User;
public interface MainPageMapper {
	User checkLogin(User user);
	User getUserRole(User user);
}

package cn.qdas.core.dao;

import java.util.List;

import cn.qdas.core.bean.User;

public interface MainPageMapper {
	User checkLogin(User user);
	User getUserRole(User user);
}

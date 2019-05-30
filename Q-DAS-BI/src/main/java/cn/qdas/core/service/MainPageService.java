package cn.qdas.core.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.qdas.core.bean.User;
import cn.qdas.core.dao.MainPageMapper;

@Service
public class MainPageService {
	@Resource
	MainPageMapper mpm;
	public User checkLogin(User user) {
		User dbUser=mpm.checkLogin(user);
		return dbUser;
	}
	public User getUserRole(User user) {
		User dbUser=mpm.getUserRole(user);
		return dbUser;
	}
}

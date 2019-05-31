package cn.qdas.core.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;
import cn.qdas.core.dao.SystemSetupMapper;

@Service
public class SystemSetupService {
	@Resource
	SystemSetupMapper ssm;
	public List getAllUser() {
		List<User> list=ssm.getAllUser();
		for(int i=0;i<list.size();i++) {
			String roleStr="";
			List<Role> roleList=list.get(i).getRoleList();
			if(roleList.size()!=0) {
				for(int j=0;j<roleList.size();j++) {
					roleStr += roleList.get(j).getRoleName()+",";
				}
			}
			list.get(i).setRoleStr(roleStr);
		}
		return list;
	}
	public List getAllProductLine() {
		List list=ssm.getAllProductLine();
		return list;
	}
	public void addProductLine(ProductLine pl,String index) {
		
		if("1".equals(index)) {
			int result=ssm.addProductLine(pl);
		}else {
			int result=ssm.updateProdectLine(pl);
		}
		System.out.println(pl.getId()+"==========");
	}
	public void delProductLine(ProductLine pl) {
		ssm.delProductLine(pl);
	}
}

package cn.qdas.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.qdas.core.bean.Permission;
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
			if("0".equals(list.get(i).getLocked())) {
				list.get(i).setLockedStr("活跃");
			}else {
				list.get(i).setLockedStr("冻结");
			}
		}
		return list;
	}
	public List getAllProductLine() {
		List<Map<String, Object>> list=ssm.getAllProductLine();
		for(int i=0;i<list.size();i++) {
			if("0".equals(list.get(i).get("available"))) {
				list.get(i).put("availableStr", "可用");
			}else {
				list.get(i).put("availableStr", "不可用");
			}
		}
		return list;
	}
	public Map addProductLine(ProductLine pl,String index) {
		Map reMap=new HashMap<String, String>();
		try {
			if("1".equals(index)) {
				ssm.addProductLine(pl);
			}else {
				ssm.updateProdectLine(pl);
			}
			reMap.put("success", "0");
		} catch (Exception e) {
			reMap.put("success", "1");
			reMap.put("error", e);
		}
		return reMap;
	}
	public Map delProductLine(ProductLine pl) {
		Map reMap=new HashMap<String, String>();
		try {
			ssm.delProductLine(pl);
			reMap.put("success", "0");
		} catch (Exception e) {
			reMap.put("success", "1");
			reMap.put("error", e);
		}
		return reMap;
	}
	public List getAllRole() {
		List<Role> list=ssm.getAllRole();
		for(int i=0;i<list.size();i++) {
			if("0".equals(list.get(i).getAvailable())) {
				list.get(i).setAvailableStr("可用");
			}else {
				list.get(i).setAvailableStr("不可用");
			}
		}
		return list;
	}
	public Map addRole(Role role,String addoredit) {
		Map reMap=new HashMap<String, String>();
		try {
			if("2".equals(addoredit)) {
				ssm.editRole(role);
			}else {
				ssm.addRole(role);
			}
			reMap.put("success", "0");
		} catch (Exception e) {
			reMap.put("success", "1");
			reMap.put("error", e);
		}
		return reMap;
		
	}
	public Map delRole(Role role) {
		Map reMap=new HashMap<String, String>();
		try {
			ssm.delRole(role);
			reMap.put("success", "0");
		} catch (Exception e) {
			reMap.put("success", "1");
			reMap.put("error", e);
		}
		return reMap;
	}
	public List getPermissionByRoleId(Role role) {
		List<Role> roleList=ssm.getPermissionByRoleId(role);
		List<Permission> plist=ssm.getAllPermission();
		List treeList=new ArrayList<Map>();
		Map menuMap=new HashMap<String, Object>();
		List menuList=new ArrayList<Map>();
		menuMap.put("id", 1);
		menuMap.put("text", "菜单");
		menuMap.put("state", "open");
		Map plMap=new HashMap<String, Object>();
		List plList=new ArrayList<Map>();
		plMap.put("id", 2);
		plMap.put("text", "产线");
		plMap.put("state", "open");
		for(int i=0;i<plist.size();i++) {
			Map perMap=new HashMap<String, Object>();
			perMap.put("text",plist.get(i).getPermissionName());
			perMap.put("permissionId", plist.get(i).getPermissionId());
			if(roleList.size()!=0) {
				List<Permission> rolePerList=roleList.get(0).getPermissionList();
				for(int j=0;j<rolePerList.size();j++) {
					if(rolePerList.get(j).getPermissionId().equals(plist.get(i).getPermissionId())) {
						perMap.put("checked",true);
					}
				}
			}
			if("menu".equals(plist.get(i).getType())) {
				perMap.put("id", "1"+String.valueOf(i));
				menuList.add(perMap);
			}else {
				perMap.put("id", "2"+String.valueOf(i));
				plList.add(perMap);
			}
		}
		menuMap.put("children",menuList);
		plMap.put("children", plList);
		treeList.add(menuMap);
		treeList.add(plMap);
		System.out.println(treeList);
		return treeList;
	}
	public Map addRolePermission(String roleId, Integer[] permissionIds) {
		Map reMap=new HashMap<String, String>();
		try {
			ssm.delPermissionByRoleId(roleId);
			ssm.addPermissionById(roleId, permissionIds);
			reMap.put("success", "0");
		} catch (Exception e) {
			reMap.put("success", "1");
			reMap.put("error", e);
		}
		return reMap;
	}
}

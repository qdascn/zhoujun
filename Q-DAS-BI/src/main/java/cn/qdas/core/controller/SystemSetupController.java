package cn.qdas.core.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;
import cn.qdas.core.service.ISystemSetupService;

@Controller
@RequestMapping("/system")
public class SystemSetupController {
	@Resource
	ISystemSetupService sss;
	@RequestMapping("initSetupPage")
	public String initSetupPage(HttpServletRequest req,Model model) {
		User user=(User) req.getAttribute("user");
		model.addAttribute("user", user);
		return "systemSetup/systemSetup";
	}
	@RequestMapping("initUserSetup")
	public String initUserSetupPage() {
		return "systemSetup/userSetup";
	}
	
	@RequestMapping("getAllUser")
	@ResponseBody
	public List getAllUser() {
		List list=sss.getAllUser();
		return list;
	}
	@RequestMapping("addOrEditUser")
	@ResponseBody
	public Map addOrEditUser(User user,String addoredit) {
		Map map=sss.addOrEditUser(user, addoredit);
		return map;
	}
	@RequestMapping("delUser")
	@ResponseBody
	public Map delUser(User user) {
		Map map=sss.delUser(user);
		return map;
	}
	@RequestMapping("userAddRole")
	@ResponseBody
	public Map userAddRole(String userId,@RequestParam(value = "roleIdArr[]")  Integer[]  roleIdArr) {
		Map map=sss.userAddRole(userId, roleIdArr);
		
		return map;
	}
	@RequestMapping("initProductLineSetup")
	public String initProductLineSetup() {
		return "systemSetup/productLineSetup";
	}
	@RequestMapping("getAllProductLine")
	@ResponseBody
	public List getAllProductLine() {
		List list=sss.getAllProductLine();
		return list;
	}	
	@RequestMapping("addProductLine")
	@ResponseBody
	public Map addProductLine(ProductLine pl,String index,String id) {
		pl.setId(id);
		Map map=sss.addProductLine(pl,index);
		return map;
	}
	@RequestMapping("delProductLine")
	@ResponseBody
	public Map delProductLine(String id) {
		ProductLine pl=new ProductLine();
		pl.setId(id);
		Map map=sss.delProductLine(pl);
		return map;
	}
	/**
	 * 角色设置页面初始化
	 * @return
	 */
	@RequestMapping("initRoleSetupPage")
	public String initRoleSetupPage() {
		return "systemSetup/roleSetup";
	}
	/**
	 * 获取角色表所有信息
	 * @return
	 */
	@RequestMapping("getAllRole")
	@ResponseBody
	public List getAllRole() {
		List list=sss.getAllRole();
		return list;
	}
	/**
	 * 添加或编辑角色
	 * @param role
	 */
	@RequestMapping("addRole")
	@ResponseBody
	public Map addRole(Role role,String addoredit) {
		Map map=sss.addRole(role,addoredit);
		return map;
	}
	/**
	 * 删除角色
	 * @param role
	 */
	@RequestMapping("delRole")
	@ResponseBody
	public Map delRole(Role role) {
		Map map=sss.delRole(role);
		return map;
	}
	/**
	 * 获取权限tree数据
	 * @param role
	 * @return
	 */
	@RequestMapping("getPermissionByRoleId")
	@ResponseBody
	public List getPermissionByRoleId(Role role) {
		List list=sss.getPermissionByRoleId(role);
		return list;
	}
	@RequestMapping("addRolePermission")
	@ResponseBody
	public Map addRolePermission(String roleId,@RequestParam(value = "permissionIds[]")  Integer[]  permissionIds) {
		Map map=sss.addRolePermission(roleId,permissionIds);
		return map;
	}
}

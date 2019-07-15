package cn.qdas.core.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.User;
import cn.qdas.core.service.IMainPageService;

@Controller
@RequestMapping("/main")
public class MainPageController {
	@Resource
	IMainPageService mps;
	@RequestMapping("loginPage")
	public String initLoginPage() {
		return "base/loginPage";
	}
	
	@RequestMapping("doLogin")
	@ResponseBody
	public Map doLogin(User user,HttpServletRequest req){
		HttpSession session=req.getSession();
		User reUser=mps.checkLogin(user);
		Map map=new HashMap<String, Object>();
		if(reUser==null) {
			map.put("message", "账户不存在");
			return map;
		}else {
			if(!user.getPassword().equals(reUser.getPassword())) {
				map.put("message", "密码错误");
				return map;
			}else if("1".equals(reUser.getLocked())) {
				map.put("message", "您的账号已被冻结");
				return map;
			}else {
				session.setAttribute("user", reUser);
				map.put("message", "0");
				return map;
			}
		}
	}
	@RequestMapping("mainPage")
	public String initMainPage(Model model,HttpServletRequest req) {
		HttpSession session=req.getSession();
		User user=(User) session.getAttribute("user");
		List<Permission> list=mps.getPermissionByUser(user);
		user.setPermissionList(list);
		session.setAttribute("user", user);
		model.addAttribute("permissionList", list);
		return "base/mainPage";
	}
	@RequestMapping("loginError")
	public String initLoginErrorPage() {
		return "base/loginError";
	}
	@RequestMapping("logout")
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session=req.getSession();
		session.removeAttribute("user");
		return new ModelAndView("redirect:/main/loginPage");
	}
}

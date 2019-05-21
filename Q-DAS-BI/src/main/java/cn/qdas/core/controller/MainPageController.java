package cn.qdas.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainPageController {
	@RequestMapping("loginPage")
	public String initLoginPage() {
		return "base/loginPage";
	}
	@RequestMapping("mainPage")
	public String initMainPage() {
		return "base/mainPage";
	}
}

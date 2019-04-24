package cn.qdas.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainPageController {
	@RequestMapping("mainPage")
	public String initMainPage() {
		return "base/mainPage";
	}
	@RequestMapping("mainTop")
	public String initTop() {
		return "base/top";
	}
	@RequestMapping("mainLeft")
	public String initLeft() {
		return "base/left";
	}
	@RequestMapping("mainFooter")
	public String initFooter() {
		return "base/footer";
	}
}

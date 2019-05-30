package cn.qdas.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/system")
public class SystemSetupController {
	@RequestMapping("initSetupPage")
	public String initSetupPage() {
		return "systemSetup/systemSetup";
	}
}

package cn.qdas.case2.controller;

import java.util.HashMap;
import java.util.Map;


import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.case2.service.GetDetailWs;


@Controller
@RequestMapping("/case2")
public class TestWsController {
	@RequestMapping("testWs")
	public String initTestWsPage() {
		return "case2/testWs";
	}
	@ResponseBody
	@RequestMapping("getWsInfo")
	public Map getWsInfo(Model model,String name) {
		JaxWsProxyFactoryBean factory=new JaxWsProxyFactoryBean();
		factory.setAddress("http://localhost:8080/Q-DAS-caseShow/webService/GetDetailWs");
		GetDetailWs client=factory.create(GetDetailWs.class);
		String aa=client.getAllDetail(name);
		//model.addAttribute("result", aa);
		Map map=new HashMap<String ,Object>();
		map.put("result", aa);
		return map;
	}
}

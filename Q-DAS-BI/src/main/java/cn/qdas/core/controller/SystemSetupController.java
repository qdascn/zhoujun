package cn.qdas.core.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.core.bean.ProductLine;
import cn.qdas.core.service.SystemSetupService;

@Controller
@RequestMapping("/system")
public class SystemSetupController {
	@Resource
	SystemSetupService sss;
	@RequestMapping("initSetupPage")
	public String initSetupPage() {
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
	public void addProductLine(ProductLine pl,String index,String id) {
		pl.setId(id);
		sss.addProductLine(pl,index);
	}
	@RequestMapping("delProductLine")
	public void delProductLine(String id) {
		ProductLine pl=new ProductLine();
		pl.setId(id);
		sss.delProductLine(pl);
	}
}

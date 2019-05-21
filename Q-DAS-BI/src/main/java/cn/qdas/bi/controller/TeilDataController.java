package cn.qdas.bi.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.bi.bean.Teil;
import cn.qdas.bi.service.ITeilDataService;

@Controller
@RequestMapping("/teil")
public class TeilDataController {
	@Resource
	ITeilDataService teilDataService;
	@RequestMapping("initTeil")
	public String initTeilPage() {
		return "bi/teilData";
	}
	@RequestMapping("getTeilData")
	@ResponseBody
	public Map getTeilData(Teil teil) {
		Map map=teilDataService.getAllTeil(teil);
		return map;
	}
	@RequestMapping("getMerkmalData")
	@ResponseBody
	public Map getMerkmalData(Teil teil) {
		Map map = teilDataService.getAllMerkmal(teil);
		return map;
	}
	@RequestMapping("getWertevarData")
	@ResponseBody
	public Map getWertevarData(Teil teil) {
		Map map = teilDataService.getAllWertevar(teil);
		return map;
	}
}

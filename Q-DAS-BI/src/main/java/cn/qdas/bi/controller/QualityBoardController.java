package cn.qdas.bi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/qb")
public class QualityBoardController {
	@RequestMapping("initQb")
	public String initQbPage(Model model) {
		List<Map> list=new ArrayList();
		for(int i=0;i<20;i++) {
			Map map=new HashMap<String, Object>();
			map.put("pName", "qdas-"+i);
			map.put("pId", "qdas-"+i);
			list.add(map);
		}
		model.addAttribute("list",list);
		return "bi/qualityBoard";
	}
}

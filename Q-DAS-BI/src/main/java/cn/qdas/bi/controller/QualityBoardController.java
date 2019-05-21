package cn.qdas.bi.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.service.IQualityBoardService;

@Controller
@RequestMapping("/qb")
public class QualityBoardController {
	@Resource
	IQualityBoardService iqbs;
	@RequestMapping("initQb")
	public String initQbPage(Model model,QualityBoard qb) {
		List<Map> list=iqbs.getProductLine(qb);
		model.addAttribute("plList",list);
		return "bi/qualityBoard";
	}
	
	@RequestMapping("getTeilData")
	@ResponseBody
	public List getTeilData(QualityBoard qb) {
		List <Map> list=iqbs.getTeilData(qb);
		return list;
	}
	
	@RequestMapping("initTeilData")
	public String initTeilData(Model model,QualityBoard qb) {
		List <Map> teilList=iqbs.getTeilData(qb);
		model.addAttribute("teilList",teilList);
		return "bi/qbTeilData";
	}
	@RequestMapping("initMerkmalData")
	public String initMerkmalData(Model model,QualityBoard qb) {
		System.out.println(qb.getTeilId());
		List list=iqbs.getMerkmalData(qb);
		System.out.println(list);
		model.addAttribute("merkmalList", list);
		return "bi/qbMerkmalData";
	}
}

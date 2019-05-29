package cn.qdas.bi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.bean.Teil;
import cn.qdas.bi.service.IQualityBoardService;

@Controller
@RequestMapping("/qb")
public class QualityBoardController {
	@Resource
	IQualityBoardService iqbs;
	@RequestMapping("initQb")
	public String initQbPage() {
		//List<Map> list=iqbs.getProductLine(qb);
		//model.addAttribute("plList",list);
		return "bi/qb/qualityBoard";
	}
	
	@RequestMapping("getProductLineData")
	public String getProductLineData(Model model,QualityBoard qb) {
		List<Map> list=iqbs.getProductLine(qb);
		Map map=new HashMap<String, String>();
		map.put("startTime", qb.getStartTime());
		map.put("endTime", qb.getEndTime());
		map.put("plName", qb.getProductLineName());
		map.put("plList", list);
		model.addAttribute("paramMap", map);
		return "bi/qb/qbProductLineData";
	}
	
	@RequestMapping("initTeilData")
	public String initTeilData(Model model,QualityBoard qb) {
		List <Map> teilList=iqbs.getTeilData(qb);
		Map map=new HashMap<String, String>();
		map.put("plId", qb.getProductLineName());
		map.put("teilList",teilList);
		map.put("startTime", qb.getStartTime());
		map.put("endTime", qb.getEndTime());
		model.addAttribute("paramMap", map);
		return "bi/qb/qbTeilData";
	}
	@RequestMapping("initMerkmalData")
	public String initMerkmalData(Model model,QualityBoard qb) {
		List list=iqbs.getMerkmalData(qb);
		Map map=new HashMap<String, String>();
		map.put("startTime", qb.getStartTime());
		map.put("endTime", qb.getEndTime());
		map.put("teilId", qb.getTeilId());
		map.put("merkmalList", list);
		model.addAttribute("paramMap", map);
		return "bi/qb/qbMerkmalData";
	}
	@RequestMapping("initWertevarChart")
	@ResponseBody
	public List getWertevarChartData(QualityBoard qb) {
		List list=iqbs.getWertevarChartData(qb);
		return list;
	}
	@RequestMapping("getWertevarData")
	@ResponseBody
	public List getWertevarData(QualityBoard qb) {
		List list = iqbs.getWertevarDate(qb);
		return list;
	}
}

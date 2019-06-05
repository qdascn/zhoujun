package cn.qdas.bi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.bi.bean.QbProductLine;
import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.bean.Teil;
import cn.qdas.bi.service.IQualityBoardService;
import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.User;

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
	public String getProductLineData(HttpServletRequest request,Model model,QualityBoard qb) {
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("user");
		//List<Map> list=iqbs.getProductLine(qb);
		List list =iqbs.getProductLineByUser(user,qb);
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
	@RequestMapping("initQbShow")
	public String initQbShowPage() {
		return "bi/qb/qbShow";
	}
	@RequestMapping("getQbForm")
	@ResponseBody
	public Map getQbFormData(HttpServletRequest request,Integer arrIndex) {
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("user");
		List<Permission> list=user.getPermissionList();
		Map map=iqbs.getQbFormData(list,arrIndex);
		return map;
	}
}

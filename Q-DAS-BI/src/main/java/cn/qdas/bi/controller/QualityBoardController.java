package cn.qdas.bi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.bi.bean.QualityBoard;
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
		return "bi/qb/qualityBoard";
	}
	
	@RequestMapping("getProductLineData")
	public String getProductLineData(HttpServletRequest request,Model model,QualityBoard qb) {
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("user");
		List list =iqbs.getProductLineByUser(user,qb);
		Map map=new HashMap<String, String>();
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
		model.addAttribute("paramMap", map);
		return "bi/qb/qbTeilData";
	}
	@RequestMapping("initTeilDataByPage")
	public String initTeilDataByPage(Model model,QualityBoard qb) {
		Map teilMap=iqbs.getTeilDataByPage(qb);
		Map map=new HashMap<String, String>();
		map.put("plId", qb.getProductLineName());
		map.put("teilList",teilMap.get("rows"));
		map.put("totalRows", teilMap.get("total"));
		model.addAttribute("paramMap", map);
		return "bi/qb/qbTeilData";
	}
	@RequestMapping("initMerkmalData")
	public String initMerkmalData(Model model,QualityBoard qb) {
		List list=iqbs.getMerkmalData(qb);
		Map map=new HashMap<String, String>();
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
	/**
	 * 
	 * @param index 1:所有产线的数据  2：单个产线的数据 3：单个零件的数据
	 * @param productLineName
	 * @return
	 */
	@RequestMapping("initQbShow")
	public String initQbShowPage(Model model,String index,String productLineName,String teilId) {
		model.addAttribute("index", index);
		model.addAttribute("productLineName", productLineName);
		model.addAttribute("teilId", teilId);
		return "bi/qb/qbShow";
	}
	@RequestMapping("getQbForm")
	@ResponseBody
	public Map getQbFormData(HttpServletRequest request,Integer arrIndex,QualityBoard qb,String teilId,String productLineName,String index) {
		List<Permission> list=new ArrayList<Permission>();
		Map map=new HashMap<String,Object>();
		switch (index) {
			case "1":
				HttpSession session=request.getSession();
				User user=(User) session.getAttribute("user");
				list=user.getPermissionList();
				map=iqbs.getQbFormData(list,arrIndex,qb);
				break;
			case "2":
				String [] plArr= {productLineName};
				map=iqbs.getQbTeilsFormData(plArr,arrIndex,qb);
				break;
			case "3":
				map=iqbs.getQbTeilFormData(teilId,arrIndex,qb);
				break;
		}
		return map;
	}
}

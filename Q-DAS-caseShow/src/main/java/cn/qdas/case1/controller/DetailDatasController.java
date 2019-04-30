package cn.qdas.case1.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import cn.qdas.case1.service.IDetailDataService;
import cn.qdas.core.bean.Filter;


@Controller
@RequestMapping("/case1")
public class DetailDatasController {
	@Resource
	IDetailDataService  dds;
	@RequestMapping("/initPage")
	public String initPage() {
		
		return "case1/detailDatas";
	}
	@ResponseBody
	@RequestMapping("/getAllDetailData")
	public List getAllDetailData() {
		List list=dds.getAllDetailData();
		return list;
	}
	@ResponseBody
	@RequestMapping("/getParamById")
	public Map getParamById(Filter filter) {
		Map map=dds.getParamById(filter);
		return map;
	}
	@ResponseBody
	@RequestMapping("/getSizeById")
	public List getSizeById(Filter filter) {
		List<Map> list=dds.getSizeById(filter);
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")));
		}
		return list;
	}
	@RequestMapping("/chartDemo")
	public String initChartDemoPage() {
		return "case1/chartDemo";
	}
}

package cn.qdas.case1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.qdas.case1.service.IDetailDataService;


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
	public List getParamById(String detailId) {
		List list=dds.getParamById(detailId);
		return list;
	}
	@ResponseBody
	@RequestMapping("/getSizeById")
	public List getSizeById(String detailId,String paramId) {
		List<Map> list=dds.getSizeById(detailId,paramId);
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")));
		}
		return list;
	}
}

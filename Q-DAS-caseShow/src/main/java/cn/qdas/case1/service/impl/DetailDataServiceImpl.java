package cn.qdas.case1.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.qdas.case1.dao.DetailDataMapper;
import cn.qdas.case1.service.IDetailDataService;
import cn.qdas.core.bean.Filter;

@Service
public class DetailDataServiceImpl implements IDetailDataService {
	@Resource
	DetailDataMapper ddm;
	@Override
	public List getAllDetailData() {
		List list=ddm.getAllDetails();
		return list;
	}
	@Override
	public Map getParamById(Filter filter) {
		Map map=new HashMap<String,Object>();
		Page page = PageHelper.startPage(filter.getPage(), filter.getRows(), true);
		List list=ddm.getParamById(filter.get("detailId"));
		map.put("total",page.getTotal());
		map.put("rows", list);
		return map;
	}
	@Override
	public List getSizeById(Filter filter) {
		//List list=ddm.getSizeById(filter.get("detailId"),filter.get("paramId"),filter.get("startTime"),filter.get("endTime"));
		List list=ddm.getSizeById(filter);
		return list;
	}

}

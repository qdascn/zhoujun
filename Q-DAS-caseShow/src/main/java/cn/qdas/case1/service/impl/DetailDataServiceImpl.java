package cn.qdas.case1.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.qdas.case1.dao.DetailDataMapper;
import cn.qdas.case1.service.IDetailDataService;

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
	public List getParamById(String id) {
		List list=ddm.getParamById(id);
		return list;
	}
	@Override
	public List getSizeById(String detailId,String paramId) {
		List list=ddm.getSizeById(detailId,paramId);
		return list;
	}

}

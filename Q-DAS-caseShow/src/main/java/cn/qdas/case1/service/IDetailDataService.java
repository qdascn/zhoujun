package cn.qdas.case1.service;

import java.util.List;
import java.util.Map;

import cn.qdas.core.bean.Filter;

public interface IDetailDataService {
	List getAllDetailData();
	Map getParamById(Filter filter);
	List getSizeById(Filter filter);
}

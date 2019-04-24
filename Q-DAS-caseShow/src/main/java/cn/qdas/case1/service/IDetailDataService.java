package cn.qdas.case1.service;

import java.util.List;

public interface IDetailDataService {
	List getAllDetailData();
	List getParamById(String id);
	List getSizeById(String detailId,String paramId);
}

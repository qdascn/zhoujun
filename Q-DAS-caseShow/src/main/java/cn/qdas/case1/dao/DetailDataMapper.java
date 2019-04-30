package cn.qdas.case1.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.qdas.core.bean.Filter;

public interface DetailDataMapper {
	List getAllDetails();
	List getParamById(String id);
	//List getSizeById(@Param("detailId")String detailId,@Param("paramId")String paramId);
	List getSizeById(Filter filter);
}

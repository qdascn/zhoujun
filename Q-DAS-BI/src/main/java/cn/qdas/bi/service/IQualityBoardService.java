package cn.qdas.bi.service;

import java.util.List;
import java.util.Map;

import cn.qdas.bi.bean.QbProductLine;
import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.User;

public interface IQualityBoardService {


	List getTeilData(QualityBoard qb);
	Map getTeilDataByPage(QualityBoard qb);
	List getMerkmalData(QualityBoard qb);

	List getWertevarChartData(QualityBoard qb);

	List<Map> getProductLineByUser(User user, QualityBoard qb);

	List getWertevarDate(QualityBoard qb);

	Map getQbFormData(List<Permission> list, Integer arrIndex, QualityBoard qb);
	Map getQbTeilsFormData(String [] plArr,Integer arrIndex,QualityBoard qb);
	Map getQbTeilFormData(String teilId,Integer arrIndex,QualityBoard qb);
}

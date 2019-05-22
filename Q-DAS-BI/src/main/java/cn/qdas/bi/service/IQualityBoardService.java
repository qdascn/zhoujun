package cn.qdas.bi.service;

import java.util.List;

import cn.qdas.bi.bean.QualityBoard;

public interface IQualityBoardService {
	List getProductLine(QualityBoard qb) ;
	List getTeilData(QualityBoard qb);
	List getMerkmalData(QualityBoard qb);
	List getWertevarChartData(QualityBoard qb);
}

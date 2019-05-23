package cn.qdas.bi.dao;

import java.util.List;

import cn.qdas.bi.bean.QualityBoard;

public interface QualityBoardMapper {
	List getProductLine(QualityBoard qb);
	List getTeilData(QualityBoard qb);
	List getMerkmalData(QualityBoard qb);
	List getWertevarChartData(QualityBoard qb);
	List getWertevarDate(QualityBoard qb);
}

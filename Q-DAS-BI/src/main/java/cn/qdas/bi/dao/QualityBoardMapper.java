package cn.qdas.bi.dao;

import java.util.List;

import cn.qdas.bi.bean.QbProductLine;
import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.core.bean.User;

public interface QualityBoardMapper {
	List getProductLine(QualityBoard qb);
	List getProductLineWithColor(QualityBoard qb);
	List getTeilData(QualityBoard qb);
	List getMerkmalData(QualityBoard qb);
	List getWertevarChartData(QualityBoard qb);
	List getWertevarDate(QualityBoard qb);
	
	/**
	 * 获取产线下报警信息
	 * @param user
	 * @return
	 */
	User getProductLineByUser(User user);
	List<QbProductLine> getAlarmValuesByProductLine(String[] productLineNames);
}

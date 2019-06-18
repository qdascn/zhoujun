package cn.qdas.bi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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
	List getAlarmValuesByProductLine(@Param("productLineNames")String[] productLineNames,@Param("startTime")String startTime,@Param("endTime")String endTime);
	
	List<Map> getQbFormData(@Param("productLineNames")String[] productLineNames,@Param("startTime")String startTime,@Param("endTime")String endTime);
	List<Map> getQbTableData(@Param("teilId")String teilId,@Param("merkmalId")String merkmalId);
	List<Map> getQbTeilFormData(@Param("teilId")String teilId,@Param("startTime")String startTime,@Param("endTime")String endTime);
}

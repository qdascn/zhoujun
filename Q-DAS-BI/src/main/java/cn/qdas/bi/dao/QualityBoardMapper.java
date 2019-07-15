package cn.qdas.bi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.qdas.bi.bean.QualityBoard;
public interface QualityBoardMapper {
	List getTeilAlarmCountData(QualityBoard qb);
	List getMerkmalAlarmCountData(QualityBoard qb);
	List getWertevarChartData(QualityBoard qb);
	List getWertevarDate(QualityBoard qb);
	
	/**
	 * 获取产线下报警信息
	 * @param user
	 * @return
	 */
	List getAlarmCountByProductLine(@Param("productLineNames")String[] productLineNames,@Param("startTime")String startTime,@Param("endTime")String endTime);
	List<Map> getQbFormData(@Param("productLineNames")String[] productLineNames,@Param("startTime")String startTime,@Param("endTime")String endTime);
	List<Map> getQbTableData(@Param("teilId")String teilId,@Param("merkmalId")String merkmalId,@Param("startTime")String startTime,@Param("endTime")String endTime);
	List<Map> getQbTeilFormData(@Param("teilId")String teilId,@Param("startTime")String startTime,@Param("endTime")String endTime);
}

package cn.qdas.bi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.dao.QualityBoardMapper;
import cn.qdas.bi.service.IQualityBoardService;
@Service
public class QualityBoardServiceImpl implements IQualityBoardService{
	@Resource
	QualityBoardMapper qbm;
	@Override
	public List getProductLine(QualityBoard qb) {
		List<Map> list = qbm.getProductLine(qb);
		for(int i=0;i<list.size();i++) {
			if(list.get(i)==null) {
				list.remove(i);
			}
		}
		for(int i=0;i<list.size();i++) {
			Map map=list.get(i);
			map.put("plId","plId"+(i+1));
		}
		return list;
	}
	@Override
	public List getTeilData(QualityBoard qb) {
		List list=qbm.getTeilData(qb);
		return list;
	}
	@Override
	public List getMerkmalData(QualityBoard qb) {
		List list=qbm.getMerkmalData(qb);
		return list;
	}
	@Override
	public List getWertevarChartData(QualityBoard qb) {
		List<Map> list=qbm.getWertevarChartData(qb);
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")).substring(0, 19));
		}
		return list;
	}

}

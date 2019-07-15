package cn.qdas.bi.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.qdas.bi.bean.QbAlarmValues;
import cn.qdas.bi.bean.QbProductLine;
import cn.qdas.bi.bean.QbTeil;
import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.dao.QualityBoardMapper;
import cn.qdas.bi.service.IQualityBoardService;
import cn.qdas.core.bean.Permission;
import cn.qdas.core.bean.Role;
import cn.qdas.core.bean.User;
import cn.qdas.core.utils.Globals;
@Service
public class QualityBoardServiceImpl implements IQualityBoardService{
	@Resource
	QualityBoardMapper qbm;
	@Override
	public Map getTeilDataByPage(QualityBoard qb) {
		Page page = PageHelper.startPage(qb.getPage(), qb.getRows(), true);
		List<Map> list=qbm.getTeilAlarmCountData(qb);
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0) {
				map.put("qualityLevel","3");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
				map.put("qualityLevel","2");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
				map.put("qualityLevel","1");
			}else{
				map.put("qualityLevel","0");
			}
		}
		Map reMap=new HashMap<String, Object>();
		reMap.put("rows",list);
		reMap.put("total",page.getTotal());
		return reMap;
	}
	public List getTeilData(QualityBoard qb) {
		List<Map> list=qbm.getTeilAlarmCountData(qb);
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0) {
				map.put("qualityLevel","3");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
				map.put("qualityLevel","2");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
				map.put("qualityLevel","1");
			}else{
				map.put("qualityLevel","0");
			}
		}
		return list;
	}
	@Override
	public List getMerkmalData(QualityBoard qb) {
		List<Map> list=qbm.getMerkmalAlarmCountData(qb);
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0) {
				map.put("qualityLevel","3");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
				map.put("qualityLevel","2");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
				map.put("qualityLevel","1");
			}else{
				map.put("qualityLevel","0");
			}
		}
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
	@Override
	public List getWertevarDate(QualityBoard qb) {
		List<Map> list=qbm.getWertevarDate(qb);
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")).substring(0, 19));
		}
		return list;
	}
	@Override
	public List<Map> getProductLineByUser(User user,QualityBoard qb) {
		List<String> plList=new ArrayList<String>();
		List<Permission> permissionList=user.getPermissionList();
		for(int i=0;i<permissionList.size();i++) {
			if("pl".equals(permissionList.get(i).getType())) {
				plList.add(permissionList.get(i).getPermissionName());
			}
		}
		String[] plArr=new String[plList.size()];
		for(int i=0;i<plList.size();i++) {
			plArr[i]=plList.get(i);
		}
		List<Map> list=qbm.getAlarmCountByProductLine(plArr, qb.getStartTime(),qb.getEndTime());
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(null==map.get("TEERZEUGNIS")||"".equals(map.get("TEERZEUGNIS"))){
				list.remove(i);
				i--;
			}else{
				if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0){
					map.put("qualityLevel","3");
				}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
					map.put("qualityLevel","2");
				}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
					map.put("qualityLevel","1");
				}else{
					map.put("qualityLevel","0");
				}
				map.put("buttonId",String.valueOf(map.get("TEERZEUGNIS")));
			}
		}
		return list;
	}
	@Override
	public Map getQbFormData(List<Permission> list,Integer arrIndex,QualityBoard qb) {
		for(int i=0;i<list.size();i++) {
			if(!"pl".equals(list.get(i).getType())) {
				list.remove(i);
			}
		}
		String[] plArr=new String[list.size()];
		for(int i=0;i<list.size();i++) {
			plArr[i]=list.get(i).getPermissionName();
		}
		List<Map> formlist=qbm.getQbFormData(plArr,qb.getStartTime(),qb.getEndTime());
		List<Map> tableList=new ArrayList<Map>();
		Map reMap=new HashMap<String, Object>();
		Map formMap=new HashMap<String, Object>();
		if(formlist.size()>0) {
			tableList=qbm.getQbTableData(formlist.get(arrIndex).get("TETEIL").toString(), formlist.get(arrIndex).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
			if(arrIndex==(formlist.size()-1)) {
				reMap.put("arrAlarm", "1");
			}else {
				reMap.put("arrAlarm", "0");
			}
			for(int i=0;i<tableList.size();i++) {
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0, 19));
			}
			formMap=formlist.get(arrIndex);
			reMap.put("formList", formMap);
		}else {
			reMap.put("arrAlarm", "1");
		}
		reMap.put("formList", formMap);
		reMap.put("tableList", tableList);
		return reMap;
	}
	/**
	 * 获取单个产线所有数据
	 */
	public Map getQbTeilsFormData(String [] plArr,Integer arrIndex,QualityBoard qb) {
		List<Map> formlist=qbm.getQbFormData(plArr,qb.getStartTime(),qb.getEndTime());
		List<Map> tableList=new ArrayList<Map>();
		Map reMap=new HashMap<String, Object>();
		Map formMap=new HashMap<String, Object>();
		if(formlist.size()>0) {
			tableList=qbm.getQbTableData(formlist.get(arrIndex).get("TETEIL").toString(), formlist.get(arrIndex).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
			if(arrIndex==(formlist.size()-1)) {
				reMap.put("arrAlarm", "1");
			}else {
				reMap.put("arrAlarm", "0");
			}
			for(int i=0;i<tableList.size();i++) {
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0, 19));
			}
			formMap=formlist.get(arrIndex);
			reMap.put("formList", formMap);
		}else {
			reMap.put("arrAlarm", "1");
		}
		reMap.put("formList", formMap);
		reMap.put("tableList", tableList);
		return reMap;
	}
	/**
	 * 获取单个零件所有数据
	 * @return
	 */
	public Map getQbTeilFormData(String teilId,Integer arrIndex,QualityBoard qb) {
		List<Map> formlist=qbm.getQbTeilFormData(teilId,qb.getStartTime(),qb.getEndTime());
		List<Map> tableList=new ArrayList<Map>();
		Map reMap=new HashMap<String, Object>();
		Map formMap=new HashMap<String, Object>();
		if(formlist.size()>0) {
			tableList=qbm.getQbTableData(formlist.get(arrIndex).get("TETEIL").toString(), formlist.get(arrIndex).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
			if(arrIndex==(formlist.size()-1)) {
				reMap.put("arrAlarm", "1");
			}else {
				reMap.put("arrAlarm", "0");
			}
			for(int i=0;i<tableList.size();i++) {
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0, 19));
			}
			formMap=formlist.get(arrIndex);
			reMap.put("formList", formMap);
		}else {
			reMap.put("arrAlarm", "1");
		}
		reMap.put("formList", formMap);
		reMap.put("tableList", tableList);
		return reMap;
	}
}

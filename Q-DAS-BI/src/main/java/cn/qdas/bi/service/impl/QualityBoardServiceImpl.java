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
	public List getProductLine(QualityBoard qb) {
		/*List<Map> plList = qbm.getProductLine(qb);
		for(int i=0;i<plList.size();i++) {
			if(plList.get(i)==null) {
				plList.remove(i);
			}
		}
		for(int i=0;i<plList.size();i++) {
			Map map=plList.get(i);
			map.put("plId","plId"+(i+1));
		}
		for(int i=0;i<plList.size();i++) {
			String qualityLevel="1";
			QualityBoard searchQb = new QualityBoard();
			searchQb.setProductLineName(String.valueOf(plList.get(i).get("TEERZEUGNIS")));
			List<Map> levelList=qbm.getProductLineWithColor(searchQb);
			for(int j=0;j<levelList.size();j++) {
				if("0".equals(String.valueOf(levelList.get(j).get("ALARM_EW")))&&!"2".equals(qualityLevel)&&!"3".equals(qualityLevel)) {
					qualityLevel="1";
				}else if(("16".equals(String.valueOf(levelList.get(j).get("ALARM_EW")))||"32".equals(String.valueOf(levelList.get(j).get("ALARM_EW"))))&&!"3".equals(qualityLevel)) {
					qualityLevel="2";
				}else if("65536".equals(String.valueOf(levelList.get(j).get("ALARM_EW")))) {
					qualityLevel="3";
				}
			}
			plList.get(i).put("qualityLevel", qualityLevel);
			plList.get(i).put("plId","plId"+(i+1));
		}*/
		List<Map> plList = qbm.getProductLine(qb);
		List<Map> allList=qbm.getProductLineWithColor(qb);
		plList.removeAll(Collections.singleton(null));
		List reList=new ArrayList<Map>();
		for(int i=0;i<plList.size();i++) {
			Map map=new HashMap();
			String qualityLevel=Globals.NO_ALARM;
			boolean falg=false;
			map.put("TEERZEUGNIS", plList.get(i).get("TEERZEUGNIS"));
			for(int j=0;j<allList.size();j++) {
				if(plList.get(i).get("TEERZEUGNIS").equals(allList.get(j).get("TEERZEUGNIS"))) {
					falg=true;
					if(Globals.UPPER_LIMIT.equals(String.valueOf(allList.get(j).get("ALARM_EW")))||Globals.DOWN_LIMIT.equals(String.valueOf(allList.get(j).get("ALARM_EW")))||Globals.DING_ALARM.equals(String.valueOf(allList.get(j).get("ALARM_EW")))) {
						qualityLevel="2";
						break;
					}else if(Globals.UPPER_ALARM.equals(String.valueOf(allList.get(j).get("ALARM_EW")))||Globals.DOWN_ALARM.equals(String.valueOf(allList.get(j).get("ALARM_EW")))) {
						qualityLevel="1";
					}
				}
			}
			if(falg) {
				map.put("qualityLevel", qualityLevel);
			}else {
				map.put("qualityLevel", "3");
			}
			map.put("plId","plId"+(i+1));
			reList.add(map);
		}
		return reList;
	}
	@Override
	public List getTeilData(QualityBoard qb) {
		List<Map> list=qbm.getTeilData(qb);
		Set teilSet=new HashSet<Map>();        
		for(int i=0;i<list.size();i++) {
			Map setMap=new HashMap<String, String>();
			setMap.put("TETEILNR", list.get(i).get("TETEILNR"));
			setMap.put("TETEIL", list.get(i).get("TETEIL"));
			setMap.put("TEBEZEICH", list.get(i).get("TEBEZEICH"));
			teilSet.add(setMap);
		}
		List reList=new ArrayList<Map>();
		Object [] teilArr=teilSet.toArray();
		for(int i=0;i<teilArr.length;i++) {
			Map map=(Map) teilArr[i];
			String qualityLevel="0";
			for(int j=0;j<list.size();j++) {
				if(map.get("TETEIL").equals(list.get(j).get("TETEIL"))) {
					if(Globals.UPPER_LIMIT.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DOWN_LIMIT.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DING_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))) {
						qualityLevel="2";
						break;
					}else if(Globals.UPPER_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DOWN_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))) {
						qualityLevel="1";
					}
				}
			}
			map.put("qualityLevel", qualityLevel);
			reList.add(map);
		}
		return reList;
	}
	@Override
	public List getMerkmalData(QualityBoard qb) {
		List<Map> list=qbm.getMerkmalData(qb);
		Set mset=new HashSet<Map>();
		for(int i=0;i<list.size();i++) {
			Map setMap=new HashMap<String, String>();
			setMap.put("METEIL", list.get(i).get("METEIL"));
			setMap.put("MEMERKMAL", list.get(i).get("MEMERKMAL"));
			setMap.put("MEMERKBEZ", list.get(i).get("MEMERKBEZ"));
			mset.add(setMap);
		}
		List reList=new ArrayList<Map>();
		Object [] mArr=mset.toArray();
		for(int i=0;i<mArr.length;i++) {
			Map map=(Map) mArr[i];
			String qualityLevel="0";
			for(int j=0;j<list.size();j++) {
				if(map.get("MEMERKMAL").equals(list.get(j).get("MEMERKMAL"))) {
					if(Globals.UPPER_LIMIT.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DOWN_LIMIT.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DING_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))) {
						qualityLevel="2";
						break;
					}else if(Globals.UPPER_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))||Globals.DOWN_ALARM.equals(String.valueOf(list.get(j).get("ALARM_EW")))) {
						qualityLevel="1";
					}
				}
			}
			map.put("qualityLevel", qualityLevel);
			reList.add(map);
		}
		return reList;
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
	public List<QbProductLine> getProductLineByUser(User user,QualityBoard qb) {
		User reUser=qbm.getProductLineByUser(user);
		List<QbProductLine> plList=new ArrayList<QbProductLine>();
		List<Role> roleList=reUser.getRoleList();
		for(int i=0;i<roleList.size();i++) {
			plList.addAll(roleList.get(i).getQbProductLineList());
		}
		HashSet plSet=new HashSet<QbProductLine>(plList);
		plList.clear();
		plList.addAll(plSet);
		String[] plArr=new String[plList.size()];
		for(int i=0;i<plList.size();i++) {
			plArr[i]=plList.get(i).getProductLineName();
		}
		List<Map> alarmList=qbm.getAlarmValuesByProductLine(plArr,qb.getStartTime(),qb.getEndTime());
		for(int i=0;i<plList.size();i++) {
			boolean flag=false;
			String qualityLevel=Globals.NO_ALARM;
			for(int j=0;j<alarmList.size();j++) {
				if(plList.get(i).getProductLineName().equals(alarmList.get(j).get("permission_name"))) {
					flag=true;
					if(Globals.UPPER_LIMIT.equals(String.valueOf(alarmList.get(j).get("ALARM_EW")))||Globals.DOWN_LIMIT.equals(String.valueOf(alarmList.get(j).get("ALARM_EW")))||Globals.DING_ALARM.equals(String.valueOf(alarmList.get(j).get("ALARM_EW")))) {
						qualityLevel="2";
						break;
					}else if(Globals.UPPER_ALARM.equals(String.valueOf(alarmList.get(j).get("ALARM_EW")))||Globals.DOWN_ALARM.equals(String.valueOf(alarmList.get(j).get("ALARM_EW")))) {
						qualityLevel="1";
					}
				}
			}
			plList.get(i).setButtonId("pl"+i);
			if(flag) {
				plList.get(i).setAlarmLevel(qualityLevel);
			}else {
				plList.get(i).setAlarmLevel("3");
			}
		}
		return plList;
	}
	@Override
	public Map getQbFormData(List<Permission> list,Integer arrIndex) {
		for(int i=0;i<list.size();i++) {
			if(!"pl".equals(list.get(i).getType())) {
				list.remove(i);
			}
		}
		String[] plArr=new String[list.size()];
		for(int i=0;i<list.size();i++) {
			plArr[i]=list.get(i).getPermissionName();
		}
		List<Map> formlist=qbm.getQbFormData(plArr);
		List<Map> tableList=qbm.getQbTableData(formlist.get(arrIndex).get("TETEIL").toString(), formlist.get(arrIndex).get("MEMERKMAL").toString());
		Map reMap=new HashMap<String, Object>();
		if(arrIndex==(formlist.size()-1)) {
			reMap.put("arrAlarm", "1");
		}else {
			reMap.put("arrAlarm", "0");
		}
		for(int i=0;i<tableList.size();i++) {
			tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0, 19));
		}
		reMap.put("formList", formlist.get(arrIndex));
		reMap.put("tableList", tableList);
		return reMap;
	}
	
}

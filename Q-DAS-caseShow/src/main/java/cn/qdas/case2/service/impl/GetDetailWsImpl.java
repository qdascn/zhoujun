package cn.qdas.case2.service.impl;


import java.util.List;

import javax.annotation.Resource;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.qdas.case1.dao.DetailDataMapper;
import cn.qdas.case2.service.GetDetailWs;
@Service
@WebService
public class GetDetailWsImpl implements GetDetailWs {
	@Resource
	DetailDataMapper ddm;
	@Override
	@WebMethod
	public String getAllDetail(@WebParam(name="param")String param) {
		ObjectMapper mapper=new ObjectMapper();
		List list=ddm.getAllDetails();
		String str="";
		try {
			str=mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return param+"==="+str;
	}

}

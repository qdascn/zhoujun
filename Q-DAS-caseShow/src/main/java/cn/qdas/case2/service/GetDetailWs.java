package cn.qdas.case2.service;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface GetDetailWs {
	@WebMethod
	String getAllDetail(@WebParam(name="param")String param);
}

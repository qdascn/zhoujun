<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							<input type="hidden" id="elSearchStartTime" name="elSearchStartTime" value="${paramMap.startTime}">
							<input type="hidden" id="elSearchEndTime" name="elSearchEndTime" value="${paramMap.endTime}">
							<input type="hidden" id="productLineList" name="productLineList" value="${paramMap.plList}">
							<c:forEach items="${paramMap.plList}" var="prodectLine">
								<c:choose>
									<c:when test="${prodectLine.alarmLevel==\"0\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.productLineName }');"><font size="4">产线名称：${prodectLine.productLineName  }</font></a>
									</c:when>
									<c:when test="${prodectLine.alarmLevel==\"1\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.productLineName }');"><font size="4">产线名称：${prodectLine.productLineName  }</font></a>
									</c:when>
									<c:when test="${prodectLine.alarmLevel==\"2\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.productLineName }');"><font size="4">产线名称：${prodectLine.productLineName  }</font></a>
									</c:when>
									<c:when test="${prodectLine.alarmLevel==\"3\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.productLineName }');"><font size="4">产线名称：${prodectLine.productLineName }</font></a>
									</c:when>
								</c:choose>
							</c:forEach>
						</div>
		        	</div>
	
	<script type="text/javascript">
	function getTeil(plId,plName){
  			$('#centerbox > a').linkbutton({
			    iconCls:''
			});
  			$('#'+plId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#teilAcc').panel({
				href:'<%=basePath%>qb/initTeilData?productLineName='+plName+'&startTime='+$('#elSearchStartTime').val()+'&endTime='+$('#elSearchEndTime').val()
			});
			//$('#teilAcc').panel('open');
			var accSelected = $('#qbAcc').accordion('getPanel',0);
			accSelected.panel('setTitle', '产线(产线名：'+plName+')');
			$('#qbAcc').accordion('select',1); 
  		}
	</script>
  </body>
</html>

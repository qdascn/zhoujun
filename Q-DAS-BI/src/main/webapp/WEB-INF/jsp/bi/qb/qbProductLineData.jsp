<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							<c:forEach items="${paramMap.plList}" var="prodectLine">
								<c:choose>
									<c:when test="${prodectLine.qualityLevel==\"0\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEERZEUGNIS }');"><font size="5">${prodectLine.TEERZEUGNIS  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"1\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c7" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEERZEUGNIS }');"><font size="5">${prodectLine.TEERZEUGNIS  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"2\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c5" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEERZEUGNIS }');"><font size="5">${prodectLine.TEERZEUGNIS  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"3\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c6" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEERZEUGNIS }');"><font size="5">${prodectLine.TEERZEUGNIS }</font></a>
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
			//var searchProductLineTeilRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
			$('#qbAcc').accordion('select',1); 
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+plName+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
  			}else{
  				var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+plName+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime);
  			}
			var accSelected = $('#qbAcc').accordion('getPanel',0);
			accSelected.panel('setTitle', '产线(产线名：'+plName+')');
  		}
	</script>
  </body>
</html>

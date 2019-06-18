<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
			零件号：<input id="teilNum" name="teilNum" class="easyui-textbox" data-options="" style="width:200px">
			零件名：<input id="teilName" name="teilName" class="easyui-textbox" data-options="" style="width:200px">
			<a id="teilSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchTeil('${paramMap.plId }');">查询</a>
			<a id="openTeilQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
			<input type="hidden" id="elTeilSearchStartTime" name="elTeilSearchStartTime" value="${paramMap.startTime}">
			<input type="hidden" id="elTeilSearchEndTime" name="elTeilSearchEndTime" value="${paramMap.endTime}">
			<input type="hidden" id="elTeilProductLineName" name="elTeilProductLineName" value="${paramMap.plId }">
		</div>
		<div id="teilbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${paramMap.teilList}" var="map">
				<c:choose>
					<c:when test="${map.qualityLevel==\"0\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">零件号：${map.TETEILNR }<br>零件名称：${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"1\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">零件号：${map.TETEILNR }<br>零件名称：${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"2\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">零件号：${map.TETEILNR }<br>零件名称：${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"3\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">零件号：${map.TETEILNR }<br>零件名称：${map.TEBEZEICH }</font></a>
					</c:when>
				</c:choose>
			</c:forEach>						
		</div> 
	</div>
	<script type="text/javascript">
		function searchTeil(plId){
			$('#teilAcc').panel({
				href:'<%=basePath%>qb/initTeilData?productLineName='+plId+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&startTime='+$('#elTeilSearchStartTime').val()+'&endTime='+$('#elTeilSearchEndTime').val()
			});
		}
		function getMerkmal(teilId,teilNum,teilName){
  			$('#teilbox > a').linkbutton({
			    iconCls:''
			});
			$('#teil'+teilId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#merkmalAcc').panel({
				href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&startTime='+$('#elTeilSearchStartTime').val()+'&endTime='+$('#elTeilSearchEndTime').val()
			});
			var accSelected = $('#qbAcc').accordion('getPanel',1);
			accSelected.panel('setTitle', '零件(零件号：'+teilNum+' / 零件名：'+teilName+')');
			$('#qbAcc').accordion('select',2); 
  		}
  		$('#openTeilQb').click(function(){
  			$('#qbDig').panel({
							href:'<%=basePath%>qb/initQbShow?index='+'2&productLineName='+$('#elTeilProductLineName').val()
						});
				$('#qbDig').dialog('open');
  		})
	</script>
  </body>
</html>

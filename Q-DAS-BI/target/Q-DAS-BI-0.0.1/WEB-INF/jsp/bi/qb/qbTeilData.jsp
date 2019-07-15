<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  </head>
  <body>
  	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
  		<input type="hidden" id="elTeilProductLineName" name="elTeilProductLineName" value="${paramMap.plId }">
  		<input type="hidden" id="TeilTotalrows" name="TeilTotalrows" value="${paramMap.totalRows }">
		<div id="teilbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${paramMap.teilList}" var="map">
				<c:choose>
					<c:when test="${map.qualityLevel==\"0\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"1\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c7" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"2\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c5" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"3\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c6" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
				</c:choose>
			</c:forEach>						
		</div> 
	</div>
	<script type="text/javascript">
		$(function(){
			$('#autoTeilSpan').html(autoTeilPageNum+"/"+Math.ceil(parseInt($('#TeilTotalrows').val())/30));
		}) 
		function searchTeil(){
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
				$('#teilAcc').panel({
					href:'<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')
				});
			}else{
				var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
				$('#teilAcc').panel({
					href:'<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime
				});
			}
		}
		function getMerkmal(teilId,teilNum,teilName){
  			$('#teilbox > a').linkbutton({
			    iconCls:''
			});
			$('#teil'+teilId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
				$('#merkmalAcc').panel({
					href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')
				});
			}else {
				var searchTeilMerkmalRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
				$('#merkmalAcc').panel({
					href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&startTime='+searchTeilMerkmalRealTime.startTime+'&endTime='+searchTeilMerkmalRealTime.endTime
				});
			}
			
			
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
  		function pageModel(checked){
  			if(checked==true){
				 //autoTeilPageTime=setInterval(autoTeilPage, $('#autoTeilPageSelect').combobox('getValue')*1000);
				 autoTeilPageTime=setInterval(autoTeilPage, 5*1000);
  			}else{
  				clearInterval(autoTeilPageTime);
  				if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  					$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
  				}else{
  					var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
  					$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime);
  				}
  				
  			}
  		}
  		function autoTeilPage(){
  			if(parseInt($('#TeilTotalrows').val())>0){
  				if(autoTeilPageNum>=Math.ceil(parseInt($('#TeilTotalrows').val())/30)){
  					autoTeilPageNum=1;
  				}else{
  					autoTeilPageNum += 1;
  				}
  			}
  			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilDataByPage?productLineName='+$('#elTeilProductLineName').val()+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')+'&page='+autoTeilPageNum+'&rows='+'30');
  			}else{
  				var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilDataByPage?productLineName='+$('#elTeilProductLineName').val()+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime+'&page='+autoTeilPageNum+'&rows='+'30');
  			}
  			
  		}
	</script>
  </body>
</html>

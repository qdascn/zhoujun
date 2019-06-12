<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
		        			选择时间：<select class="easyui-combobox" id="timecc" name="searchDate" style="width:200px;" 
		        			data-options="editable:false,onSelect:function(record){searchByTime(record);}">
		        						<option>---选择时间---</option>
									    <option value="0">显示全部数据</option>
									    <option value="1h">显示最后一小时的数据</option>
									    <option value="1">显示最后一天的数据</option>
									    <option value="7">显示最后一周的数据</option>
									    <option value="30">显示最后一个月(30)的数据</option>
									</select >
							<input type="hidden" id="elSearchStartTime" name="elSearchStartTime" value="${paramMap.startTime}">
							<input type="hidden" id="elSearchEndTime" name="elSearchEndTime" value="${paramMap.endTime}">
							<input type="hidden" id="productLineList" name="productLineList" value="${paramMap.plList}">
							<a id="openQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
		        		</div>
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
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
	<div id="qbDig" class="easyui-dialog" data-options="title:'质量看板',resizable:true,maximizable:true,modal:true,closed:true,onClose:function(){clearInterval(auto)}">
	</div>
	<script type="text/javascript">
	$(function(){
		$('#qbDig').height(window.innerHeight-200);
			$('#qbDig').width(window.innerWidth-200);
		
		$('#openQb').click(function(){
			var days=$('#timecc').combobox('getValue');
			console.log(days);
			$('#qbDig').panel({
						href:'<%=basePath%>qb/initQbShow'
					});
			$('#qbDig').dialog('open');
		})
	})
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
  		function searchByTime(record){
  			var days=record.value;
				var now=new Date();
				if(days=='0'){
					$('#plAcc').panel('refresh','<%=basePath%>qb/getProductLineData?searchTimeStr='+days);
				}else if(days=='1h'){
					var searchTime=now.getTime()-3600000;
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					$('#plAcc').panel({
						href:'<%=basePath%>qb/getProductLineData?startTime='+startDate+'&endTime='+endDate+'&searchTimeStr='+days
					});
				}else if(days=='1'|days=='7'|days=='30'){
					var searchTime=now.getTime()-(days*86400000);
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					$('#plAcc').panel({
						href:'<%=basePath%>qb/getProductLineData?startTime='+startDate+'&endTime='+endDate+'&searchTimeStr='+days
					});
				}
  		}
	</script>
  </body>
</html>

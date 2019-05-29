<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
		        			选择时间：<select id="timecc" name="searchDate" style="width:200px;">
		        						<option>---选择日期---</option>
									    <option value="0">显示全部数据</option>
									    <option value="1h">显示最后一小时的数据</option>
									    <option value="1">显示最后一天的数据</option>
									    <option value="7">显示最后一周的数据</option>
									    <option value="30">显示最后一个月(30)的数据</option>
									</select>
		        			产线号：<input id="productLineName" name="productLineName" class="easyui-textbox" style="width:200px">
							<a id="productLineSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
							<input type="hidden" id="elSearchStartTime" name="elSearchStartTime" value="${paramMap.startTime}">
							<input type="hidden" id="elSearchEndTime" name="elSearchEndTime" value="${paramMap.endTime}">
		        		</div>
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							<c:forEach items="${paramMap.plList}" var="map">
								<c:choose>
									<c:when test="${map.qualityLevel==\"0\"}">
										<a id="${map.plId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
									</c:when>
									<c:when test="${map.qualityLevel==\"1\"}">
										<a id="${map.plId}" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
									</c:when>
									<c:when test="${map.qualityLevel==\"2\"}">
										<a id="${map.plId}" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
									</c:when>
									<c:when test="${map.qualityLevel==\"3\"}">
										<a id="${map.plId}" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
									</c:when>
								</c:choose>
							</c:forEach>
						</div>
		        	</div>
	<script type="text/javascript">
	$(function(){
		//$('#productLineName').textbox();
		$('#productLineSearchbtn').click(function(){
			$('#plAcc').panel({
				href:'<%=basePath%>qb/getProductLineData?productLineName='+$('#productLineName').textbox('getValue')
			});
		});
		$('#timecc').combobox({
			editable:false,
			onSelect:function(record){
				var days=record.value;
				var now=new Date();
				if(days==0){
					$('#plAcc').panel({
						href:'<%=basePath%>qb/getProductLineData?productLineName='+$('#productLineName').textbox('getValue')
					});
				}else if(days=='1h'){
					var searchTime=now.getTime()-3600000;
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					$('#plAcc').panel({
						href:'<%=basePath%>qb/getProductLineData?productLineName='+$('#productLineName').textbox('getValue')+'&startTime='+startDate+'&endTime='+endDate
					});
				}else if(days=='1'|days=='7'|days=='30'){
					var searchTime=now.getTime()-(days*86400000);
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					$('#plAcc').panel({
						href:'<%=basePath%>qb/getProductLineData?productLineName='+$('#productLineName').textbox('getValue')+'&startTime='+startDate+'&endTime='+endDate
					});
				}
			}
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
	</script>
  </body>
</html>

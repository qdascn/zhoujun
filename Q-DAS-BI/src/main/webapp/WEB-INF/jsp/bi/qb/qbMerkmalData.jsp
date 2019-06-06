<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>

  </head>
  
  <body>
    <div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
			<input id="teilIdVal" type="hidden" value="${paramMap.teilId }">
			参数名：<input id="merkmalName" name="merkmalName" class="easyui-textbox" data-options="" style="width:200px">
			<a id="merkmalSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
			<a id="showDetailsBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="float: right;">查看详情</a>
			<input type="hidden" id="elmSearchStartTime" name="elmSearchStartTime" value="${paramMap.startTime}">
			<input type="hidden" id="elmSearchEndTime" name="elmSearchEndTime" value="${paramMap.endTime}">
		</div>
		<div id="merkmalbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${paramMap.merkmalList}" var="map">
				<c:choose>
					<c:when test="${map.qualityLevel==\"0\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4">${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"1\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4">${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"2\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4">${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"3\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4">${map.MEMERKBEZ }</font></a>
					</c:when>
				</c:choose>
			</c:forEach>						
		</div> 
		<div id="charts" data-options="region:'east',split:true" style="padding:5px;background:#eee;width:50%;"></div>
	</div>
	<div id="dataWin" class="easyui-dialog" data-options="title:'数据详情',resizable:true,maximizable:true,modal:true,closed:true">
		<table id="wertevarTable" style="width: 100%;height: 100%">
			<thead>
				<tr>
					<th data-options="field:'WVWERT',width:80,align:'center',sortable:true">WVWERT</th>
					<th data-options="field:'MEUGW',width:50,align:'center'">MEUGW</th>
					<th data-options="field:'MEOGW',width:50,align:'center'">MEOGW</th>
					<th data-options="field:'PRVORNAME',width:50,align:'center'">PRVORNAME</th>
					<th data-options="field:'PMNR',width:100,align:'center'">PMNR</th>
					<th data-options="field:'PMBEZ',width:100,align:'center'">PMBEZ</th>
					<th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
					<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th>
					<th data-options="field:'WVDATZEIT',width:120,align:'center',sortable:true">WVDATZEIT</th>
				</tr>
			</thead>
		</table>
					    	<div id='wertevarTb' style="padding: 10px;width: 100%">
						    	开始时间：<input class ="easyui-datetimebox" name ="startTime" id="startTime"  style ="width ：150px "> 
						    	结束时间：<input class ="easyui-datetimebox" name ="endTime" id="endTime"  style ="width ：150px ">
						    	<a id="wseBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
						    	查询近<select id="timecc" class="easyui-combobox" name="dept" style="width:150px;">
								    <option value="0">--选择日期查询--</option>
								    <option value="1">一天</option>
								    <option value="2">两天</option>
								    <option value="3">三天</option>
								    <option value="7">一周</option>
								    <option value="30">一月</option>
								    <option value="180">半年</option>
								    <option value="365">一年</option>
								</select>
								<a id="wlBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
						    </div>
	</div>
	<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/js/charts.js"></script>
	<script type="text/javascript">
		var lineChart;
		var teilId,merkmalId;
		$(function(){
			$('#dataWin').height(window.innerHeight-200);
			$('#dataWin').width(window.innerWidth-200);
			$('#wertevarTable').datagrid({
				url:'<%=basePath%>qb/getWertevarData',
				toolbar:'#wertevarTb',
				border : false,
				pagination : false,
				fit : true,
				rownumbers : true,
				fitColumns : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				pageSize : 20,
				pageList : [ 20, 40, 60, 80 ],
				dndRow : false,
				enableHeaderClickMenu : false,
				enableHeaderContextMenu : true,
				enableRowContextMenu : false,
				rowTooltip : false,
			})
			window.onresize=function(){
				if(lineChart!=null&lineChart!=''){
					lineChart.resize();
				}
			}
			$('#merkmalbox > a').eq(0).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#merkmalSearchbtn').click(function(){
				$('#merkmalAcc').panel({
					href:"<%=basePath%>qb/initMerkmalData?teilId="+$('#teilIdVal').val()+"&merkmalName="+$('#merkmalName').textbox('getValue')
				});
			});
			teilId='${paramMap.merkmalList[0].METEIL}';
			merkmalId='${paramMap.merkmalList[0].MEMERKMAL}';
			getChartData('${paramMap.merkmalList[0].MEMERKMAL}','${paramMap.merkmalList[0].METEIL}');
			$('#showDetailsBtn').click(function(){
				$('#wertevarTable').datagrid('reload',{
						teilId:teilId,
						merkmalId:merkmalId
					});
				$('#dataWin').dialog('open');
			
			})
			$('#wseBtn').click(function(){
				var startTime=$("#startTime").datebox('getValue');
				var endTime=$("#endTime").datebox('getValue');
				if((startTime==''|startTime==null)&(endTime==''|endTime==null)){
					$ .messager.alert('错误','查询条件不能为空！','info');
				}
				if(startTime!=''&startTime!=null&endTime!=''&endTime!=null&startTime>endTime){
					$ .messager.alert('错误','起始时间必须结束时间之前！','info');
				}
				$('#wertevarTable').datagrid('reload',{
												teilId:teilId,
												merkmalId:merkmalId,
												startTime:startTime,
												endTime:endTime});
			})
			$('#wlBtn').click(function(){
				var days=$('#timecc').combobox('getValue');
				if(days==0|days==""|days==null){
					return false;
				}
				var now=new Date();
				var searchTime=now.getTime()-(days*86400000);
				var ago=new Date(searchTime);
				var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
				var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
				$('#wertevarTable').datagrid('reload',{
												teilId:teilId,
												merkmalId:merkmalId,
												startTime:startDate,
												endTime:endDate});
			})
		})
		function showChart(mId,tId,name){
			teilId=tId;
			merkmalId=mId;
			$('#merkmalbox > a').linkbutton({
			    iconCls:''
			});
			$('#merkmal'+mId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			var accSelected = $('#qbAcc').accordion('getPanel',2);
			accSelected.panel('setTitle', '测量参数(参数名：'+name+')');
			getChartData(mId,tId)
		}
		function getChartData(mId,tId){
			$.ajax({
				type:'post',
				url:'<%=basePath%>qb/initWertevarChart',
				data:{
					teilId:tId,
					merkmalId:mId,
					startTime:$('#elmSearchStartTime').val(),
					endTime:$('#elmSearchEndTime').val()
				},
				success:function(data){
					if(data[0].MEARTOGW=='1'){
						var upLimit=data[0].MEOGW;
						var downLimit=data[0].MEUGW;
						var xValue=[];
						var yValue=[];
						for(var i=0;i<data.length;i++){
							xValue.push(data[i].WVDATZEIT);
							yValue.push(data[i].WVWERT)
						}
						lineChart=initLineChart2('charts',xValue,yValue,upLimit,downLimit,data[0].MENENNMAS);
					}else{
						var xValues=new Array();
						var yValues=new Array();
						for(var i=0;i<data.length;i++){
							xValues.push(data[i].WVWERT);
						}
						var pieObj={};
						var pieArr=[];
						var cc=[];
						var xData=[];
						for(var i=0; i<xValues.length; i++){
						//通过把数组的val值赋给obj做为下标，通过下标来查找
							if(!pieObj[xValues[i]]){
								xData.push(xValues[i])
								pieObj[xValues[i]]=1 //这里如果不给个值，那么obj还是为空。
							}else{
								pieObj[xValues[i]]++
							}
						}
						for(var i=0;i<xData.length;i++){
							var obj=new Object();
							obj.name=xData[i];
							obj.value=pieObj[xData[i]];
							yValues[i]=pieObj[xData[i]];
							pieArr.push(obj);
						}
						lineChart=initBarAndPie('charts',xData,yValues,pieArr);						
					}
					
				}
			});
		}
	</script>
  </body>
</html>

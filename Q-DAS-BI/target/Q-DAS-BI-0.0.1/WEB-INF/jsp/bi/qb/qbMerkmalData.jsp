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
			<a id="showDetailsBtn" class="easyui-linkbutton c4" data-options="iconCls:'icon-search'" style="float: right;">查看详情</a>
			<a id="openMerkmalQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
		</div>
		<div id="merkmalbox" data-options="region:'west',split:true" style="padding:5px;background:#eee;width:350px;">
			<c:forEach items="${paramMap.merkmalList}" var="map">
				<c:choose>
					<c:when test="${map.qualityLevel==\"0\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4" style="line-height: 100%">${map.MEMERKNR }</br>${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"1\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4" style="line-height: 100%">${map.MEMERKNR }</br>${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"2\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4" style="line-height: 100%">${map.MEMERKNR }</br>${map.MEMERKBEZ }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"3\"}">
						<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="showChart('${map.MEMERKMAL }','${map.METEIL }','${map.MEMERKBEZ }');"><font size="4" style="line-height: 100%">${map.MEMERKNR }</br>${map.MEMERKBEZ }</font></a>
					</c:when>
				</c:choose>
			</c:forEach>						
		</div> 
		<div id="charts" data-options="region:'center',onResize:function(){chartResize()}" style="padding:5px;background:#eee;"></div>
	</div>
	<div id="dataWin" class="easyui-dialog" data-options="title:'数据详情',resizable:true,maximizable:true,modal:true,closed:true">
		<table id="wertevarDetailsTable" style="width: 100%;height: 100%">
			<thead>
				<tr>
					<th data-options="field:'WVWERT',width:100,align:'center',sortable:true,formatter:clcellFormatter">测量值</th>
					<th data-options="field:'MENENNMAS',width:50,align:'center'">名义值</th>
					<th data-options="field:'MEUGW',width:50,align:'center'">上公差</th>
					<th data-options="field:'MEOGW',width:50,align:'center'">下公差</th>
					<th data-options="field:'PRVORNAME',width:50,align:'center'">测量人员</th>
					<th data-options="field:'PMNR',width:100,align:'center'">机台号</th>
					<th data-options="field:'PMBEZ',width:100,align:'center'">机台名</th>
					<th data-options="field:'WVDATZEIT',width:120,align:'center',sortable:true">测量日期</th>
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
			$('#wertevarDetailsTable').datagrid({
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
			$('#merkmalbox > a').eq(0).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#merkmalSearchbtn').click(function(){
				var startTime;
				var endTime;
				if($('#qbSearchTimeType1').radiobutton('options').checked==true){
					startTime=$('#qbStartTime').datetimebox('getValue');
					endTime=$('#qbEndTime').datetimebox('getValue');
				}else{
					var searchChartRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
					startTime=searchChartRealTime.startTime;
					endTime=searchChartRealTime.endTime;
				}
				$('#merkmalAcc').panel({
					href:"<%=basePath%>qb/initMerkmalData?teilId="+$('#teilIdVal').val()+"&merkmalName="+$('#merkmalName').textbox('getValue')+'&startTime='+startTime+'&endTime='+endTime
				});
			});
			teilId='${paramMap.merkmalList[0].METEIL}';
			merkmalId='${paramMap.merkmalList[0].MEMERKMAL}';
			getChartData('${paramMap.merkmalList[0].MEMERKMAL}','${paramMap.merkmalList[0].METEIL}');
			$('#showDetailsBtn').click(function(){
				$('#dataWin').dialog('open');
				  	$('#wertevarDetailsTable').datagrid('reload',{
						teilId:teilId,
						merkmalId:merkmalId
					}); 
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
				$('#wertevarDetailsTable').datagrid('reload',{
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
				$('#wertevarDetailsTable').datagrid('reload',{
												teilId:teilId,
												merkmalId:merkmalId,
												startTime:startDate,
												endTime:endDate});
			})
			$('#openMerkmalQb').click(function(){
	  			$('#qbDig').panel({
								href:'<%=basePath%>qb/initQbShow?index='+'3&teilId='+teilId
							});
					$('#qbDig').dialog('open');
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
			var startTime;
			var endTime;
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
				startTime=$('#qbStartTime').datetimebox('getValue');
				endTime=$('#qbEndTime').datetimebox('getValue');
			}else{
				var searchChartRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
				startTime=searchChartRealTime.startTime;
				endTime=searchChartRealTime.endTime;
			}
			
			$.ajax({
				type:'post',
				url:'<%=basePath%>qb/initWertevarChart',
				data:{
					teilId:tId,
					merkmalId:mId,
					startTime:startTime,
					endTime:endTime
				},
				success:function(data){
					if(data.length>0){
						if(data[0].MEMERKART=='0'){
							var upLimit=data[0].MEOGW;
							var downLimit=data[0].MEUGW;
							var xValue=[];
							var yValue=[];
							var tooltipTime=[];
								var tooltipPRVORNAME=[];
								var tooltipPMBEZ=[];
							for(var i=0;i<data.length;i++){
								tooltipTime.push(data[i].WVDATZEIT);
									tooltipPRVORNAME.push(data[i].PRVORNAME);
									tooltipPMBEZ.push(data[i].PMBEZ);
									xValue.push(data[i].WVWERTNR);
									yValue.push(data[i].WVWERT)
							}
							lineChart=initLineChart2('charts',xValue,yValue,upLimit,downLimit,data[0].MENENNMAS,tooltipTime,tooltipPRVORNAME,tooltipPMBEZ);
						}else{
							var integerNum=data[0].WVWERT+'';
							if(integerNum.indexOf('.')!=-1){
								integerNum=integerNum.substring(0, integerNum.indexOf('.'));
								
							}
							var xData=['合格','不合格'];
							var yData=[];
							var pieArr=[];
							var c=0;
							var okCount=0;
							var nokCount=0;
							if(integerNum.length==4){
								for(var i=0;i<data.length;i++){
									if(data[i].WVWERT==1000){
										okCount +=1;
									}else{
										nokCount +=1;
									}
								}
							}else{
								for(var i=0;i<data.length;i++){
									var strNum=data[i].WVWERT+'';
									if(strNum.indexOf('.')!=-1){
										var frontNum=parseInt(strNum.substring(0, strNum.indexOf('.')))/1000;
										var afterNum=parseFloat(strNum.substring(strNum.indexOf('.')-1))*1000000;
										okCount += frontNum-afterNum;
										nokCount += afterNum;
									}else{
										okCount += (parseInt(strNum)/1000);
									}
								}
							}
							yData=[okCount,nokCount];
							pieArr=[{name:'合格',value:okCount},{name:'不合格',value:nokCount}];
							lineChart=initBarAndPie('charts',xData,yData,pieArr);	
						}
					}else{
						if(lineChart!=null){
							lineChart.clear();
						}
					}
				}
			});
		}
		function chartResize(){
			if(lineChart!=null&lineChart!=''){
				lineChart.resize();
			}
		}
		function clcellFormatter(value,row,index){
			var strNum=value+'';
			var result=value;
			 if(row.MEMERKART=='1'){
				var integerNum=value+'';
				if(integerNum.indexOf('.')!=-1){
					integerNum=integerNum.substring(0, integerNum.indexOf('.'));
				}
				if(integerNum.length==4){
					if(value!=1000){
						result="不合格";
					}else{
						result="合格";
					}
				}else{
					if(strNum.indexOf('.')!=-1){
						var frontNum=parseInt(strNum.substring(0, strNum.indexOf('.')))/1000;
						var afterNum=parseFloat(strNum.substring(strNum.indexOf('.')-1))*1000000;
						result=frontNum+'个样本缺陷率：'+(parseFloat(afterNum/frontNum).toFixed(4))*100+'%';
					}else{
						result=integerNum/1000+'个样本缺陷率：0%'
					}
				}
			}
			return result;
		}
	</script>
  </body>
</html>

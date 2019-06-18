<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
 <body>
    <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	    <div data-options="region:'north',collapsible:false" style="height:7%;padding: 0">
	    	<div style="float: left;width: 40%;height: 80%">
	    		<span style="margin-left: 20px">轮播间隔：</span>
		    	<select id="jgtime" style="width:150px;padding-left: 20px">
				    <option value="10">10秒</option>
				    <option value="20">20秒</option>
				    <option value="30">30秒</option>
				    <option value="60">1分钟</option>
				     <option value="1">1秒</option>
				</select>
				轮播：<select class="easyui-combobox" id="qbSearchInterval" name="qbSearchInterval" style="width:200px;" 
		        			data-options="editable:false">
									    <option value="0">全部数据</option>
									    <option value="1h">近一小时的数据</option>
									    <option value="1">近一天的数据</option>
									    <option value="7">近一周的数据</option>
									    <option value="30">近一个月(30)的数据</option>
									</select >
	    	</div>
			<form id="titleForm" style="float: left;width: 60%;height: 70%">
				<input class="easyui-textbox" name="TEERZEUGNIS" style="width:30%;padding-left: 20px;" data-options="label:'<font color=red>产线名:</font>',editable:false">
				<input class="easyui-textbox" name="TETEILNR" style="width:30%;padding-left: 20px" data-options="label:'<font color=red>零件号:</font>',editable:false">
				<input class="easyui-textbox" name="TEBEZEICH" style="width:30%;padding-left: 20px" data-options="label:'<font color=red>零件名:</font>',editable:false">
			</form>
	    </div>
	    <div  data-options="region:'south',title:'测量值',collapsible:true" style="height:50%;">
	    	<table id="wertevarTable">
				<thead>
					<tr>
						<th data-options="field:'WVWERT',width:80,align:'center'">测量值</th>
						<th data-options="field:'PRVORNAME',width:50,align:'center'">测量人员</th>
						<th data-options="field:'PMNR',width:100,align:'center'">机台编号</th>
						<th data-options="field:'PMBEZ',width:100,align:'center'">机台名</th>
						<!-- <th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
						<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th> -->
						<th data-options="field:'WVDATZEIT',width:120,align:'center'">日期</th>
					</tr>
				</thead>
			</table>
	    </div>
	    <div data-options="region:'west',collapsible:false" style="width:30%;padding: 10px">
	    	<form id="dataForm" method="post">
	    		<!-- <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEERZEUGNIS" style="width:100%;padding-left: 20px" data-options="label:'产线名:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TETEILNR" style="width:100%;padding-left: 20px" data-options="label:'零件号:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEBEZEICH" style="width:100%;padding-left: 20px" data-options="label:'零件名:',editable:false">
	            </div> -->
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="MEMERKBEZ" style="width:100%;padding-left: 20px" data-options="label:'参数:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" id="MENENNMAS" name="MENENNMAS" style="width:100%;padding-left: 20px" data-options="label:'名义值:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" id="MEOGW" name="MEOGW" style="width:100%;padding-left: 20px" data-options="label:'上公差上限:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" id="MEUGW" name="MEUGW" style="width:100%;padding-left: 20px" data-options="label:'下公差上限:',editable:false">
	            </div>
	            <input type="hidden" id="MEMERKART" name="MEMERKART">
	        </form>
	        <input type="hidden" id="index" name="index" value="${index }">
	        <input type="hidden" id="productLineName" name="productLineName" value="${productLineName }">
	        <input type="hidden" id="teilId" name="teilId" value="${teilId }">
	    </div>
	    <div id="qbCharts" data-options="region:'center'"></div>
	</div>
	<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>resources/js/charts.js"></script>
	<script type="text/javascript">
		var index=0;
		var autotime;
		var auto;
		var qbShowCharts;
		var qbStartTime,qbEndTime;
		getFormData();
		$("#jgtime").combobox({
			editable:false,
			onSelect:function(record){
				autotime=record.value;
				clearInterval(auto);
				auto=setInterval(getFormData, autotime*1000);
			}
		})
		$('#wertevarTable').datagrid({
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
					onLoadSuccess:function(data){
						initChart(data,$('#MEMERKART').val());
					},
					rowStyler: function(index,row){
						if(row.ALARM_EW=='1'|row.ALARM_EW=='2'|row.ALARM_EW=='65536'){
							return 'background-color:#FF7256;color:#0000CD;';
						}else if(row.ALARM_EW=='16'|row.ALARM_EW=='32'){
							return 'background-color:#FFFF00;color:#0000CD;';
						}
					}
				});
		function getFormData(){
			var days=$('#qbSearchInterval').val();
			qbSearchTime(days)
			$.ajax({
				type:'post',
				data:{
					arrIndex:index,
					startTime:qbStartTime,
					endTime:qbEndTime,
					teilId:$('#teilId').val(),
					productLineName:$('#productLineName').val(),
					index:$('#index').val()
				},
				url:'<%=basePath%>qb/getQbForm',
				success:function(data){
					$('#dataForm').form('clear');
					$('#titleForm').form('clear');
					if(data.arrAlarm==0){
						index += 1;
					}else{
						index=0
					}
					$('#dataForm').form('load',data.formList);
					$('#titleForm').form('load',data.formList);
					$('#wertevarTable').datagrid('loadData',data.tableList);
				}
			})
		}
		function initChart(data,lineBar){
			if(data.total==0){
				qbShowCharts.clear();
			}
			var rows=data.rows;
			if(lineBar=='0'){
				var upLimit=$('#MEOGW').textbox('getValue');
				var downLimit=$('#MEUGW').textbox('getValue');
				var mData=$('#MENENNMAS').textbox('getValue');
				var xValue=[];
				var yValue=[];
				for(var i=0;i<rows.length;i++){
					xValue.push(rows[i].WVDATZEIT);
					yValue.push(rows[i].WVWERT);
				}
				qbShowCharts=initLineChart2('qbCharts',xValue,yValue,upLimit,downLimit,mData);
			}else if(lineBar=='1'){
				var xValues=new Array();
						var yValues=new Array();
						for(var i=0;i<rows.length;i++){
							xValues.push(rows[i].WVWERT);
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
						qbShowCharts=initBarAndPie('qbCharts',xData,yValues,pieArr);	
			}
		}
		function qbSearchTime(days){
				var now=new Date();
				if(days=='0'){
					qbStartTime='';
					qbEndTime='';
				}else if(days=='1h'){
					var searchTime=now.getTime()-3600000;
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					qbStartTime=startDate;
					qbEndTime=endDate;
				}else if(days=='1'|days=='7'|days=='30'){
					var searchTime=now.getTime()-(days*86400000);
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					qbStartTime=startDate;
					qbEndTime=endDate;
				}
		} 
	</script>
</body>
</html>

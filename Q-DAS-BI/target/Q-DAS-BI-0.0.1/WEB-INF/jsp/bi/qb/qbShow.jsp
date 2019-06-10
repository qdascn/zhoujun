<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
 <body>
    <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	    <div data-options="region:'north',collapsible:false" style="height:5%;">
	    	<span style="margin-left: 20px">轮播时间间隔：</span>
	    	<select id="jgtime" style="width:150px;padding-left: 20px">
			    <option value="1">1秒</option>
			    <option value="10">10秒</option>
			    <option value="20">20秒</option>
			    <option value="30">30秒</option>
			    <option value="60">1分钟</option>
			</select>
	    </div>
	    <div  data-options="region:'south',collapsible:false" style="height:50%;">
	    	<table id="wertevarTable">
				<thead>
					<tr>
						<th data-options="field:'WVWERT',width:80,align:'center',sortable:true">测量值</th>
						<th data-options="field:'PRVORNAME',width:50,align:'center'">测量人员</th>
						<th data-options="field:'PMNR',width:100,align:'center'">机台编号</th>
						<th data-options="field:'PMBEZ',width:100,align:'center'">机台名</th>
						<!-- <th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
						<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th> -->
						<th data-options="field:'WVDATZEIT',width:120,align:'center',sortable:true">日期</th>
					</tr>
				</thead>
			</table>
	    </div>
	    <div data-options="region:'west',collapsible:false" style="width:30%;padding: 10px">
	    	<form id="dataForm" method="post">
	    		<div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEERZEUGNIS" style="width:100%;padding-left: 20px" data-options="label:'产线名:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TETEILNR" style="width:100%;padding-left: 20px" data-options="label:'零件号:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEBEZEICH" style="width:100%;padding-left: 20px" data-options="label:'零件名:',editable:false">
	            </div>
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
	        </form>
	    </div>
	    <div id="charts" data-options="region:'center'"></div>
	</div>
	<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>resources/js/charts.js"></script>
	<script type="text/javascript">
		var index=0;
		var autotime;
		var auto;
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
						initChart(data);
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
			$.ajax({
				type:'post',
				data:{
					arrIndex:index
				},
				url:'<%=basePath%>qb/getQbForm',
				success:function(data){
					$('#dataForm').form('clear');
					if(data.arrAlarm==0){
						index += 1;
					}else{
						index=0
					}
					$('#dataForm').form('load',data.formList);
					$('#wertevarTable').datagrid('loadData',data.tableList);
				}
			})
		}
		function initChart(data){
			var rows=data.rows;
			var upLimit=$('#MEOGW').textbox('getValue');
			var downLimit=$('#MEUGW').textbox('getValue');
			var mData=$('#MENENNMAS').textbox('getValue');
			var xValue=[];
			var yValue=[];
			for(var i=0;i<rows.length;i++){
				xValue.push(rows[i].WVDATZEIT);
				yValue.push(rows[i].WVWERT);
			}
			lineChart=initLineChart2('charts',xValue,yValue,upLimit,downLimit,mData);
		}
	</script>
</body>
</html>

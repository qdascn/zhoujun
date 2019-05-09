<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<head>
<title>bi Page</title>
<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/js/charts.js"></script>
<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
	<script type="text/javascript">
		$(function(){
			//var pointChart=initPointChart('charts');
			$('#teilTable').datagrid({
				url:'<%=basePath%>teil/getTeilData',
				toolbar:'#teilTb',
				border : false,
				pagination : true,
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
				onSelect:function(rowIndex, rowData){
					var row=$('#teilTable').datagrid('getSelected');
					$('#teilAcc').accordion('select',1);
					var accSelected = $('#teilAcc').accordion('getPanel',0);
					accSelected.panel('setTitle', '零件(零件号:'+row.TETEILNR+')');
					$('#merkmalTable').datagrid('reload',{
						teilId:row.TETEIL
					})
				}
			})
			$('#merkmalTable').datagrid({
				url:'<%=basePath%>teil/getMerkmalData',
				toolbar:'#merkmalTb',
				border : false,
				pagination : true,
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
				onSelect:function(rowIndex, rowData){
					var row1=$('#teilTable').datagrid('getSelected');
					var row2=$('#merkmalTable').datagrid('getSelected');
					$('#teilAcc').accordion('select',2);
					var accSelected = $('#teilAcc').accordion('getPanel',1);
					accSelected.panel('setTitle', '测量参数(参数名:'+row2.MEMERKBEZ+')');
					$('#wertevarTable').datagrid('reload',{
						teilId:row1.TETEIL,
						merkmalId:row2.MEMERKMAL
					});
				}
			})
			$('#wertevarTable').datagrid({
				url:'<%=basePath%>teil/getWertevarData',
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
				onLoadSuccess:function(data){
					var row2=$('#merkmalTable').datagrid('getSelected');
					if(row2!=null&row2!=""){
						var xV=[]; 
						var yV=[];
						var sizeRows=data.rows;
						for(var i=0;i<sizeRows.length;i++){
							xV.push(sizeRows[i].WVDATZEIT);
							yV.push(sizeRows[i].WVWERT);
						}
						initLineChart('charts',xV,yV,row2.MEOGW,row2.MEUGW);
					}
				}
			})
			$('#teilSearch').click(function(){
				$('#teilTable').datagrid('reload',{
					teilNum:$('#teilNum').textbox('getValue'),
					teilName:$('#teilName').textbox('getValue')
				});
			})
			$('#merkmalSearch').click(function(){
				var row=$('#teilTable').datagrid('getSelected');
				$('#merkmalTable').datagrid('reload',{
					merkmalName:$('#merkmalName').textbox('getValue'),
					teilId:row.TETEIL
				})
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
				var row1=$('#teilTable').datagrid('getSelected');
				var row2=$('#merkmalTable').datagrid('getSelected');
				$('#wertevarTable').datagrid('reload',{
												teilId:row1.TETEIL,
												merkmalId:row2.MEMERKMAL,
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
				var row1=$('#teilTable').datagrid('getSelected');
				var row2=$('#merkmalTable').datagrid('getSelected');
				$('#wertevarTable').datagrid('reload',{
												teilId:row1.TETEIL,
												merkmalId:row2.MEMERKMAL,
												startTime:startDate,
												endTime:endDate});
			})
			$('#showChart').click(function(){
				console.log($('#faDiv').height());
			})
			$('#teilAcc').accordion({
				animate:false,
				onSelect:function(title,index){
					if(index==1){
						if($('#teilTable').datagrid('getSelected')==null){
							$.messager.show({
								title:'提示信息',
								msg:'请选中一个零件',
								timeout:3000,
								showType:'slide'
							});
						}
					}else if(index==2){
						if($('#merkmalTable').datagrid('getSelected')==null){
							$.messager.show({
								title:'提示信息',
								msg:'请选中一个测量参数',
								timeout:3000,
								showType:'slide'
							});
						}
					}
				
				}
			});
			$('#cancelTeilSearch').click(function(){
				$('#teilNum').textbox('setValue','');
				$('#teilName').textbox('setValue','');
				$('#teilTable').datagrid('reload',{
					teilNum:$('#teilNum').textbox('getValue'),
					teilName:$('#teilName').textbox('getValue')
				});
			})
			$('#cancelMerkmalSearch').click(function(){
				var row=$('#teilTable').datagrid('getSelected');
				$('#merkmalName').textbox('setValue','');
				$('#merkmalTable').datagrid('reload',{
					merkmalName:$('#merkmalName').textbox('getValue'),
					teilId:row.TETEIL
				})
			})
			$('#cancelWertevarSearch').click(function(){
				$('#startTime').datebox('setValue','');
				$('#endTime').datebox('setValue','');
				$('#timecc').combo('setValue','0');
				var row1=$('#teilTable').datagrid('getSelected');
				var row2=$('#merkmalTable').datagrid('getSelected');
				$('#wertevarTable').datagrid('reload',{
												teilId:row1.TETEIL,
												merkmalId:row2.MEMERKMAL,
												startTime:'',
												endTime:''});
			})
		})
	</script>
</head>
<body>
	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
		</div>
	    <div data-options="region:'center',border:false" style="overflow: hidden;">
	    	<!-- <iframe src="teil/initTeilPage" name="mainFrame" id="mainFrame" scrolling="No" frameborder="0" width="100%" height="100%"></iframe> -->
	    	<div id="teilAcc" class="easyui-accordion" data-options="multiple:false,fit:true,halign:'left'" style="width:100%;height:100%;">
		        <div title="零件" style="overflow:auto;">
		            <table id="teilTable">
						<thead>
							<tr>
								<th data-options="field:'TETEIL',width:50,align:'center',sortable:true">TETEIL</th>
								<th data-options="field:'TETEILNR',width:100,align:'center'">TETEILNR</th>
								<th data-options="field:'TEBEZEICH',width:100,align:'center'">TEBEZEICH</th>
								<th data-options="field:'TEWERKSTOFFNR',width:100,align:'center'">TEWERKSTOFFNR</th>
							</tr>
						</thead>
					</table>
					<div id="teilTb" style="padding: 10px">
						零件号：<input class="easyui-textbox" id="teilNum" name="teilNum" style="width: 200px">
						零件名：<input class="easyui-textbox" id="teilName" name="teilName" style="width: 200px">
						<a id="teilSearch" class="easyui-linkbutton" data-options="iconCls:'icon-search'">零件查找</a>
						<a id="cancelTeilSearch" class="easyui-linkbutton" data-options="iconCls:'icon-back'" style="float: right">取消查询</a>
					</div>
		        </div>
		        <div title="测量参数" style="padding:0px;">
		            <table id="merkmalTable">
				    	<thead>
				    		<tr>
				    			<th data-options="field:'METEIL',width:50,align:'center'">METEIL</th>
				    			<th data-options="field:'MEMERKMAL',width:50,align:'center'">MEMERKMAL</th>
				    			<th data-options="field:'MEMERKNR',width:50,align:'center'">MEMERKNR</th>
				    			<th data-options="field:'MEMERKBEZ',width:100,align:'center'">MEMERKBEZ</th>
				    			<th data-options="field:'MENENNMAS',width:50,align:'center'">MENENNMAS</th>
				    			<th data-options="field:'MEUGW',width:50,align:'center'">MEUGW</th>
				    			<th data-options="field:'MEOGW',width:50,align:'center'">MEOGW</th>
				    		</tr>
				    	</thead>
				    </table>
				    <div id="merkmalTb" style="padding: 10px">
				    	测量工序：<input class="easyui-textbox" id="merkmalName" name="merkmalName" style="width: 200px">
						<a id="merkmalSearch" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查找</a>
						<a id="cancelMerkmalSearch" class="easyui-linkbutton" data-options="iconCls:'icon-back'" style="float: right">取消查询</a>
				    </div>
		        </div>
		        <div title="测量值">
		        	<div class="easyui-layout" data-options="fit:true">
		        		<div data-options="region:'center',split:true">
				        	<table id="wertevarTable">
					    		<thead>
					    			<tr>
					    				<th data-options="field:'WVMERKMAL',width:50,align:'center'">WVMERKMAL</th>
					    				<th data-options="field:'WVUNTERS',width:50,align:'center'">WVUNTERS</th>
					    				<th data-options="field:'WVWERTNR',width:50,align:'center'">WVWERTNR</th>
					    				<th data-options="field:'WVWERT',width:80,align:'center',sortable:true">WVWERT</th>
					    				<th data-options="field:'WVATTRIBUT',width:50,align:'center'">WVATTRIBUT</th>
					    				<th data-options="field:'PRVORNAME',width:50,align:'center'">PRVORNAME</th>
					    				<th data-options="field:'WVPRUEFMIT',width:50,align:'center'">WVPRUEFMIT</th>
					    				<th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
					    				<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th>
					    				<th data-options="field:'WVDATZEIT',width:150,align:'center',sortable:true">WVDATZEIT</th>
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
								<a id="cancelWertevarSearch" class="easyui-linkbutton" data-options="iconCls:'icon-back'" style="float: right">取消查询</a>
						    </div>
				        </div>
				        <div id="faDiv" data-options="region:'south',title:'数据图表',split:true" style="height:40%;">
				        	<div id="charts" style="height: 270px;width: 1800px"></div>
				        
				        </div>
					</div>
		        </div>
		    </div>
	    </div>
	</div>
</body>
</html>


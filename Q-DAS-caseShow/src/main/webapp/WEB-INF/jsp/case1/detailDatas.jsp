<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
<%@ include file="../base/meta.jsp"%>
<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var pointChart=initPointChart('charts');
			$('#paramTable').datagrid({
				url:'<%=basePath%>case1/getParamById',
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
				onLoadSuccess:function(){
					$('#paramTable').datagrid('selectRow',0);
					
				},
				onSelect:function(rowIndex, rowData){
					var row1=$('#detailTable').datagrid('getSelected');
					var row2=$('#paramTable').datagrid('getSelected');
					$('#sizeTable').datagrid('reload',{detailId:row1.TETEIL,paramId:row2.MEMERKMAL});
					/* var xV=[]; var yV=[];
					var sizeRows=$('#sizeTable').datagrid('getData').rows;
					for(var i=0;i<sizeRows.length;i++){
						xV.push(sizeRows[i].WVDATZEIT);
						yV.push(sizeRows[i].WVWERT);
					}
					reloadPointChart(pointChart,xV,yV,row2.MEOGW,row2.MEUGW); */
				}
			})
			$('#detailTable').datagrid({
				url:'<%=basePath%>case1/getAllDetailData',
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
				onLoadSuccess:function(){
					$('#detailTable').datagrid('selectRow',0);
					
				},
				onSelect:function(rowIndex, rowData){
					var row=$('#detailTable').datagrid('getSelected');
					$('#paramTable').datagrid('reload',{detailId:row.TETEIL});
				}
			})
			
			$('#sizeTable').datagrid({
				url:'<%=basePath%>case1/getSizeById',
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
					var row2=$('#paramTable').datagrid('getSelected');
					var xV=[]; 
					var yV=[];
					var sizeRows=data.rows;
					for(var i=0;i<sizeRows.length;i++){
						xV.push(sizeRows[i].WVDATZEIT);
						yV.push(sizeRows[i].WVWERT);
					}
					reloadPointChart(pointChart,xV,yV,row2.MEOGW,row2.MEUGW);
				}
			})
		})
		function initPointChart(divId){
			var pointChart=echarts.init(document.getElementById(divId));
			option = {
				 tooltip: {
		            trigger: 'axis'
		        },
			    xAxis: {
			   		type : 'category',
			    	//name:'检测时间',
			    	data: []
			    },
			    yAxis: {
			    	type : 'value',
			    	splitLine:{
                        show:false
                    },
                    //axisLine: {show: false},
			    },
			    
			    series: [{
			        data: [],
			        type: 'line'
			        
			    }]
			};
			pointChart.setOption(option);
			return pointChart;
		}
		function reloadPointChart(chartName,x,y,upLimitData,downLimitData){
   					 // 填入数据
			    chartName.setOption({
			        xAxis: {
			            data: x
			        },
			         yAxis : [
		                {
		                    type : 'value',
		                    splitLine:{
		                        show:false
		                    },
		                    min: function(value) {
		                        //判断y轴最大最小值
		
		                        if(value.min<parseFloat(downLimitData)){
		                            return value.min
		                        }else{
		                            return downLimitData
		                        };
		
		                    },
		                    max: function(value) {
		                        if(value.max>parseFloat(upLimitData)){
		                            return value.max
		                        }else{
		                            return upLimitData
		                        }
		                    }
		                }
		            ],
		            dataZoom: [{
			            type: 'slider'
			        }],
			        series: [{
			            // 根据名字对应到相应的系列
			            data: y,
			            markLine:{
			           		precision:5,
				        	data:[{
				        		silent:true,
	                            lineStyle:{
	                                type:"dashed",
	                                color:"#f00",
	                            },
				        		yAxis:upLimitData,
	                            name:upLimitData,
				        		label:{
	                                position:"end",
	                                normal:{
	                                    show:true,
	                                    formatter:'{c}'+'上公差限'
	                                }
	                            }
				        	},{
				        		silent:true,
	                            lineStyle:{
	                                type:"dashed",
	                                color:"#f00",
	                            },
				        		yAxis:downLimitData,
	                            name:downLimitData,
				        		label:{
	                                position:"end",
	                                normal:{
	                                    show:true,
	                                    formatter:'{c}'+'下公差限'
	                                }
	                            }
				        	}]
				        }
			        }]
			    });
			
		}
	</script>
  </head>
  
  <body class="easyui-layout">
    <div class="easyui-layout" data-options="region:'north',split:false,collapsible:false" style="height:30%;">
    	<div data-options="region:'center',title:'零件',split:false,collapsible:false" style="width:40%;height: 100%">
    		<table id="detailTable">
	    		<thead>
	    			<tr>
	    				<th data-options="field:'TETEIL',width:50,align:'center'">TETEIL</th>
	    				<th data-options="field:'TETEILNR',width:100,align:'center'">TETEILNR</th>
	    				<th data-options="field:'TEBEZEICH',width:100,align:'center'">TEBEZEICH</th>
	    			</tr>
	    		</thead>
	    	</table>
    	</div>
   		<div data-options="region:'east',title:'尺寸参数',split:false,collapsible:false" style="width:60%;height: 100%">
   			<table id="paramTable">
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
   		</div>
    </div>
     <div data-options="region:'center',title:'尺寸参数'" style="height:30%;">
     	<table id="sizeTable">
    		<thead>
    			<tr>
    				<th data-options="field:'WVMERKMAL',width:50,align:'center'">WVMERKMAL</th>
    				<th data-options="field:'WVUNTERS',width:50,align:'center'">WVUNTERS</th>
    				<th data-options="field:'WVWERTNR',width:50,align:'center'">WVWERTNR</th>
    				<th data-options="field:'WVWERT',width:80,align:'center'">WVWERT</th>
    				<th data-options="field:'WVATTRIBUT',width:50,align:'center'">WVATTRIBUT</th>
    				<th data-options="field:'WVPRUEFER',width:50,align:'center'">WVPRUEFER</th>
    				<th data-options="field:'WVPRUEFMIT',width:50,align:'center'">WVPRUEFMIT</th>
    				<th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
    				<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th>
    				<th data-options="field:'WVDATZEIT',width:150,align:'center'">WVDATZEIT</th>
    			</tr>
    		</thead>
    	</table>
     </div>
    <div id="charts" data-options="region:'south',title:'尺寸数据',split:false,collapsible:false" style="height:40%;">
    	
    </div>
   
  </body>
</html>

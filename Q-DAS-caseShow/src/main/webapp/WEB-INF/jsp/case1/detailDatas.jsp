<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
<%@ include file="../base/meta.jsp"%>
	<script type="text/javascript">
		$(function(){
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
			})
		
		
		})
		
	
	</script>
  </head>
  
  <body class="easyui-layout">
    <div data-options="region:'north',title:'零件',split:false,collapsible:false" style="height:30%;">
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
     <div data-options="region:'center',title:'尺寸参数'" style="height:30%;">
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
    <div data-options="region:'south',title:'尺寸数据',split:false,collapsible:false" style="height:40%;">
    	<table id="sizeTable">
    		<thead>
    			<tr>
    				<th data-options="field:'WVMERKMAL',width:50,align:'center'">WVMERKMAL</th>
    				<th data-options="field:'WVUNTERS',width:50,align:'center'">WVUNTERS</th>
    				<th data-options="field:'WVWERTNR',width:50,align:'center'">WVWERTNR</th>
    				<th data-options="field:'WVWERT',width:100,align:'center'">WVWERT</th>
    				<th data-options="field:'WVATTRIBUT',width:50,align:'center'">WVATTRIBUT</th>
    				<th data-options="field:'WVPRUEFER',width:50,align:'center'">WVPRUEFER</th>
    				<th data-options="field:'WVPRUEFMIT',width:50,align:'center'">WVPRUEFMIT</th>
    				<th data-options="field:'WVMASCHINE',width:50,align:'center'">WVMASCHINE</th>
    				<th data-options="field:'WVNEST',width:50,align:'center'">WVNEST</th>
    				<th data-options="field:'WVDATZEIT',width:50,align:'center'">WVDATZEIT</th>
    			</tr>
    		</thead>
    	</table>
    </div>
   
  </body>
</html>

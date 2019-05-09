<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
	<script type="text/javascript">
		$(function(){
			$('#paramTable').datagrid({
				url:'<%=basePath%>teil/getMerkmalData',
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
				}
			})
		
		})
	
	</script>
  </head>
  
  <body>
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
  </body>
</html>

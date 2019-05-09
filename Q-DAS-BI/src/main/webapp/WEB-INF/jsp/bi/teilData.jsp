<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
<head>
	<script type="text/javascript">
		$(function(){
			$('#detailTable').datagrid({
				url:'<%=basePath%>teil/getTeilData',
				toolbar:'#searchTb',
				border : false,
				pagination : true,
				fit : true,
				rownumbers : true,
				fitColumns : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				pageSize : 25,
				pageList : [ 25, 50, 75, 100 ],
				dndRow : false,
				enableHeaderClickMenu : false,
				enableHeaderContextMenu : true,
				enableRowContextMenu : false,
				rowTooltip : false,
				onSelect:function(rowIndex, rowData){
					window.location.href="<%=basePath%>teil/initMerkmalPage?teilId="+'123';
				}
			})
		})
	</script>
</head>
  
<body>
	<table id="detailTable">
		<thead>
			<tr>
				<th data-options="field:'TETEIL',width:50,align:'center',sortable:true">TETEIL</th>
				<th data-options="field:'TETEILNR',width:100,align:'center'">TETEILNR</th>
				<th data-options="field:'TEBEZEICH',width:100,align:'center'">TEBEZEICH</th>
				<th data-options="field:'TEWERKSTOFFNR',width:100,align:'center'">TEWERKSTOFFNR</th>
			</tr>
		</thead>
	</table>
	<div id="searchTb" style="padding: 10px">
		<input class="easyui-textbox" id="teilNum" name="teilNum" style="width: 200px">
		<a id="btn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">零件号查找</a>
	
	</div>
</body>
</html>

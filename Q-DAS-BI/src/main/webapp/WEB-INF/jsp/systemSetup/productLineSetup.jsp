<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>

  </head>
  
  <body>
     <table id="plTable" style="width: 100%;height: 100%">
	    <thead>
	        <tr>
	            <th data-options="field:'permission_id',width:50,align:'center'">产线ID</th>
	            <th data-options="field:'permission_name',width:80,align:'center'">产线名</th>
	            <th data-options="field:'availableStr',width:180,align:'center'">状态</th>
	        </tr>
	    </thead>
	</table>
	<div id="plTb" style="padding: 10px">
		<a id="addPl" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="openDig(1)">添加产线</a>
		<a id="editPl" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="openDig(2)">修改产线信息</a>
		<a id="delPl" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="delPl()">删除产线</a>
	</div>
	<div id="plAddDig" class="easyui-dialog" style="width:400px;height:250px;padding: 20px"
		data-options="modal:true,closed:true,buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						addPl();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#plAddDig').dialog('close');
					}
				}]"> 
			<form id="plAddForm" method="post">
				<div style="margin-bottom:10px">
					<input class="easyui-textbox" id="productLineName" name="productLineName" style="width:100%" data-options="label:'产线名',required:true">
				</div>
				<div style="margin-bottom:10px">
					<select id="cc" class="easyui-combobox" name="available" style="width:100%" data-options="label:'状态',required:true,panelHeight:100">
					    <option value="0">可用</option>
					    <option value="1">不可用</option>
					</select>
				</div>
			</form>
		</div>
	<script type="text/javascript">
		var addoredit;
  		$(function(){
  			$('#plTable').datagrid({
			    url:'<%=basePath%>system/getAllProductLine',
				toolbar:'#plTb',
				border : false,
				fit : true,
				rownumbers : true,
				fitColumns : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				dndRow : false,
				enableHeaderClickMenu : false,
				enableHeaderContextMenu : true,
				enableRowContextMenu : false,
				rowTooltip : false,
			});
  		
  		})
  		function openDig(index){
  			if(index==2){
  				var row=$('#plTable').datagrid('getSelected');
  				if(row==null|row==''){
  					$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
  					return false;
  				}
  				$('#plAddForm').form('load',{
  					productLineName:row.permission_name,
  					available:row.available
  				})
  			}
  			$('#plAddDig').dialog('open');
  			addoredit=index;
  		}
  		function addPl(){
  			var id;
  			if(addoredit=="2"){
  				var row=$('#plTable').datagrid('getSelected');
  				if(row!=null|row!=''){
	  				id=row.permission_id;
	  			}
  			}
  			$.messager.progress();
			$('#plAddForm').form('submit', {
				url: '<%=basePath%>system/addProductLine',
				onSubmit: function(){
					var isValid = $(this).form('validate');
					if (!isValid){
						$.messager.progress('close');
					}
					return isValid;
				},
				queryParams:{
					index:addoredit,
					id:id
				},
				success: function(data){
					$.messager.progress('close');
					$('#plAddDig').dialog('close');
					if(JSON.parse(data).success==0){
		  						$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:3000,
									showType:'slide'
								});
		  					}else if(JSON.parse(data).success==1){
		  						$.messager.alert('提示信息','操作失败！！！  错误：'+data.error,'error');
		  					}
					$('#plTable').datagrid('reload');
				}
			});
  		}
  		function delPl(){
  			var row=$('#plTable').datagrid('getSelected');
  			if(row==null|row==''){
  				$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
  				return false;
  			}
  			$.messager.confirm('提示信息', '是否确定删除这条记录?', function(r){
				if (r){
					$.ajax({
		  				type:'post',
		  				url:'<%=basePath%>system/delProductLine',
		  				data:{
		  					id:row.permission_id
		  				},
		  				success:function(data){
		  					if(data.success==0){
		  						$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:3000,
									showType:'slide'
								});
		  					}else if(data.success==1){
		  						$.messager.alert('提示信息','操作失败！！！  错误：'+data.error,'error');
		  					}
		  					$('#plTable').datagrid('reload');
		  				}
		  			})
				}
			});
  		}
  	</script>
  </body>
</html>

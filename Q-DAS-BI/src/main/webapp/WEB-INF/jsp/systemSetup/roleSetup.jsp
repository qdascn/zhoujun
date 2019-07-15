<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>

  </head>
  
  <body>
     <table id="roleTable" style="width: 100%;height: 100%">
	    <thead>
	        <tr>
	            <th data-options="field:'roleId',width:50,align:'center'">角色ID</th>
	            <th data-options="field:'roleName',width:80,align:'center'">角色名</th>
	            <th data-options="field:'availableStr',width:180,align:'center'">状态</th>
	        </tr>
	    </thead>
	</table>
	<div id="roleTb" style="padding: 10px">
		<a id="addRole" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="openRoleDig(1)">添加角色</a>
		<a id="editRole" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="openRoleDig(2)">修改角色信息</a>
		<a id="delRole" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="delRole()">删除角色</a>
		<a id="perRole" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="openPermissionDig()">授权角色</a>
	</div>
	<div id="roleAddDig" class="easyui-dialog" style="width:400px;height:250px;padding: 20px"
		data-options="modal:true,title:'角色',closed:true,buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						addRole();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#roleAddDig').dialog('close');
					}
				}]"> 
			<form id="roleAddForm" method="post">
				<div style="margin-bottom:10px">
					<input class="easyui-textbox" id="roleName" name="roleName" style="width:100%" data-options="label:'角色名',required:true">
				</div>
				<div style="margin-bottom:10px">
					<select id="cc" class="easyui-combobox" name="available" style="width:100%" data-options="label:'状态',required:true,panelHeight:100">
					    <option value="0">可用</option>
					    <option value="1">不可用</option>
					</select>
				</div>
			</form>
		</div>
		<div id="permissionAddDig" class="easyui-dialog" style="width:400px;height:500px;padding: 20px"
			data-options="modal:true,title:'授权',closed:true,buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							roleAddPermission();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$('#permissionAddDig').dialog('close');
						}
					}]"> 
				<ul id="permissionTree"></ul>
			</div>
	<script type="text/javascript">
		var addoredit;
  		$(function(){
  			$('#roleTable').datagrid({
			    url:'<%=basePath%>system/getAllRole',
				toolbar:'#roleTb',
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
  		function openRoleDig(index){
  			if(index=="2"){
  				var row=$('#roleTable').datagrid('getSelected');
  				if(row==null|row==''){
  					$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
  					return false;
  				}
  				$('#roleAddForm').form('load',{
  					roleName:row.roleName,
  					available:row.available
  				})
  			}
  			addoredit=index;
  			$('#roleAddDig').dialog('open');
  		}
  		function addRole(){
  			var id;
  			if(addoredit=="2"){
  				var row=$('#roleTable').datagrid('getSelected');
  				id=row.roleId;
  			}
  			$.messager.progress();
			$('#roleAddForm').form('submit', {
				url: '<%=basePath%>system/addRole',
				onSubmit: function(){
					var isValid = $(this).form('validate');
					if (!isValid){
						$.messager.progress('close');
					}
					return isValid;
				},
				queryParams:{
					roleId:id,
					addoredit:addoredit
				},
				success:function(data){
					$.messager.progress('close');
					$('#roleAddDig').dialog('close');
					if(data.success==0){
		  						$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:3000,
									showType:'slide'
								});
		  					}else if(data.success==1){
		  						$.messager.alert('提示信息','操作失败！！！  错误：'+data.error.message,'error');
		  					}
					$('#roleTable').datagrid('reload');
				}
			});
  		}
  		function delRole(){
  			var row=$('#roleTable').datagrid('getSelected');
  			if(row==null|row==''){
  				$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
  				return false;
  			}
  			$.messager.confirm('提示信息', '是否确定删除这条记录?', function(r){
				if (r){
					$.ajax({
		  				type:'post',
		  				url:'<%=basePath%>system/delRole',
		  				data:{
		  					roleId:row.roleId
		  				},
		  				success:function(data){
		  					$('#roleTable').datagrid('reload');
		  					if(data.success==0){
		  						$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:3000,
									showType:'slide'
								});
		  					}else if(data.success==1){
		  						$.messager.alert('提示信息','操作失败！！！  错误：'+data.error.message,'error');
		  					}
		  				}
		  			});
				}
			});
  		}
  		function openPermissionDig(){
  			var row=$('#roleTable').datagrid('getSelected');
  			if(row==null|row==''){
  				$.messager.alert('提示 信息','请选择一个角色授权','info');
  				return false;
  			}
  			$('#permissionTree').tree({
				url:'<%=basePath%>system/getPermissionByRoleId',
				animate:true,
				checkbox:true,
				queryParams:{
					roleId:row.roleId
				}
			})
  			$('#permissionAddDig').dialog('open');
  		}
  		function roleAddPermission(){
  			var roleId=$('#roleTable').datagrid('getSelected').roleId;
  			var nodes = $('#permissionTree').tree('getChecked');
  			var pId=new Array();
  			for(var i=0;i<nodes.length;i++){
  				if(nodes[i].permissionId!=''&nodes[i].permissionId!=null){
  					pId.push(nodes[i].permissionId);
  				}
  			}
  			$.ajax({
  				type:'post',
  				url:'<%=basePath%>system/addRolePermission',
  				data:{
  					roleId:roleId,
  					permissionIds:pId
  				},
  				success:function(data){
  					$('#permissionAddDig').dialog('close');
  					if(data.success==0){
  						$.messager.show({
							title:'提示信息',
							msg:'授权操作成功',
							timeout:3000,
							showType:'slide'
						});
  					}else if(data.success==1){
  						$.messager.alert('提示信息','授权操作失败！！！  错误：'+data.error.message,'error');
  					}
  				}
  			})
  		}
  	</script>
  </body>
</html>

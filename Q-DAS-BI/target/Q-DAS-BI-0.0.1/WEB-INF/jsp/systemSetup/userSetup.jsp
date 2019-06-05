<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
  	
	
  </head>
  
  <body>
    <table id="userTable" style="width: 100%;height: 100%">
	    <thead>
	        <tr>
	            <th data-options="field:'userId',width:50,align:'center'">用户ID</th>
	            <th data-options="field:'userName',width:80,align:'center'">用户名</th>
	            <th data-options="field:'userAccount',width:80,align:'center'">用户账号</th>
	            <th data-options="field:'password',width:80,align:'center'">密码</th>
	            <th data-options="field:'roleStr',width:60,align:'center'">角色</th>
	            <th data-options="field:'lockedStr',width:180,align:'center'">状态</th>
	        </tr>
	    </thead>
	</table>
	<div id="userTb" style="padding: 10px">
		<a id="addUser" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="openUserDig(1)">添加用户</a>
		<a id="editUser" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="openUserDig(2)">修改用户信息</a>
		<a id="roleUser" class="easyui-linkbutton" data-options="iconCls:'icon-man'" onclick="roleUser()">授权用户</a>
		<a id="delUser" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="delUser()">删除用户</a>
	</div>
	<div id="userEditDig" class="easyui-dialog" style="width:400px;height:350px;padding: 20px"
		data-options="modal:true,title:'编辑用户',closed:true,buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						editUser();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#userEditDig').dialog('close');
					}
				}]"> 
		<form id="userForm" method="post">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="userName" name="userName" style="width:100%" data-options="label:'用户名',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="userAccount" name="userAccount" style="width:100%" data-options="label:'用户账号',required:true,validType:{length:[1,20]},prompt:'账户名不能为空'">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="password" name="password" style="width:100%" data-options="label:'密码',required:true,validType:{length:[5,20]},prompt:'5-20位长度'">
			</div>
			<div style="margin-bottom:10px">
				<select id="lockedcc" class="easyui-combobox" name="locked" style="width:100%" data-options="label:'状态',required:true,panelHeight:100,editable:false">
					    <option value="0">活跃</option>
					    <option value="1">冻结</option>
					</select>
			</div>
			<input type="hidden" id="userId" name="userId">
		</form>
	</div>
	<div id="userRoleDig" class="easyui-dialog" style="width:400px;height:200px;padding: 20px"
		data-options="modal:true,title:'授权用户',closed:true,buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						userAddRole();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#userRoleDig').dialog('close');
					}
				}]"> 
		<form id="userRoleForm" method="post">
			<div style="margin-bottom:10px">
				<input id="roleList" name="roleList" style="width:100%" data-options="label:'角色',editable:false">
			</div>
		</form>
	</div>
	<script type="text/javascript">
		var addoredit;
  		$(function(){
  			$('#userTable').datagrid({
			    url:'<%=basePath%>system/getAllUser',
				toolbar:'#userTb',
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
  			$('#roleList').combobox({
  				url:'<%=basePath%>system/getAllRole',
				valueField:'roleId',
				textField:'roleName',
				multiple:true
  			})
  		})
  		function openUserDig(index){
  			var row=$('#userTable').datagrid('getSelected');
  			if(index==1){
  				addoredit=1;
  				$('#userForm').form('clear');
  			}else{
  				if(row==null|row==''){
	  				$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
	  				return false;
	  			}
	  			addoredit=2;
	  			$('#userForm').form('load',row);
  			}
  			$('#userEditDig').dialog('open');
  		
  		}
  		function editUser(){
  			$.messager.progress();
			$('#userForm').form('submit', {
				url:'<%=basePath%>system/addOrEditUser',
				onSubmit: function(){
					var isValid = $(this).form('validate');
					if (!isValid){
						$.messager.progress('close');
					}
					return isValid;
				},
				queryParams:{
					addoredit:addoredit
				},
				success: function(data){
					$.messager.progress('close');
					$('#userEditDig').dialog('close');
					var odata=JSON.parse(data);
					if(odata.success==0){
		  						$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:3000,
									showType:'slide'
								});
		  					}else if(odata.success==1){
		  						$.messager.alert('提示信息','操作失败！！！  错误：'+odata.error,'error');
		  					}
					$('#userTable').datagrid('reload');
				}
			});
  		}
  		function roleUser(){
  			var row=$('#userTable').datagrid('getSelected');
  			if(row==null|row==''){
	  				$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
	  				return false;
	  			}
	  		$('#userRoleForm').form('clear');
	  		$('#userRoleDig').dialog('open');
  		}
  		function delUser(){
  			var row=$('#userTable').datagrid('getSelected');
  			if(row==null|row==''){
	  				$.messager.alert('提示 信息','请选择一行数据进行删除','info');
	  				return false;
	  			}
	  		$.messager.confirm('提示信息', '确定删除该用户吗？', function(r){
				if (r){
					$.ajax({
						type:'post',
						data:{
							userId:row.userId
						},
						url:'<%=basePath%>system/delUser',
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
							$('#userTable').datagrid('reload');
						}
					})
				}
			})
  		}
  		function userAddRole(){
  			var row=$('#userTable').datagrid('getSelected');
  			var roleIds=$('#roleList').combobox('getValues');
  			$.ajax({
  				type:'post',
  				data:{
  					roleIdArr:roleIds,
  					userId:row.userId
  				},
  				url:'<%=basePath%>system/userAddRole',
  				success:function(data){
  					$('#userTable').datagrid('reload');
  				}
  			})
  		}
  	</script>
  </body>
</html>

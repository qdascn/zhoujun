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
		<a id="delUser" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="delUser()">删除用户</a>
	</div>
	<div id="userEditDig" class="easyui-dialog" style="width:400px;height:400px;padding: 20px"
		data-options="modal:true,closed:true,buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						alert('ok');
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
				<input class="easyui-textbox" id="userAccount" name="userAccount" style="width:100%" data-options="label:'用户账号',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="password" name="password" style="width:100%" data-options="label:'密码',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input id="roleList" name="roleStr" style="width:100%" data-options="label:'角色',required:true">
			</div>
			<div style="margin-bottom:10px">
				<select id="lockedcc" class="easyui-combobox" name="locked" style="width:100%" data-options="label:'状态',required:true,panelHeight:100">
					    <option value="0">活跃</option>
					    <option value="1">冻结</option>
					</select>
			</div>
		</form>
	</div>
	<script type="text/javascript">
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
  			console.log(row);
  			if(index==1){
  				
  			}else{
  				if(row==null|row==''){
	  				$.messager.alert('提示 信息','请选择一行数据进行编辑','info');
	  				return false;
	  			}
	  			$('#userForm').form('load',row);
  			}
  			$('#userEditDig').dialog('open');
  		
  		}
  	</script>
  </body>
</html>

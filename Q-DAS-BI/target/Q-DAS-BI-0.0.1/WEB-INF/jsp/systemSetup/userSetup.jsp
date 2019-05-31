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
	            <th data-options="field:'locked',width:180,align:'center'">状态</th>
	        </tr>
	    </thead>
	</table>
	<div id="userTb" style="padding: 10px">
		<a id="editUser" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改用户信息</a>
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
		<form id="ff" method="post">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="name" style="width:100%" data-options="label:'用户名',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="email" style="width:100%" data-options="label:'用户账号',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="subject" style="width:100%" data-options="label:'密码',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="email" style="width:100%" data-options="label:'角色',required:true">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="email" style="width:100%" data-options="label:'状态',required:true">
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
		  	$('#editUser').click(function(){
		  		$('#userEditDig').dialog('open');
		  	})	
  		
  		})
  	</script>
  </body>
</html>

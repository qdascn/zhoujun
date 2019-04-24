<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
<%@ include file="../base/meta.jsp"%>
	<script type="text/javascript">
		$(function(){
			$('#btn').click(function(){
				$.ajax({
					type:'post',
					data:{
						message:$('#message').textbox('getValue')
					},
					url:'<%=basePath%>case3/sendMessage'
				})
			})
			$('#btnrec').click(function(){
				$.ajax({
					type:'post',
					data:{
						message:$('#message').textbox('getValue')
					},
					url:'<%=basePath%>case3/receiveMessage'
				})
			})
		})
	
	</script>
  </head>
  
  <body>
  	<form method="post">
  	
  		<input id="message" name="message" class="easyui-textbox" style="width:500px;" />
  		<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">发送消息</a>
  		<a id="btnrec" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">获取消息</a>
  	</form>
  </body>
</html>

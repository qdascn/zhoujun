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
					name:$('#name').textbox('getValue')
				},
				url:'<%=basePath%>case2/getWsInfo',
				success:function(data){
					$('#name').textbox('setValue',data.result);
				}
			})
		})
	
	
	})

</script>
  </head>
  
  <body>
  	<form>
  		<input id="name" name="name" class="easyui-textbox" data-options="multiline:true" style="width:500px;height:300px" />
  		<a id="btn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">访问WebService获取零件表数据</a>
  	</form>
  </body>
</html>

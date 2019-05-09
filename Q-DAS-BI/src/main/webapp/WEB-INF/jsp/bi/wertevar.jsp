<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
	<script type="text/javascript">
	$(function(){
		$('#asd').click(function(){
			alert(1111);
			$('#teilAcc').accordion('select',1);
		})
	
	
	})
		
		
	
	
	</script>
  </head>
  
  <body>
    <a id="asd" class="easyui-linkbutton" data-options="iconCls:'icon-large-chart'" >显示测量值图表</a>
  </body>
</html>

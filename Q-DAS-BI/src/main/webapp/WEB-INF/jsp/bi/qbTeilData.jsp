<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,title:'查询栏'" style="height:10%;padding: 5px">
			零件号：<input id="teilNum" name="teilNum" class="easyui-textbox" data-options="" style="width:200px">
			<a id="teilSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchTeil('${plId }');">查询</a>
		</div>
		<div id="teilbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${teilList}" var="map">
				<a id="teil${map.TETEIL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }');"><font size="4">零件号：${map.TETEILNR }<br>零件名称：${map.TEBEZEICH }</font></a>
			</c:forEach>						
		</div> 
	</div>
	<script type="text/javascript">
		function searchTeil(plId){
			$('#teilAcc').panel({
				href:'<%=basePath%>qb/initTeilData?productLineName='+plId+'&teilNum='+$('#teilNum').textbox('getValue')
			});
		}
		function getMerkmal(teilId){
  			$('#teilbox > a').linkbutton({
			    iconCls:''
			});
			$('#teil'+teilId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#merkmalAcc').panel({
				href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId
			});
			$('#qbAcc').accordion('select',2); 
  		}
	</script>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
		        			产线号：<input id="productLineName" name="productLineName" class="easyui-textbox" data-options="" style="width:200px">
							<a id="productLineSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
		        		</div>
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							<c:forEach items="${plList}" var="map">
								<a id="${map.plId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
							</c:forEach>
						</div>
		        	</div>
	<script type="text/javascript">
	$(function(){
		$('#productLineSearchbtn').click(function(){
			$('#plAcc').panel({
				href:'<%=basePath%>qb/getProductLineData?productLineName='+$('#productLineName').textbox('getValue')
			});
		})
	
	})
	function getTeil(plId,plName){
  			$('#centerbox > a').linkbutton({
			    iconCls:''
			});
  			$('#'+plId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#teilAcc').panel({
				href:'<%=basePath%>qb/initTeilData?productLineName='+plName
			});
			//$('#teilAcc').panel('open');
			var accSelected = $('#qbAcc').accordion('getPanel',0);
			accSelected.panel('setTitle', '产线(产线名：'+plName+')');
			$('#qbAcc').accordion('select',1); 
  		}
	</script>
  </body>
</html>

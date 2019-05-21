<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
  	<script type="text/javascript">
  		function aaaa(obj){
  			$('#centerbox > a').linkbutton({
			    iconCls:''
			});
  			$('#'+obj).linkbutton({
			    iconCls: 'icon-large-gou'
			});
  		}
  	
  	</script>
  </head>
  
<body class="easyui-layout" fit="true" style="width: 100%;height: 100%">
	<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
		<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
	</div>
	<div data-options="region:'center',border:false,fit:true" style="overflow: hidden;">
		<div id="teilAcc" class="easyui-accordion" data-options="multiple:false,fit:true" style="width:100%;height:100%;">
			<div class="easyui-layout" fit="true" title="产线">
				<div data-options="region:'north',split:false,title:'查询'" style="height:10%;"></div>
				<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
					<c:forEach items="${list}" var="map">
						<a id="${map.pId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="aaaa('${map.pId}');"><font size="5">${map.pName }</font></a>
					</c:forEach>
				</div>
			</div>
			<div class="easyui-layout" fit="true" title="零件">
			
			</div>
			<div class="easyui-layout" fit="true" title="参数">
			
			</div>
		</div>
	</div>
</body>
</html>

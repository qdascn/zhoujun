<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
  <link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
  	<script type="text/javascript">
  		$(function(){
			$('#plAcc').panel({
				href:'<%=basePath%>qb/getProductLineData'
			});
		})
  	</script>
  </head>
  
<body>
	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
		</div>
	    <div data-options="region:'center',border:false" style="overflow: hidden;">
	    	<div id="qbAcc" class="easyui-accordion" data-options="multiple:false,fit:true,animate:true" style="width:100%;height:100%;">
		        <div id="plAcc" title="产线" style="overflow:auto;">
		        	<%-- <div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,title:'查询栏'" style="height:10%;"></div>
						<div id="centerbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							<c:forEach items="${plList}" var="map">
								<a id="${map.plId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getTeil('${map.plId}','${map.TEERZEUGNIS }');"><font size="4">产线名称：${map.TEERZEUGNIS }</font></a>
							</c:forEach>
						</div>
		        	</div> --%>
		        </div>
		        <div id="teilAcc" title="零件" style="padding:0px;">
		        	<!-- <div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,title:'查询'" style="height:10%;"></div>
						<div id="teilbox" data-options="region:'center'" style="padding:5px;background:#eee;">
							
						</div> 
		        	</div>-->
		        </div>
		        <div id="merkmalAcc" title="测量参数">
		        </div>
		    </div>
	    </div>
	</div>
</body>
</html>
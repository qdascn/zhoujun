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
		<div id="merkmalbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${merkmalList}" var="map">
				<a id="merkmal${map.MEMERKMAL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick=""><font size="4">${map.MEMERKBEZ }</font></a>
			</c:forEach>						
		</div> 
		<div id="charts" data-options="region:'east',split:true" style="padding:5px;background:#eee;width:50%;">
				        
		</div>
	</div>
  </body>
</html>

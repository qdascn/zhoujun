<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<frameset rows="88,*,31" cols="*" frameborder="no" border="0" framespacing="0">
	<frame src="<%=basePath%>main/mainTop" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
	<frameset cols="187,*" frameborder="no" border="0" framespacing="0">
		<frame src="<%=basePath%>main/mainLeft" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
		<frame src="" name="rightFrame" id="rightFrame" title="rightFrame" />
	</frameset>
	<frame src="<%=basePath%>main/mainFooter" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset>
<noframes>
	<body>
	</body>
</noframes>
</html>

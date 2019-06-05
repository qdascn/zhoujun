<%-- 资源文件页面 --%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=basePath%>resources/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/easyui/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui/themes/material-teal/easyui.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui/themes/color.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui/themes/icon.css" />

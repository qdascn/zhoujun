<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="meta.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">



</head>


<body style="background:#edf6fa;">
    
    <div class="error">
	    <h2>您还未登录或登录信息超时</h2>
	    <h2>请重新登录</h2>
	    <div class="reindex"><a href="<%=basePath%>main/loginPage">返回登录</a></div>
    </div>

<link href="<%=basePath %>resources/blueThemes/css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	$(function(){
    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
	$(window).resize(function(){  
    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
    })  
}); 
</script> 
</body>

</html>



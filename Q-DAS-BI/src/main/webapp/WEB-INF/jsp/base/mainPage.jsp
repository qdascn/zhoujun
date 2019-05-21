<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<head>
<title>bi Page</title>
<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
<link href="<%=basePath %>resources/blueThemes/css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	$(function(){
    $('.loginbox0').css({'position':'absolute','left':($(window).width()-810)/2});
	$(window).resize(function(){  
    $('.loginbox0').css({'position':'absolute','left':($(window).width()-810)/2});
    })  
});  
</script> 

</head>

<body background="<%=basePath%>resources/blueThemes/images/mainbg.png" style=" background-repeat:no-repeat ; background-size:100% 100%;  background-attachment: fixed;" >


	<div class="logintop">    
	    <span>欢迎进入信息管理系统</span>    
	    <ul>
	    <li><a href="#">回首页</a></li>
	    <li><a href="#">帮助</a></li>
	    <li><a href="#">关于</a></li>
	    </ul>    
    </div>
    
    <div class="loginbody1">
	    <span class="systemlogo"></span> 
	    <div class="loginbox0">
		    <ul class="loginlist">
			    <li><a href="<%=basePath%>teil/initTeil"><img src="<%=basePath%>resources/blueThemes/images/l01.png"  alt="测量数据展示"/><p>测量数据展示</p></a></li>
			    <li><a href="<%=basePath%>qb/initQb"><img src="<%=basePath%>resources/blueThemes/images/l04.png"  alt="质量看板"/><p>质量看板</p></a></li>
		    </ul>
	    </div>
    </div>
    <div class="loginbm">版权所有  2014&nbsp;&nbsp;&nbsp; <strong>uimaker.com</strong> &nbsp;&nbsp;&nbsp;仅供学习交流，勿用于任何商业用途</div>
</body>

</html>

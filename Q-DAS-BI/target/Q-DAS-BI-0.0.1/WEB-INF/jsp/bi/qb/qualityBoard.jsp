<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  <link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
  <link href="<%=basePath %>resources/blueThemes/css/bi.css" rel="stylesheet" type="text/css" />
  	<script type="text/javascript">
  		var qbStartTime,qbEndTime;
  		$(function(){
  		
			$('#plCenterbox').panel({
				href:'<%=basePath%>qb/getProductLineData'
			});
			$('#qbDig').dialog({
				title:'质量看板',
				height:$(window).height()-100,
   				width:$(window).width()-100,
				resizable:true,
				maximizable:true,
				modal:true,
				closed:true,
				onClose:function(){
					clearInterval(auto)
				}
			})
			$('#openQb').click(function(){
				$('#qbDig').panel({
							href:'<%=basePath%>qb/initQbShow?index='+'1'
						});
				$('#qbDig').dialog('open');
			});
		})
		function logout(){
			$.messager.confirm('提示信息', '确定登出用户？', function(r){
				if (r){
					window.location.href='<%=basePath%>main/logout';
				}
			});
		}
		function searchByTime(record){
  			var days=record.value;
				var now=new Date();
				if(days=='0'){
					$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData');
				}else if(days=='1h'){
					var searchTime=now.getTime()-3600000;
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					qbStartTime=startDate;
					qbEndTime=endDate;
					$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+startDate+'&endTime='+endDate);
				}else if(days=='1'|days=='7'|days=='30'){
					var searchTime=now.getTime()-(days*86400000);
					var ago=new Date(searchTime);
					var startDate=ago.getFullYear()+"-"+(ago.getMonth()+1)+"-"+ago.getDate()+" "+ago.getHours()+":"+ago.getMinutes()+":"+ago.getSeconds();
					var endDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
					qbStartTime=startDate;
					qbEndTime=endDate;
					$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+startDate+'&endTime='+endDate);
				}
  		}
  	</script>
  </head>
  
<body>
	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
							<div class="user">
							    <span>${user.userName }</span>
							    <i><a onclick="logout()" style="cursor:pointer">退出登录</a></i>
						    </div>    
		</div>
	    <div data-options="region:'center',border:false" style="overflow: hidden;">
	    	<div id="qbAcc" class="easyui-accordion" data-options="multiple:false,fit:true,animate:true" style="width:100%;height:100%;">
		        <div id="plAcc" title="产线" style="overflow:auto;">
		        	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
		        			选择时间：<select class="easyui-combobox" id="timecc" name="searchDate" style="width:200px;" 
		        			data-options="editable:false,onSelect:function(record){searchByTime(record);}">
		        						<option>---选择时间---</option>
									    <option value="0">显示全部数据</option>
									    <option value="1h">显示最后一小时的数据</option>
									    <option value="1">显示最后一天的数据</option>
									    <option value="7">显示最后一周的数据</option>
									    <option value="30">显示最后一个月(30)的数据</option>
									</select >
		        			<a id="openQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
		        		</div>
						<div id="plCenterbox" data-options="region:'center'"> </div>
		        	</div> 
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
	<div id="qbDig" ></div>
</body>
</html>
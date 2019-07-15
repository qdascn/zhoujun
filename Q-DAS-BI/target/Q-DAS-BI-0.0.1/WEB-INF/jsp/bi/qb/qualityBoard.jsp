<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  <title>质量看板</title>
  <link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
  <link href="<%=basePath %>resources/blueThemes/css/bi.css" rel="stylesheet" type="text/css" />
  	<script type="text/javascript">
  		var autoTeilPageTime;
		var autoTeilPageNum=1;
  		$(function(){
  			$('#autoTeilSpan').hide();
  			$('#qbAcc').accordion({
  				multiple:false,
  				fit:true,
			    animate:false,
			    onSelect:function(title,index){
			    	if(index==1){
			    		if($('#autoTeilPage').switchbutton('options').checked==true){
			    			autoTeilPageTime=setInterval(autoTeilPage, 5*1000);
			    		}
			    	}
			    },
			    onUnselect:function(title,index){
			    	if(index==1){
			    		if(autoTeilPageTime!=null&autoTeilPageTime!='undefined'){
			    			clearInterval(autoTeilPageTime);
			    		}
			    	}
			    }
			});
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
			$('#timecc').combobox({
				editable:false
			})
			$('#qbStartTime').datetimebox({
				disabled:true,
				onChange: function(newValue,oldValue){
					<%-- if($('#qbEndTime').datetimebox('getValue')!=''&$('#qbEndTime').datetimebox('getValue')<$('#c').datetimebox('getValue')){
						$.messager.alert('提示信息','结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
					} --%>
				}
			})
			$('#qbEndTime').datetimebox({
				disabled:true,
				onChange: function(newValue,oldValue){
					<%-- if($('#qbStartTime').datetimebox('getValue')!=''&$('#qbEndTime').datetimebox('getValue')<$('#qbStartTime').datetimebox('getValue')){
						$.messager.alert('提示信息','结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
					} --%>
				}
			})
			$('#qbSearchTimeType1').radiobutton({
				onChange:function(checked){
					if(checked==true){
						$('#timecc').combobox('disable');
						$('#qbEndTime').datetimebox('enable');
						$('#qbStartTime').datetimebox('enable');
					}
				}
			})
			$('#qbSearchTimeType2').radiobutton({
				checked:true,
				onChange:function(checked){
					if(checked==true){
						$('#timecc').combobox('enable');
						$('#qbEndTime').datetimebox('clear').datetimebox('disable');
						$('#qbStartTime').datetimebox('clear').datetimebox('disable');
					}
				}
			})
			
			$('#autoTeilPage').switchbutton({
	            checked: false,
	            onText:'自动翻页',
	            offText:'无翻页',
	            onChange: function(checked){
	                if(checked==true){
	                	$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilDataByPage?productLineName='+$('#elTeilProductLineName').val()+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')+'&page='+1+'&rows='+'30');
	                	$('#autoTeilSpan').show();
	                }else{
	                	$('#autoTeilSpan').hide();
	                }
	                pageModel(checked);
	            }
	        });
	        $('#qbMainSearchBtn').click(function(){
	        	if($('#qbSearchTimeType1').radiobutton('options').checked==true){
	        		if($('#qbStartTime').datetimebox('getValue')==''|$('#qbEndTime').datetimebox('getValue')==''|$('#qbEndTime').datetimebox('getValue')<$('#qbStartTime').datetimebox('getValue')){
						$.messager.alert('提示信息','时间不能为空，结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
					}
	        	}else{
	        		var mainSearchTime=searchTimeInterval($('#timecc').combobox('getValue'));
	        		$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+mainSearchTime.startTime+'&endTime='+mainSearchTime.endTime);
	        	}
	        })
	     })   
	        
	     function logout(){
			$.messager.confirm('提示信息', '确定登出用户？', function(r){
				if (r){
					window.location.href='<%=basePath%>main/logout';
				}
			});
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
	    	<div id="qbAcc" style="width:100%;height:100%;">
		        <div id="plAcc" title="产线" style="overflow:auto;">
		        	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px;overflow: hidden">
		        			<form>
		        				<input id="qbSearchTimeType1" name="qbSearchTimeType">
			        			&nbsp;<input id="qbStartTime" name="qbStartTime" style="width:180px" data-options="editable:false">
			        			至&nbsp;<input id="qbEndTime" name="qbEndTime" style="width:180px" data-options="editable:false">
			        			<input id="qbSearchTimeType2" name="qbSearchTimeType">
			        			<select id="timecc" name="searchDate" style="width:200px;">
			        						<!-- <option value="init">---选择时间---</option> -->
										    <option value="0">显示全部数据</option>
										    <option value="1h">显示最后一小时的数据</option>
										    <option value="1">显示最后一天的数据</option>
										    <option value="7">显示最后一周的数据</option>
										    <option value="30">显示最后一个月(30)的数据</option>
										</select >
								<a id="qbMainSearchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
			        			<a id="openQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
		        			</form>
		        		</div>
						<div id="plCenterbox" data-options="region:'center'"> </div>
		        	</div> 
		        </div>
		        <div title="零件" style="padding:0px;">
		        	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
							零件号：<input id="teilNum" name="teilNum" class="easyui-textbox" data-options="" style="width:200px">
							零件名：<input id="teilName" name="teilName" class="easyui-textbox" data-options="" style="width:200px">
							<a id="teilSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchTeil();">查询</a>
							&nbsp;&nbsp;&nbsp;<input id='autoTeilPage' style="width: 100;">
							&nbsp;<span id="autoTeilSpan"></span>
							<!-- <select class="easyui-combobox" id="autoTeilPageSelect" name="autoTeilPageSelect" style="width:100px;"data-options="editable:false">
									    <option value="5">5秒</option>
									    <option value="10">10秒</option>
									    <option value="1">1秒</option>
									</select > -->
							<a id="openTeilQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-search'" style="float: right">打开轮播看板</a>
						</div>
						<div id="teilAcc" data-options="region:'center'"></div>
		        	</div>
		        </div>
		        <div id="merkmalAcc" title="测量参数">
		        </div>
		    </div>
	    </div>
	</div>
	<div id="qbDig" ></div>
</body>
</html>
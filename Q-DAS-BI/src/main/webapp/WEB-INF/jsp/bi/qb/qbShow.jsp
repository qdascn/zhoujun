<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
 <body>
    <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	    <div data-options="region:'north',collapsible:false" style="height:10%;">
	    	<a id="openQb" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getFormData()" style="float: right">easyui</a>
	    </div>
	    <div data-options="region:'south',collapsible:false" style="height:30%;"></div>
	    <div data-options="region:'west',collapsible:false" style="width:30%;padding: 10px">
	    	<form id="dataForm" method="post">
	    		<div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEERZEUGNIS" style="width:100%;padding-left: 20px" data-options="label:'产线名:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TETEILNR" style="width:100%;padding-left: 20px" data-options="label:'零件号:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="TEBEZEICH" style="width:100%;padding-left: 20px" data-options="label:'零件名:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="MEMERKBEZ" style="width:100%;padding-left: 20px" data-options="label:'参数:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="MENENNMAS" style="width:100%;padding-left: 20px" data-options="label:'名义值:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="MEUGW" style="width:100%;padding-left: 20px" data-options="label:'上公差上限:',editable:false">
	            </div>
	            <div style="margin-top:15px">
	                <input class="easyui-textbox" name="MEOGW" style="width:100%;padding-left: 20px" data-options="label:'下公差上限:',editable:false">
	            </div>
	        </form>
	    </div>
	    <div data-options="region:'center'" style="padding:5px;background:#eee;"></div>
	</div>
	<script type="text/javascript">
		var index=0;
		setInterval(getFormData, 3000);
		function getData(){
			index +=1;
		    console.log(index);
		}
		function getFormData(){
			$.ajax({
				type:'post',
				data:{
					arrIndex:index
				},
				url:'<%=basePath%>qb/getQbForm',
				success:function(data){
					if(data.arrAlarm==0){
						index += 1;
					}else{
						index=0
					}
					$('#dataForm').form('load',data);
				}
			})
		}
	</script>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
	<script type="text/javascript">
		var data = [{
	        text: '权限设置',
	        iconCls: 'icon-sum',
	        state: 'open',
	        children: [{
	            text: '用户设置'
	        }]
	    }];

		function toggle(){
			var opts = $('#sm').sidemenu('options');
			$('#sm').sidemenu(opts.collapsed ? 'expand' : 'collapse');
			opts = $('#sm').sidemenu('options');
			$('#sm').sidemenu('resize', {
				width: opts.collapsed ? 60 : 200
			})
		}
	</script>
  </head>
  
  <body>
    <div class="easyui-layout" fit="true"> 
    	<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
		</div>
	    <div data-options="region:'west',title:'菜单',split:true" style="background:#eee;width:300px;">
	    	<div id="sm" class="easyui-sidemenu" data-options="data:data" style="width: 100%"></div>
	    </div>
	    <div data-options="region:'center'" style="padding:5px;background:#eee;"></div>
    </div>
  </body>
</html>

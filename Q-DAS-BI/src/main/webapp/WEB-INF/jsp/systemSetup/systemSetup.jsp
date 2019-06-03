<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../base/meta.jsp"%>
<html>
  <head>
	<script type="text/javascript">
		$(function(){
			var data = [{
		        text: '权限设置',
		        iconCls: 'icon-sum',
		        state: 'open',
		        children: [{
		            text: '用户设置',
		            url:'<%=basePath%>system/initUserSetup'
		            
		        },{
		        	text:'角色设置',
		        	url:'<%=basePath%>system/initRoleSetupPage'
		        },{
		        	text:'产线设置',
		        	url:'<%=basePath%>system/initProductLineSetup'
		        }]
		    }];
			$('#sm').sidemenu({
				data:data,
				onSelect:function(item){
					$('#centerDiv').panel({
						href:item.url
					})
				}
			});
			$('#_easyui_tree_1').addClass('tree-node-selected');
			$('#centerDiv').panel({
				href:'<%=basePath%>system/initUserSetup'
			})
		
		})
		/* function toggle(){
			var opts = $('#sm').sidemenu('options');
			$('#sm').sidemenu(opts.collapsed ? 'expand' : 'collapse');
			opts = $('#sm').sidemenu('options');
			$('#sm').sidemenu('resize', {
				width: opts.collapsed ? 60 : 200
			})
		} */
	</script>
  </head>
  
  <body>
    <div class="easyui-layout" fit="true"> 
    	<div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small> <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></small></div>
		</div>
	    <div data-options="region:'west',title:'菜单',split:true" style="background:#eee;width:150px;">
	    	<div id="sm" style="width: 100%"></div>
	    </div>
	    <div id="centerDiv" data-options="region:'center'"></div>
    </div>
  </body>
</html>

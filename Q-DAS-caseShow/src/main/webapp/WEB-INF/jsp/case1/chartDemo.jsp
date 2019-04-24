<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
	<%@ include file="../base/meta.jsp"%>
	<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function(){
			// 基于准备好的dom，初始化echarts实例
	        var myChart = echarts.init(document.getElementById('zhu'));
	
	        // 指定图表的配置项和数据
	        var option = {
	            title: {
	                text: 'ECharts 入门示例'
	            },
	            tooltip: {},
	            legend: {
	                data:['销量']
	            },
	            xAxis: {
	                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
	            },
	            yAxis: {},
	            series: [{
	                name: '销量',
	                type: 'bar',
	                data: [5, 20, 36, 10, 10, 20]
	            }]
	        };
	
	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
			
		
		})
		
	</script>
  </head>
  
  <body class="easyui-layout">
	  <div data-options="region:'north',title:'散点图',split:false,collapsible:false" style="height:30%;"></div>
	  <div data-options="region:'south',title:'折线图',split:false,collapsible:false" style="height:30%;"></div>
	  <div data-options="region:'center',title:'柱状图'" >
	  	<div id="zhu" style="width: 600px;height:300px;"></div>
	  </div>
  </body>
  
</html>

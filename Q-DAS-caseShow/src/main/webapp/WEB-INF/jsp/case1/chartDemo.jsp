<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
	<%@ include file="../base/meta.jsp"%>
	<script type="text/javascript" src="<%=basePath%>resources/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function(){
			// 基于准备好的dom，初始化echarts实例
	        var myChart = echarts.init(document.getElementById('zhu'),'dark');
	
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
			
			var binchart=echarts.init(document.getElementById('bin'));
			binchart.setOption({
				backgroundColor: '#2c343c',
				title:{
					text:'吃饼',
					    textStyle: {
					        color: 'rgba(255, 255, 255, 0.3)'
					    }
				},
				series : [
				        {
				            name: '访问来源',
				            type: 'pie',
				            radius: '55%',
				            roseType: 'angle',
				            data:[
				                {value:235, name:'视频广告'},
				                {value:274, name:'联盟广告'},
				                {value:310, name:'邮件营销'},
				                {value:335, name:'直接访问'},
				                {value:400, name:'搜索引擎'}
				            ],
				            label: {
				                    textStyle: {
				                        color: 'rgba(255, 255, 255, 0.3)'
				                    }
				            },
				            labelLine: {
				                    lineStyle: {
				                        color: 'rgba(255, 255, 255, 0.3)'
				                    }
				            },
				            itemStyle: {
							    // 设置扇形的颜色
							    color: '#c23531',
							    shadowBlur: 200,
							    shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
				        }
				    ],
				    
				    itemStyle: {
					    // 阴影的大小
					    shadowBlur: 200,
					    // 阴影水平方向上的偏移
					    shadowOffsetX: 0,
					    // 阴影垂直方向上的偏移
					    shadowOffsetY: 0,
					    // 阴影颜色
					    shadowColor: 'rgba(0, 0, 0, 2)',
					    emphasis: {
					        shadowBlur: 200,
					        shadowColor: 'rgba(0, 0, 0, 2)'
					    }
					}
			})
		
		})
		
	</script>
  </head>
  
  <body class="easyui-layout">
	  <div data-options="region:'north',title:'散点图',split:false,collapsible:false" style="height:30%;"></div>
	  <div data-options="region:'south',title:'折线图',split:false,collapsible:false" style="height:30%;"></div>
	  <div data-options="region:'center',title:'柱状图'" >
	  	<div id="zhu" style="width: 600px;height:300px;float: left"></div>
	  	<div id="bin" style="width: 600px;height:300px;float: left"></div>
	  </div>
  </body>
  
</html>

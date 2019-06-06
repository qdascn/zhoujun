function initLineChart(divId,xValues,yValues,upLimitData,downLimitData){
	if(upLimitData==null|upLimitData==''){
			upLimitData=0
		}
		if(downLimitData==null|downLimitData==''){
			downLimitData=0
		}
	var lineChart=echarts.init(document.getElementById(divId));
	option = {
			toolbox: {
		        show: true,
		        feature: {
		            dataZoom: {
		                yAxisIndex: 'none'
		            },
		            dataView: {readOnly: false},
		            magicType: {type: ['line','bar']},
		            restore: {},
		            saveAsImage: {}
		        }
		    },
			 tooltip: {
	            trigger: 'axis'
	        },
		    xAxis: {
		   		type : 'category',
		    	//name:'检测时间',
		    	data: xValues
		    },
		    yAxis : [
                {
                    type : 'value',
                    splitLine:{
                        show:false
                    },
                    min: function(value) {
                        //判断y轴最大最小值

                        if(value.min<parseFloat(downLimitData)){
                            return value.min
                        }else{
                            return downLimitData
                        };

                    },
                    max: function(value) {
                        if(value.max>parseFloat(upLimitData)){
                            return value.max
                        }else{
                            return upLimitData
                        }
                    }
                }
            ],
            dataZoom: [{
	            type: 'slider'
	        }],
		    series: [{
		        data: yValues,
		        type: 'line',
		        	markLine:{
		           		precision:5,
			        	data:[{
			        		silent:true,
                            lineStyle:{
                                type:"dashed",
                                color:"#f00",
                            },
			        		yAxis:upLimitData,
                            name:upLimitData,
			        		label:{
                                position:"end",
                                normal:{
                                    show:true,
                                    formatter:'{c}'+'上公差限'
                                }
                            }
			        	},{
			        		silent:true,
                            lineStyle:{
                                type:"dashed",
                                color:"#f00",
                            },
			        		yAxis:downLimitData,
                            name:downLimitData,
			        		label:{
                                position:"end",
                                normal:{
                                    show:true,
                                    formatter:'{c}'+'下公差限'
                                }
                            }
			        	}]
			        }
		    }]
		};
	lineChart.setOption(option);
	return lineChart;
}
function initLineChart2(divId,xValues,yValues,upLimitData,downLimitData,mData){
	if(upLimitData==null|upLimitData==''){
			upLimitData=0
		}
		if(downLimitData==null|downLimitData==''){
			downLimitData=0
		}
		if(mData==null|mData==''){
			mData=0
		}
	var lineChart=echarts.init(document.getElementById(divId));
	option = {
			toolbox: {
		        show: true,
		        feature: {
		            dataZoom: {
		                yAxisIndex: 'none'
		            },
		            dataView: {readOnly: false},
		            magicType: {type: ['line','bar']},
		            restore: {},
		            saveAsImage: {}
		        }
		    },
			 tooltip: {
	            trigger: 'axis'
	        },
		    xAxis: {
		   		type : 'category',
		    	//name:'检测时间',
		    	data: xValues
		    },
		    yAxis : [
                {
                    type : 'value',
                    splitLine:{
                        show:false
                    },
                    min: function(value) {
                        //判断y轴最大最小值

                        if(value.min<parseFloat(downLimitData)){
                            return value.min
                        }else{
                            return downLimitData
                        };

                    },
                    max: function(value) {
                        if(value.max>parseFloat(upLimitData)){
                            return value.max
                        }else{
                            return upLimitData
                        }
                    }
                }
            ],
            dataZoom: [{
	            type: 'slider'
	        }],
		    series: [
		    	{
		        data: yValues,
		        type: 'line',
		        color:'#3838fc',
		        	markLine:{
		           		precision:5,
			        	data:[{
			        		silent:false,
                            lineStyle:{
                                type:"dashed",
                                color:"#f00",
                            },
			        		yAxis:upLimitData,
                            name:upLimitData,
			        		label:{
                                position:"end",
                                normal:{
                                    show:true,
                                    formatter:'{c}'+'上公差限'
                                }
                            }
			        	},{
			        		silent:false,
                            lineStyle:{
                                type:"dashed",
                                color:"#f00",
                            },
			        		yAxis:downLimitData,
                            name:downLimitData,
			        		label:{
                                position:"end",
                                normal:{
                                    show:true,
                                    formatter:'{c}'+'下公差限'
                                }
                            }
			        	},{
			        		silent:false,
                            lineStyle:{
                                type:"dashed",
                                color:"#00EE00",
                            },
			        		yAxis:mData,
                            name:mData,
			        		label:{
                                position:"end",
                                normal:{
                                    show:true,
                                    formatter:'{c}'+'名义值'
                                }
                            }
			        	}]
			        }
		    }]
		};
	lineChart.setOption(option);
	return lineChart;
}
function initBarAndPie(divId,xValues,yValues,pieData){
	var chart=echarts.init(document.getElementById(divId));
	option = {
		     grid: [{
		        top: 100,
		        width: '50%',
		        bottom: 100,
		        left: 10,
		        containLabel: true
		    }],
		    xAxis: {
		        type: 'category',
		        data: xValues
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [{
		        data: yValues,
		        type: 'bar'
		    },{       
		            name: '访问来源',
		            type: 'pie',
		            radius : '40%',
		            center: ['75%', '50%'],
		            data:pieData,
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }    
		    
		    ]
		};
		chart.setOption(option);
		return chart;
	
}
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

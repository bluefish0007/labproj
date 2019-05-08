<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- newtopic_news.jsp -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民汉舆情汇聚与监测系统 — 热门话题</title>

    <link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrapSwitch.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/jquery-ui.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/model.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/timeline.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/hotspots.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/vendor-font.css">

    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery-1.9.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/bootstrap.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/bootstrapSwitch.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery.metisMenu.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/underscore-1.5.2.js"></script>
    <!--<script src="js/highlight.js"></script>-->
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/hotspots.js"></script>
    <!-- 搜索提示 -->
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/search.js"></script>

    <!--例子-->
    <script src="resourse/js/myjs.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/mycss.css">
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    
    <!-- 上一个页面链接 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/templatemo_justified.css" />
	<script src="<%=request.getContextPath()%>/resources/js/jquery-1.7.2.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/bootstrap-modal.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/bootstrap-dialog.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/index/html5shiv.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/index/respond.min.js"></script>	
	<script src="<%=request.getContextPath()%>resources/js/echarts/echarts.js"></script>
		
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    
    <!-- 另一个页面考过来的代码 -->
   	<script type="text/javascript">
		require.config({
		    paths: {
		        echarts: 'http://echarts.baidu.com/build/dist'
		    }
		});

		// 使用
		require([
	        'echarts',
	        'echarts/chart/bar',
	        'echarts/chart/wordCloud',
	        'echarts/chart/force'
	        // 使用柱状图就加载bar模块，按需加载
	    ],
	    function (ec) {
    	    // 基于准备好的dom，初始化echarts图表
	        var nePerChart = ec.init(document.getElementById('ne-per')); 
	        var neLocChart = ec.init(document.getElementById('ne-loc')); 
	        var neOrgChart = ec.init(document.getElementById('ne-org')); 
	        var myChart4 = ec.init(document.getElementById('ciyun'));
	        //var myChart5 = ec.init(document.getElementById('shiti'));
	        
	        var myChartTest = ec.init(document.getElementById('shititest'));
               
	        var optNePer = {
			    noDataLoadingOption:{
			    	//text:'正在等待请求数据或者数据不存在',
			    	text: '暂无数据', //sunpeng-2018.03.25
			    	effect: 'bubble',
			    	effectOption: {
			    		effect: {
			    			n:0
			    		}
			    	}
			    },
	        	tooltip: {
			        trigger: 'item'
			    },
			    grid: {
	           		x:60,
	           		y:5,
	           		x2:30,
	           		y2:25
	           },
			   calculable : true,
			   xAxis: [{
				   name : '数量',
			       type : 'value',
			       boundaryGap : [0, 0.01]
			   }],
			   yAxis: [{
			   		type : 'category',
			        //  data : ['巴西','印尼','美国','印度','中国','世界']
			        axisLabel : {
			        	interval : 0,
						rotate : 30,
						margin : 5,
						textStyle : {
							fontSize : 10
						}
					},
			   }],
			   series: [{
					type:'bar',
			        //  data: [100, 200, 500, 550, 600, 600]
			        itemStyle : {
			        	normal : {
			            	color:"#00BFFF",
			            	label : {
					 			show : true
					 		}
					 	}
					}
			   }]
			};
	        function loadPerData(option) {
				$.ajax({
					type : "get",
					async : false,
					url : "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicPer",
					data : {},
					dataType : "json",
					success : function(result) {
						if (result) {
							var j = 0;
							
							option.yAxis[0].data = [];
							for(var i in result){
								option.yAxis[0].data.push(i);
								j=j+1;
								if(j > 10) { break; }
							}
							option.series[0].data = [];
							j=0;
							for(var i in result) {
								option.series[0].data.push(parseInt(result[i]));
								j=j+1;
								if(j > 10) { break; }
							}
						}
					}
				});
			}
        
		var optNeLoc = {
			noDataLoadingOption: {
			   	//text:'正在等待请求数据或者数据不存在',
			   	text: '暂无数据', //sunpeng-2018.03.25
			   	effect: 'bubble',
			   	effectOption: {
			   		effect: {
			   			n:0
				    }
				}
		    },
			tooltip: {
		    	trigger: 'item'
		    },
		    grid: {
		    	x:60,
           		y:5,
           		x2:30,
           		y2:25
           	},
		    calculable : true,
		    xAxis: [{
		    	name : '数量',
		    	type: 'value',
		        boundaryGap: [0, 0.01]
		    }],
		    yAxis: [{
		    	type: 'category',
		       	//     data : ['巴西','印尼','美国','印度','中国','世界']
		        axisLabel: {
		            interval: 0,
					rotate: 30,
					margin: 5,
					textStyle: {
						fontSize : 10
					}
				},
		    }],
		    series: [{
		    	type: 'bar',
		       	//     data:[100, 200, 500, 550, 600, 600]
		        itemStyle: {
		          	normal: {
			        	color: "#FF00FF",
			            label: {
					 		show : true
					 	}
					}
		 		}
		    }]
		};
		
		function loadLocData(option){
			$.ajax({
				type: "get",
				async: false,
				url: "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicLoc",
				data: {},
				dataType: "json",
				success : function(result) {
					if (result) {
						option.yAxis[0].data = [];
						//	for (var i = 0; i < result.length; i++) {
						//		option.xAxis[0].data.push(i);
						//	}
						var j = 0;
							for(var i in result){
								option.yAxis[0].data.push(i);
								j=j+1;
								if(j > 10) { break; }
							}
							option.series[0].data = [];
						//	for (var i = 0; i < result.length; i++) {
						//		option.series[0].data.push(result[i]);
						//	}
							j=0;
							for(var i in result){
								option.series[0].data.push(parseInt(result[i]));
								j=j+1;
								if(j > 10) { break; }
							}
						}
					}

				});
			}
		 
		 var optNeOrg = {
				 noDataLoadingOption:{
				    //text:'正在等待请求数据或者数据不存在',
				    text:'暂无数据', //sunpeng-2018.03.25
				    effect:'bubble',
				    effectOption:{
				    	effect:{
				    		n:0
				    	}
				    }
				 },
				 tooltip : {
				 	trigger: 'item'
				 },
				 grid:{
					x:60,
		           	y:5,
		           	x2:30,
		           	y2:25
	             },
				 calculable : true,
				 xAxis : [{
					name : '数量',
				 	type : 'value',
				    boundaryGap : [0, 0.01]
				 }],
				 yAxis : [{
				 	type : 'category',
				    //  data : ['巴西','印尼','美国','印度','中国','世界']
				    axisLabel : {
						interval : 0,
						rotate : 30,
						margin : 5,
						textStyle : {
							fontSize : 10
						}
					}
				 }],
				 series : [{
				 	type:'bar',
				    //  data:[100, 200, 500, 550, 600, 600]
				 	itemStyle : {
				 		normal : {
				 			color:"#228B22",
				 			label : {
				 				show : true
				 			}
				 		}
				 	}
				 }]
				};   
		 function loadOrgData(option){
				$.ajax({
					type : "get",
					async : false,
					url : "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicOrg",
					data : {},
					dataType : "json",
					success : function(result) {
						if (result) {
							var j=0;
							option.yAxis[0].data = [];
							for(var i in result){
								option.yAxis[0].data.push(i);
								j=j+1;
								if(j > 10) { break; }
							}
							option.series[0].data = [];
							j=0;
							for(var i in result){
								option.series[0].data.push(parseInt(result[i]));
								j=j+1;
								if(j > 10) { break; }
							}
						}
					}

				});
			}
		 
		 function createRandomItemStyle() {
			    return {
			        normal: {
			            color: 'rgb(' + [
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160)
			            ].join(',') + ')'
			        }
			    };
			}
		 
		 var keys=[];
		 var values=[];
		 
		 $.ajax({
		 	type:"get",
		 	async:false,
		 	url:"${request.contextPath}/mwyqMonitor/topic/${topicId}/getEntityKey",
		 	dataType:"json",
		 	success:function(result){
		 		if(result){
		 			for(var i in result){
		 				keys.push(i);
		 				values.push(result[i]);
		 			}
		 		}
		 	}
		 });

		option4 = {
			//    title: {
			//        text: 'Google Trends',
			//        link: 'http://www.google.com/trends/hottrends'
			//    },
			 noDataLoadingOption:{
		    	//text:'正在等待请求数据或者数据不存在',
		    	text:'暂无数据', //sunpeng-2018.03.25
		    	effect:'bubble',
		    	effectOption:{
		    		effect:{
		    			n:0
		    		}
		    	}
		    },   
			tooltip: {
			        show: true
			    },
			    series: [{
			     //   name: '中央民族大学',
			        type: 'wordCloud',
			        size: ['95%', '95%'],
			        textRotation : [0, 45, 90, -45],
			        textPadding: 0,
			        autoSize: {
			            enable: true,
			            minSize: 20
			        },
			        data:	
	            		(function(){
		        		var res=[];
		        		var len=keys.length;
		        		while(len--){
		        			res.push({
		        				name:keys[len],
		        				value:values[len],
		        				itemStyle: createRandomItemStyle()	
		        			});
		        		}
		        		return res;
		        	})()
			    }]
			};
			
			var names=[];
			var name_values=[];
			 $.ajax({
			 	type:"get",
			 	async:false,
			 	url:"${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicToEntity",
			 	dataType:"json",
			 	success:function(result){
			 		if(result){
			 			for(var i in result){
			 				names.push(i);
			 				name_values.push(result[i]);
			 			}
			 		}
			 	}
			 });
			
			/* 
			option5 = {
				  //  title : {
				  //      text: '人物关系：乔布斯',
				  //      subtext: '数据来自人立方',
				  //      x:'right',
				  //      y:'bottom'
				  //  },
				   noDataLoadingOption:{
		    	//text:'正在等待请求数据或者数据不存在',
		    	text:'暂无数据', //sunpeng-2018.03.25
		    	effect:'bubble',
		    	effectOption:{
		    		effect:{
		    			n:0
		    		}
		    	}
		    }, 
				  tooltip : {
				        trigger: 'item',
				        formatter: '{a} : {b}'
				    },
				    toolbox: {
				        show : true,
				      //  feature : {
				      //      restore : {show: true},
				     //       magicType: {show: true, type: ['force', 'chord']},
				     //       saveAsImage : {show: true}
				     //   }
				    },
				    legend: {
				        x: 'left',
				        data:['话题','人物','地点','组织机构']
				    },
				    series : [
				        {
				            type:'force',
				       //     name : "话题和实体的关系",
				            ribbonType: false,
				            categories : [
				                {
				                    name: '新闻'
				                },
				                {
				                    name:'人物'
				                },
				                {
				                    name: '地点'
				                },
				                {
				                    name: '组织机构'
				                }
				            ],
				            itemStyle: {
				                normal: {
				                    label: {
				                        show: true,
				                        textStyle: {
				                            color: '#333'
				                        }
				                    },
				                    nodeStyle : {
				                        brushType : 'both',
				                        borderColor : 'rgba(255,215,0,0.4)',
				                        borderWidth : 1
				                    },
				                    linkStyle: {
				                        type: 'curve'
				                    }
				                },
				                emphasis: {
				                    label: {
				                        show: false
				                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
				                    },
				                    nodeStyle : {
				                        //r: 30
				                    },
				                    linkStyle : {}
				                }
				            },
				            useWorker: false,
				            minRadius : 15,
				            maxRadius : 25,
				            gravity: 1.1,
				            scaling: 1.1,
				            roam: 'move',
				            nodes:
				            	///*
				            	[
				                {category:0, name: '乔布斯', value : 10, label: '乔布斯\n（主要）'},
				                {category:1, name: '丽萨-乔布斯',value : 2},
				                {category:1, name: '保罗-乔布斯',value : 3},
				                {category:1, name: '克拉拉-乔布斯',value : 3},
				                {category:1, name: '劳伦-鲍威尔',value : 7},
				                {category:2, name: '史蒂夫-沃兹尼艾克',value : 5},
				                {category:2, name: '奥巴马',value : 8},
				                {category:2, name: '比尔-盖茨',value : 9},
				                {category:2, name: '乔纳森-艾夫',value : 4},
				                {category:2, name: '蒂姆-库克',value : 4},
				                {category:2, name: '龙-韦恩',value : 1},
				            ],
				            //
				            	(function(){
					        		var res=[];
					        		var len=names.length;
					        		while(len--){
					        			res.push({
					        				name:names[len],
					        				//name:name,
					        				
					        				category:name_values[len],
					        				//category:name_value,
					        				//itemStyle: createRandomItemStyle()	
					        				value:Math.round(Math.random() * 100)
					        			});
					        		}
					        		return res;
					        	})()
					        	,

					            links : 
					            	(function(){
						        		var res=[];
						        		var len=names.length;
						        		while(len--){
						        			res.push({
						        				source:names[len],
						        				target:names[names.length-1]
						        				//itemStyle: createRandomItemStyle()	
						        			});
						        		}
						        		return res;
						        	})()
				        }
				    ]
				};
			*/
				
		loadPerData(optNePer);
		loadLocData(optNeLoc);
		loadOrgData(optNeOrg);
				                    
        nePerChart.setOption(optNePer); 
        neLocChart.setOption(optNeLoc); 
        neOrgChart.setOption(optNeOrg); 
        myChart4.setOption(option4); 
        //myChart5.setOption(option5);
        
        var nodes = [];
        var links = [];
        var entity = [];
        var title = [];
        var a=0;
        var b=0;
        
        //nodes
        //{category:0, name: '新闻1', value : 10},
        
        //links
        //{source : '新闻1', target : '北京', weight : 1},
	 function loadRelationData(){
		 $.ajax({
			 	type:"get",
			 	async:false,
			 	url:"${request.contextPath}/mwyqMonitor/topic/${topicId}/getEntityRe",
			 	dataType:"json",
			 	success:function(result){
			 		//a=a+1;
			 		//var test = JSON.stringify(result);
			 		//alert(test);
			 		$.each(result,function(i,item){
			 			b = b+1;
			 			links.push({
			 				source:item.title,
			 				target:item.entity,
			 				weight:1
			 			});
			 			
			 			if(title.indexOf(item.title)==-1){
			 				title.push(item.title);
			 				nodes.push({
			 					category:0,
			 					name:item.title,
			 					value:20
			 				});
			 			}
			 			
			 			if(entity.indexOf(item.entity)==-1){
			 				entity.push(item.entity);
			 				
			 				if(item.type==1){
			 					nodes.push({
			 						category:1,
			 						name:item.entity,
			 						value:15
			 					});
			 				}
			 				
			 				if (item.type==2){
			 					nodes.push({
			 						category:2,
			 						name:item.entity,
			 						value:15
			 					});
			 				}
			 				
			 				else{
			 					nodes.push({
			 						category:3,
			 						name:item.entity,
			 						value:15
			 					});
			 				}
			 			}
			 			
			 			
			 			
			 		})
			 	},
			 	error: function () {
		            alert("返回数据失败");
		            a=a+2;
		        }
			 });
		};
        var optionEntity = {
                tooltip : {
                    trigger: 'item',
                    formatter: '{a} : {b}'
                },
                toolbox: {
                    show : true,
                    feature : {
                        restore : {show: true},
                        magicType: {show: true, type: ['force', 'chord']},
                        //saveAsImage : {show: true}
                    }
                },
                legend: {
                    x: 'left',
                    data:['人物','地点','组织结构']
                },
                series : [
                    {
                        type:'force',
                        name : "关系",
                        ribbonType: false,
                        categories : [
                            {
                                name: '新闻'
                            },
                            {
                                name: '人物'
                            },
                            {
                                name:'地点'
                            },
                            {
                                name:'组织结构'
                            }
                        ],
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true,
                                    textStyle: {
                                        color: '#333'
                                    }
                                },
                                nodeStyle : {
                                    brushType : 'both',
                                    borderColor : 'rgba(255,215,0,0.4)',
                                    borderWidth : 1
                                },
                                linkStyle: {
                                    type: 'curve'
                                }
                            },
                            emphasis: {
                                label: {
                                    show: false
                                    // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                                },
                                nodeStyle : {
                                    //r: 30
                                },
                                linkStyle : {}
                            }
                        },
                        useWorker: false,
                        minRadius : 15,
                        maxRadius : 20,
                        gravity: 1.1,
                        scaling: 1.1,
                        roam: 'move',
                        nodes:nodes,
                        	/*
                        	[
                            {category:0, name: '新闻1', value : 10},
                            {category:0, name: '新闻2', value : 10},
                            {category:1, name: '李维',value : 2},
                            {category:1, name: '孙朋',value : 3},
                            {category:1, name: '赖文',value : 3},
                            {category:1, name: '王丽客',value : 7},
                            {category:2, name: '北京',value : 5},
                            {category:2, name: '上海',value : 8},
                            {category:2, name: '广州',value : 9},
                            {category:2, name: '深圳',value : 4},
                            {category:3, name: '法院',value : 1},
                            {category:3, name: '检察院',value : 1},
                            {category:3, name: '军事委员会',value : 1},
                            {category:3, name: '共青团中央',value : 1}
                        ],
                        */
                        links :links
                        	/*[
                            {source : '新闻1', target : '北京', weight : 1},
                            {source : '新闻1', target : '上海', weight : 2},
                            {source : '新闻1', target : '广州', weight : 1},
                            {source : '新闻1', target : '深圳', weight : 2},
                            {source : '新闻1', target : '法院', weight : 3},
                            {source : '新闻1', target : '检察院', weight : 1},
                            {source : '新闻1', target : '中央军委', weight : 2},
                            {source : '新闻1', target : '共青团中央', weight : 1},
                            {source : '新闻1', target : '李维', weight : 1},
                            {source : '新闻1', target : '孙朋', weight : 1},
                            {source : '新闻2', target : '北京', weight : 1},
                            {source : '新闻2', target : '上海', weight : 1},
                            {source : '新闻2', target : '广州', weight : 1},
                            {source : '新闻2', target : '深圳', weight : 1},
                            {source : '新闻2', target : '李维', weight : 1},
                            {source : '新闻2', target : '王丽客', weight : 6},
                            {source : '新闻2', target : '共青团中央', weight : 1},
                            {source : '新闻2', target : '检察院', weight : 1}
                        ]*/
                    }
                ]
            };
        
        loadRelationData();
        //alert(nodes.length);
        //alert(links.length);
        //alert(b);
        myChartTest.setOption(optionEntity);
        
    }
);
</script>

	<script type="text/javascript">
		window.onload=function(){
			alert($("#topicId").val());
		}
		function PageCallback(index) { 
			window.location.href="<%=request.getContextPath()%>
		/topic/topicPage?page="
					+ (index + 1);
		}
		$(document).ready(function() {
			var id = 0;
			$("#Pagination").pagination("${page.totalPage }", {
				current_page : "${page.currentPage-1}",
				callback : PageCallback
			});
		});
	</script>
</head>

<body>
<div id="wrapper">
    <!--左侧部分-->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#"><span>民汉舆情汇聚与监测系统</span></a>
            </div>
        </div>

        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="<%=request.getContextPath()%>/main/" target="_blank"><span class="glyphicon glyphicon-home span-icon"></span>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                    <li><a href="/baidu/" target="_blank"><span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank"><span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank"><span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
                    <li><a href="<%=request.getContextPath()%>/sensite/" target="_blank"><span class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测</a></li>
                    <li><a href="<%=request.getContextPath()%>/weibo/" target="_blank"><span class="glyphicon glyphicon-time span-icon"></span> 微博分析</a></li>
                    <li><a href="http://10.10.130.152:6688/" target="_blank"><span class="glyphicon glyphicon-road span-icon"></span> 知识图谱</a></li>
                    <li class="active">
                        <a href="javascript: void(0);" onclick="listUserWord();">
                            <span class="glyphicon glyphicon-book span-icon"></span> 自定义监测
                        </a>
                        <ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
                    </li>
                </ul>
                <!-- /#side-menu -->
            </div>
            <!-- /.sidebar-collapse -->
        </div>
    </nav>
    <!-- 右侧主体部分 -->
    <div id="page-wrapper">
        <div class="row row-ptop-25">
        	<!--蓝色显示框-->
            <div class="row row-not-margin">
                <div class="col-sm-12">
                    <div class="alert alert-info">
                        <p style="font-size:18px;"><strong>标题：</strong>${title}</p>
                        <p style="font-size:15px;"><strong>关键词：</strong>${keyword}</p>
                     </div>
                </div>
            </div>
        
            <!--时事热点显示-->
            <div class="row row-not-margin">
                <div class="col-sm-6">
                    <div class="panel panel-default" style="height:350px;">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-sort"></span> 话题下有： 
                        	<span id="huatishu" class="font_news">${newsCount}</span> 篇新闻，
                        	<span id="numplace" class="font_loc">${locNum}</span> 个地点实体，
                        	<span id="numper" class="font_per">${perNum}</span> 个人物实体， 
                        	<span id="numorg" class="font_org">${orgNum}</span> 个组织机构实体
                        </div>
                        <div class="panel-body" style="height:300px;">
                        	<c:forEach items="${topicNews }" var="topicNews">
								<c:choose>
									<c:when test="${topicNews.lang_type == 'cn'}">
										<div id="topicDetailedContent" style="writing-mode:lr-tb;overflow-y:scroll;width:100%;height:100%;">
											<p><fmt:formatDate value="${topicNews.news_time}" type="date" pattern="yyyy-MM-dd"/></p>
											<p id="huatixia" class="huatixia" style="height:100%;width:100%;font-size:15px;">${topicNews.news_content}</p>
										</div>
									</c:when>
									<c:otherwise>
										<div id="topicDetailedContent" style="writing-mode:lr-tb;overflow-y:scroll;width:100%;height:100%;">
											<p><fmt:formatDate value="${topicNews.news_time}" type="date" pattern="yyyy-MM-dd"/></p>
											<p id="huatixia" class="huatixia" style="height:100%;width:100%;font-size:18px;">${topicNews.news_content}</p>
										</div>
									</c:otherwise>
								</c:choose>
								<!-- 
								<div id="topicDetailedContent" style="writing-mode:lr-tb;overflow-y:scroll;width:100%;height:100%;">
									<p><fmt:formatDate value="${topicNews.news_time}" type="date" pattern="yyyy-MM-dd"/></p>
									<p id="huatixia" class="huatixia" style="height:100%;width:100%;font-size:15px;">${topicNews.news_content}</p>
								</div>
								 -->
							</c:forEach>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="panel panel-default" style="height:350px;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-sort"></span>  新闻列表</div>
                        <div class="panel-body" style="overflow:auto;height:290px;width:98%;">
                            <c:forEach items="${topicAllNews }" var="topicAllNews">
								<p id="newstitle" style="height:auto;font-size:16px;">
									<a style="height:auto;" href="<%=request.getContextPath()%>/topic/${topicAllNews.news_id }/newsDisplay">${topicAllNews.news_title}</a>
									<small id="time" style="border-right:1px dotted #333333;height:100%;text-align:right;width:auto;float:right;">
										<fmt:formatDate value="${topicAllNews.news_time}" type="date" pattern="yyyy-MM-dd"/>
									</small>
								</p>
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 词云模块 -->
        <div class="row row-not-margin">
	    	<div class="row row-ptop-25">
		        <div class="col-sm-8" style="witdh:100%;height:350px;">
	                <div class="panel panel-default" style="width:100%;">
	                    <div class="panel-heading"><span class="glyphicon glyphicon-sort"></span>  词云</div>
	                    <div class="panel-body" id="ciyun" style="height:300px;"></div>
	                </div>
	    	    </div>
            	<div class="col-sm-4" style="height:350px;">
                    <div class="panel panel-default" style="height:100%;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-left"></span> 十个关键字</div>
                        <div class="panel-body" style="height:90%; font-size:15px; line-height:25px;">
                            <c:forEach items="${tenWord}" var="tenWord">
								<span>${tenWord.name}</span><span style="float:right;padding-right:100px;">${tenWord.value}</span><br/>
							</c:forEach>
                        </div>
                    </div>
            	</div>       
	        </div>
	    </div>
		
		<!-- 实体关系模块 -->
	    <div class="row row-not-margin">    
	        <div class="row row-ptop-25">
	           <div class="col-sm-6" style="width:100%;height:600px;">
		       		<div class="panel panel-default" style="height:100%;">
		                <div class="panel-heading"><span class="glyphicon glyphicon-sort"></span>  实体关系</div>
		                <div class="panel-body" id="shititest" style="height:550px;">
		                </div>
		            </div>
		        </div>
			</div>
		</div>
		<br/><br/>
		
        <div class="row row-not-margin">
            <div id="statistics">
            	<div class="col-xs-4 col4-draw-left" style="height:350px;padding-left:0px;">
                    <div class="panel panel-default" style="height:100%;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-left"></span> 地点统计</div>
                        <div class="panel-body" id="ne-loc" style="height:90%;"></div>
                    </div>
                </div>

                <div class="col-xs-4 col4-draw-center" style="height:350px;padding-left:0px;padding-right:0px;">
                    <div class="panel panel-default" style="height:100%;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-left"></span> 人物统计</div>
                        <div class="panel-body" id="ne-per" style="height:90%;"></div>
                    </div>
                </div>

                <div class="col-xs-4 col4-draw-right" style="height:350px;padding-right:0px;">
                    <div class="panel panel-default" style="height:100%;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-left"></span> 组织机构统计</div>
                        <div class="panel-body" id="ne-org" style="height:90%;"></div>
                    </div>
                </div>
            </div>
        </div><br/><br/>
        
            <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->


<!--版权-->
<div class="footer">
    版权所有 &copy; 2018中央民族大学
</div>

<!-- 自定义监测添加 -->
<div id="monitor" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="monitor_title">自定义监测添加</h4>
            </div>
            <div class="modal-body">
                <div id="monitor_body">
                    <div class="row monitor-row">
                        <div class="col-xs-2 monitor-tag">
                            <span class="node-name">监控词：</span>
                        </div>
                        <div class="col-xs-9">
                            <input type="text" class="form-control" id="monitor_word" value="">
                        </div>
                    </div>
                    <div class="row monitor-row">
                        <div class="col-xs-2 monitor-tag">
                            <span class="node-name">类型：</span>
                        </div>
                        <div class="col-xs-9">
                            <select class="form-control input-group-sm" id="monitor_wordType">
                                <option>其他</option>
                                <option>人物</option>
                                <option>地点</option>
                                <option>组织机构</option>
                            </select>
                        </div>
                    </div>
                    <div class="row monitor-row">
                        <div class="col-xs-2 monitor-tag">
                            <span class="node-name">语言：</span>
                        </div>
                        <div class="col-xs-9">
                            <select class="form-control input-group-sm" id="monitor_langType">
                                <option>中文</option>
                                <!-- sunpeng.2018.03.25
                                <option>朝文</option>
                                <option>维文</option>
                                 -->
                                <option>藏文</option>
                            </select>
                        </div>
                    </div>
                    <div class="row monitor-row">
                        <div class="col-xs-2 monitor-tag">
                            <span class="node-name">描述：</span>
                        </div>
                        <div class="col-xs-9">
                            <input type="text" class="form-control" id="monitor_describe" value="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer modal-footer-point">
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-sm btn-primary" onclick="saveMonitor();">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
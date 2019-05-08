<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- index.jsp 主页 -->
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>民汉舆情汇聚与监测系统 - 首页</title>

    <link rel="shortcut icon" href="favicon.png"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/normalize.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrapSwitch.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/morris-0.4.3.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/model.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/index-style.css">

    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/json2.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/d3.v2.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/d3.layout.cloud.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/highcharts-3.0.7.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/highcharts-more.js"></script>
    
    <script src="<%=request.getContextPath()%>/resources/js/underscore-1.5.2.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/map_demo.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/raphael-2.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jquery.paginate.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/morris.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/bootstrapSwitch.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jquery.metisMenu.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/echarts.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/settings.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/hcdraw.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/charts.draw.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/highlight.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/index.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/search.js"></script>
    
    <script src="<%=request.getContextPath()%>/resources/js/test.js"></script>
    
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=5rxDjqRP3g01EacBIyIbhsu9"></script>
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=fjsxGIsSOK38jRWvX2KVjIzGZ0FfZceT"></script>
	
	<script type="text/javascript">

	
		var width;
		var height;
	
		$(function() {
			width = $(window).width();
			height = $(window).height();
			$("#mainBar").css("width", width - 40); //
			$("#mainBar").css("height", height - 40); //			
			
			console.log(height);
			setEcharts(); 
		});
		$(window).resize(function() {
			width = $(window).width();
			height = $(window).height();
			$("#mainBar").css("width", width - 40); //
			$("#mainBar").css("height", height - 40); //		
		});

		//路径配置
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});

		// 使用
		require(
			['echarts',
			 'echarts/chart/map',
			 'echarts/chart/line',
			 'echarts/chart/bar',
			 'echarts/chart/pie'
			],
			function setEcharts(ec) {
				// 基于准备好的dom，初始化echarts图表
				//var topicMapChart = ec.init(document.getElementById('topic_map'));
				//var entityNewsTrendChart = ec.init(document.getElementById('news_trends_echart'));
				var entityNewsSourceChart = ec.init(document.getElementById('news_source'));
				var entityLocChart = ec.init(document.getElementById('panel_loc_stat'));
				var entityPerChart = ec.init(document.getElementById('panel_per_stat'));
				var entityOrgChart = ec.init(document.getElementById('panel_org_stat'));
				var entityAllChart = ec.init(document.getElementById('news_count_entity'));
				//var sensitiveTrendChart = ec.init(document.getElementById('sensitive_tendency_echarts'));
				
				var newsNumChart = ec.init(document.getElementById('news_count_chart'));
				
				window.onresize = newsNumChart.resize;
				//window.onresize = sensitiveTrendChart.resize;
				//window.onresize = topicMapChart.resize;
				window.onresize = entityNewsSourceChart.resize;
				window.onresize = entityLocChart.resize;
				window.onresize = entityPerChart.resize;
				window.onresize = entityOrgChart.resize;
				window.onresize = entityAllChart.resize;
				
				var topicMapOption = {
					tooltip : {
						trigger : 'item'
					},
					dataRange : {
						min : 0,
						max : 2500,
						x : 'left',
						y : 'bottom',
						text : [ '高', '低' ], // 文本，默认为数值文本
						calculable : true
					},
					toolbox : {
						show : true
					},
					series : [ {
						name : '相关新闻',
						type : 'map',
						mapType : 'china',
						roam : true,
						itemStyle : {
							normal : {
								label : {
									show : true
								}
							},
							emphasis : {
								label : {
									show : true
								}
							}
						},
						data : [ {
							name : '北京',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '天津',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '上海',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '重庆',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '河北',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '河南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '云南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '辽宁',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '黑龙江',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '湖南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '安徽',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '山东',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '新疆',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '江苏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '浙江',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '江西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '湖北',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '广西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '甘肃',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '山西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '内蒙古',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '陕西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '吉林',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '福建',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '贵州',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '广东',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '青海',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '西藏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '四川',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '宁夏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '海南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '台湾',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '香港',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '澳门',
							value : Math.round(Math.random() * 1000)
						} ]
					} ]	
				};

				var entityNewsSourceOption = {
					//数据提示框配置  
					tooltip : {
						trigger : 'item' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框  
					},
					grid : {
						x: 50,
						y: 25,
						x2: 50,
						y2: 50,
						calculable : true,
					},
					//轴配置  
					xAxis : [{
						type : 'category',
						//data:['人民网蒙文版','青海湖网','中国新闻网','好乐宝网','正北方网','中国西藏新闻网','蒙古语新闻网','海西州人民政府','新疆维吾尔自治区人民政府网','新华网维语版'],
						axisLabel : {
							interval : 0,
							rotate : -15,
							margin : 2,
							
							textStyle : {
								//fontWeight : "bolder",
								color : "#000000"
							}
						}
					}],
					//Y轴配置  
					yAxis: [{
						name : '新闻数量',
						type : 'value',
					}],
					//图表Series数据序列配置  
					series : [ {
						//type : 'line',
						type : 'bar',
						//data:[19715,4600,4364,2827,2571,2113,2062,1701,1142,881],
						//smooth : true,
						itemStyle : {
							normal : {
								//color:"#00CED1",
								areaStyle : {
									color:'#00CED1'
								}
							},
						},
					} ]
				};                    
				
				function loadNewsSourceData(option,lang) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/news/getNewsSource",
						data : {},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.xAxis[0].data = [];
								for ( var i in result) {
									option.xAxis[0].data.push(i);
								}
								option.series[0].data = [];
								for ( var i in result) {
									option.series[0].data.push(result[i]);
								}
							}
						}
					});
				}

				var entityLocOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '实体数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						}
					}],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color:"#1C86EE",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};

				function loadEntityLocData(option, lang) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/main/getLoc?lang=" + lang,
						data : {},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.xAxis[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.xAxis[0].data.push(result[i].entity_key);
								}
								option.series[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.series[0].data.push(result[i].count);
								}
							}
						}
					});
				}

				var entityPerOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '实体数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [{
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					}],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color:"#8968CD",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					}]
				};

				function loadEntityPerData(option, lang) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/main/getPer?lang=" + lang,
						data : {},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.xAxis[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.xAxis[0].data.push(result[i].entity_key);
								}
								option.series[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.series[0].data.push(result[i].count);
								}
							}
						}
					});
				}

				var entityOrgOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [{
						name : '实体数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					}],
					xAxis : [{
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					}],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color:"#228B22",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};
				function loadEntityOrgData(option, lang) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/main/getOrg?lang=" + lang,
						data : {},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.xAxis[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.xAxis[0].data.push(result[i].entity_key);
								}
								option.series[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.series[0].data.push(result[i].count);
								}
							}
						}
					});
				}
				
				//全部实体
				var entityAllOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [{
						name : '实体数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					}],
					xAxis : [{
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					}],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color:"#228B22",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};
				function loadEntityAllData(option, lang) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/main/getAll?lang=" + lang,
						data : {},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.xAxis[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.xAxis[0].data.push(result[i].entity_key);
								}
								option.series[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.series[0].data.push(result[i].count);
								}
							}
						}
					});
				}
				
				
				var newsCountOption = {
					    tooltip: {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['中文','藏文','维文','蒙文']
					    },
					    grid: {
					    	x: 50,
							y: 50,
							x2: 50,
							y2: 50,
					        containLabel: true
					    },
					    toolbox: {
					        feature: {
					            saveAsImage: {}
					        }
					    },
					    xAxis: {
					    	name: '日期',
					        type: 'category',
					        boundaryGap: false,
					        //data: ['周一','周二','周三','周四','周五','周六','周日']
					    },
					    yAxis: {
					    	name: '新闻数量',
					        type: 'value'
					    },
					    series: [
					        {
					            name:'中文',
					            type:'line',
					            stack: '总量',
					            //data:[120, 132, 101, 134, 90, 230, 210]
					        },
					        {
					            name:'藏文',
					            type:'line',
					            stack: '总量',
					            //data:[220, 182, 191, 234, 290, 330, 310]
					        },
					        {
					            name:'维文',
					            type:'line',
					            stack: '总量',
					            //data:[150, 232, 201, 154, 190, 330, 410]
					        },
					        {
					            name:'蒙文',
					            type:'line',
					            stack: '总量',
					            //data:[320, 332, 301, 334, 390, 330, 320]
					        }
					    ]
					};
				
				function loadNewsNumData(option) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/main/getAllNewsNum",
						data : {},
						dataType : "json",
						success : function(result) {
							option.xAxis.data = [];
							option.series[0].data = [];
							option.series[1].data = [];
							option.series[2].data = [];
							option.series[3].data = [];
							for (var i in result) {
								option.xAxis.data.push(i);
								option.series[0].data.push(result[i][0]);
								option.series[1].data.push(result[i][1]);
								option.series[2].data.push(result[i][2]);
								option.series[3].data.push(result[i][3]);
							}
							//alert("123");
							/*
							if (result) {
								option.xAxis[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.xAxis[0].data.push(result[i].entity_key);
								}
								option.series[0].data = [];
								for (var i = 0; i < result.length; i++) {
									option.series[0].data.push(result[i].count);
								}
							}
							*/
						}
					});
				}

				var lang = '${sessionScope.lang}';
				loadNewsSourceData(entityNewsSourceOption,lang);
				loadEntityLocData(entityLocOption, lang);
				loadEntityPerData(entityPerOption, lang);
				loadEntityOrgData(entityOrgOption, lang);
				loadEntityAllData(entityAllOption, lang);
				//loadSensitiveData(sensitiveOption,lang);
				
				loadNewsNumData(newsCountOption);
				
				//topicMapChart.setOption(topicMapOption);
				entityNewsSourceChart.setOption(entityNewsSourceOption);
				//sensitiveTrendChart.setOption(sensitiveOption);
				entityLocChart.setOption(entityLocOption);
				entityPerChart.setOption(entityPerOption);
				entityOrgChart.setOption(entityOrgOption);
				entityAllChart.setOption(entityAllOption);
				newsNumChart.setOption(newsCountOption); 			
			}
		);
	</script>
</head>

<body onload="javascript: loadData();">
<div id="wrapper">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#"><span>民汉舆情汇聚与监测系统</span></a>
            </div>
        </div>
		        <!-- 标题栏   -->
        <div class="search-and-seting"> 
            <!-- 工具栏 -->
            <div class="col-md-4 col-set" style="width:395px;float:right;margin-right:50px;">
	           <div class="panel-body">
		            	<form id="langTypeForm" action="chooselang" method="POST">			
			            	<div class="form-group">
			            		<!-- 
			                	<label class="control-label set-label" style="font-size:16px;margin-top:5px;">语言选择 </label>
			                	 -->
			                    <div class="max-search">
			                    	<div class="input-group margin-right-5" id="langsRadio">
										<span class="input-group-addon">
											<input name="langtype" type="radio" checked="checked" value="cn">中文</input>
										</span>
										<span class="input-group-addon">
											<input name="langtype" type="radio" value="meng">蒙文</input>
										</span>
										<span class="input-group-addon">
											<input name="langtype" type="radio" value="wei">维文</input>
										</span>
										<span class="input-group-addon">
											<input name="langtype" type="radio" value="zang">藏文</input>
										</span>&nbsp;&nbsp;
										<button id="langSubmitBtn" class="btn btn-default" type="submit" style="float:right;font-size:15px;">切换</button>
			                        </div>
			                    </div>
			                </div><!-- form-group -->
		                </form>
           		 	</div>
             </div>
        </div>
		
		
		<!-- 标题栏   
        <div class="search-and-seting">
            <div class="search col-xs-8" style="width:580px;margin-right:100px;">
                <div id="search_conditions" class="input-group input-group-sm">
                    <form action="doSearch" method="post">
	                    <div id="conditions_input">
	                    	<input id="conditions_keyword" name="key" class="ui-autocomplete-input" autocomplete="off" style="width:550px;">
	                    </div>
	                    <span class="input-group-btn" style="float:right">
							<button class="btn btn-primary btn-search" type="submit" >
	                   			 <span class="glyphicon glyphicon-search"></span>
	                   		</button>
						</span>
					</form>
                </div>
            </div>
              
            <!-- 工具栏
            <div class="col-xs-4 col-set" style="width:500px;float:right;margin-right:50px;">
            	<div id="lang-opt" style="float:left;width:50%;height:50px;">
            		<form id="langTypeForm" action="chooselang" method="POST">			
            			<div id="langsRadio">
							<div style="float:left;padding-top:12px;">
								<span class="input-group-addon" style="height:100%;width:50px;">
									<input name="langtype" type="radio" checked="checked" value="cn">中文</input>
								</span>
								<span class="input-group-addon" style="height:100%;width:50px;">
									<input name="langtype" type="radio" value="zang">藏文</input>
								</span>
							</div>
							<div style="float:left;padding-top:12px;">
								<button id="langSubmitBtn" type="submit" style="float:right;background-color:#eee;height:29px;">提交</button>
							</div>
	                    </div>
                	</form>
            	</div>
            	
            	<!-- 用户单位及用户名称 
            	<div id="user-info" style="float:left;width:50%;height:50px;">
            		<div style="float:left;padding-top:15px;">
            			<span style="font-size:15px;">用户单位</span>
            		</div>
		            <div style="float:right;padding-top:5px;">
		            	<div id="username" style="padding-top:10px;float:left;">
		                	<span style="font-size:18px;color:red;text-decoration:underline;">${username}</span>
		                </div>
		                <ul class="nav navbar-right" style="width:80px;">
		                    <li class="dropdown">
		                        <a class="dropdown-toggle" data-toggle="dropdown" title="设置" onclick="settings();" style="width:20px;">
		                            <span class="caret"></span>
		                        </a>
		                    </li>
		                </ul>
		            </div>
					<!-- 设置页面，隐藏域 --><!--
			        <div id="set-panel" class="panel panel-default set-panel" style="width:80px;">
			        	<div style="width:80px;padding:10px 10px;">
					    	<table cellpadding="0" cellspacing="0">
						    	<tr>
						           	<td><a href="http://localhost:8080/mwyqMonitor/setting.jsp">个人设定</a></td>
						        </tr>
						        <tr>
						          	<td><a target="_blank" href="http://localhost:8080/mwyqMonitor/">安全退出</a></td>
						        </tr>
					    	</table>
			        	</div>
			        </div>
			        
            	</div>
             </div>
        </div>
	-->
        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="#">
                    	<span class="glyphicon glyphicon-home span-icon"></span> 总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                    <li><a href="/baidu/" target="_blank">
                    	<span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank">
                    	<span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank">
                    	<span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
                    <li><a href="<%=request.getContextPath()%>/sensite/" target="_blank">
                    	<span class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测</a></li>
					<li><a href="<%=request.getContextPath()%>/weibo/" target="_blank">
                    	<span class="glyphicon glyphicon-time span-icon"></span> 微博分析</a></li>
                    <li><a href="<%=request.getContextPath()%>/twitter/" target="_blank">
                    	<span class="glyphicon glyphicon-th-large span-icon"></span> 推特分析</a></li>
                    <li><a href="http://10.10.130.152:6688/" target="_blank">
                    	<span class="glyphicon glyphicon-road span-icon"></span> 知识图谱</a></li>
                    <li class="active">
                    	<a id="customMonitorBtn" href="javascript: void(0);" onclick="listUserWord();">
                            <span class="glyphicon glyphicon-book span-icon"></span> 自定义监测</a>
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
        <!-- 搜索结果显示区域，隐藏域 -->
        <div class="row">
            <div class="col-xs-12">
                <div id="search-result" class="alert alert-info">
                    <span class="search-result-show"></span>
                    <button type="button" class="close" onclick="sr_close();"><span>&times;</span></button>
                </div>
            </div>
        </div>
        <div class="row row-ptop-20">
            <div class="col-xs-8">
                <!-- 地图 -->
                <div class="row row-not-margin">
                    <div class="panel panel-default panel-area-print">
                    	<div class="panel-heading"><span class="glyphicon glyphicon-map-marker"></span>  话题地图</div>
                        <div class="panel-body panel-map">
                        	<div id="topic_map" style="width:100%; height:500px;"></div>
                        </div>
                    </div>
                </div>
                
                <script type="text/javascript">
            	
	            	var map1 = new BMap.Map("topic_map");
	            	var point = new BMap.Point(116.404, 39.915);
	            	map1.centerAndZoom(point, 6);  // 编写自定义函数，创建标注
	            	map1.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	            	
	            	var data_info = [[116.380943298,39.923614502,"35"],
	            	                 [117.20349884,39.1311187744,"41"],
	            	                 [114.489776611,38.0451278687,"69"],
	            	                 [118.201728821,39.6253395081,"49"],
	            	                 [119.598297119,39.9243087769,"52"],
	            	                 [114.472953796,36.6015167236,"33"],
	            	                 [114.49508667,37.0655899048,"89"],
	            	                 [113.574256897,37.8606567383,"31"],
	            	                 [113.105567932,36.1819114685,"83"],
	            	                 [112.842720032,35.5065116882,"11"],
	            	                 [112.423271179,39.3131332397,"19"],
	            	                 [112.745361328,37.6761398315,"73"],
	            	                 [110.991149902,35.0139160156,"38"],
	            	                 [112.731552124,38.3992080688,"53"],
	            	                 [106.814872742,39.6742019653,"77"],
	            	                 [118.949821472,42.2679824829,"2"],
	            	                 [122.2603302,43.6115608215,"63"],
	            	                 [109.997581482,39.8184280396,"74"],
	            	                 [123.411682129,41.7966156006,"81"],
	            	                 [121.133369446,41.111125946,"61"],
	            	                 [124.377449036,43.1656074524,"5"],
	            	                 [125.137283325,42.9085922241,"5"],
	            	                 [125.923126221,41.7232933044,"17"],
	            	                 [126.421607971,41.9303321838,"98"],
	            	                 [124.82204,45.172604,"73"],
	            	                 [122.839576721,45.6164169312,"23"],
	            	                 [126.643341064,45.7414932251,"7"],
	            	                 [123.959266663,47.3413696289,"13"],
	            	                 [130.947753906,45.2970046997,"32"],
	            	                 [130.276199341,47.3372840881,"35"],
	            	                 [131.152160645,46.6376914978,"55"],
	            	                 [129.598495483,44.5839233398,"21"],
	            	                 [118.29706,33.958302,"39"],
	            	                 [120.159248352,30.2659950256,"62"],
	            	                 [121.541282654,29.8706684113,"32"],
	            	                 [120.650291443,28.0164756775,"79"],
	            	                 [120.753631592,30.7711143494,"85"],
	            	                 [120.097129822,30.8660392761,"42"],
	            	                 [120.573928833,30.010931015,"30"],
	            	                 [119.652206421,29.1108169556,"29"],
	            	                 [118.869178772,28.9584445953,"19"],
	            	                 [122.101608276,30.0200424194,"8"],
	            	                 [121.11844635,28.8488922119,"66"],
	            	                 [119.916557312,28.4488372803,"8"],
	            	                 [117.034431458,30.5126457214,"33"],
	            	                 [118.309066772,29.7208442688,"70"],
	            	                 [119.518318176,26.6664772034,"81"],
	            	                 [115.899917603,28.6759910583,"41"],
	            	                 [117.963401794,28.4532661438,"17"],
	            	                 [117.005599976,36.6670722961,"19"],
	            	                 [120.35816955600001,36.1338615417,"72"],
	            	                 [117.66173,36.205116,"47"],
	            	                 [113.868553162,35.3074684143,"51"],
	            	                 [113.221786499,35.2473564148,"4"],
	            	                 [115.014953613,35.7018966675,"57"],
	            	                 [113.821586609,34.0268592834,"69"],
	            	                 [114.041091919,33.5725097656,"39"],
	            	                 [111.195259094,34.7807693481,"77"],
	            	                 [112.537513733,32.9990196228,"75"],
	            	                 [111.285270691,30.7039527893,"12"],
	            	                 [112.141113281,32.0453987122,"97"],
	            	                 [113.028648376,25.8022918701,"85"],
	            	                 [111.612197876,26.2112998962,"27"],
	            	                 [109.954231262,27.5474071503,"45"],
	            	                 [111.993896484,27.7413349152,"78"],
	            	                 [113.371452332,22.5268535614,"98"],
	            	                 [116.63666,23.667706,"76"],
	            	                 [116.34977,23.542976,"53"],
	            	                 [112.03999,22.933193,"91"],
	            	                 [108.311767578,22.8065433502,"55"],
	            	                 [109.402809143,24.3104057312,"75"],
	            	                 [110.286682129,25.2818832397,"92"],
	            	                 [111.30594635,23.4866199493,"14"],
	            	                 [104.776351929,29.3677215576,"21"],
	            	                 [101.698417664,26.5547981262,"93"],
	            	                 [105.437843323,28.8819942474,"39"],
	            	                 [104.391548157,31.1304454803,"39"],
	            	                 [104.748550415,31.4563484192,"63"],
	            	                 [105.831703186,32.4439697266,"12"],
	            	                 [104.616867065,28.7702560425,"82"],
	            	                 [104.873252869,26.5767745972,"57"],
	            	                 [106.929397583,27.6953868866,"48"],
	            	                 [105.926071167,26.2442588806,"57"],
	            	                 [105.282417297,27.3062953949,"15"],
	            	                 [109.192680359,27.7221660614,"9"],
	            	                 [109.057281494,35.0754585266,"45"],
	            	                 [107.13835907,34.3822860718,"35"],
	            	                 [108.710128784,34.3372154236,"69"],
	            	                 [109.500839233,34.5015258789,"61"],
	            	                 [109.471282959,36.5938720703,"52"],
	            	                 [107.034393311,33.0781478882,"90"],
	            	                 [109.757446289,38.2972755432,"41"],
	            	                 [109.025787354,32.6898651123,"76"],
	            	                 [109.930236816,33.871925354,"10"],
	            	                 [106.683067322,35.5355186462,"92"],
	            	                 [98.5111160278,39.7449684143,"66"],
	            	                 [107.636230469,35.7385597229,"42"],
	            	                 [104.61856842,35.5752372742,"3"],
	            	                 [104.92928,33.39484,"61"],
	            	                 [101.787452698,36.6094474792,"34"],
	            	                 [118.75,30.95,"35"],
	            	                 [110.47,29.13,"41"]
	            					];
	            	var opts = {
	            				width : 250,     // 信息窗口宽度
	            				height: 80,     // 信息窗口高度
	            				title : "新闻数量" , // 信息窗口标题
	            				enableMessage:true//设置允许信息窗发送短息
	            			   };
	            	for(var i=0;i<data_info.length;i++){
	            		var marker = new BMap.Marker(new BMap.Point(data_info[i][0],data_info[i][1]));  // 创建标注
	            		var content = data_info[i][2];
	            		map1.addOverlay(marker);               // 将标注添加到地图中
	            		addClickHandler(content,marker);
	            	}
	            	function addClickHandler(content,marker){
	            		marker.addEventListener("click",function(e){
	            			openInfo(content,e)}
	            		);
	            	}
	            	function openInfo(content,e){
	            		var p = e.target;
	            		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
	            		var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
	            		map1.openInfoWindow(infoWindow,point); //开启信息窗口
	            	}
	            	
                </script>
                
                <!-- 新闻趋势 -->
                <div class="row row-not-margin">
                    <div class="panel panel-default panel-area-print">
                        <div class="panel-heading"><span class="glyphicon glyphicon-stats"></span> 新闻来源
                        <!-- --20180805.sunpeng.add-start----------------------- -->
                        <!-- 
                        <div class="pull-right">
							<div class="btn-group">
							    <button type="button" id="btn_langFilter" class="btn btn-default btn-xs" data-toggle="dropdown">
							        <span id="lang_category">全部</span>
							        <span class="caret"></span>
							    </button>
							    <ul class="dropdown-menu pull-right" role="menu" id="filter_ul_li">
							        <li><a href="#">全部</a></li>
							        <li><a href="#">按年</a></li>
							        <li><a href="#">按月</a></li>
									<li><a href="#">按周</a></li>
									<li><a href="#">按日</a></li>
						        </ul>
							</div>
						</div>
						 -->
                        <!-- --20180805.sunpeng.add-end----------------------- -->
                        </div>
                        <div class="panel-body">
                            <div id="news_source" style="width:100%; height:350px;">
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 敏感词趋势 -->
                <div class="row row-not-margin">
                    <div class="panel panel-default panel-area-print">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-stats"></span> 新闻数量统计
                        </div>
                        <div class="panel-body" style="heigth:400px;">
                            <div id="news_count_chart" style="width:100%; height:350px;">         	
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 全部实体 -->
                <div class="row row-not-margin">
                    <div class="panel panel-default panel-area-print">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-stats"></span> 热点
                        </div>
                        <div class="panel-body" style="heigth:400px;">
                            <div id="news_count_entity" style="width:100%; height:350px;">         	
                            </div>
                        </div>
                    </div>
                </div>
                 
				<!-- 统计分析 -->
                <div class="row row-not-margin">
                    <div id="statistics">
                        <!-- mod-sunpeng-03/22-start -->
                        <div class="col-xs-4 col4-draw-left" style="height:350px;">
                            <div class="panel panel-default" style="height:100%;">
                                <div class="panel-heading">
                                	<span class="glyphicon glyphicon-align-left"></span> 地点统计
                                </div>
                                <div id="panel_loc_stat" style="height:100%;"></div>
                            </div>
                        </div>

                        <div class="col-xs-4 col4-draw-center" style="height:350px;">
                            <div class="panel panel-default" style="height:100%;">
                                <div class="panel-heading">
                                	<span class="glyphicon glyphicon-align-left"></span> 人物统计
                                </div>
                                <div id="panel_per_stat" style="height:100%;"></div>
                            </div>
                        </div>

                        <div class="col-xs-4 col4-draw-right" style="height:350px;">
                            <div class="panel panel-default" style="height:100%;">
                                <div class="panel-heading">
                                	<span class="glyphicon glyphicon-align-left"></span> 组织机构统计
                                </div>
                                <div id="panel_org_stat" style="height:100%;"></div>            
                            </div>
                        </div>
                        <!-- mod-sunpeng-03/22-end -->
                    </div>
                </div>
            </div>

            <div class="col-xs-4">
                <!-- 热门话题 -->
                <div class="new-des">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-bell"></span>  热门话题
                        </div>
                        <div class="panel-body" style="overflow:auto;height:850px;margin-bottom:10px;">
                        	<c:forEach items="${topicList}" var="topic">
                        		<div id="hotTopicItem" style="height:auto;" >
                        			<!-- add-sunpeng-03/22-start -->
									<div style="float:left;width:45px;padding-right:5px;">
										<span style="float:right;font-size:25px;color:blue;">${topic.news_count}</span>
									</div>
									<div>
		                        		<div style="margin-top:5px">
											<a href="<%=request.getContextPath() %>/topic/${topic.topic_id}/newtopic" style="cursor:pointer;font-size:15px;" target="_blank">${topic.topic_name}</a>								
										</div>
										<div style="float:right;">
		                        			<fmt:formatDate value="${topic.news_time}" type="date" pattern="yyyy-MM-dd" />
		                        		</div>
									</div>
									<!-- add-sunpeng-03/22-end -->
									<br></br><hr></hr>
								</div>
							</c:forEach>
                        </div>
                    </div>
                </div>
                
                <!-- 新加 -->
                <div class="row row-not-margin">
                    <div class="panel panel-default panel-area-print">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-stats"></span> 宗教新闻
                        </div>
                        <div class="panel-body" style="overflow:auto;height:845px;margin-bottom:10px;">
                        	<c:forEach items="${religion}" var="religion">
								<p id="newstitle" style="margin-bottom:20px;font-size:16px;">
									<a style="height:auto;" href="<%=request.getContextPath()%>/topic/${religion.news_id }/newsDisplay">${religion.news_title}</a>
									<small id="time" style="border-right:1px dotted #333333;height:100%;text-align:right;width:auto;float:right;">
										<fmt:formatDate value="${religion.news_time}" type="date" pattern="yyyy-MM-dd"/>
									</small>
								</p>
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<!--版权-->
<div class="footer">
    版权所有 &copy; 2018 中央民族大学
</div>

<!-- 半透明背景层 -->
<div id="bg"><div id="wait_login"><img src="img/wait_login.gif"/></div></div>

<!-- 新闻列表模态框 -->
<div id="pointNewsList" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title">新闻列表</h3>
            </div>
            <div class="modal-body modal-body-point"></div>
            <div class="modal-footer modal-footer-point">
                <div id="pagination"></div><!-- 模态框页脚分页 -->
                <button type="button" class="btn btn-sm btn-primary" data-dismiss="modal" >关 闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 新闻内容模态框 -->
<div id="pointNewsContent" class='modal fade news-modal' tabindex='-1' role='dialog' aria-labelledby='modalLabel' aria-hidden='true'>
    <div class='modal-dialog modal-newsContent-width'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
                <h3 class='modal-title' id='modalNewstTitle'></h3>
            </div>
            <div class='modal-body modal-news-content' style="min-height:410px;">
                <div class='news_time'>
                    <span class='glyphicon glyphicon-time'></span>  <span id="modalNewsTime"></span>
                </div>
                <span id="modalNewsContent"></span>
            </div>
            <div class='modal-footer modal-footer-point' id='yqjg_a'>
            </div>
        </div>
    </div>
</div>

<!-- 自定义监测添加 -->
<div id="monitor" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span></button>
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

<!-- 实体详情 -->
<div class="popover top">
    <div class="arrow"></div>
    <div class="popover-title"></div>
    <div class="popover-content"></div>
</div>
</body>

</html>

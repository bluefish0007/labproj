<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="zh-CN">

<head>
	<!-- analysis.jsp -->
	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>民汉舆情汇聚与监测系统 - 统计分析</title>

    <link rel="shortcut icon" href="favicon.png"/>
    
    <!-- 主页样式文件 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/normalize.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrapSwitch.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/morris-0.4.3.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/model.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/index-style.css">
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/bootstrapSwitch.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/jquery-ui.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/morris-0.4.3.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/model.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/analysis/analysis.css">
    
    <!-- 历史话题排行所导入的其他页面的CSS -->
<!--
	<link rel="stylesheet" type="text/css"href="<%=request.getContextPath()%>/resources/css/templatemo_justified.css" />
-->
    <script src="<%=request.getContextPath()%>/resources/js/analysis/jquery-1.9.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.v2.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.layout.cloud.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/highcharts-3.0.7.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/raphael-2.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/chinaMapConfig.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/map.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/morris.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/jquery.paginate.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/underscore-1.5.2.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/bootstrapSwitch.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/jquery.metisMenu.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/charts.draw.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/analysis.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/search.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/echarts.min.js"></script>
    
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    
    <script type="text/javascript">
    	function topic_filter(value)
    	{
    		//alert(value);
    		$
			.ajax({
				type : "get",
				async : false,
				url : "${request.contextPath}/mwyqMonitor/mystat/getSelect",
				data : {
					selected:value
				},
				dataType : "text",
				success:function(){
					location.reload();
	               }
			});
    	}
    </script>
    
</head>

<body>

<div id="wrapper">

<!-- 左侧导航栏部分 -->
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#"><span>民汉舆情汇聚与分析系统</span></a>
            </div>
        </div>
        
        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="<%=request.getContextPath()%>/main/" target="_blank">
                    	<span class="glyphicon glyphicon-home span-icon"></span> 总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                    <li><a href="/baidu/" target="_blank">
                    	<span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank">
                    	<span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="#">
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
            <div class="row row-not-margin">  
                <!-- 新闻数量趋势图 -->
                <div class="col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-stats"></span>  敏感分析                        
                        </div>
                        <div class="panel-body">
                           	<div id="sensitive_news_count_x" style="height: 310px"></div>      
                           	
                           	
                 <script type="text/javascript">
                     	var mySensitiveChart8 = echarts.init(document.getElementById('sensitive_news_count_x'));
                     	var optionSensitive = {
                     		    tooltip: {
                     		        trigger: 'axis'
                     		    },
                     		    legend: {
                     		        data:['全部新闻','中性新闻','敏感新闻']
                     		    },
                     		    grid : {
	       							x : 50,
	       							y : 50,
	       							x2 : 50,
	       							y2 : 30
								},
                     		    xAxis: {
                     		        type: 'category',
                     		        boundaryGap: false,
                     		        //data: ['周一','周二','周三','周四','周五','周六','周日']
                     		       axisLabel : {
										interval : 0,
										rotate : -10,
										margin : 2,
										textStyle : {
											//fontWeight : "bolder",
											color : "#000000"
										}
									}
                     		    },
                     		    yAxis: {
                     		        type: 'value'
                     		    },
                     		    series: [
                     		        {
                     		            name:'全部新闻',
                     		            type:'line',
                     		            stack: '总量',
                     		            //data:[120, 132, 101, 134, 90, 230, 210]
                     		        },
                     		        {
                     		            name:'中性新闻',
                     		            type:'line',
                     		            stack: '总量',
                     		            //data:[220, 182, 191, 234, 290, 330, 310]
                     		        },
                     		        {
                     		            name:'敏感新闻',
                     		            type:'line',
                     		            stack: '总量',
                     		            //data:[150, 232, 201, 154, 190, 330, 410]
                     		        }
                     		    ]
                     		};
                     	                     	
              			function loadSensitiveData(option,lang) {
              				
              				$.ajax({
              					type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/mystat/getSensitiveByLang?lang=" + lang,
								data:{},
								dataType : "json",
								success : function(result) {
									option.xAxis.data = [];
									option.series[0].data = [];
									option.series[1].data = [];
									option.series[2].data = [];
									for (var i in result) {
										option.xAxis.data.push(i);
										option.series[0].data.push(result[i][0]);
										option.series[1].data.push(result[i][1]);
										option.series[2].data.push(result[i][2]);
									}
								}
              				});
              			}
              			var lang = '${sessionScope.lang}';
              			
              			loadSensitiveData(optionSensitive,lang);
                     	mySensitiveChart8.setOption(optionSensitive);
                     	</script>
                           	 <!--     
                        		<script type="text/javascript">
                        		
			              			var myChart8 = echarts.init(document.getElementById('news_count_chart_x'));
			              			var option8 = {
			              		    	tooltip: {
			              		        	trigger: 'axis'
			              		    	},
			              		    	legend: {
			              		        	data:['中文', '蒙文', '维文', '藏文']
				              		    },
				              		    grid: {
        	    							x : 50,
            								y : 30,
            								x2 : 30,
            								y2 : 30
            				  		    },
			              			    xAxis: [{
			              			        type: 'category',
			              		    	    axisLabel : {
												interval : 0,
												rotate : -10,
												margin : 2,
												textStyle : {
													//fontWeight : "bolder",
													color : "#000000"
												}
											}		              		    
			              		  		}],
			              		    	yAxis: [{
			              		        	type: 'value'
			              		    	}],
			              		    	series: [{
			              					name:'中文',
			              					type:'line',
			              					stack: '总量',
			              				},{
			              				    name:'蒙文',
			              				    type:'line',
			              				    stack: '总量',
			              				},{
			              					name:'维文',
			              				    type:'line',
			              				    stack: '总量',
			              				},{
			              					name:'藏文',
			              					type:'line',
			              				    stack: '总量',
			              				}]
		              				};
			              			function loadLangCountData(option) {
			              				$.ajax({
			              					type : "get",
											async : false,
											url : "${request.contextPath}/mwyqMonitor/mystat/getLangStat",
											dataType : "json",
											success : function(result) {
												option.xAxis[0].data = [];
												option.series[0].data = [];
												option.series[1].data = [];
												option.series[2].data = [];
												option.series[3].data = [];
												for (var i in result) {
													option.xAxis[0].data.push(i);
													var cnt = 0;
													for (var j in result[i]) {
														option.series[cnt].data.push(result[i][j]);													
														cnt = cnt + 1;
													}
												}
											}
			              				});
			              			}
		              				//loadLangCountData(option8);
			              			//myChart8.setOption(option8);
			              			
		              			</script>  
		              			 -->           
                        	</div>
                    	</div>
                </div>

                <!-- 时间数量折线图 -->
                <div class="col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading"><span class="glyphicon glyphicon-stats"></span>  话题数量
                        	<!-- --20180805.sunpeng.add-start----------------------- 
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
                            <!--<div id="event_count_chart"></div>-->
                            <div id="event_count_chart_x"></div>
                            <script type="text/javascript">
                            
                                var myChart = echarts.init(document.getElementById('event_count_chart_x'));
						 		var eventCountOption = {
									//数据提示框配置  
									tooltip : {
										trigger : 'item' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框  
									},
									grid : {
            							x : 50,
            							y : 15,
            							x2 : 30,
            							y2 : 30
									},
									calculable : true,
									//轴配置  
									xAxis : [ {
										type : 'category',
										axisLabel : {
											interval : 0,
											rotate : -10,
											margin : 2,
											textStyle : {
												//fontWeight : "bolder",
												color : "#000000"
											}
										}
									}],
									//Y轴配置  
									yAxis : [ {
										type : 'value',
									} ],
									//图表Series数据序列配置  
									series : [ {
										type : 'line',
										smooth : true,
										itemStyle : {
											normal : {
												color:"#0f0",
												areaStyle : {
													color:"#2578cb",
												}
											}
										}
									}]
								};
								function loadEventCountData(option, lang) {
									$.ajax({
										type : "get",
										async : false,
										url : "${request.contextPath}/mwyqMonitor/topic/getTopicNum?lang=" + lang,
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
											else{
												option.xAxis[0].data = [0,0,0,0,0,0,0];
												option.series[0].data = [0,0,0,0,0,0,0];
											}
										}
									});
								}
								
								var lang = '${sessionScope.lang}';
								//var lang =session.getAttribute("lang");
								
								loadEventCountData(eventCountOption,lang);
                                myChart.setOption(eventCountOption); 
                            </script>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row row-not-margin">
            	<!-- 实体统计饼图 -->
              	<div class="col-sm-6">
                	<div class="panel panel-default">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-stats"></span>  实体统计
                        	<!-- --20180805.sunpeng.add-start----------------------- 
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
                        	<div id="entity_count_chart_x">
                            <script type="text/javascript">
                            
                                var myChart = echarts.init(document.getElementById('entity_count_chart_x'));
                				var lang = '${sessionScope.lang}';
                				
                				var keys = [];
                				var values = [];
                				$.ajax({
                					type : "get",
                					async : false,
                					url : "${request.contextPath}/mwyqMonitor/topic/getStaticEntity?lang=" + lang,
                					dataType : "json",
                					success : function(result) {
	                					if (result) {
	                						for ( var i in result) {
	                							keys.push(i);
	                							values.push(result[i]);
	                						}
	                					}
                					}
                				});

                				option3 = {
                					legend : {
                						orient : 'vertical',
                						x : 'left',
                						data : [ '人物', '地点', '组织机构' ]
                					},
                					calculable : true,
                					series : [ {
                						name : '实体统计',
                						type : 'pie',
                						radius : '75%',
                						center : [ '50%', '50%' ],
                						itemStyle : {
                							normal : {
                								label : {
                									show : true,
                									formatter : "{b} : {c} ({d}%)",
                									textStyle : {
                										fontSize : 15
                									}
                								}
                							}
                						},
                						data : (function() {
                							var res = [];
                							var len = keys.length;
                							while (len--) {
                								res.push({
                									name : keys[len],
                									value : values[len]
                								});
                							}
                							return res;
                						})()
                					} ]
                				};
                				var lang = '${sessionScope.lang}';
                				myChart.setOption(option3);
                				
                            </script>
                    	</div>
                    </div>
                </div> 
                <!-- 饼图 -->
            </div>

           	<div class="col-sm-6">
			<!-- 新闻语种统计 -->
	        	<div class="panel panel-default">
		        	<div class="panel-heading">
		            	<span class="glyphicon glyphicon-stats"></span>新闻类别统计
		            	<!-- --20180805.sunpeng.add-start----------------------- 
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
                    	<!-- --20180805.sunpeng.add-end-------------- -->
		            </div>
		            <div class="panel-body">   
		            	<div id="newsLangCount_chart">
		            		<script>
		            		var myChart4 = echarts.init(document.getElementById('newsLangCount_chart'));
		            		
		            		var lang = '${sessionScope.lang}';
		            		
            				var dataCategory = [];
            				var dataCateValue = [];
            				$.ajax({
            					type : "get",
            					async : false,
            					url : "${request.contextPath}/mwyqMonitor/topic/getNewsCategory?lang=" + lang,
            					dataType : "json",
            					success : function(result) {
                					if (result) {
                						for ( var i in result) {
                							dataCategory.push(i);
                							dataCateValue.push({
                								value:result[i],
                								name:i
                							});
                						}
                					}
            					}
            				});
		            		
		            		option4 = {
		            			    tooltip: {
		            			        trigger: 'item',
		            			        formatter: "{a} <br/>{b}: {c} ({d}%)"
		            			    },
		            			    legend: {
		            			        orient: 'vertical',
		            			        x: 'left',
		            			        data:dataCategory
		            			    },
		            			    series: [
		            			        {
		            			            name:'新闻类别',
		            			            type:'pie',
		            			            radius: ['50%', '70%'],
		            			            avoidLabelOverlap: false,
		            			            label: {
		            			                normal: {
		            			                    show: false,
		            			                    position: 'center'
		            			                },
		            			                emphasis: {
		            			                    show: true,
		            			                    textStyle: {
		            			                        fontSize: '20',
		            			                        fontWeight: 'bold'
		            			                    }
		            			                }
		            			            },
		            			            labelLine: {
		            			                normal: {
		            			                    show: false
		            			                }
		            			            },
		            			            data:dataCateValue
		            			        }
		            			    ]
		            			};
		            			myChart4.setOption(option4);
		            		</script>
		        		</div>      
		    		</div> <!-- pannel body -->
				</div><!-- panel-defalt -->
			</div><!-- col-sm-6 -->             	            	
		</div>  <!-- row row-not-margin -->
			
		<!-- 历史话题排行 -->
		<div class="row row-not-margin">
			<div class="col-sm-6" style="width:100%;">
				<div class="panel panel-default">
					<div class="panel-heading"><span class="glyphicon glyphicon-sort"></span> 历史话题排行
					
                    <div class="pull-right">
						<div class="btn-group">
							<button type="button" id="btn_langFilter" class="btn btn-default btn-xs" data-toggle="dropdown">
								<span id="lang_category">全部</span>
							    <span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right" role="menu" id="filter_ul_li">
								<li><a onclick="topic_filter('all')">全部</a></li>
							    <li><a onclick="topic_filter('week')">过去一周</a></li>
							    <li><a onclick="topic_filter('month')">过去一月</a></li>
								<li><a onclick="topic_filter('year')">过去一年</a></li>
						    </ul>
						</div>
					</div>
		
                    <!-- --20180805.sunpeng.add-end----------------------- -->
					</div>
					<div class="panel-body">
						<c:forEach items="${topicList}" var="topic">
							<div id="hotTopicItem" style="height:200px;">
								<div id="hotTopicNewsCount" style="display:inline;float:left;font-size:25px; width:50px;color:blue;">${topic.news_count}</div>
								<div id="hotTopicTitle" style="margin-left:50px;margin-top:25px;text-algin:left;">
									<a style="display:inline;font-size:20px;" href="<%=request.getContextPath() %>/topic/${topic.topic_id}/newtopic" target="_blank">${topic.topic_name}</a>
									&nbsp;&nbsp;
									<fmt:formatDate value="${topic.news_time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
							    	<br></br>
							    	<div id="topicNewsContent" style="width:100%;height:140px;overflow:hidden;font-size:16px;line-height:1.5;">${topic.news_content}</div>
								</div>
							</div>
							<hr></hr>
						</c:forEach>
					</div>
				</div>
			</div>  <!-- col-sm-6 --> 
	   	</div>
    </div><!-- /.row -->
</div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<!--版权-->
<div class="footer">
    版权所有 &copy; 2018 中央民族大学
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
                                <option>蒙文</option>
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
</div><!-- /.modal --></div>
       
</body>

</html>

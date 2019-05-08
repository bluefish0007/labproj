<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<!-- weibo.jsp -->
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民汉舆情汇聚与监测系统 — 微博分析</title>

	<link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
	<link rel="stylesheet" href="
	<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrapSwitch.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/jquery-ui.css">
	
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/model.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/timeline.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/hotspots.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/vendor-font.css">
	
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-3.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-1.9.0.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrap.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrapSwitch.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery.metisMenu.js"></script>
	

    <script src="<%=request.getContextPath()%>/resources/js/analysis/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.v2.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.layout.cloud.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/highcharts-3.0.7.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/raphael-2.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/chinaMapConfig.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/map.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/morris.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/underscore-1.5.2.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/charts.draw.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/analysis.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/search.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/echarts.common.min.js"></script>
    
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css"> 
    

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
                    <li><a href="<%=request.getContextPath()%>/main/" target="_blank">
                    	<span class="glyphicon glyphicon-home span-icon"></span>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                    <li><a href="/baidu/" target="_blank">
                    	<span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank">
                    	<span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank">
                    	<span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
                    <li><a href="<%=request.getContextPath()%>/sensite/" target="_blank">
                    	<span class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测</a></li>
                    <li><a href="#" target="_blank"><span class="glyphicon glyphicon-time span-icon">
                    	</span> 微博分析</a></li>
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
			
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
                            <span class="glyphicon glyphicon-stats"></span>博主排行                   
                        </div>
                        <div class="panel-body" >
                           	<div id="bozhu_chart" style="height:350px;">
							   <script type="text/javascript">
							
						   		var lang = '${sessionScope.lang}';
						   		/*
						   		var dataname;
						   		var datavalue;
						   		
						   		if(lang=="cn"){
						   			dataname=['胡歌','陈小春','林心如','林志颖','杨幂','姚晨','范冰冰','迪丽热巴'];
						   			datavalue = [7002,6722,4719,3949, 3672, 2954, 1812, 848];
						   		}
						   		else if(lang=="wei"){
						   			dataname=['维吾尔美文'];
						   			datavalue = [3818];
						   		}
						   		else if(lang=="zang"){
						   			dataname=['怒僧达人', 'Stray', '张尕藏加', '山神pelhun', '玉错', '唃厮啰', 'thupten13','万玛才旦'];
						   			datavalue = [9846, 9000, 4838, 4160, 3325, 2517, 2236, 102];
						   		}
						   		else{
						   			dataname=['胡歌','陈小春','林心如','林志颖','杨幂','姚晨','范冰冰','迪丽热巴'];
						   			datavalue = [7002,6722,4719,3949, 3672, 2954, 1812, 848];
						   		}
						   		*/
							   
						   		var myChart1 = echarts.init(document.getElementById('bozhu_chart'));
						   		var option1 = {
						   			
					   			    tooltip: {
					   			        trigger: 'axis',
					   			        axisPointer: {
					   			            type: 'shadow'
					   			        }
					   			    },
						   				
						   			grid : {
										x: 50,
										y: 30,
								        left: '3%',
								        right: '5%',
								        bottom: '3%',
								        containLabel: true
									},
						   			xAxis: {
						   				type: 'category',
						   			    //data: dataname
						   				splitLine: {
						   					lineStyle: {
						   						type:'dashed'
						   					}
										},
										axisLabel : {
											interval : 0,
											rotate : -15,
											margin : 2,
										}
						   			},
						   			yAxis: {
						   				name : '微博数量',
						   				type: 'value'
						   			},
						   			series: [{
						   				//data: datavalue,
						   			    type: 'bar'
						   			}]
						   		};
							   		
								function loadAuthorData(option,lang) {
									
									$.ajax({
										type : "get",
										async : false,
										url : "${request.contextPath}/mwyqMonitor/mynews/getWeiAuthor",
										data : {
											lang:lang
										},
										dataType : "json",
										success : function(result) {
			
											if (result) {
												option.xAxis.data = [];
												option.series[0].data = [];
												for(i in result){
													option.xAxis.data.push(i);
													option.series[0].data.push(result[i]);
												}
											}
										}
									});
								};
								loadAuthorData(option1,lang);
							   	myChart1.setOption(option1);
								</script>
                           	</div>
                        </div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
                            <span class="glyphicon glyphicon-bell"></span>情感分析                          
                        </div>
                        <div class="panel-body" >
                           	<div id="emotion_chart" style="height:350px;">
                   <script type="text/javascript">  
						   	var lang = '${sessionScope.lang}';
			       			var myChart2 = echarts.init(document.getElementById('emotion_chart'));
			       			var optWeiboMotion = {
			       				    title : {
			       				        text: '情感分析',
			       				        x:'center'
			       				    },
			       				    tooltip : {
			       				        trigger: 'item',
			       				        formatter: "{a} <br/>{b} : {c} ({d}%)"
			       				    },
			       				    series : [
			       				        {
			       				            name: '情感倾向',
			       				            type: 'pie',
			       				            radius : '75%',
			       				            center: ['50%', '60%'],
			       				            //data:[
			       				             //   {value:335, name:'直接访问'},
			       				             //   {value:310, name:'邮件营销'},
			       				             //   {value:234, name:'联盟广告'},
			       				             //   {value:135, name:'视频广告'},
			       				             //   {value:1548, name:'搜索引擎'}
			       				            //],
			       				            /*
			       				            itemStyle: {
			       				                emphasis: {
			       				                    shadowBlur: 10,
			       				                    shadowOffsetX: 0,
			       				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			       				                }
			       				            }*/
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
		             						}
			       				        }
			       				    ]
			       				};
			       			
							function loadEmotionData(option,lang) {
			
								$.ajax({
									type : "get",
									async : false,
									url : "${request.contextPath}/mwyqMonitor/mynews/getWeiEmotion",
									data : {
										lang:lang
									},
									dataType : "json",
									success : function(result) {
		
										if (result) {
											//option.legend.data = [];
											option.series[0].data = [];
											for(i in result){
												//option.legend.data.push(i);
												option.series[0].data.push({
													value:result[i],
													name:i
												});
												}
											}
										}
			
								});
							};
							
							loadEmotionData(optWeiboMotion,lang);
			       			myChart2.setOption(optWeiboMotion);
			       		</script>
                           	</div>
                        </div>
					</div>
				</div>
			</div>
			<!-- 
			<script type="text/javascript">
				//window.onload = function(){
				//	var li = document.getElementById("weibo_li").getElementsByTagName("li");
				//	alert(li);
				//}
			</script>
			
			 -->
			 <div class="row row-not-margin">
			 	<div class="col-sm-6">
				 	 <div class="panel panel-default">
			 			<div class="panel-heading">
	                           <span class="glyphicon glyphicon-tint"></span>粉丝数量                         
	                    </div>
	                    <div class="panel-body" >
	                           <div id="fensi_chart" style="height:400px;"></div>
	                  </div> 
                   </div>
			 	</div>
			 	
			 	<div class="col-sm-6">
			 	  <div class="panel panel-default">
		 			<div class="panel-heading">
                        <span class="glyphicon glyphicon-tags"></span>推送通知                     
                    </div>
                    <h5 id="guanzhu">&nbsp;&nbsp;您已经关注的人有:${guanzhu}</h5><hr></hr>
                    <div class="panel-body" style="overflow:auto;height:395px;">
                         
                         
                         	<c:forEach items="${tuisong}" var="weibo">
								 <div style="height:120px;" id=${weibo.id}>                                       
									<!-- 
									<p style="font-size:15px;color:green;"><span>&nbsp;${weibo.author}&nbsp;&nbsp;&nbsp;&nbsp;${weibo.time}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${weibo.emotion}</span></p>
									 -->
									<div style="height:50px;">
										<div style="float:left;width:150px;padding-top:5px;">
											<a href="author/${weibo.author}" target="_blank">
											   <span style="font-size:15px;color:blue;">${weibo.author}</span>
											</a>
										</div>
										<div  style="float:left;width:250px;padding-top:5px;">
											<span style="font-size:15px;color:blue;margin-top:10px;"> 
												<fmt:formatDate value="${weibo.time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
											</span>									
										</div>
										<div style="float:left;width:60px;padding-top:5px;">
											<span style="font-size:15px;">${weibo.emotion}</span>
										</div>	
										
										<button class="btn btn-default" onclick="WeiboContent(this,${weibo.id})">翻译</button>
										<!-- 
										<a style="float:left;width:60px;" onclick="WeiboContent(this,${weibo.id})">翻译</a>
										 -->
									</div>
									
									
									
									<div style="height:70px;">
										<span>&nbsp;&nbsp;&nbsp;&nbsp;${weibo.content}</span>
										<div class="translation">
									</div>
									</div>
								</div>
								<hr/> 
							</c:forEach>
                    </div>  
                   </div>
			 	</div>
			 </div>
			 
			 

			 <!-- 粉丝数量和推送通知script代码 -->
			 <script type="text/javascript">
			 	//var gaunzhu = document.getElementById("guanzhu").innerHTML;
			 	//alert(guanzhu);
			 
       			var myFensiChart = echarts.init(document.getElementById('fensi_chart'));
       			var fensiOption = {
       				    tooltip: {
       				        trigger: 'axis',
       				        axisPointer: {
       				            type: 'shadow'
       				        }
       				    },
       				    grid: {
       				        left: '3%',
       				        right: '4%',
       				        bottom: '3%',
       				        containLabel: true
       				    },
       				    xAxis: {
       				        type: 'value',
       				        boundaryGap: [0, 0.01]
       				    },
       				    yAxis: {
       				        type: 'category'
       				    },
       				    series: [
       				        {
       				            name: '粉丝数',
       				            type: 'bar'
       				        },
       				    ]
       				};
       			
				function loadFensiData(option) {
					$.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/weibo/getWeiFensi",
						data : {
						},
						dataType : "json",
						success : function(result) {
							if (result) {
								option.series[0].data = [];
								option.yAxis.data=[];
								for(i in result){
						    		    option.yAxis.data.push(i);
										option.series[0].data.push(result[i]);
									}
								}
							}

					});
				};
				loadFensiData(fensiOption);
				myFensiChart.setOption(fensiOption);
			 </script>
			 
			 
			 <%
			 int ID;
			 %>
			
		    <script type="text/javascript">
	   			function WeiboContent(e,weibo_id) {
						$
						.ajax({
							type : "get",
							async : false,
							url : "${request.contextPath}/mwyqMonitor/mynews/getWeiboContent?weibo_id=" + weibo_id,
							data : {},
							dataType : "text",
							success : function(result) {
									//document.getElementById(weibo_id).innerHTML=result;
									document.getElementById(weibo_id).lastElementChild.lastElementChild.innerHTML=result;
									//alert("456");
							}
						});
						
						//alert(weibo_id);
	   			}

			</script>
			
			<div class="row row-not-margin">
				<div class="col-sm-12">
					<div class="panel panel-default">
						<div class="panel-heading"><span class="glyphicon glyphicon-sort"></span>微博内容
						</div>
						<div class="panel-body">
							<c:forEach items="${weibo}" var="weibo">
								 <div style="height:120px;" id=${weibo.id}>                                       
									<!-- 
									<p style="font-size:15px;color:green;"><span>&nbsp;${weibo.author}&nbsp;&nbsp;&nbsp;&nbsp;${weibo.time}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${weibo.emotion}</span></p>
									 -->
									<div style="height:50px;">
										<div style="float:left;width:150px;padding-top:5px;">
											<a href="author/${weibo.author}" target="_blank">
											   <span style="font-size:15px;color:blue;">${weibo.author}</span>
											</a>
										</div>
										<div  style="float:left;width:250px;padding-top:5px;">
											<span style="font-size:15px;color:blue;margin-top:10px;"> 
												<fmt:formatDate value="${weibo.time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
											</span>									
										</div>
										<div style="float:left;width:60px;padding-top:5px;">
											<span style="font-size:15px;">${weibo.emotion}</span>
										</div>	
										
										<button class="btn btn-default" onclick="WeiboContent(this,${weibo.id})">翻译</button>
										<!-- 
										<a style="float:left;width:60px;" onclick="WeiboContent(this,${weibo.id})">翻译</a>
										 -->
									</div>
									
									
									
									<div style="height:70px;">
										<span>&nbsp;&nbsp;&nbsp;&nbsp;${weibo.content}</span>
										<div class="translation">
										</div>
									</div>
									
									
								</div>
									<hr/> 
							</c:forEach>
						</div>
					</div>
				</div>  <!-- col-sm-6 --> 
			</div>
			
			
			
		</div><!-- end row row-ptop-25 -->
	</div><!-- end page-wrapper -->

</div>


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

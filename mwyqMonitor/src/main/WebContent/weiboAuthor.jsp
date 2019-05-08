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
    
    <script type="text/javascript">
    
    function no_follow(bozhu)
    {
    	document.getElementById("follow").innerHTML="未关注";
    	$.ajax({
    		type:"get",
    		async:false,
    		url:"${request.contextPath}/mwyqMonitor/weibo/guanzhu",
    		data:{
    			follow:"no",
    			bozhu:bozhu
    		},
    		dataType:"json"
    	});
    }
    
    function yes_follow(bozhu)
    {
    	document.getElementById("follow").innerHTML="已关注";
    	$.ajax({
    		type:"get",
    		async:false,
    		url:"${request.contextPath}/mwyqMonitor/weibo/guanzhu",
    		data:{
    			follow:"yes",
    			bozhu:bozhu
    		},
    		dataType:"json"
    	});
    }
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
                    <li><a href="<%=request.getContextPath()%>/weibo/" target="_blank"><span class="glyphicon glyphicon-time span-icon">
                    	</span> 微博分析</a></li>
                    <li><a href="http://10.10.130.152:6688/" target="_blank">
                    	<span class="glyphicon glyphicon-road span-icon"></span> 知识图谱</a></li>
                    <li class="active">
                        <a href="javascript: void(0);" onclick="listUserWord();">
                            <span class="glyphicon glyphicon-book span-icon"></span> 自定义监测
                        </a>
                        <ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
                    </li>
                </ul>
            </div>
        </div>      
    </nav>

    <!-- 右侧主体部分 -->

	<div id="page-wrapper">
		<div class="row row-ptop-25">
			<div class="col-md-12" style="text-align:center;">
				<span>
					<h2>${name}</h2>
					<p id="follow">已关注</p>
				</span><br></br>
				<button  onclick="yes_follow('${name}')">选择关注</button>&nbsp;&nbsp;
				<button onclick="no_follow('${name}')">取消关注</button>
			</div>
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

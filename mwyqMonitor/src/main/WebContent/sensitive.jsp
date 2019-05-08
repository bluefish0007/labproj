<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>
	<!-- sensitive.jsp -->
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>民汉舆情汇聚与监测系统 — 敏感词检测    </title>

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
	
	<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/underscore-1.5.2.js"></script>
	<!--<script src="js/highlight.js"></script>-->
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/hotspots.js"></script>
	<!-- 搜索提示 -->
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/search.js"></script>
	
	
	
	<!--例子-->
    <script src="<%=request.getContextPath()%>/resources/js/hotpots/myjs.js"></script>
    <link rel="stylesheet" charset="utf-8" type="text/css" href="<%=request.getContextPath()%>/resources/css/hotpots/mycss.css"> 
	
	
	<link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
	


</head>

<body>

<!-- 

<script type="text/javascript">
	function sensitiveInit(){
		//alert("123");
		
		var lang = '${sessionScope.lang}';
		.ajax({
			type : "get",
			async : false,
			url : "${request.contextPath}/mwyqMonitor/sensite/getLastestSensitiveType?lang="+lang,
			data : {},
			dataType : "text",
			success : function(result) {
				document.getElementById("sensitive_type").innerHTML=result;
			}
		});
	 	var html1="";				
	 	$.ajax({
			type : "get",
			async : false,
			url : "${request.contextPath}/mwyqMonitor/sensite/getLastestSensitiveWord?lang=",
			data : {},
			dataType : "json",
			success : function(result) {
				for(var i in result){
					html1=html1+"<p>"+"<span style=\"color:red\">"+i+"&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+result[i]+"</span>"+"</p>";
				}
				document.getElementById("sensitive_word_table").innerHTML=html1;
			}
		});
	}
	sensitiveInit();
    //alert("123");
</script>

 -->



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
                    	<span class="glyphicon glyphicon-home span-icon"></span>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                    <li><a href="/baidu/" target="_blank">
                    	<span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank">
                    	<span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank">
                    	<span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
                    <li><a href="#""><span class="glyphicon glyphicon-flag span-icon">
                    	</span> 敏感词检测</a></li>
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
                <div class="col-sm-12">
                    <div class="alert alert-info">
     				    <!-- <strong>已抓取敏感新闻数量：中文${cnCount}篇，蒙文${mengCount}篇，维文${weiCount}篇，藏文${zangCount}篇</strong> --> 
     				    <strong>本页面显示均为敏感信息新闻，敏感词使用红色字体标出</strong>  
                    </div>
                </div>
            </div>

            <!--时事热点显示-->
            <div class="row row-not-margin">
                <div class="col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-time"></span>  敏感词新闻
                            <div class="pull-right">
	                                <div class="btn-group">
	                                    <button type="button" id="btn_langFilter" class="btn btn-default btn-xs" data-toggle="dropdown">
	                                        <span id="lang_category">全部</span>
	                                        <span class="caret"></span>
	                                    </button>
	                                    <ul class="dropdown-menu pull-right" role="menu" id="filter_ul_li">
	                                    	<li><a href="<%=request.getContextPath()%>/mynews/">全部</a></li>
	                                        <li><a href="#">敏感新闻</a></li>
	                                        <li><a href="<%=request.getContextPath()%>/mynews/">热点新闻</a></li>
	                                        <!-- 
	                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'zh-CN')">中文</a></li>
	                                         -->
	                                    </ul>
	                                </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body timeline-body">
                            <div id="showTimeLine">
                            
                   			<script >
                   			function displaycontent(e,news_id) {
            					$
            							.ajax({
            								type : "get",
            								async : false,
            								url : "${request.contextPath}/mwyqMonitor/mynews/getSensitiveContent?news_id=" + news_id,
            								data : {},
            								dataType : "text",
            								success : function(result) {
           										document.getElementById("sensitive_content").innerHTML=result;
            								}
            							});
            					
            					
              					$
    							.ajax({
    								type : "get",
    								async : false,
    								url : "${request.contextPath}/mwyqMonitor/mynews/getOnClickTime?news_id=" + news_id,
    								data : {},
    								dataType : "text",
    								success : function(result) {
   										document.getElementById("sensitive_time").innerHTML=result;
    								}
    							});
              					var html="";
              					
              					$
              					.ajax({
    								type : "get",
    								async : false,
    								url : "${request.contextPath}/mwyqMonitor/sensite/getSensitiveWord?news_id=" + news_id,
    								data : {},
    								dataType : "json",
    								success : function(result) {
    									for(var i in result){
    										html=html+"<p>"+"<span style=\"color:red\">"+i+"&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+result[i]+"</span>"+"</p>";
    									}
    									document.getElementById("sensitive_word_table").innerHTML=html;
    								}
    							});
              					
            					
            					document.getElementById("sensitive_title").innerHTML=document.getElementById(news_id).innerHTML;
            					
            					var type = e.getAttribute("sensitiveType");
            					if(type==1){
            						document.getElementById("sensitive_type").innerHTML="中性";
            					}
            					if(type==2){
            						document.getElementById("sensitive_type").innerHTML="敏感";
            					}
            					
            					document.getElementById("sensitive_url").innerHTML="原文链接："+e.getAttribute("urlvalue");
            					document.getElementById("sensitive_url").href=e.getAttribute("urlvalue");
            					//document.getElementById("news_content_time").innerHTML=e.getAttribute("timevalue");
            				}			  											
							</script>
							
						
							<% 
							SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss");
							Date date = new Date();
							%>
                                <c:forEach items="${sensitiveNews}" var="sensitiveNews">                              
                                	<div class="a4">                                       
										<a id=${sensitiveNews.news_id} class="a1" onclick="displaycontent(this,${sensitiveNews.news_id})"
											timevalue=${sensitiveNews.news_time} urlvalue=${sensitiveNews.news_url}
									    	titlevalue=${sensitiveNews.news_title} sensitiveType=${sensitiveNews.is_sensitive}>
											${sensitiveNews.news_title}</a> 
										<span style="margin-top:15px;margin-bottom:10px;"> 
											<fmt:formatDate value="${sensitiveNews.news_time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
										</span>                      
									    <p class="a2" style="font-size:15px;margin:15px auto;">&nbsp;&nbsp;&nbsp;&nbsp;${sensitiveNews.news_content}</p>
										<br>
									</div>
									<hr> 
								</c:forEach>	 
                            </div>
                            <div class="showMore"><a class="showMore-a" onclick="takeMore();">回到顶部</a></div>
                        </div>
                    </div>
                </div><!-- end col-sm-8  -->

                <div class="col-sm-4">
                    <div class="panel panel-default panel-fixed" id="panel_show_news">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-justify"></span>  新闻内容</div>
                        <div class="panel-body">
                            <div>
                                <h3 id="sensitive_title">${lastestSensitiveNews.news_title}</h3>
                                <p>该篇文章类型为：<span id="sensitive_type">${lastestSensitiveType}</span></p>
                          		<p id="sensitive_time">
                          			<span style="margin-top=10px"> 
										<fmt:formatDate value="${lastestSensitiveNews.news_time}" type="date" pattern="yyyy-MM-dd " />
									</span>
								</p>
                                <a id="sensitive_url" cursor:pointer target="_blank">原文链接:&nbsp;&nbsp;${lastestSensitiveNews.news_url}</a>
                            </div>
                            <div >
                                <p id="sensitive_content" style="font-size:15px;margin:15px auto;text-indent:1em;">${firstContent}</p>                                                             
                            </div>
                            
                            <p style="color:blue">---------敏感词词表---------------------------</p>
                            
                            <div id="sensitive_word_table">
                            	${firstWord}
                            </div>
                        </div>
                    </div>
                </div><!-- end col-sm-4 -->
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

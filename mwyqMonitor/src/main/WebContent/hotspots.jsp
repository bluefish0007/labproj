<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>
	<!-- hotspots.jsp -->
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>民汉舆情汇聚与监测系统 — 实时热点</title>

	<link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
	<link rel="stylesheet" href="
	<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrapSwitch.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/jquery-ui.css">
	
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/sb-admin.css">
     
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/model.css">
    <!--
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/model.css">
     -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/timeline.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/hotspots.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/vendor-font.css">
	
	<style>
        .btn-default:active {
    		background-color:green !important;
		}
    </style>
	
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
	
	<!-- 筛选 -->
	<script src="<%=request.getContextPath()%>/resources/bootstrap/js/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/bootstrap/js/commonSearch.js"></script>
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/css/bootstrap.min.css.map">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.css">
	<link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
</head>

<body>
<div id="wrapper">

    <!--左侧部分-->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#" style="font-size:18;"><span>民汉舆情汇聚与监测系统</span></a>
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
                    <li><a href="#">
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

        <!-- 设置页面，隐藏域 -->
        <div id="set-panel" class="panel panel-default set-panel">
            <div class="panel-body" style="width:498px;">
                <form id="langTypeForm" role="form"  action="actionhotspots" target="_blank">
                   	<!-- add-sunpeng-2018/03/24-start -->
                    <div class="form-group">
                        <label class="control-label set-label" style="font-size:16px;width:70px;margin-top:5px;">语言选择 </label>
                        <div class="max-search">
                            <div class="input-group margin-right-15" id="langsRadio">
								<span class="input-group-addon" style="width:50px;">
									<input name="cbLanguage" type="radio" checked="checked" value="cn">中文</input>
								</span>
								<span class="input-group-addon" style="width:50px;">
									<input name="langtype" type="radio" value="meng">蒙文</input>
								</span>
								<span class="input-group-addon" style="width:50px;">
									<input name="langtype" type="radio" value="wei">维文</input>
								</span>
                                <span class="input-group-addon" style="width:50px;">
									<input name="cbLanguage" type="radio" value="zang">藏文</input>
								</span>&nbsp;&nbsp;	
								<button id="langSubmitBtn" type="submit" style="padding:2px;font-size:16px;border-radius:3px;width:50px;background-color:#eee">提交</button>	
                            </div>
                        </div>
                    </div>
                   	<!-- add-sunpeng-2018/03/24-end -->  
                </form>
            </div>
        </div>
        <!-- 设置页面 end -->
    </nav>

    <!-- 右侧主体部分 -->
    <div id="page-wrapper">
        <div class="row row-ptop-25">
            <!--蓝色显示框-->
            <div class="row row-not-margin">
                <div class="col-sm-12">
                    <div class="alert alert-info">
                        <strong>最新抓取新闻为：中文${ch}篇，蒙文${meng}篇，维文${wei}篇，藏文${zang}篇</strong>
                     </div>
                </div>
            </div>
            <!--时事热点显示-->
            <div class="row row-not-margin">
                <div class="col-md-8">
                   <div class="panel panel-default">
	                    <div class="panel-heading" id="search-filter">
							<span class="glyphicon glyphicon-list span-icon"></span> 实时热点
	                    </div>                      
                        
                        <div class="panel-body">
                            <div id="showTimeLine">
                            
                            <%! int translationID; %>
                            
                            <script>
                   			
                            translationID=${lastestOneNews.news_id};
            				//alert(translationID);								
							</script>
                            
                   			<script type="text/javascript">
                   			
                   			function displaynewsContent(e,news_id) {
            					$
            							.ajax({
            								type : "get",
            								async : false,
            								url : "${request.contextPath}/mwyqMonitor/mynews/getContent?news_id=" + news_id,
            								data : {},
            								dataType : "text",
            								success : function(result) {
           										document.getElementById("news_content").innerHTML=result;
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
   										document.getElementById("news_content_time").innerHTML=result;
    								}
    							});
              					
              					translationID=news_id;
              					//alert(translationID);
            					
            					document.getElementById("news_content_title").innerHTML=document.getElementById(news_id).innerHTML;
            					
            					document.getElementById("news_content_url").innerHTML="原文链接："+e.getAttribute("urlvalue");
            					document.getElementById("news_content_url").href=e.getAttribute("urlvalue");
            					
            					document.getElementById("trans_Title").innerHTML="";
            					document.getElementById("trans_Content").innerHTML="";
            					//document.getElementById("news_content_time").innerHTML=e.getAttribute("timevalue");
            					
            					
            				}			  											
							</script>
							
							<% 
							//SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss");
							SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss");
							Date date = new Date();
							%>
							
							
                                <c:forEach items="${latestNews}" var="latestNews">                              
                                   <div class="a4">                                       
										<a id=${latestNews.news_id} class="a1" onclick="displaynewsContent(this,${latestNews.news_id})"
											timevalue=${latestNews.news_time} urlvalue=${latestNews.news_url} titlevalue=${latestNews.news_title}
											style="margin-top:25px;">
											${latestNews.news_title}
										</a> 
										
										<span style="margin-top:10px;font-size:16px;"> 
											<fmt:formatDate value="${latestNews.news_time}" type="date" pattern="yyyy-MM-dd" />
										</span>                      
										<p class="a2" style="font-size:16px;line-height:1.5;">&nbsp;&nbsp;&nbsp;&nbsp;${latestNews.news_content}</p>
										<br>
									</div><hr> 
								</c:forEach>
                            </div>
                            <div class="showMore"><a class="showMore-a" onclick="takeMore();">回到顶部</a></div>
                        </div>
                    </div>
                    </div><!-- end pannel-default  -->
                </div><!-- end col-sm-8  -->

			<!-- 
				<div class="col-xs-4">
	            	<div class="panel panel-default">
						<div class="panel-heading ">地点词云</div>
						<div id="ciyun2" class="panel-body1" style="height:300px;"></div>
					</div>
				</div>
 -->
                <div class="col-xs-4">
                    <div class="panel panel-default panel-fixed" id="panel_show_news">
                        <div class="panel-heading">
                        	<span class="glyphicon glyphicon-align-justify"></span>  新闻内容
                            <div class="pull-right">
                            	<button type="button" class="btn btn-default btn-xs">
                                	<span id="lang_category" onclick="transContent()">翻译</span>
                                </button>
                            </div>
                        </div>
                        
                        <!--
                        <div class="progress progress-striped active">
							<div id= "my-progress-bar" class="progress-bar progress-bar-success" role="progressbar"
		 						aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
							</div>
							<p id="tranProgStat">翻译进度</p>
						</div>
						-->
                        
                        <!--
                        <div class="progress">
					        <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="10" style="width:20%;">
					            <span>翻译进度：</span><span id="span-prog-value">0%</span>
					        </div>
					    </div>
					    -->

                        <script type="text/javascript">
					        /*
                        	function run() {
					        	$(".progress-bar").css("width", 100 + "%");
					            for (var prog = 0; prog <= 100;prog += 5) {
					            	document.getElementById("span-prog-value").innerHTML = prog + "%";
					            	setTimeout("run()", 50);	
					            }
					        }
					        */
					        function beginTrans() {
					        	document.getElementById("tranProgStat").innerHTML = "正在翻译...";
					        }
					        function endTrans() {
					        	document.getElementById("tranProgStat").innerHTML = "完成翻译!!!";
					        }
                        
                   			function transContent() {
                   				//var mydiv = document.getElementById("my-progress-bar");
								//mydiv.style.width = "100%";
                   				//beginTrans();
                   				//alert("开始翻译");
								//run(); //翻译进度条
								
    							$.ajax({
    								type : "get",
    								async : false,
    								url : "${request.contextPath}/mwyqMonitor/mynews/getTransAll?news_id=" + translationID,
    								data : {},
    								dataType : "json",
    								success : function(result) {
   										document.getElementById("trans_Title").innerHTML=result.title;
   										document.getElementById("trans_Content").innerHTML=result.content;
   										//endTrans();
   										//alert("翻译完成");
    								}
    							});  
    							
                   				/*
                   				$
    							.ajax({
    								type : "get",
    								async : false,
    								url : "${request.contextPath}/mwyqMonitor/mynews/getTransContent?news_id=" + translationID,
    								data : {},
    								dataType : "text",
    								success : function(result) {
   										document.getElementById("news_content").innerHTML=result;
    								}
    							});   
                   				
                   				$
    							.ajax({
    								type : "get",
    								async : false,
    								url : "${request.contextPath}/mwyqMonitor/mynews/getTransTitle?news_id=" + translationID,
    								data : {},
    								dataType : "text",
    								success : function(result) {
    									if(result)
   											document.getElementById("news_content_title").innerHTML=result;
    								}
    							});   
                   				*/
                   			}							
							</script>
                        
	                        <div class="panel-body">
	                            <div id="news_content_caption" >
	                                <h3 id="news_content_title">${lastestOneNews.news_title}</h3>
	                                <p id=news_content_time><fmt:formatDate value="${lastestOneNews.news_time}" type="date" pattern="yyyy-MM-dd" /></p>
	                                <a id="news_content_url" cursor: pointer><span>原文链接：</span>${lastestOneNews.news_url}</a>
	                            </div>
								<div style="overflow:auto;">
	                                <p id="news_content" style="font-size:16px;line-height:1.5;text-indent:2em;">${lastestOneNews.news_content}</p>
	                            </div>
	                            
	                            <!-- 译文  -->
	                            <hr></hr>
	                            <div style="text-align: center;">
									<h3 id="trans_Title" style="color: #1874CD; word-wrap: break-word; white-space: normal;">译文标题</h3>
								</div>
	                            <div style="padding: 5px; margin-bottom: 5px; min-width: 300px;">
									<div id="trans_Content" style="font-size: 16px; word-wrap: break-word;
															    width: 100%; height:400px;text-align: top; vertical-align: top; 
															    margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height:1.5;
															    overflow-x: hidden; overflow-y: scroll;">
											【译文内容】
									</div>
								</div>
	
								<!-- 
									<div id="trans_Title">【译文标题】</div>
	                            <div id="trans_Content">【译文内容】</div>
								-->                            
	                        </div>
                        </div>
                    </div>
                </div><!-- end col-sm-4 -->
            </div>
        </div><!-- /.row -->
    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->

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

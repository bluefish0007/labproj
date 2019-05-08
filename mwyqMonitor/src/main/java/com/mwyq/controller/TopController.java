/**
 * 
 */
package com.mwyq.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.mwyq.dao.EntityMapper;
import com.mwyq.model.Entity;
import com.mwyq.model.EntityTopicRelationExample;
import com.mwyq.model.News;
import com.mwyq.model.Page;
import com.mwyq.model.Topic;
import com.mwyq.model.topicEntity;
import com.mwyq.model.typeWord;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.PageUtil;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



@RestController
@RequestMapping("/topic")
public class TopController{
	
	
	@Autowired
	private TopicService topicService;
	@Autowired
	private EntityService entityService;
	@Autowired
	private NewsService newsService;	

	public void allTop(ModelAndView view,String lang){
		int total = topicService.getTopicNum();
		int pageSize = 30;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		
		List<Topic> topics = topicService.getTopicByPage(p,lang);
		view.addObject("topicList",topics);
		
		
//		view.addObject("topicAll",topicAll);
	}
	/**
	 * 得到话题下的新闻数量
	 * */
	
	

	

	@RequestMapping(value = "/",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,HttpSession session){
		Object lang = session.getAttribute("lang");
		if(lang==null){
			session.setAttribute("lang", "meng");
			lang = "meng";
		}

		ModelAndView view = new ModelAndView("0711index");
		/**
		 * 得到所有话题，无热度，无时间排序
		 * */
//		System.out.println("11111111111");
//		allTop(view,lang.toString());
		int total = topicService.getTopicNum();
		
		int pageSize = 30;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		
		List<Topic> topics = topicService.getTopicByPage(p,lang.toString());
		view.addObject("topicList",topics);
		
		
		List<Topic> hoTopics =  topicService.getHotTopics();
		view.addObject("hot", hoTopics);
		
		Map<String,Integer> indexEntity = entityService.getIndexEntity(lang.toString());
		view.addObject("indexEntity", indexEntity);
		
		return view;
	}
	
	@RequestMapping(value="/chooselang",method=RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request,HttpSession session){
		String lang = request.getParameter("langtype");
		ModelAndView view = new ModelAndView("redirect:/main/");
		session.setAttribute("lang", lang);
		
		//System.out.println("####################师兄界面显示语言："+lang.toString());
		if(lang.toString().equals("cn"))
			session.setAttribute("lang", "cn");
		else if(lang.toString().equals("wei"))
			session.setAttribute("lang", "wei");
		else if(lang.toString().equals("zang"))
			session.setAttribute("lang", "zang");
		else
		{
			ModelAndView viewmeng = new ModelAndView("redirect:/topic/");
			return viewmeng;
		}
		
		return view;
	}
	@RequestMapping(value="/chooselangType",method=RequestMethod.POST)
	public ModelAndView chooseLangType(HttpServletRequest request,HttpSession session){
		String lang = request.getParameter("langtype");
		ModelAndView view = new ModelAndView("redirect:/topic/");
		session.setAttribute("lang", lang);
		return view;
	}
	
	@RequestMapping(value="/getPer",method=RequestMethod.GET,produces="text/html;charset=UTF-8")
	public String getPer(HttpServletRequest request){
		String lang = request.getParameter("lang");
		List<Entity> perIndex = new ArrayList<Entity>();
		perIndex=entityService.getTopPer(lang);
	//	Map<String,String> perIndex = new HashMap<String,String>();
	//	perIndex=entityService.getTopPer();
		
		
		
//		LatinToUnicodeRuleList.getUtf8String(perIndex);
//		System.out.println("perIndex-----"+perIndex);
		//JSON json = JSONObject.fromObject(perIndex);
		
		//System.out.println(per);
		JSONArray json = JSONArray.fromObject(perIndex);
		//System.out.println(json);
		/*
		JSONArray jsons = new JSONArray();
		for(int j=0;j<perIndex.size();j++){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("per", perIndex.get(j));
			jsons.add(jsonObject);
		}
		*/
		
		//response.getWriter().print(json);
		return json.toString();
	}
	
	
	@RequestMapping(value="/getLoc",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getLoc(HttpServletRequest request){
	//	List<Entity> locIndex = entityService.getTopLoc();
		//System.out.println(per);
	//	JSONArray json = JSONArray.fromObject(locIndex);
		//System.out.println(json);
		/*
		JSONArray jsons = new JSONArray();
		for(int j=0;j<locIndex.size();j++){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("per", locIndex.get(j));
			jsons.add(jsonObject);
		}
		*/
		//response.setContentType("text/json");
		//response.setCharacterEncoding("utf-8");
		
		
	//	response.getWriter().print(json);
		String lang = request.getParameter("lang");
		List<Entity> locIndex = new ArrayList<Entity>();
		locIndex=entityService.getTopLoc(lang);
//		System.out.println("locIndex-----"+locIndex);
		JSONArray json = JSONArray.fromObject(locIndex);
		
		return json.toString();
	}
	
	
	@RequestMapping(value="/getOrg",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getOrg(HttpServletRequest request){
		String lang = request.getParameter("lang");
		List<Entity> orgIndex = new ArrayList<Entity>();
		orgIndex=entityService.getTopOrg(lang);

		JSONArray json = JSONArray.fromObject(orgIndex);
		
		return json.toString();
	}
	
	@RequestMapping(value="/getEntityNum",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityNum(HttpServletRequest request){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		String lang = request.getParameter("lang");
		
		Map<String,Integer> entityNum=new HashMap<String,Integer>();
		entityNum=entityService.getIndexEntity(lang);
		JSONObject json = JSONObject.fromObject(entityNum);
		
//		Iterator<Entry<String, Integer>> it = entityNum.entrySet().iterator();  
//		while (it.hasNext()) {  
//			Entry<String, Integer> entry = it.next();  
//		    System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());  
//		}
//		System.out.println(json.toString());
		return json.toString();
	}
	
	/*
	 * 获取实体数量经过优化
	 * */
	@RequestMapping(value="/getStaticEntity",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getStaticEntity(HttpServletRequest request){
		String lang = request.getParameter("lang");
		JSONObject json = newsService.getStaticEntity(lang);
//		System.out.println(json.toString());
		return json.toString();
	}
	
	
	@RequestMapping(value="/{id}/getEntityRe",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityRelation(HttpServletRequest request,@PathVariable("id") String id){
		
//		System.out.println("实体关系映射成功s");
		String result = topicService.getNewsEntityRelation(id);
		
//		JSONArray jsonArray = new JSONArray();
//		JSONObject json1= new JSONObject();
//		JSONObject json2= new JSONObject();
//		
//		json1.put("name","liwei");
//		json1.put("value",14);
//		
//		json2.put("name","yaoming");
//		json2.put("value",18);
//		
//		jsonArray.add(json1);
//		jsonArray.add(json2);
//		System.out.println("数组长度为");
//		System.out.println(result.length());
//		System.out.println("{{{{{{{{{{{{{{");
//		System.out.println(result.toString());
//		System.out.println("}}}}}}}}}}}}}}");
		
		return result;
	}
	
	/*
	 * 获取新闻类别
	 * */
	@RequestMapping(value="/getNewsCategory",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getNEwsCategory(HttpServletRequest request){
		String lang = request.getParameter("lang");
		JSONObject json = newsService.getNewsCategory(lang);
//		System.out.println(json.toString());
		
		JSONObject result = new JSONObject();
		Iterator it = json.keys();
		
		if(lang.equals("cn")){
			result.put("国内",0);
			result.put("国际",0);
			result.put("军事",0);
			result.put("文化",0);
			result.put("体育",0);
			result.put("经济",0);
			result.put("社会",0);
			result.put("港澳台",0);
			result.put("娱乐",0);
			result.put("其他",0);
		}

		while(it.hasNext()&&lang.equals("cn")){
			String key = (String) it.next();
			int value = (int)json.get(key);
			System.out.println(key);
			if(key.equals("国内")){
				result.put("国内", value+(int)result.get("国内"));
			}
			else if (key.equals("国际")) {
				result.put("国际", value+(int)result.get("国际"));
			}
			else if (key.equals("军事")||key.equals("强国社区")) {
				result.put("军事", value+(int)result.get("军事"));
			}
			else if (key.equals("文化")) {
				result.put("文化", value+(int)result.get("文化"));
			}
			else if (key.equals("体育")) {
				result.put("体育", value+(int)result.get("体育"));
			}
			else if (key.equals("经济")||key.equals("财经中心")||key.equals("产经中心")) {
				result.put("经济", value+(int)result.get("经济"));
			}
			else if (key.equals("社会")) {
				result.put("社会", value+(int)result.get("社会"));
			}
			else if (key.equals("娱乐")) {
				result.put("娱乐", value+(int)result.get("娱乐"));
			}
			else if (key.equals("港澳台")||key.equals("台湾")||key.equals("港澳")) {
				result.put("港澳台", value+(int)result.get("港澳台"));
			}
			else{
				result.put("其他", value+(int)result.get("其他"));
			}
		}
		
		if (lang.equals("cn")) {
			return result.toString();
		}
		
		if(lang.equals("zang")){
			result.put("རྒྱལ་ནང་དུ་",0);
			result.put("རྒྱལ་སྤྱི་",0);
			result.put("དམག་དོན་",0);
			result.put("སློབ་གསོ་བྱེད་པ་",0);
			result.put("ཆོས་ལུགས་",0);
			result.put("དཔལ་འབྱོར་",0);
			result.put("སྤྱི་ཚོགས་",0);
			result.put("རོལ་རྩེད་",0);
			result.put("རིག་གནས་",0);
			result.put("དེ་མིན་", 0);
		}
		
		
		while(it.hasNext()&&lang.equals("zang")){
			String key = (String) it.next();
			int value = (int)json.get(key);
			System.out.println(key);
			if(key.equals("རྒྱལ་ནང་དུ་")||key.equals("གལ་ཆེའི་གསར་འགྱུར།")||key.equals("འགོ་ཁྲིད་བྱེད་སྒོ།")){
				result.put("རྒྱལ་ནང་དུ་", value+(int)result.get("རྒྱལ་ནང་དུ་"));
			}
			else if (key.equals("རྒྱལ་སྤྱི་")) {
				result.put("རྒྱལ་སྤྱི་་", value+(int)result.get("རྒྱལ་སྤྱི་་"));
			}
			else if (key.equals("དམག་དོན་")) {
				result.put("དམག་དོན་", value+(int)result.get("དམག་དོན་"));
			}
			else if (key.equals("སློབ་གསོ་བྱེད་པ་")||key.equals("བྱིས་པའི་སློབ་གསོ།")||key.equals("མི་རིགས་སློབ་གསོ།")) {
				result.put("སློབ་གསོ་བྱེད་པ་", value+(int)result.get("སློབ་གསོ་བྱེད་པ་"));
			}
			else if (key.equals("ཆོས་ལུགས་")||key.equals("ཆོས་ལུགས་གསར་འགྱུར།")) {
				result.put("ཆོས་ལུགས་", value+(int)result.get("ཆོས་ལུགས་"));
			}
			else if (key.equals("དཔལ་འབྱོར་")) {
				result.put("དཔལ་འབྱོར་", value+(int)result.get("དཔལ་འབྱོར་"));
			}
			else if (key.equals("སྤྱི་ཚོགས་")||key.equals("བོད་ཁུལ་གསར་འགྱུར།")||key.equals("དམངས་འཚོ།")||key.equals("དམངས་ཕན་སྲིད་ཇུས།")) {
				result.put("སྤྱི་ཚོགས་", value+(int)result.get("སྤྱི་ཚོགས་"));
			}
			else if (key.equals("རོལ་རྩེད་")||key.equals("གངས་རིའི་སྐར་རྒྱན།")||key.equals("ལྗོངས་ཕྱིའི་ཡུལ་སྐོར།")) {
				result.put("རོལ་རྩེད་", value+(int)result.get("རོལ་རྩེད་"));
			}
			else if (key.equals("རིག་གནས་")||key.equals("སྔོན་བྱོན་མཁས་པ།")||key.equals("ལོ་རྒྱུས་ཤེས་བྱ།")||key.equals("སྙན་རྩོམ།")||key.equals("བོད་ལྗོངས་སྒྱུ་རྩལ།")||key.equals("བོད་ལྗོངས་སྒྱུ་རྩལ།")) {
				result.put("རིག་གནས་", value+(int)result.get("རིག་གནས་"));
			}
			else {
				result.put("དེ་མིན་", value+(int)result.get("དེ་མིན་"));
			}
			
			
		}
		
		if (lang.equals("zang")) {
			return result.toString();
		}
		
		return json.toString();
	}
	
	
	
	/**
	 * 获取话题的新闻并分页显示
	 * **/
	@RequestMapping(value = "/newsPage",params="page", method=RequestMethod.GET)
	public ModelAndView newsPage(HttpServletRequest request,@Param("page") String page,HttpSession session){
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");
		
		int total = topicService.getTopicNum();
		
		Object lang = session.getAttribute("lang");
		if(lang==null){
			session.setAttribute("lang", "meng");
			lang = "meng";
		}
		
		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));
		
		List<Topic> topics = topicService.getTopicByPage(p,lang.toString());
		
		view.addObject("page", p);
		view.addObject("topics", topics);
		return view;
	}
	
	/*
	 * 新页面获取热门话题详情
	 * */
	@RequestMapping(value = "/{id}/newtopic", method=RequestMethod.GET)
	public ModelAndView newListtopNews(HttpServletRequest request,@PathVariable("id") String id){
		
		System.out.println("topicid:"+id);
		
		Topic topic = topicService.getTopic(id);
		String keyword = topic.getTopwords();
		String title = topic.getTopic_name();

		
		ModelAndView view = new ModelAndView("newtopic_news");
		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);
		
		int newsCount = topicAllNews.size();
		HashMap<String,Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if(perNum==null){
			perNum=0;
		}
		if(locNum==null){
			locNum=0;
		}
		if(orgNum==null){
			orgNum=0;
		}
		
		String entityList;
		
		List<typeWord> tenWord = topicService.getTenEntity(id);
		System.out.println("jsjsjsjs");
		
		view.addObject("topicId",id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);
		
		view.addObject("topicNews",topicNews);

		view.addObject("topicAllNews",topicAllNews);
		
		view.addObject("keyword",keyword);
		
		view.addObject("title",title);
		
		view.addObject("tenWord",tenWord);
		
		System.out.println(keyword);
		
		
		return view;
	}
	
	
	
	/**
	 * 获取单条热门话题详情
	 * */
	@RequestMapping(value = "/{id}/news", method=RequestMethod.GET)
	public ModelAndView listtopNews(HttpServletRequest request,@PathVariable("id") String id){
		
		System.out.println("topicid:"+id);
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");
		
		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);
		
		int newsCount = topicAllNews.size();
		HashMap<String,Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if(perNum==null){
			perNum=0;
		}
		if(locNum==null){
			locNum=0;
		}
		if(orgNum==null){
			orgNum=0;
		}
		
		view.addObject("topicId",id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);
		
		view.addObject("topicNews",topicNews);

		view.addObject("topicAllNews",topicAllNews);
		
		
		
		return view;
	}
	
	
	/**
	 * 获取单条热门话题详情
	 * */
	@RequestMapping(value = "/entityrelation", method=RequestMethod.GET)
	public ModelAndView EntityRelationShow(HttpServletRequest request){
		
		String id = "67b71614-a4fd-4f32-8450-a52799981ec3";
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news_entityrelation");
		
		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);
		
		
		
//		System.out.println(topicNews);
		
		int newsCount = topicAllNews.size();
		HashMap<String,Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if(perNum==null){
			perNum=0;
		}
		if(locNum==null){
			locNum=0;
		}
		if(orgNum==null){
			orgNum=0;
		}
		
		view.addObject("topicId",id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);
		
		view.addObject("topicNews",topicNews);

		view.addObject("topicAllNews",topicAllNews);
		
		
		
		return view;
	}

	
	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 * **/
	@RequestMapping(value = "/{id}/newsContent", method=RequestMethod.GET)
	public ModelAndView topicNewsContent(HttpServletRequest request,@PathVariable("id") int id){
		
		System.out.println("newsid-----:"+id);
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent");
		
		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent",topicNewsContent);
		view.addObject("newsId",id);
		return view;
	}
	
	
	/**
	 * 新页面获取话题新闻列表的单条新闻的新闻内容
	 * **/
	@RequestMapping(value = "/{id}/newsDisplay", method=RequestMethod.GET)
	public ModelAndView topicNewsdisplay(HttpServletRequest request,@PathVariable("id") int id){
		
		System.out.println("newsid-----:"+id);
		
		ModelAndView view = new ModelAndView("newsdisplay");
		
		List<News> topicNewsContent = newsService.getNewsContent(id);
		
		News displayNew = topicNewsContent.get(0);
		
		view.addObject("displayNew",displayNew);
		
		view.addObject("topicNewsContent",topicNewsContent);
		view.addObject("newsId",id);
		return view;
	}
	
	/**
	 * 新页面获取话题新闻列表的单条新闻的新闻内容
	 * **/
	@RequestMapping(value = "/{id}/newsDisplay2/{word}", method=RequestMethod.GET)
	public ModelAndView topicNewsdisplay2(HttpServletRequest request,@PathVariable("id") int id,@PathVariable("word") String word){
		
		System.out.println("newsid-----:"+id);
		System.out.println("news_word---"+word);
		
		ModelAndView view = new ModelAndView("newsdisplay");
		
		List<News> topicNewsContent = newsService.getNewsContent(id);
		
		News displayNew = topicNewsContent.get(0);
		
		displayNew.setNews_content(displayNew.getNews_content().replaceAll(word,"<span style=\"color:red;\">"+word+"</span>"));
		displayNew.setNews_title(displayNew.getNews_title().replaceAll(word,"<span style=\"color:red;\">"+word+"</span>"));
		
		view.addObject("displayNew",displayNew);
		
		view.addObject("topicNewsContent",topicNewsContent);
		view.addObject("newsId",id);
		return view;
	}
	
	
	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 * **/
	@RequestMapping(value = "/{id}/newsContentEntityRelation", method=RequestMethod.GET)
	public ModelAndView topicNewsContentEntityRelation(HttpServletRequest request,@PathVariable("id") int id){
		
		System.out.println("newsid-----:"+id);
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent_entityRelation");
		
		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent",topicNewsContent);
		view.addObject("newsId",id);
		return view;
	}
	
	
	/**
	 * 话题的分页显示
	 * */
	@RequestMapping(value = "/topicPage",params="page", method=RequestMethod.GET)
	public ModelAndView topicsPage(HttpServletRequest request,@Param("page") String page,HttpSession session){
		
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topics");
		
		int total = topicService.getTopicNum();
		
		Object lang = session.getAttribute("lang");
		if(lang==null){
			session.setAttribute("lang", "meng");
			lang = "meng";
		}
		
		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));
		
		List<Topic> topics = topicService.getTopicByPage(p,lang.toString());
		
		view.addObject("page", p);
		view.addObject("topics", topics);
		return view;
	}
	
	
	@RequestMapping(value="/{id}/getTopicPer",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getTopicPer(HttpServletRequest request,@PathVariable("id") String id){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		
		HashMap<String,Double> topic_per=new HashMap<String,Double>();
	
		topic_per=topicService.getEntityPer(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_per.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String,Integer>();
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
	
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			Double bDouble = entry.getValue();
			Integer integer = bDouble.intValue();
			finalResult.put(entry.getKey(),integer);
		}
		
		JSONObject json = JSONObject.fromObject(finalResult);
		
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@RequestMapping(value="/{id}/getTopicLoc",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getTopicLoc(HttpServletRequest request,@PathVariable("id") String id){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		
		HashMap<String,Double> topic_loc=new HashMap<String,Double>();
	
		topic_loc=topicService.getEntityLoc(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_loc.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String,Integer>();
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			Double bDouble = entry.getValue();
			Integer integer = bDouble.intValue();
			finalResult.put(entry.getKey(),integer);
		}	
		JSONObject json = JSONObject.fromObject(finalResult);
		System.out.println(json.toString());
		return json.toString();
	}
	
	@RequestMapping(value="/{id}/getTopicOrg",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getTopicOrg(HttpServletRequest request,@PathVariable("id") String id){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		
		HashMap<String,Double> topic_org=new HashMap<String,Double>();
	
		topic_org=topicService.getEntityOrg(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_org.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String,Integer>();
		
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
		
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			Double bDouble = entry.getValue();
			Integer integer = bDouble.intValue();
			finalResult.put(entry.getKey(),integer);
		}
		
		JSONObject json = JSONObject.fromObject(finalResult);
		System.out.println(json.toString());
		return json.toString();
	}
	
	@RequestMapping(value="/{id}/getEntityKey",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityKey(HttpServletRequest request,@PathVariable("id") String id){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		
		HashMap<String,String> topic_per=new HashMap<String,String>();
	
		topic_per=topicService.getEntityKey(id);
		JSONObject json = JSONObject.fromObject(topic_per);
		
		return json.toString();
	}
	
	@RequestMapping(value="/getTopicTime",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getNewsTime(HttpServletRequest request){
		String lang = request.getParameter("lang");
		HashMap<String,Integer> topic_time_t = new HashMap<String,Integer>();
		topic_time_t=topicService.getTopicTendency(lang);
		TreeMap<String, Integer> finalResult = new TreeMap<String,Integer>();
		List<Map.Entry<String,Integer>> list = new ArrayList<Map.Entry<String,Integer>>(topic_time_t.entrySet());
		for(Map.Entry<String,Integer> entry : list){
			finalResult.put(entry.getKey(),entry.getValue());
		}
		JSONObject json = JSONObject.fromObject(finalResult);
		
//		System.out.println(json.toString());
		
		return json.toString();
	}
	
	//获取话题数量-优化之后
	@RequestMapping(value="/getTopicNum",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getTopicNum(HttpServletRequest request){
		String lang = request.getParameter("lang");
		TreeMap<String, Integer> result = topicService.getTopicTendencyNum(lang); 
		JSONObject json = JSONObject.fromObject(result);
		return json.toString();
	}
	
	
	@RequestMapping(value="/{id}/getTopicToEntity",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getTopicToEntity(HttpServletRequest request,@PathVariable("id") String id){
//		TreeMap<String,Integer> topic_entity=new TreeMap<String,Integer>();
		String topic_entity;
	//	List<String> topic_entity= new ArrayList<String>();
		topic_entity=topicService.getTopicToEntity(id);
		JSONObject json = JSONObject.fromObject(topic_entity);
		return json.toString();
	}

	@RequestMapping(value="/{id}/getEntityPerKey",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityPerKey(HttpServletRequest request,@PathVariable("id") int id){
		HashMap<String,String> new_per=new HashMap<String,String>();
		
		new_per=newsService.getEntityPerKey(id);
		JSONObject json = JSONObject.fromObject(new_per);
		
		return json.toString();
	}
	@RequestMapping(value="/{id}/getEntityLocKey",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityLocKey(HttpServletRequest request,@PathVariable("id") int id){
		HashMap<String,String> new_loc=new HashMap<String,String>();
		
		new_loc=newsService.getEntityLocKey(id);
		JSONObject json = JSONObject.fromObject(new_loc);
		
		return json.toString();
	}
	@RequestMapping(value="/{id}/getEntityOrgKey",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getEntityOrgKey(HttpServletRequest request,@PathVariable("id") int id){
		HashMap<String,String> new_org=new HashMap<String,String>();
		new_org=newsService.getEntityOrgKey(id);
		JSONObject json = JSONObject.fromObject(new_org);
		
		return json.toString();
	}


}

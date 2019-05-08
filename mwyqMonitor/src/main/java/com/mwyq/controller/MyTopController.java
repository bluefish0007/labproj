/**
 * MyTopController.java
 * 2017.12.11 SunPeng
 */

package com.mwyq.controller;

import java.io.IOException;
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
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.ServletException;
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
import com.mwyq.model.typeQuery;
import com.mwyq.model.typeSensitive;
import com.mwyq.service.DoSearchServlet;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.PageUtil;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/main")
public class MyTopController {
	@Autowired
	private TopicService topicService;
	@Autowired
	private EntityService entityService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private DoSearchServlet doss;
	
	
	
	public void allTop(ModelAndView view, String lang) {
		int total = topicService.getTopicNum();
		int pageSize = 20;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		List<Topic> topics = topicService.getTopicByPage(p, lang);
		view.addObject("topicList", topics);
		
//		System.out.println("rrrrrrrrrrrrrrrrrrrrrrr");
//		List<typeSensitive> test = newsService.getTypeSensitive();
//		for(typeSensitive t1:test){
//			System.out.print(t1.getDataTime());
//			System.out.print(" ");
//			System.out.println(t1.getNum());
//		}
//		System.out.println("RRRRRRRRRRRRRRRRRRRRRRR");
	}

	/*
	 * 获取前10条hotTopic
	 */
	public void dealTop(ModelAndView view) {
		List<Topic> hotTopics = topicService.getHotTopics();
		view.addObject("hotTopics", hotTopics);
	}

	private void dealEntity(ModelAndView view, String lang) {
		Map<String, Integer> indexEntity = entityService.getIndexEntity(lang);
		view.addObject("indexEntity", indexEntity);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		Object lang = session.getAttribute("lang");
		
		
		String username = (String) session.getAttribute("username");
		String passwd = (String) session.getAttribute("passwd");
		
//		System.out.println(passwd);
//		System.out.println(username);
//		System.out.println("123456789");
		
//		JSONObject jsonObject = newsService.getAllNewsNum();
//		System.out.println("======-=908990889");
//		System.out.println(jsonObject.toString());
//		System.out.println("12312313212312312");
		
		
//		System.out.println("fgfgfgfggfgfgfgfgfgfgfg");
//		String contentww = "";
//		System.out.println(newsService.getOnlyNewsContent(153817));
//		System.out.println(newsService.getOnlyNewsContent(113811));
//		System.out.println(newsService.getOnlyNewsContent(153910
//));
//		System.out.println("gfgfgfgfgfgfgfgfgfgfgfg");
//		
		
		boolean is = newsService.getUser(username,passwd);
		if(is){
			if (lang == null) {
				session.setAttribute("lang", "cn");
				lang = "cn";
			}

			ModelAndView view = new ModelAndView("/index");
			
			List<News> religionNews = new ArrayList<News>();
//			if(lang.toString().equals("cn")){
			religionNews = newsService.getReligionNews(lang.toString());
			view.addObject("religion",religionNews);
//			}
			
			/**
			 * 得到所有话题，无热度，无时间排序
			 */
			allTop(view, lang.toString());

			/**
			 * 1、top模块 dealTop 得到热贴
			 */
			dealTop(view);
			
			
			
			dealEntity(view, lang.toString());

			return view;
		}
		
		
		ModelAndView view = new ModelAndView("redirect:/");

		return view;

	}

	/**
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/chooselang", method = RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request, HttpSession session) {

		String lang = request.getParameter("langtype");
	
		ModelAndView view = new ModelAndView("redirect:/main/");
		session.setAttribute("lang", lang);
		
		String s = session.getAttribute("lang").toString();
		if(s.equals("meng")){
			ModelAndView view1 = new ModelAndView("redirect:/topic/");
			return view1;
		}
		
		return view;
	}

	
	
	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getPer", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getPer(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> perIndex = new ArrayList<Entity>();
		perIndex = entityService.getTopPer(lang);

		//System.out.println("MyTopController/getPer--->>>语言：" + lang + " >>>实体数量" + perIndex.size());

		JSONArray json = JSONArray.fromObject(perIndex);
		
		return json.toString();
	}

	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getLoc", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getLoc(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> locIndex = new ArrayList<Entity>();
		locIndex = entityService.getTopLoc(lang);
		JSONArray json = JSONArray.fromObject(locIndex);
		

		return json.toString();
	}

	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getOrg", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getOrg(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> orgIndex = new ArrayList<Entity>();
		orgIndex = entityService.getTopOrg(lang);

		JSONArray json = JSONArray.fromObject(orgIndex);

		return json.toString();
	}
	
	@RequestMapping(value = "/getAll", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getAll(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> allIndex = new ArrayList<Entity>();
		allIndex = entityService.getTopAll(lang);

		JSONArray json = JSONArray.fromObject(allIndex);

		return json.toString();
	}

	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getEntityNum", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityNum(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		Map<String, Integer> entityNum = new HashMap<String, Integer>();
		entityNum = entityService.getIndexEntity(lang);
		JSONObject json = JSONObject.fromObject(entityNum);
		
		return json.toString();
	}

	/**
	 * 获取话题的新闻并分页显示
	 **/
	@RequestMapping(value = "/newsPage", params = "page", method = RequestMethod.GET)
	public ModelAndView newsPage(HttpServletRequest request, @Param("page") String page, HttpSession session) {
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");

		int total = topicService.getTopicNum();
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "meng";
		}

		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));
		List<Topic> topics = topicService.getTopicByPage(p, lang.toString());

		view.addObject("page", p);
		view.addObject("topics", topics);
		
		return view;
	}
	
	

	/**
	 * 获取单条热门话题详情
	 */
	@RequestMapping(value = "/{id}/news", method = RequestMethod.GET)
	public ModelAndView listtopNews(HttpServletRequest request, @PathVariable("id") String id) {

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");

		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);

		int newsCount = topicAllNews.size();
		HashMap<String, Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if (perNum == null) {
			perNum = 0;
		}
		if (locNum == null) {
			locNum = 0;
		}
		if (orgNum == null) {
			orgNum = 0;
		}

		view.addObject("topicId", id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);

		view.addObject("topicNews", topicNews);
		view.addObject("topicAllNews", topicAllNews);

		return view;
	}

	/**
	 * 获取单条热门话题详情
	 */
	@RequestMapping(value = "/entityrelation", method = RequestMethod.GET)
	public ModelAndView EntityRelationShow(HttpServletRequest request) {
		String id = "67b71614-a4fd-4f32-8450-a52799981ec3";

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news_entityrelation");

		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);

		int newsCount = topicAllNews.size();
		HashMap<String, Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if (perNum == null) {
			perNum = 0;
		}
		if (locNum == null) {
			locNum = 0;
		}
		if (orgNum == null) {
			orgNum = 0;
		}

		view.addObject("topicId", id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);

		view.addObject("topicNews", topicNews);
		view.addObject("topicAllNews", topicAllNews);

		return view;
	}

	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsContent", method = RequestMethod.GET)
	public ModelAndView topicNewsContent(HttpServletRequest request, @PathVariable("id") int id) {

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent");

		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent", topicNewsContent);
		view.addObject("newsId", id);

		return view;
	}
	
	
	@RequestMapping(value = "/searchDan", method = RequestMethod.GET)
	public void searechDan(HttpServletRequest request){
			System.out.println("1234567890");
	}


	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsContentEntityRelation", method = RequestMethod.GET)
	public ModelAndView topicNewsContentEntityRelation(HttpServletRequest request, @PathVariable("id") int id) {

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent_entityRelation");

		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent", topicNewsContent);
		view.addObject("newsId", id);
		
		return view;
	}

	/**
	 * 话题的分页显示
	 */
	@RequestMapping(value = "/topicPage", params = "page", method = RequestMethod.GET)
	public ModelAndView topicsPage(HttpServletRequest request, @Param("page") String page, HttpSession session) {
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topics");

		int total = topicService.getTopicNum();
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "meng";
		}

		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));
		List<Topic> topics = topicService.getTopicByPage(p, lang.toString());

		view.addObject("page", p);
		view.addObject("topics", topics);
		
		return view;
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getTopicPer", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicPer(HttpServletRequest request, @PathVariable("id") String id) {
		HashMap<String, Double> topic_per = new HashMap<String, Double>();
		topic_per = topicService.getEntityPer(id);


		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(topic_per.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();

				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}

		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String, Double>();
		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}

		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue());
		}

		JSONObject json = JSONObject.fromObject(finalResult);

//		System.out.println("//////////////////////////");
//		System.out.println(json.toString());
//		System.out.println("//////////////////////////");
		
		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getTopicLoc", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicLoc(HttpServletRequest request, @PathVariable("id") String id) {
		HashMap<String, Double> topic_loc = new HashMap<String, Double>();

		topic_loc = topicService.getEntityLoc(id);
		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(topic_loc.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}

		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String, Double>();
		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}
		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue());
		}

		JSONObject json = JSONObject.fromObject(finalResult);

		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getTopicOrg", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicOrg(HttpServletRequest request, @PathVariable("id") String id) {
		HashMap<String, Double> topic_org = new HashMap<String, Double>();
		topic_org = topicService.getEntityOrg(id);

		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(topic_org.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}

		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String, Double>();

		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}

		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue());
		}

		JSONObject json = JSONObject.fromObject(finalResult);

		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getEntityKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityKey(HttpServletRequest request, @PathVariable("id") String id) {
		HashMap<String, String> topic_per = new HashMap<String, String>();

		topic_per = topicService.getEntityKey(id);
		JSONObject json = JSONObject.fromObject(topic_per);
		
		

		return json.toString();
	}

	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getTopicTime", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getNewsTime(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		HashMap<String, Integer> topic_time_t = new HashMap<String, Integer>();
		topic_time_t = topicService.getTopicTendency(lang);

		TreeMap<String, Integer> finalResult = new TreeMap<String, Integer>();
		List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(topic_time_t.entrySet());
		for (Map.Entry<String, Integer> entry : list) {
			finalResult.put(entry.getKey(), entry.getValue());
		}

		JSONObject json = JSONObject.fromObject(finalResult);

		//System.out.println("MyTopController/getNewsTime--->>>语言：" + lang + " >>>新闻数量" + finalResult.size());
		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getTopicToEntity", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicToEntity(HttpServletRequest request, @PathVariable("id") String id) {
//		TreeMap<String, Integer> topic_entity = new TreeMap<String, Integer>();
		String topic_entity;
		topic_entity = topicService.getTopicToEntity(id);
		JSONObject json = JSONObject.fromObject(topic_entity);
		
		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getEntityPerKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityPerKey(HttpServletRequest request, @PathVariable("id") int id) {
		HashMap<String, String> new_per = new HashMap<String, String>();
		new_per = newsService.getEntityPerKey(id);
		JSONObject json = JSONObject.fromObject(new_per);
		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getEntityLocKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityLocKey(HttpServletRequest request, @PathVariable("id") int id) {
		HashMap<String, String> new_loc = new HashMap<String, String>();
		new_loc = newsService.getEntityLocKey(id);
		JSONObject json = JSONObject.fromObject(new_loc);

		return json.toString();
	}

	/**
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}/getEntityOrgKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityOrgKey(HttpServletRequest request, @PathVariable("id") int id) {
		HashMap<String, String> new_org = new HashMap<String, String>();
		new_org = newsService.getEntityOrgKey(id);
		JSONObject json = JSONObject.fromObject(new_org);

		return json.toString();
	}
	
//	public void getKey(HttpServletRequest request,HttpServletResponse resp) throws ServletException, IOException {
//		doss.doPost(request, resp);
//	}
	
	
//	@RequestMapping(value = "/test", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
//	public void test(HttpServletRequest request,HttpServletResponse response) {
//			String s = request.getParameter("username");
//			System.out.println("111111"+s);
//	}
//	
	
	
	/**
	 * 获取四种语言数量
	 */
	@RequestMapping(value = "/getAllNewsNum", method = RequestMethod.GET)
	public String getAllNewsNum(HttpServletRequest request) {
		JSONObject json = newsService.getAllNewsNum();
//		System.out.println("新闻语种统计");
//		System.out.println(json.toString());
		return json.toString();
	}

}

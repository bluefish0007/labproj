/**
 * AnalysisController.java
 */

package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.News;
import com.mwyq.model.Page;
import com.mwyq.model.Topic;
import com.mwyq.model.sensitiveTendency;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.PageUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/mystat")
public class AnalysisController {
	@Autowired
	private TopicService topicService;

	@Autowired
	private EntityService entityService;
	@Autowired
	private NewsService newsService;
	//历史话题排行筛选时间
	public static String range = "all";

	public void allTop(ModelAndView view, String lang) {
		int total = topicService.getTopicNum();
		int pageSize = 30;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		List<Topic> topics = topicService.getTopicByPage(p, lang);
	}

	public void dealTop(ModelAndView view) {
		List<Topic> hoTopics = topicService.getHotTopics();
		view.addObject("hot", hoTopics);
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		ModelAndView view = new ModelAndView("analysis");
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "cn");
			lang = "cn";
		}
		
//		System.out.println("-----------------------");
//		JSONObject json = new JSONObject();
//		json = newsService.getNewsCategory(lang.toString());
//		System.out.println(json.toString());
//		System.out.println("-----------------------");
		
//		System.out.println("pppppppppppppppppppp");
//		List<sensitiveTendency> result = newsService.getSensitiveTendencyByLang(lang.toString());
//		for(sensitiveTendency t:result){
//			System.out.println(t.getData_time());
//			System.out.println(t.getTotal());
//		}
//		System.out.println("pppppppppppppppppppp");
		
		
		
		List<Topic> topics = new ArrayList<Topic>();
		
//		System.out.println("99999999999999999999");
////		System.out.println(range);
//		topicService.getTopicTendencyNum(lang.toString());
//		System.out.println("99999999999999999999");
		
		if(range.equals("all")){
			topics = topicService.getHistoryHotTopics(lang.toString());
		}
		else if (range.equals("week")) {
//			System.out.println("!!!!!!!!!!!!!!!!");
//			System.out.println("week");
			topics = topicService.getHistoryWeekHotTopics(lang.toString());
		}
		else if (range.equals("month")) {
//			System.out.println("!!!!!!!!!!!!!!!!");
//			System.out.println("month");
			topics = topicService.getHistoryMonthHotTopics(lang.toString());
		}
		else if (range.equals("year")){
//			System.out.println("!!!!!!!!!!!!!!!!");
//			System.out.println("year");
			topics = topicService.getHistoryYearHotTopics(lang.toString());
		}
		else {
			topics = topicService.getHistoryHotTopics(lang.toString());
		}
		
//		System.out.println(topics.size()+"话题数量901284190284091");

		for (int i = 0; i < topics.size(); ++i) {
			Topic topic = topics.get(i);
			String str = topic.getNews_content();
			int loc = 0;
			if (str.lastIndexOf("。") != -1) {
				loc = str.lastIndexOf("。");
			} else if (str.lastIndexOf("！") != -1) {
				loc = str.lastIndexOf("！");
			} else if (str.lastIndexOf("；") != -1) {
				loc = str.lastIndexOf("；");
			} else if (str.lastIndexOf("：") != -1) {
				loc = str.lastIndexOf("：");
			} else if (str.lastIndexOf("，") != -1) {
				loc = str.lastIndexOf("，");
			} else if (str.lastIndexOf("、") != -1) {
				loc = str.lastIndexOf("、");
			} else {
				if (str.length() > 100) {
					loc = 100;
				} else {
					loc = str.length() - 1;
				}
			}
			str = str.substring(0, loc + 1);
			topic.setNews_content(str);
			topics.set(i, topic);
		}
		
		view.addObject("topicList", topics);
		return view;
	}
	
	@RequestMapping(value = "getLangStat", method = RequestMethod.GET)
	public String langStat(HttpServletRequest request, HttpSession session) {
		TreeMap<String, TreeMap<String, Integer>> ssiMap = new TreeMap<String, TreeMap<String, Integer>>();
		ssiMap = newsService.sevenDayNews();
		
		JSONObject json = JSONObject.fromObject(ssiMap);

//		System.out.println("AnalysisController.java/langStat 格式化的查询结果：\n\t" + json.toString());
		return json.toString();
	}
	
	@RequestMapping(value = "/getSelect", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public ModelAndView getSelect(HttpServletRequest request) {
		String value = request.getParameter("selected");
		range = value;
//		System.out.println("---------------------");
//		System.out.println(range);
		ModelAndView view = new ModelAndView("redirect:/mystat/");
		return view;
	}
	
	@RequestMapping(value = "actionanalysis", method = RequestMethod.GET)
	public ModelAndView action(HttpServletRequest request, HttpSession session) {
		String s = request.getParameter("cbLanguage");
		switch (s) {
		case "cn":
			session.setAttribute("lang", "cn");
			break;
		case "meng":
			session.setAttribute("lang", "meng");
			break;
		case "wei":
			session.setAttribute("lang", "wei");
			break;
		case "zang":
//			System.out.println("统计分析语言选择---藏语");
			session.setAttribute("lang", "zang");
			break;
		}

		if (s.equals("meng")) {
			ModelAndView view = new ModelAndView("redirect:http://210.31.0.145:8080/mwyqMonitor/topic/");
			return view;
		}

		ModelAndView view = new ModelAndView("redirect:/mystat/");
		return view;
	}
	
	
	@RequestMapping(value = "/getSensitiveByLang", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getSensitiveByLang(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		
		
		JSONObject json = new JSONObject();
		List<sensitiveTendency> result = newsService.getSensitiveTendencyByLang(lang);
		
//		ListIterator it = result.listIterator(result.size());
		
		for(int i=result.size()-1;i>=0;i--)
		{
			int[] value = new int[3];
			value[0] = result.get(i).getTotal();
			value[1] = result.get(i).getSensitive1();
			value[2] = result.get(i).getSensitive2();
			json.put(result.get(i).getData_time(),value);
		}
		
		
//		for(sensitiveTendency t:result){
//			int[] value = new int[3];
//			value[0] = t.getTotal();
//			value[1] = t.getSensitive1();
//			value[2] = t.getSensitive2();
//			json.put(t.getData_time(),value);
//		}
		System.out.println(json.toString());
		return json.toString();
	}
	
}


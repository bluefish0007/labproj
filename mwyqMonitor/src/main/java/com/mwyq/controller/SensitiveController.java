package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.solr.common.util.Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.News;
import com.mwyq.service.NewsService;
import com.mwyq.service.SensitiveService;

import net.sf.json.JSONObject;



@RestController
@RequestMapping("sensite")
public class SensitiveController {
	@Autowired
	private NewsService newsService;
	//@Autowired
	//private SensitiveService sensitiveService;
	
	/**
	 * 显示敏感新闻列表
	 * **/
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,HttpSession session){
//		System.out.println("程序开始-------------------》");

		
		ModelAndView view = new ModelAndView("sensitive");

		/**
		 * 得到所有敏感新闻，以时间排序
		 * */
		Object lang = session.getAttribute("lang");
		
		if(lang==null){
			session.setAttribute("lang", "cn");
			lang = "cn";
		}
		
//		String sss = getSensitiveTendency(lang.toString());
		
		List<News> sensitive = newsService.getSensitiveNews(lang.toString());
		view.addObject("sensitiveNews",sensitive);
		
		News lastestSensitiveNews = newsService.getLastestSensitiveNews(lang.toString());
		view.addObject("lastestSensitiveNews",lastestSensitiveNews);
		
		String sensitiveType = "";
		Integer lastestSensitiveType = lastestSensitiveNews.getIs_sensitive();
		if(lastestSensitiveType==1){
			sensitiveType="中性";
		}
		else{
			sensitiveType="敏感";
		}
		view.addObject("lastestSensitiveType",sensitiveType);
		
		String lastestWord = lastestSensitiveNews.getSensitive_words();
		String lastestContent = lastestSensitiveNews.getNews_content();
		
		String tableResult = getTableResult(lastestWord);
		String firstContent = getContentResult(lastestContent,lastestWord);
		
		view.addObject("firstContent", firstContent);
		view.addObject("firstWord", tableResult);
		
		
		
		
		for(News news : sensitive){	
			List<String> listOfStr = Arrays.asList(news.getSensitive_words().split("[*]")); 
//			for (String str : listOfStr) {
//				news.setNews_content(news.getNews_content().replaceAll(str,"<span style=\"color:red\">" + str +"</span>"));
//			}
			
			news.setSensitive_words(news.getSensitive_words().replaceAll("[*]", " "));
		}
		
		News lastestOneNews = newsService.getLastOneNews(lang.toString());
		view.addObject("lastestOneNews", lastestOneNews);
		return view;
	}
	
	public String getTableResult(String Word) {
		// TODO Auto-generated method stub
		

		String[] word = Word.split("\\*");
		
		String first,last;
		String result="";
		
		for(String w:word){
			first = w.substring(0, w.indexOf(":"));
			last = w.substring(w.indexOf(":")+1,w.length());
//			html=html+"<p>"+"<span style=\"color:red\">"+i+"&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+result[i]+"</span>"+"</p>";
			result = result + "<p>" + "<span style=\"color:red\">"+first+"&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+last+"</span>"+"</p>";
		}
		
		return result;
	}
	
	public String getContentResult(String Content, String Word) {
		// TODO Auto-generated method stub
		
//		HashMap<String,String> sencitiveWord = new HashMap<String,String>();
		String[] word = Word.split("\\*");
		
		String first,last;
		String lastestContent;
		
		for(String w:word){
			first = w.substring(0, w.indexOf(":"));
			
			Content = Content.replaceAll(first, "<span style=\"color:red\">" + first +"</span>");
			
			last = w.substring(w.indexOf(":")+1,w.length());
//			sencitiveWord.put(first, last);
		}
		
		return Content;
	}

	/*语言选择 */
	@RequestMapping(value = "actionhotspots",method=RequestMethod.GET)
	public ModelAndView actiontest(HttpServletRequest request,HttpSession session){
		String s = request.getParameter("cbLanguage");
		switch(s)
		{
		case "cn":
			session.setAttribute("lang","cn");
			break;
		case "meng":
			session.setAttribute("lang","meng");
			break;
		case "zang":
			session.setAttribute("lang","zang");
			break;
		case "wei":
			session.setAttribute("lang","wei");
			break;
		}
		System.out.println(s);
		
		
		if(s.equals("meng")){
			ModelAndView view = new ModelAndView("redirect:http://210.31.0.145:8080/mwyqMonitor/topic/");
			return view;
		}
		
		ModelAndView view = new ModelAndView("redirect:/sensite/");
		return view;		
	}
	
	
	@RequestMapping(value ="/getSensitiveWord", method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getSensitiveContent(HttpServletRequest request){
		System.out.println("获取映射敏感词页面成功");
		Integer news_id = new Integer(request.getParameter("news_id"));
		List<News> newsSensitive = newsService.getNewsContent(news_id);
		News clickSensitiveNew = newsSensitive.get(0);
		
		String clickSensitiveContent = clickSensitiveNew.getNews_content();
		String clickSensitiveWord = clickSensitiveNew.getSensitive_words();
		String langType = clickSensitiveNew.getLang_type();
		

		
		String sensitiveResult;
		
		System.out.println(langType.toString());
//		if(langType.equals("zang")){
//			System.out.println("点击语言为藏文");
//			sensitiveResult = getZangWord(langType,clickSensitiveContent,clickSensitiveWord);
//		}
//		else{
//			System.out.println("点击语言为中文或维文");
//			sensitiveResult = getWord(langType,clickSensitiveContent,clickSensitiveWord);
//		}
		
		sensitiveResult = getZangWord(langType,clickSensitiveContent,clickSensitiveWord);
		
//		System.out.println("&&&&&&&&&&&&&&&&&&&&");
//		System.out.println(sensitiveResult);
		
		return sensitiveResult;
	}
	
	public String getZangWord(String lang,String content,String wordList){
		
		HashMap<String,String> sencitiveWord = new HashMap<String,String>();
		String[] word = wordList.split("\\*");
		
		String first,last;
		
		for(String w:word){
			first = w.substring(0, w.indexOf(":"));
			last = w.substring(w.indexOf(":")+1,w.length());
			sencitiveWord.put(first, last);
		}
		
		JSONObject json = JSONObject.fromObject(sencitiveWord);
		
		return json.toString();
	} 
	
	public String getWord(String lang,String content,String wordList){
		
		HashMap<String,String> sencitiveWord = new HashMap<String,String>();
		
		String[] word = wordList.split("\\*");
		int count=0;
		String[] sensitiveWordList;
		
		for(String w:word){
			sensitiveWordList = content.split(w);
			count = sensitiveWordList.length-1;
			sencitiveWord.put(w, String.valueOf(count));
		}
		
		JSONObject json = JSONObject.fromObject(sencitiveWord);
		
		return json.toString();
	} 
	
	
	@RequestMapping(value = "/getSensitive", method = RequestMethod.GET)
	public String getSensitiveTendency(HttpServletRequest request){
		
		System.out.println("映射敏感词模块成功");
		
		String lang = request.getParameter("lang");
		
		if(lang==null){
			lang = "cn";
		}
		TreeMap<String,TreeMap<String,Integer>> sensitiveCount = newsService.getSensitiveTendency(lang.toString());
		
		JSONObject json = JSONObject.fromObject(sensitiveCount);
		
		System.out.println(json.toString());
		return json.toString();
	}
	
//	@RequestMapping(value ="/getSensitiveWord", method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
//	public String getLastestSContent(HttpServletRequest request){
//		System.out.println("获取映射敏感词页面成功");
//		Integer news_id = new Integer(request.getParameter("news_id"));
//		List<News> newsSensitive = newsService.getNewsContent(news_id);
//		News clickSensitiveNew = newsSensitive.get(0);
//		
//		String clickSensitiveContent = clickSensitiveNew.getNews_content();
//		String clickSensitiveWord = clickSensitiveNew.getSensitive_words();
//		String langType = clickSensitiveNew.getLang_type();	
//		String sensitiveResult;
//		
//		System.out.println(langType.toString());
//		
//		return "123";
//	}
	
//	@RequestMapping(value ="/getLastestSensitiveType", method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
//	public String getLastestSensitiveType(HttpServletRequest request){
//		String lang= request.getAttribute("lang").toString();
////		Object lang = session.getAttribute("lang");
//		System.out.println("初始化敏感词状态");
//		News lastestSensitiveNews = newsService.getLastestSensitiveNews(lang);
//		Integer type = lastestSensitiveNews.getIs_sensitive();
//		String result;
//		if(type==1){
//			result="中性";
//		}
//		else{
//			result="敏感";
//		}
//		return result;
//	}
	
//	@RequestMapping(value ="/getLastestSensitiveWord", method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
//	public String getLastestSensitiveWord(HttpServletRequest request){
//		
////		Object lang = session.getAttribute("lang");
//		String lang = request.getAttribute("lang").toString();
//		System.out.println("初始化敏感词表");
//		News lastestSensitiveNews = newsService.getLastestSensitiveNews(lang);
//		
//		String word = lastestSensitiveNews.getSensitive_words();
//		String content = lastestSensitiveNews.getNews_content();
//		
//		String sensitiveResult;
//		sensitiveResult = getZangWord(lang.toString(),content,word);	
//		
//		return sensitiveResult;
//	}
	
}

package com.mwyq.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.chainsaw.Main;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.News;
import com.mwyq.model.weiboGroup;
import com.mwyq.service.NewsService;
import com.mwyq.util.HttpUtils;
import com.mwyq.util.translation;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("mynews")
public class HotspotsController {
	@Autowired
	private NewsService newsService;

	/**
	 * 閺勫墽銇氶弬浼存閸掓銆�
	 **/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {

		/*
		 * 妫ｆ牠銆夊Ο鈥虫健 1閵嗕焦鏌婇梻璇插灙鐞涳拷 2閵嗕礁顕惔鏃�鏌婇梻璇插敶鐎癸拷 3閵嗭拷.....
		 */
		ModelAndView view = new ModelAndView("hotspots");

		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "cn");
			lang = "cn";
		}

		/**
		 * 瀵版鍩岄幍锟介張澶嬫煀闂備紮绱濇禒銉︽闂傚瓨甯撴惔锟�
		 */

		allNews(view, lang.toString());

		News lastestOneNews = newsService.getLastOneNews(lang.toString());
		lastestOneNews.setNews_content(lastestOneNews.getNews_content().replace("\n","<br>").replace("\r",""));
		view.addObject("lastestOneNews", lastestOneNews);

		return view;
	}

	/* 鐠囶叀鈻堥柅澶嬪 */
	@RequestMapping(value = "actionhotspots", method = RequestMethod.GET)
	public ModelAndView actiontest(HttpServletRequest request, HttpSession session) {
		String s = request.getParameter("cbLanguage");

		switch (s) {
		case "cn":
			session.setAttribute("lang", "cn");
			break;
		case "meng":
			session.setAttribute("lang", "meng");
			break;
		case "zang":
			session.setAttribute("lang", "zang");
			break;
		case "wei":
			session.setAttribute("lang", "wei");
			break;
		}
		System.out.println(s);

		if (s.equals("meng")) {

			// redirect:http://210.31.0.145:8080/mwyqMonitor

			ModelAndView view = new ModelAndView("redirect:/topic/");
			return view;

		}

		ModelAndView view = new ModelAndView("redirect:/mynews/");
		return view;

	}

	public void allNews(ModelAndView view, String lang) {
		// List<News> latestNews = newsService.getAllNews();

		List<News> latestNews = newsService.getLatestNews(lang);

		// int ch=newsService.getChinese();
		// int meng=newsService.getMeng();
		// int zang=newsService.getZang();
		// int wei=newsService.getWei();
		
		HashMap<String, Integer> newsCount = newsService.getNewsCount();
		
		int lastestNewsCount = newsService.getLastestNewsCount();

		String clickNewsTime = newsService.getClickTime("92672");

		
		 view.addObject("ch", newsCount.get("cn"));
		 view.addObject("meng", newsCount.get("meng"));
		 view.addObject("zang", newsCount.get("zang"));
		 view.addObject("wei", newsCount.get("wei"));
		
		view.addObject("lastestNewsCount", lastestNewsCount);

		// for (int i = 0; i < latestNews.size(); ++i) {
		// System.out.println(i + " -------------------------- " +
		// latestNews.get(i).getNews_title() + " : " +
		// latestNews.get(i).getNews_content());
		// }

		// System.out.println(latestNews);
		view.addObject("latestNews", latestNews);

	}

	// 濮ｅ繑娼弬浼存鐎电懓绨查惃鍕煀闂傝鍞寸�癸拷
	@RequestMapping(value = "/getContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String listtopNew(HttpServletRequest request) {

		Integer news_id = new Integer(request.getParameter("news_id"));
		List<News> newsContent = newsService.getNewsContent(news_id);
		return newsContent.get(0).getNews_content().replace("\n", "<br></br>").replace("\r", "<br></br>");
	}
	
	@RequestMapping(value = "/getWeiboContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiContent(HttpServletRequest request) {

		Integer id = new Integer(request.getParameter("weibo_id"));
		
		String content = newsService.tranWeibo(id);
		
		if(content!=""){
			content = translation(content, "ti");
		}
		
		content = content.substring(4,content.length());
		
		return content;
	}

	@RequestMapping(value = "/getSensitiveContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getSensitiveContent(HttpServletRequest request) {

		Integer news_id = new Integer(request.getParameter("news_id"));
		List<News> newsContent = newsService.getNewsContent(news_id);

		// for(News news : sensitive){
		// System.out.println("Line 68!!!!!!!!!!!!!!!!!!!!!!!!!!");
		//
		// List<String> listOfStr =
		// Arrays.asList(news.getSensitive_words().split("[*]"));
		// for (String str : listOfStr) {
		// System.out.println("閺佸繑鍔呯拠宥忕磼閿涳拷++++++++++++++++>>>>>>>>>>>>>>>>>" + str);
		// news.setNews_content(news.getNews_content().replaceAll(str,"<span
		// style=\"color:red\">" + str +"</span>"));
		// }
		//
		// news.setSensitive_words(news.getSensitive_words().replaceAll("[*]", " "));
		// //System.out.println(news.getNews_content());
		// }
		List<String> listOfStr = Arrays.asList(newsContent.get(0).getSensitive_words().split("[*]"));
		for (String str : listOfStr) {
			str = str.substring(0, str.length() - 2);
			newsContent.get(0).setNews_content(newsContent.get(0).getNews_content().replaceAll(str,
					"<span style=\"color:red\">" + str + "</span>"));
		}

		return newsContent.get(0).getNews_content();
	}
	
	@RequestMapping(value = "/getTransAll", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String transAll(HttpServletRequest request, HttpSession session) {

		int news_id = new Integer(request.getParameter("news_id"));
		System.out.println("翻译ID：" + news_id);
		System.out.println("翻译语言为：" + session.getAttribute("lang"));

		String lang = session.getAttribute("lang").toString();

		List<News> news = newsService.getNewsContent(news_id);
		News transNew = news.get(0);
		
		String transContent = transNew.getNews_content();
		String transTitle = transNew.getNews_title();
		System.out.println(transTitle);
		
		try {
//			String ssString = newsService.getOnlyNewsContent(news_id);
//			System.out.println("ahjsgdhjasd");
//			System.out.println("呵呵呵呵呵");
//			System.out.println(ssString);
//			System.out.println("شى جىنپىڭ ۋە پېڭ لىيۈەن فىرانسىيە تەرەپ ئەمەلدارلىرى بىلەن بىرمۇبىر قول ئېلىشىپ خوشلاشتى");
//			String str = "شى جىنپىڭ ۋە پېڭ لىيۈەن فىرانسىيە تەرەپ ئەمەلدارلىرى بىلەن بىرمۇبىر قول ئېلىشىپ خوشلاشتى";
//			str = new String(str.getBytes("utf-8"),"utf-8");
//			System.out.println(str);
//			str = new String(transContent.getBytes("utf-8"),"utf-8");
//			System.out.println(str);
			System.out.println("kkkkkk");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("有异常哈哈哈");
		}
		

		
		translation trans = new translation();
		JSONObject json = new JSONObject();

		if (lang.equals("cn")){
			json.put("title",transTitle);
			json.put("content",transContent);
			return json.toString();
		}
		
		else if (lang.equals("wei")) {
//			System.out.println("閹笛嗩攽缂堟槒鐦ч崙鑺ユ殶");
//			transTitle = translation(transTitle, "uy");
//			transTitle = transTitle.substring(4, transTitle.length());
//			
//			transContent = translation(transContent, "uy");
//			json.put("title",transTitle);
//			json.put("content",transContent);
//			return json.toString();
//			
			System.out.println(transContent);
			
			String s = transTitle.replace("\n", "")+"\n"+transContent;
			s = trans.sendPostWei(s);
			transTitle = s.split("\n")[0];
			transContent = s.replaceAll(transTitle,"");
			transContent = transContent.replace("\n", "<br>").replace("\r","<br>");
			json.put("title",transTitle);
			json.put("content",transContent);
			return json.toString();
			
		} else if (lang.equals("zang")) {
			String s = transTitle.replace("\n", "")+"\n"+transContent;
			s = trans.sendPostZang(s);
			transTitle = s.split("\n")[0];
			transContent = s.replaceAll(transTitle,"");
			transContent = transContent.replace("\n", "\n<br>").replace("\r","\n<br>");
			json.put("title",transTitle);
			json.put("content",transContent);
			return json.toString();
		} else {
			return transTitle;
		}

	}

	@RequestMapping(value = "/getTransTitle", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String transTitle(HttpServletRequest request, HttpSession session) {

		int news_id = new Integer(request.getParameter("news_id"));
		System.out.println("缂堟槒鐦ч弬浼存ID娑撶尨绱�" + news_id);
		System.out.println("缂堟槒鐦х拠顓♀枅娑擄拷" + session.getAttribute("lang"));

		String lang = session.getAttribute("lang").toString();

		List<News> newsContent = newsService.getNewsContent(news_id);
		News transNew = newsContent.get(0);

		String transTitle = transNew.getNews_title();
		System.out.println(transTitle);

		// 缂佺顕㈡稉绨巠,閽樺繗顕㈡稉绨峣
		// System.out.println("閹笛嗩攽缂堟槒鐦ч崙鑺ユ殶");
		
		translation trans = new translation();

		if (lang.equals("cn"))
			return transTitle;
		else if (lang.equals("wei")) {
			System.out.println("閹笛嗩攽缂堟槒鐦ч崙鑺ユ殶");
			transTitle = translation(transTitle, "uy");
			transTitle = transTitle.substring(4, transTitle.length());
			return transTitle;
		} else if (lang.equals("zang")) {
//			transTitle = translation(transTitle, "ti");
//			transTitle = transTitle.substring(4, transTitle.length());
			transTitle = trans.sendPostZang(transTitle);
			return transTitle;
		} else {
			return transTitle;
		}

	}

	@RequestMapping(value = "/getTransContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String transContent(HttpServletRequest request, HttpSession session) {

		int news_id = new Integer(request.getParameter("news_id"));
		System.out.println("缂堟槒鐦ч弬浼存ID娑撶尨绱�" + news_id);
		System.out.println("缂堟槒鐦х拠顓♀枅娑擄拷" + session.getAttribute("lang"));

		String lang = session.getAttribute("lang").toString();

		List<News> newsContent = newsService.getNewsContent(news_id);
		News transNew = newsContent.get(0);

		String transContent = transNew.getNews_content();
		System.out.println(transContent);

		// 缂佺顕㈡稉绨巠,閽樺繗顕㈡稉绨峣
		// System.out.println("閹笛嗩攽缂堟槒鐦ч崙鑺ユ殶");
		
		translation trans = new translation();

		if (lang.equals("cn"))
			return transContent;
		else if (lang.equals("wei")) {
			System.out.println("閹笛嗩攽缂堟槒鐦ч崙鑺ユ殶");

			transContent = translation(transContent, "uy");

			transContent = transContent.substring(4, transContent.length());
			return transContent;
		} else if (lang.equals("zang")) {
//			transContent = translation(transContent, "ti");
//
//			transContent = transContent.substring(4, transContent.length());
			
			transContent = trans.sendPostZang(transContent);
			return transContent;
		} else {
			return transContent;
		}

	}

	@RequestMapping(value = "/getRNNContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String tranRNNContent(HttpServletRequest request, HttpSession session) {

		int news_id = new Integer(request.getParameter("news_id"));

		String lang = session.getAttribute("lang").toString();

		List<News> newsContent = newsService.getNewsContent(news_id);
		News transNew = newsContent.get(0);
		String transContent = transNew.getNews_content();
		
		translation translation1 = new translation();

		if (lang.equals("cn"))
			return transContent;
		else if (lang.equals("wei")) {
			String result = translation1.sendPostWei(transContent);
			return result;
		} else if (lang.equals("zang")) {
			String[] temp = transContent.split("鍡夛拷");
			String result = "";
			for (String t : temp) {
				result = result + translation1.sendPostZang(t);
			}
			return result;
		} else {
			return transContent;
		}
	}

	@RequestMapping(value = "/getRNNTitle", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String tranRNNTitle(HttpServletRequest request, HttpSession session) {

		int news_id = new Integer(request.getParameter("news_id"));

		String lang = session.getAttribute("lang").toString();
		
		translation translation1 = new translation();

		List<News> newsContent = newsService.getNewsContent(news_id);
		News transNew = newsContent.get(0);
		String transContent = transNew.getNews_title();
		if (lang.equals("cn"))
			return transContent;
		else if (lang.equals("wei")) {

			String result = translation1.sendPostWei(transContent);
			return result;
		} else if (lang.equals("zang")) {
			String[] temp = transContent.split("鍡夛拷");
			String result = "";
			for (String t : temp) {
				result = result + translation1.sendPostZang(t);
			}
			return result;
		} else {
			return transContent;
		}
	}

	@RequestMapping(value = "/getOnClickTime", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String onClickNewsTime(HttpServletRequest request) {

		Integer news_id = new Integer(request.getParameter("news_id"));
		System.out.println(news_id.toString());
		String news_time = newsService.getClickTime(news_id.toString());

		// SimpleDateFormat smf=new SimpleDateFormat("yyyy-MM-dd");
		// Date date = new Date();
		// try{
		// date = smf.parse(news_time);
		// System.out.println(date);
		// }
		// catch(Exception e){
		// System.out.println("閺冪姵纭舵潪顒佸床閺冦儲婀�");
		// }

		return news_time;
	}

	@RequestMapping(value = "/getNewsTime", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getNewsTime(HttpServletRequest request) {
		String lang = request.getParameter("lang");

		HashMap<String, Integer> news_time_t = new HashMap<String, Integer>();

		news_time_t = newsService.getNewsTendency(lang);
		List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(news_time_t.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
			@Override
			public int compare(Map.Entry<String, Integer> arg0, Map.Entry<String, Integer> arg1) {
				String dateStr1 = arg0.getKey();
				String dateStr2 = arg1.getKey();
				return dateStr1.compareTo(dateStr2);
			}
		});
		TreeMap<String, Integer> finalResult = new TreeMap<String, Integer>();

		for (Map.Entry<String, Integer> entry : list) {
			finalResult.put(entry.getKey(), entry.getValue());
		}

		JSONObject json = JSONObject.fromObject(finalResult);

		return json.toString();
	}
	
	@RequestMapping(value = "/getWeiAuthor", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiboAuthor(HttpServletRequest request){
//		System.out.print("瀵邦喖宕ユ担婊嗭拷鍛板箯閸欙拷");
		String lang = request.getParameter("lang").toString();
//		System.out.println(lang);
//		System.out.print("瀵邦喖宕ユ担婊嗭拷鍛板箯閸欙拷");
		List<weiboGroup> result = newsService.getWeiboAuthor(lang);
		JSONObject json = new JSONObject();
//		for(int i=result.size()-1;i>=0;i--){
//			json.put(result.get(i).getAuthor(),result.get(i).getNum());
//		}
		
		for(weiboGroup weiboAuthor:result){
			json.put(weiboAuthor.getAuthor(), weiboAuthor.getNum());
		}
		return json.toString();
	}
	
	@RequestMapping(value = "/getWeiEmotion", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiboEmotion(HttpServletRequest request){
		String lang = request.getParameter("lang").toString();
//		System.out.print("瀵邦喖宕ラ幆鍛妳閼惧嘲褰�");
//		System.out.println(lang);
//		String result = new NewsService().getWeiboEmotion(lang);	
		
		JSONObject test = newsService.getWeiboEmotion(lang.toString());
		System.out.println(test.toString());
		return test.toString();
	}
	


	public String translation(String src_text, String lang) {

		System.out.println("缂堟槒鐦у锟芥慨锟�");
		System.out.println("缂堟槒鐦ч惃鍕鐟楀じ璐熼敍锟�" + src_text);
		System.out.println("缂堟槒鐦ч惃鍕嚔鐟凤拷娑撶尨绱�" + lang);

		String host = "http://niutrans1.market.alicloudapi.com";
		String path = "/NiuTransServer/translation";
		String method = "GET";
		String appcode = "90bd536854b7411d9ed3baeeac40d9d0";

		// 85c31fdfe77c4c7790e97755a046055c
		// e5c8983ce0824ce09b5e3c1dd7a54f33
		Map<String, String> headers = new HashMap<String, String>();
		// 閺堬拷閸氬骸婀猦eader娑擃厾娈戦弽鐓庣础(娑擃參妫块弰顖濆閺傚洨鈹栭弽锟�)娑撶瘓uthorization:APPCODE 83359fd73fe94948385f570e3c139105
		headers.put("Authorization", "APPCODE " + appcode);
		Map<String, String> querys = new HashMap<String, String>();

		List<String> transList = getStrList(src_text, 300);

		String transResult = null;

		for (Iterator<String> it = transList.iterator(); it.hasNext();) {

			String str = it.next();
			querys.put("from", lang);
			querys.put("src_text", str);
			querys.put("to", "zh");

			try {
				/**
				 * 闁插秷顩﹂幓鎰仛婵″倷绗�: HttpUtils鐠囪渹绮�
				 * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
				 * 娑撳娴�
				 *
				 * 閻╃绨查惃鍕贩鐠ф牞顕崣鍌滃弾
				 * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
				 */
				HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
				System.out.println(response.toString());
				// 閼惧嘲褰噐esponse閻ㄥ垺ody
				String responseEntity = EntityUtils.toString(response.getEntity());

				System.out.println(responseEntity);

				JSONObject json = JSONObject.fromObject(responseEntity);

				System.out.println(json.getString("tgt_text"));

				String s = json.getString("tgt_text");

				transResult += s;

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		// querys.put("from", lang);
		// querys.put("src_text", src_text) ;
		// querys.put("to", "zh");

		System.out.println(transResult);

		return transResult;
	}

	/**
	 * 閹跺﹤甯慨瀣摟缁楋缚瑕嗛崚鍡楀閹存劖瀵氱�规岸鏆辨惔锔炬畱鐎涙顑佹稉鎻掑灙鐞涳拷
	 * 
	 * @param inputString
	 *            閸樼喎顫愮�涙顑佹稉锟�
	 * @param length
	 *            閹稿洤鐣鹃梹鍨
	 * @return
	 */

	public List<String> getStrList(String inputString, int length) {
		int size = inputString.length() / length;
		if (inputString.length() % length != 0) {
			size += 1;
		}
		return getStrList(inputString, length, size);
	}

	/**
	 * 閹跺﹤甯慨瀣摟缁楋缚瑕嗛崚鍡楀閹存劖瀵氱�规岸鏆辨惔锔炬畱鐎涙顑佹稉鎻掑灙鐞涳拷
	 * 
	 * @param inputString
	 *            閸樼喎顫愮�涙顑佹稉锟�
	 * @param length
	 *            閹稿洤鐣鹃梹鍨
	 * @param size
	 *            閹稿洤鐣鹃崚妤勩�冩径褍鐨�
	 * @return
	 */

	public List<String> getStrList(String inputString, int length, int size) {
		List<String> list = new ArrayList<String>();
		for (int index = 0; index < size; index++) {
			String childStr = substring(inputString, index * length, (index + 1) * length);
			list.add(childStr);
		}
		return list;
	}

	/**
	 * 閸掑棗澹婄�涙顑佹稉璇х礉婵″倹鐏夊锟芥慨瀣╃秴缂冾喖銇囨禍搴＄摟缁楋缚瑕嗛梹鍨閿涘矁绻戦崶鐐碘敄
	 * 
	 * @param str
	 *            閸樼喎顫愮�涙顑佹稉锟�
	 * @param f
	 *            瀵拷婵缍呯純锟�
	 * @param t
	 *            缂佹挻娼担宥囩枂
	 * @return
	 */

	public String substring(String str, int f, int t) {
		if (f > str.length())
			return null;
		if (t > str.length()) {
			return str.substring(f, str.length());
		} else {
			return str.substring(f, t);
		}
	}
	
//	public static void main(String[] args) {
//		System.out.println("شى جىنپىڭ ۋە پېڭ لىيۈەن فىرانسىيە تەرەپ ئەمەلدارلىرى بىلەن بىرمۇبىر قول ئېلىشىپ خوشلاشتى");
//	}

}

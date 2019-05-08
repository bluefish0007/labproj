package com.mwyq.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//import org.apache.catalina.connector.Request;
import org.apache.commons.collections.set.SynchronizedSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.News;
import com.mwyq.model.weiBo;
import com.mwyq.model.weiboGroup;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("weibo")
public class weiboController {
	@Autowired
	private NewsService newsService;

	@Autowired
	private EntityService entityService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {

		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "cn");
			lang = "cn";
		}
		
//		JSONObject jsonObject = newsService.getWeiboFens(lang.toString());
//		System.out.println(jsonObject.toString());
//		JSONObject test = newsService.getWeiboEmotion(lang.toString());
//		System.out.println("jkasdghfjkasdghfjgs");
//		System.out.println(test.toString());
//		System.out.println("jkasdghfjkasdhfjklas");
		
//		List<weiboGroup> result = newsService.getWeiboAuthor(lang.toString());
//		System.out.println("qpqpqpqpqpqpqp");
//		for(weiboGroup G:result){
//			System.out.println(G.getAuthor());
//			System.out.println(G.getNum());
//		}
//		System.out.println("nmnmnmnmnmnmnmnm");

		List<weiBo> weiBos = newsService.getWeiBo(lang.toString());

		for (weiBo weiBo : weiBos) {
			String emotion = weiBo.getEmotion();
			System.out.print(emotion);
			if (emotion.equals("正面")) {
				weiBo.setEmotion("<span style=\"color:green\">正向</span>");
			} 
			else if (emotion.equals("负面")) {
				weiBo.setEmotion("<span style=\"color:red\">负向</span>");
			}
			else {
				weiBo.setEmotion("<span style=\"color:blue\">中性</span>");
			}
		}
		
		
		String username = (String) session.getAttribute("username");
		String passwd = (String) session.getAttribute("passwd");
		
		String guanzhu = newsService.getGuanzhu(username, passwd);
		guanzhu = guanzhu.replace("*"," ");
		List<weiBo> tuisongWeibo = newsService.getTuisong(guanzhu); 
		
		
		
		System.out.println(guanzhu);
//		System.out.println(username);
		
//		<a href="author/${weibo.author}" target="_blank">
//		   <span style="font-size:15px;color:blue;">${weibo.author}</span>
//		</a>

		ModelAndView view = new ModelAndView("weibo");
		if (guanzhu!=""&&guanzhu!=null) {
			String names[] = guanzhu.split(" ");
			guanzhu = "";
			for(int i=0;i<names.length;i++){
				guanzhu = guanzhu+"<a href=\"author/" + names[i]+ "\"" + " target=\"_blank\">"
						+" <span style=\"font-size:15px;color:blue;\">"+names[i]+"</span></a>";
			}
		}
		view.addObject("guanzhu",guanzhu);
		view.addObject("weibo", weiBos);
		view.addObject("tuisong",tuisongWeibo);

		return view;
	}

	@RequestMapping(value = "/getWeiBoTendency", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiBoTendency(HttpServletRequest request, HttpSession session) {
		String lang = session.getAttribute("lang").toString();
		String result = entityService.getWeiBoTendency(lang);
		return result;
	}
	
	
	@RequestMapping(value = "/getWeiboContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiboContent(HttpServletRequest request,@PathVariable("id") int id) {


//		Integer weibo_id = new Integer(request.getParameter("weibo_id"));
//		List<News> newsContent = newsService.getNewsContent(weibo_id);
		return "ok";
	}
	
	@RequestMapping(value = "/getWeiFensi", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiFensi(HttpServletRequest request,HttpSession session){
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "cn";
		}
		JSONObject json = newsService.getWeiboFens(lang.toString());
		return json.toString();
	}
	
	@RequestMapping(value = "/guanzhu", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public void guanzhu(HttpServletRequest request,HttpSession session){
		
		String username = (String) session.getAttribute("username");
		String passwd = (String) session.getAttribute("passwd");
		
		Object follow = request.getParameter("follow");
		Object bozhu = request.getParameter("bozhu");
		
//		System.out.println(";;;;;;");
//		System.out.println(follow.toString());
//		System.out.println(bozhu.toString());
//		System.out.println(";;;;;");
		
		if (follow.toString().equals("yes")) {
			newsService.upYesFollow(username, passwd, bozhu.toString());
		}
		else {
			newsService.upNoFollow(username, passwd, bozhu.toString());
		}
		
	}
	
	
	@RequestMapping(value = "/author/{name}", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public ModelAndView getWeiAuthor(HttpServletRequest request,@PathVariable("name") String name,HttpSession session){
		ModelAndView view = new ModelAndView("weiboAuthor");
		
//		Object name = request.getAttribute("name");
//		System.out.println(name.toString());
		List<weiBo> list = newsService.getAuthorWeibo(name);
		view.addObject("name",name);
		view.addObject("weibo",list);
		
		return view;
	} 
	

}

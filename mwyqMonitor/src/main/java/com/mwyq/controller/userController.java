package com.mwyq.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.service.NewsService;
@RestController
public class userController extends HttpServlet{
	@Autowired
	private NewsService newsService = new NewsService();
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String username = req.getParameter("userName");
		String passwd = req.getParameter("password");
//		System.out.println("papapaapap");
//		System.out.println(username);
//		System.out.println(passwd);
//		System.out.println("papapaapap");
		
		req.getSession().setAttribute("username", username);
		req.getSession().setAttribute("passwd", passwd);
		resp.sendRedirect("/mwyqMonitor/main/");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}



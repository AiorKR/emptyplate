package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("todayController")
public class TodayController {
	
	public static Logger logger = LoggerFactory.getLogger(TodayController.class);
	
	@RequestMapping(value="/today/list")
	public String todayList(HttpServletRequest request, HttpServletResponse response)
	{
		return "/today/list";
	}
	
}

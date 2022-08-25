package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("helpController")
public class HelpController {
	
	private static Logger logger = LoggerFactory.getLogger(HelpController.class);
	
	@RequestMapping(value="/help/index")
	public String helpIndex(HttpServletRequest request, HttpServletResponse response)
	{
		return "/help/index";
	}
}

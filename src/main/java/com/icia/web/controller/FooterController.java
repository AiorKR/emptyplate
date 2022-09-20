package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("footerController")
public class FooterController {

	private static Logger logger = LoggerFactory.getLogger(FooterController.class);
	
	@RequestMapping(value="/footer/resources")
	public String resources(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/resources";
	}
	
	@RequestMapping(value="/footer/resources2")
	public String resources2(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/resources2";
	}
	
	@RequestMapping(value="/footer/resources3")
	public String resources3(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/resources3";
	}
	
	@RequestMapping(value="/footer/resources4")
	public String resources4(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/resources4";
	}
	
	@RequestMapping(value="/footer/aboutus")
	public String aboutus(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/aboutus";
	}
	
	@RequestMapping(value="/footer/company")
	public String company(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/company";
	}
	
	@RequestMapping(value="/footer/logohistory")
	public String logohistory(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/footer/logohistory";
	}
	
	
}

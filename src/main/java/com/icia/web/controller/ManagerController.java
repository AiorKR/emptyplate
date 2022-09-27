package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("managerController")
public class ManagerController {
	
	@RequestMapping(value="/manager/shopManage")
	public String shopManage(HttpServletRequest request, HttpServletResponse response){
		
		return "/manager/shopManage";
	}

}

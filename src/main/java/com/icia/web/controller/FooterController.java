package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Entry;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.EntryService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("footerController")
public class FooterController {

	private static Logger logger = LoggerFactory.getLogger(FooterController.class);
	
	//쿠키명
    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
	@Autowired
	private EntryService entryService;
	
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
	
	
	
	//입점문의폼
	@RequestMapping(value="/footer/regProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> entryReg(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		logger.debug("###############################");
		logger.debug("#작동중");
		logger.debug("###############################");
		String shopName = HttpUtil.get(request, "shopName");
		String userName = HttpUtil.get(request, "userName");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if(!StringUtil.isEmpty(shopName) && 
				!StringUtil.isEmpty(userName) &&
				!StringUtil.isEmpty(userPhone) && 
				!StringUtil.isEmpty(userEmail))
		{
			
				Entry entry = new Entry();
				
				entry.setShopName(shopName);
				entry.setUserName(userName);
				entry.setUserPhone(userPhone);
				entry.setUserEmail(userEmail);
				entry.setAgreement("Y");
				entry.setStatus("I");
				entry.setResultStatus("N");
				
				if(entryService.entryInsert(entry) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
		}
				
		
		
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[FooterController] /footer/resource4 response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		
		
				
		return ajaxResponse;
	}
}

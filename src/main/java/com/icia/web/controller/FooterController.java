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
	
	@Autowired
	private UserService userService;
	
	//개인정보처리방침
	@RequestMapping(value="/footer/privacy")
	public String privacy(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/privacy";
	}
	
	//서비스이용약관
	@RequestMapping(value="/footer/contract")
	public String contract(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
		
		return "/footer/contract";
	}
	
	//위치정보 이용약관
	@RequestMapping(value="/footer/location")
	public String location(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/location";
	}
	
	//입점문의
	@RequestMapping(value="/footer/launchingInquiry")
	public String launchingInquiry(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/launchingInquiry";
	}
	
	//aboutus
	@RequestMapping(value="/footer/aboutus")
	public String aboutus(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/aboutus";
	}
	
	//company
	@RequestMapping(value="/footer/company")
	public String company(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/company";
	}
	
	//logohistory
	@RequestMapping(value="/footer/logohistory")
	public String logohistory(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return "/footer/logohistory";
	}
	
	
	
	//입점문의폼
	@RequestMapping(value="/footer/regProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> entryReg(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
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
			logger.debug("[FooterController] /footer/launchingInquiry response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//상단 닉네임 불러오는 객체
		User userNickname = new User();
		userNickname = userService.userUIDSelect(cookieUserUID);
		if(userNickname != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", userNickname.getUserNick());
				model.addAttribute("adminStatus", userNickname.getAdminStatus());
				if(!StringUtil.isEmpty(userNickname.getBizName())&& !StringUtil.isEmpty(userNickname.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[BoardController] /board/list shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[BoardController] /board/list cookieUserNick NullPointerException", e);
			}
		}
				
		return ajaxResponse;
	}
}

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

import com.icia.web.model.Shop;
import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;

@Controller("managerController")
public class ManagerController {
	
	private static Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['board.upload.save.dir']}")
	private String BOARD_UPLOAD_SAVE_DIR;
	
	@RequestMapping(value="/manager/shopManage")
	public String shopManage(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userUIDSelect(cookieUserUID);
		Shop shop = shopService.shopUIDSelect(user.getUserUID());
				
		model.addAttribute("shop", shop);
		if(user != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user.getUserNick());
				model.addAttribute("adminStatus", user.getAdminStatus());
				if(user.getBizNum() != null)
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[HelpController] /help/index shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] /help/index cookieUserNick NullPointerException", e);
			}
		}
		
		
		return "/manager/shopManage";
	}

}

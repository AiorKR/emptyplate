package com.icia.web.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopTotalTable;
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
		Shop shop = shopService.shopUIDSelect(cookieUserUID);
		List<ShopTotalTable> list = shopService.shopCheckTable(shop);
		model.addAttribute("list", list);
		String address = "";
		if(shop.getShopLocation1() != null)
		{
			address = shop.getShopLocation1() + " " + shop.getShopLocation2() +" "+ shop.getShopAddress();
		}
		else
		{
			address = shop.getShopLocation2() + " " + shop.getShopAddress();
		}
		model.addAttribute("shop", shop);
		model.addAttribute("address", address);
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
						logger.error("[ManagerController] /manager/shopManage shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[ManagerController] /manager/shopManage cookieUserNick NullPointerException", e);
			}
		}
		
		
		return "/manager/shopManage";
	}
	
	@RequestMapping(value="/manager/shopUpdate")
	public String shopUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userUIDSelect(cookieUserUID);
		Shop shop = shopService.shopUIDSelect(cookieUserUID);
		String address = "";
		if(shop.getShopLocation1() != null)
		{
			address = shop.getShopLocation1() + " " + shop.getShopLocation2();
		}
		else
		{
			address = shop.getShopLocation2() + " ";
		}
		
		//요일출력
		String holiday = shop.getShopHoliday();
		String[] day = holiday.split(",");
		int i=0, j=0;
		for(i=0; i<day.length; i++)
		{
			for(j=StringUtil.stringToInteger(day[i],-1); j<7;j++)
			{
				model.addAttribute("day"+j, 1);
				break;
			}
		}
		
		//해시태그
		String hashTag = shop.getShopHashtag();
		String[] tag = hashTag.split("#");
		int x=0, y=0;
		for(i=0; i<tag.length; i++)
		{
			model.addAttribute("tag"+(i+1), tag[i]);
		}
		
		
		model.addAttribute("shop", shop);
		model.addAttribute("address", address);
		
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
						logger.error("[ManagerController] /manager/shopUpdate shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[ManagerController] /manager/shopUpdate cookieUserNick NullPointerException", e);
			}
		}
		
		
		return "/manager/shopUpdate";
	}
	
	
}

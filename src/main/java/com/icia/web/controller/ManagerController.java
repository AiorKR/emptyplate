package com.icia.web.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopMenu;
import com.icia.web.model.ShopTime;
import com.icia.web.model.ShopTotalTable;
import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

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
	@Value("#{env['shop.upload.save.dir']}")
	private String SHOP_UPLOAD_SAVE_DIR;
	
	@RequestMapping(value="/manager/shopManage")
	public String shopManage(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userUIDSelect(cookieUserUID);
		Shop shop = shopService.shopUIDSelect(cookieUserUID);
		String address = shop.getShopLocation1() + " " + shop.getShopAddress();
		
		//매장테이블 현황
		List<ShopTotalTable> tableList = shopService.shopCheckTable(shop.getShopUID());
		model.addAttribute("list1", tableList);
		
		//영업시간 현황
		List<ShopTime> timeList = shopService.shopCheckTime(shop.getShopUID());
		model.addAttribute("list2", timeList);
		
		//메뉴 현황
		List<ShopMenu> menuList = shopService.shopCheckMenu(shop.getShopUID());
		model.addAttribute("list3", menuList);
		
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
		
		String address = shop.getShopLocation1() + " " + shop.getShopAddress();
		model.addAttribute("address", address);
		
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
		List<String> list = new ArrayList<String>(Arrays.asList(tag));
		list.remove(0);
		logger.debug("# hashTag : " + hashTag);
		logger.debug("# tag : " + tag);
		logger.debug("# list : " + list);
		model.addAttribute("list", list);
		
		//매장테이블 현황
		List<ShopTotalTable> tableList = shopService.shopCheckTable(shop.getShopUID());
		model.addAttribute("list1", tableList);
		
		//영업시간 현황
		List<ShopTime> timeList = shopService.shopCheckTime(shop.getShopUID());
		model.addAttribute("list2", timeList);
		
		//메뉴 현황
		List<ShopMenu> menuList = shopService.shopCheckMenu(shop.getShopUID());
		model.addAttribute("list3", menuList);
		
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
	
	@RequestMapping(value="/manager/updateProc")
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse= new Response<Object>();
		
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		/***********
		 * 매장기본정보
		 ***********/
		//상호명
		String shopTitle = HttpUtil.get(request, "shopTitle", "");
		//매장 도로명 주소
		String shopLocation1 = HttpUtil.get(request, "shopLocation1", "");
		//매장 지번 주소
		String shopLocation2 = HttpUtil.get(request, "shopLocation2", "");
		//매장 상세주소
		String shopAddress = HttpUtil.get(request, "shopAddress", "");
		//매장 상세주소
		String shopTelephone = HttpUtil.get(request, "shopTelephone", "");
		//매장 형태
		char shopType = HttpUtil.get(request, "shopType", "").charAt(0);
		/***********
		 * 소개글
		 ***********/
		/***********
		 * 매장추가정보
		 ***********/
		/***********
		 * 첨부파일
		 ***********/
		//첨부파일
		FileData fileData = HttpUtil.getFile(request, "shopFile", SHOP_UPLOAD_SAVE_DIR);
		
		return ajaxResponse;
	}
}

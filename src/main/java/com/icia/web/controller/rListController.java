package com.icia.web.controller;

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


import com.icia.web.model.Order;
import com.icia.web.model.Paging;
import com.icia.web.model.User;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("rListController")
public class RListController
{
	private static Logger logger = LoggerFactory.getLogger(RListController.class);
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private UserService userService;
	
	private static final int LIST_COUNT = 5;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
	
	
	
	//페이지
	@RequestMapping(value="/myPage/rList")
	public String rList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//조회 객체
		Order order = new Order();
		User user = new User();
		String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		user = userService.userUIDSelect(userUID);
	    model.addAttribute("user", user);
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Order> list = null;
		//페이징 객체
		Paging paging = null;
		
		totalCount = shopService.myOrderListCount(userUID);
		
		if(totalCount > 0)
		{
			paging = new Paging("/myPage/rList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("curPage", curPage);
			
			order.setStartRow(paging.getStartRow());
			order.setEndRow(paging.getEndRow());

			
			list = shopService.myOrderList(userUID);
		}
		logger.debug("list size() : " + list.size());
		for(int i=0; i < list.size(); i++)
		{
			logger.debug("list.MenuSize size() : " + list.get(i).getOrderMenu().size());
			
			for(int j=0; j < list.get(i).getOrderMenu().size(); j++)
			{
				logger.debug("이름 : " + list.get(i).getOrderMenu().get(j).getOrderMenuName());
				logger.debug("수량 : " + list.get(i).getOrderMenu().get(j).getOrderMenuQuantity());
			}
		}
		
		
		for(int i=0; i < list.size(); i++)
		{
			String shopName = list.get(i).getShopName();
			if(shopName.length() > 9)
			{
				String dot = "..";
				String subShopName = shopName.substring(1, 9);
				String shopName2 = subShopName += dot;
				list.get(i).setShopName(shopName2);
			}
			logger.debug("여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기 : " + list.get(i).getShopName());
		}
		
	
		
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/myPage/rList";
	}
}
   
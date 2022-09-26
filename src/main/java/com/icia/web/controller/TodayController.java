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
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Order;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.User;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("todayController")
public class TodayController {
	
	public static Logger logger = LoggerFactory.getLogger(TodayController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	//파일 저장 경로
	@Value("#{env['shop.upload.image.dir']}")
	private String SHOP_UPLOAD_IMAGE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	private static final int LIST_COUNT = 9;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
	
	@RequestMapping(value="/today/list")
	public String todayList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//조회항목
		String searchType = HttpUtil.get(request, "searchType");
		
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//총 게시물 수
		long totalCount = 0;
		
		//게시물 리스트
		List<Order> list = null;
		
		//페이징 객체
		Paging paging = null;
		
		//조회 객체
		Shop search = new Shop();
		

		if(StringUtil.equals(searchType, "1") || StringUtil.equals(searchType, "2")) { // 1: 파인다이닝 2:오마카세
			
			search.setSearchType(searchType);
		}
		else { //searchType을 선택 안했거나 또는 값이 이상한 경우는 무족건 0: 전체 로 고정
			search.setSearchType("0");
		}
		
		if(!StringUtil.isEmpty(searchValue) && !StringUtil.equals(searchValue, "")) { //검색 값이 있냐 또는 공백이냐를 체크
			search.setSearchValue(searchValue);
		}
		
		totalCount = shopService.todayListCount();
		
		if(totalCount > 0)
		{	
			paging = new Paging("/today/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());

			list = shopService.todayList("");
		}
			model.addAttribute("list", list);
		
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		if(user2 != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user2.getUserNick());
			}
			catch(NullPointerException e2)
			{
				logger.error("[ShopController] reservation/list NullPointerException", e2);
			}
		}
		
		return "/today/list";
	}
	
	@RequestMapping(value="/today/viewProc")
	@ResponseBody
	public Response<Object> todayViewProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajax = new Response<Object>();
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String shopUID = HttpUtil.get(request, "shopUID");
		
		if(!StringUtil.isEmpty(cookieUserUID)) {
			if(!StringUtil.isEmpty(shopUID)) {
				List<Order> list = shopService.todayList(shopUID);
				if(list != null) {
					ajax.setResponse(0, "success", list);
				}
				else {
					ajax.setResponse(-999, "list is null");
				}
			}
			else {
				ajax.setResponse(404, "shopUId is empty");
			}
		}
		else {
			ajax.setResponse(403, "cookie is empty");
		}
		
		return ajax;
	}
	
}

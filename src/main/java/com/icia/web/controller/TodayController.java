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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Shop;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
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
	
	private static final int LIST_COUNT = 3;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
	
	@RequestMapping(value="/today/list")
	public String todayList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String searchType = HttpUtil.get(request, "searchType");
		
		String searchValue = HttpUtil.get(request, "searchValue");
		
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		long totalCount = 0;
		
		List<Shop> list = null;
		
		Paging paging = null;
		
		String reservationDate = HttpUtil.get(request, "reservationDate");
		
		String reservationTime = HttpUtil.get(request, "reservationTime");
		
		Shop search = new Shop();
		
		if(StringUtil.equals(searchType, "1") || StringUtil.equals(searchType, "2")) {
			search.setSearchType(searchType);
		}
		else {
			search.setSearchType("0");
		}
		
		if(!StringUtil.isEmpty(searchValue) && !StringUtil.equals(searchValue, "")) { //검색 값이 있냐 또는 공백이냐를 체크
			search.setSearchValue(searchValue);
		}
		
		totalCount = shopService.shopListCount(search);
		
		if(totalCount > 0)
		{
			paging = new Paging("/today/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			paging.addParam("reservationDate", reservationDate);
			paging.addParam("reservationTime", reservationTime);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			logger.debug("starRow : " + search.getStartRow());
			logger.debug("endRow : " + search.getEndRow());
			
			list = shopService.shopList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/today/list";
	}
	
}

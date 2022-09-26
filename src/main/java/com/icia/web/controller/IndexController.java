/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
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
import org.springframework.web.bind.annotation.RequestMethod;

import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.User;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;



/**
 * <pre>
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * 설명       : 인덱스 컨트롤러
 * </pre>
 */
@Controller("indexController")
public class IndexController
{
	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	/**
	 * <pre>
	 * 메소드명   : index
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 인덱스 페이지 
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		Shop shop = new Shop();
		ShopFile shopFile = new ShopFile();
		List<Shop> recommand= shopService.indexShopList(shop);
		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		shopFile.setShopFileSeq(0);
		logger.debug("####################");
		logger.debug("#" + recommand.get(0).getShopFile().getShopFileExt());
		logger.debug("#" + recommand.get(0).getShopFile().getShopFileName());
		logger.debug("#" + recommand.get(0).getShopFile().getShopFileOrgName());
		logger.debug("#" + recommand.get(0).getShopFile().getShopFileRegDate());
		logger.debug("####################");
		
		model.addAttribute("recommand", recommand);
		if(user2 == null)
		{
			return "/index";
		}
		else
		{
			try
			{
				model.addAttribute("cookieUserNick", user2.getUserNick());
			}
			catch(NullPointerException e)
			{
				logger.error("[IndexController] index Exception", e);
			}
			return "/index";
		}
		
		
	}
}

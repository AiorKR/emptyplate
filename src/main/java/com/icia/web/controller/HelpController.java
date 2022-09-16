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

import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;

@Controller("helpController")
public class HelpController {
	
	private static Logger logger = LoggerFactory.getLogger(HelpController.class);
	
	@Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
   
    //파일 저장 경로
    @Value("#{env['user.upload.save.dir']}")
    private String UPLOAD_SAVE_DIR;
   
    @Autowired
    private UserService userService;
    
	@RequestMapping(value="/help/index")
	public String helpIndex(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	       User user = null;
	      
	      user = userService.userUIDSelect(userUID);
	              
	      model.addAttribute("user", user);
		
		return "/help/index";
	}
}

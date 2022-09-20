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

import com.icia.web.model.User;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;

@Controller("rListController")
public class rListController 
{
   private static Logger logger = LoggerFactory.getLogger(rListController.class);
   
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   @Autowired
   private UserService userService;
   
  

   @RequestMapping(value="/rList/rList", method=RequestMethod.GET)
   public String myProfile(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       User user = null;
      
      user = userService.userUIDSelect(userUID);
              
      model.addAttribute("user", user);
      User user2 = new User();
      user2 = userService.userUIDSelect(userUID);
      model.addAttribute("cookieUserNick", user2.getUserNick());
      
      return "/rList/rList";
   }
    
}   
   
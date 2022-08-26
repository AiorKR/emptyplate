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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("myPageController")
public class MyPageController {
   
   public static Logger logger = LoggerFactory.getLogger(TodayController.class);
   
    //쿠키명
    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
   
    //파일 저장 경로
    @Value("#{env['upload.save.dir']}")
    private String UPLOAD_SAVE_DIR;
   
    @Autowired
    private UserService userService;
   
    
    //페이지로드
   @RequestMapping(value="/myPage/myProfile", method=RequestMethod.GET)
   public String myProfile(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       User user = null;
      
      user = userService.userUIDSelect(userUID);
              
      model.addAttribute("user", user);
      
      return "/myPage/myProfile";
   }
   
   //팝업로드
   
   @RequestMapping(value="/myPage/nick_popup", method=RequestMethod.GET)
   public String nick_popup(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       User user = null;
      
      user = userService.userUIDSelect(userUID);
              
      model.addAttribute("user", user);
      
      return "/myPage/nick_popup";
   }
}
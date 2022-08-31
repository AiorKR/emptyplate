package com.icia.web.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("userController")
public class UserController 
{
   private static Logger logger = LoggerFactory.getLogger(UserController.class);
   
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   @Autowired
   private UserService userService;
   
   //로그인페이지
   @RequestMapping(value = "/user/login", method=RequestMethod.GET)
   public String login(HttpServletRequest request, HttpServletResponse response)
   {
      return "/user/login";
   }
   
   //회원가입페이지
   @RequestMapping(value = "/user/joinUs", method=RequestMethod.GET)
   public String joinUs(HttpServletRequest request, HttpServletResponse response)
   {
      return "/user/joinUs";
   }
   
   //매장회원가입페이지
   @RequestMapping(value = "/user/storeJoinUs", method=RequestMethod.GET)
   public String storeJoinUs(HttpServletRequest request, HttpServletResponse response)
   {
      return "/user/storeJoinUs";
   }

   //로그인
   @RequestMapping(value="/user/loginOk", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> loginOk(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String userId = HttpUtil.get(request, "userId");
      String userPwd = HttpUtil.get(request, "userPwd");
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
      {
         User user = userService.userSelect(userId);
         
         if(user != null)
         {
            if(StringUtil.equals(user.getUserPwd(), userPwd))
            {
               String userUID = user.getUserUID();
               CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userUID));
               ajaxResponse.setResponse(0, "Success");
            }
            else
            {
               ajaxResponse.setResponse(-1, "Passwords do not match");
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "Not Found");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
       if(logger.isDebugEnabled())
       {
          logger.debug("[UserController] /user/login response\n" + JsonUtil.toJsonPretty(ajaxResponse));
       }
       
      return ajaxResponse;
   }
 
   //로그아웃
   @RequestMapping(value="/user/loginOut", method=RequestMethod.GET)
   public String loginOut(HttpServletRequest request, HttpServletResponse response)
   {
      logger.debug("=================================");
      logger.debug("logOutStart======================");
      logger.debug("=================================");
      if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
      {
         CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
      }
      
      return "redirect:/";
   }
   
 //아이디중복체크
   @RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request,  "userId");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId))
      {
         if(userService.userSelect(userId) == null)
         {
            ajaxResponse.setResponse(0, "Success");
         }
         else
         {
            ajaxResponse.setResponse(100, "Bad Request");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      if(logger.isDebugEnabled())
          {
             logger.debug("[UserController] /user/idCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
          }
      
      return ajaxResponse;
   }
   
   //회원가입
   @RequestMapping(value="/user/regProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String userUID = UUID.randomUUID().toString();  //uuid생성
      String userId = HttpUtil.get(request, "userId");
      String userPwd = HttpUtil.get(request, "userPwd");
      String userName = HttpUtil.get(request, "userName");
      String userEmail = HttpUtil.get(request, "userEmail");
      String userPhone = HttpUtil.get(request, "userPhone");
      String userNick = HttpUtil.get(request, "userNick");
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPhone))
      {
         if(userService.userSelect(userUID) == null)
         {
            User user = new User();
            
            
              
            user.setUserUID(userUID);   
            user.setUserId(userId);
            user.setUserPwd(userPwd);
            user.setUserName(userName);
            user.setUserEmail(userEmail);
            user.setUserPhone(userPhone);
            user.setStatus("Y");
            user.setAdminStatus("N");
            user.setUserNick(userNick);
              
              
               if(userService.userInsert(user) > 0)
               {
                  ajaxResponse.setResponse(0, "Success");
               }
               else
               {
                  ajaxResponse.setResponse(500, "Internal Server Error");
               }
            }
            else
            {
               ajaxResponse.setResponse(100, "duplikcate id");
            }
         }
         else
         {
            ajaxResponse.setResponse(400, "Bad Request");
         }
         
         if(logger.isDebugEnabled())
          {
            logger.debug("[UserController] /user/userInsert response\n" + JsonUtil.toJsonPretty(ajaxResponse));
          }
         
         return ajaxResponse;
   }
}   
   
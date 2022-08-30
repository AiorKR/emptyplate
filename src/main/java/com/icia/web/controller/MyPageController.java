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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("myPageController")
public class MyPageController {
   
   public static Logger logger = LoggerFactory.getLogger(MyPageController.class);
   
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
   
   //닉네임 팝업로드
   @RequestMapping(value="/myPage/nick_popup", method=RequestMethod.GET)
   public String nick_popup(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       User user = null;
      
      user = userService.userUIDSelect(userUID);
              
      model.addAttribute("user", user);
      
      return "/myPage/nick_popup";
   }
   
   
   //닉네임 수정
   @RequestMapping(value="/user/NickUpdate", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> Nickupdate(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String userNick = HttpUtil.get(request, "userNick");
	   
	   if(!StringUtil.isEmpty(userUID))
	   {
		   User user = userService.userUIDSelect(userUID);
		   if(user != null)
		   {
			   String userPwd = user.getUserPwd();
			   String userPhone = user.getUserPhone();
			   String userName = user.getUserName();
			   String userEmail = user.getUserEmail();
			   if(StringUtil.equals(user.getStatus(), "Y"))
			   {
				   if(!StringUtil.isEmpty(userNick))
				   {  
					   user.setUserPwd(userPwd);
					   user.setUserPhone(userPhone);
					   user.setUserName(userName);
					   user.setUserEmail(userEmail);
					   user.setUserNick(userNick);
					   if(userService.userUpdate(user) > 0)
					   {
						   ajaxResponse.setResponse(0, "Success");
					   }
					   else
					   {
						   ajaxResponse.setResponse(500, "Internal server error");
					   }
				   }
				   else
				   {
					   ajaxResponse.setResponse(400, "Bad Request");
				   }
			   }
			   else
			   {
				   //정지된 사용자
				   CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
				   ajaxResponse.setResponse(404, "Not Found");
			   }
		   }
		   else
		   {	
			   //사용자 정보가 없을 때 쿠키 삭제
			   CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	
	   }
		   return ajaxResponse;   
   	}
   
   
   
   //이메일 팝업로드
   @RequestMapping(value="/myPage/email_popup", method=RequestMethod.GET)
   public String email_popup(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       User user = null;
      
      user = userService.userUIDSelect(userUID);
              
      model.addAttribute("user", user);
      
      return "/myPage/email_popup";
   }
   
   
   //이메일 수정
   @RequestMapping(value="/user/EmailUpdate", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String userEmail = HttpUtil.get(request, "userEmail");
	   if(!StringUtil.isEmpty(userUID))
	   {
		   User user = userService.userUIDSelect(userUID);
		   if(user != null)
		   {
			   String userPwd = user.getUserPwd();
			   String userPhone = user.getUserPhone();
			   String userName = user.getUserName();
			   String userNick = user.getUserNick();
			   if(StringUtil.equals(user.getStatus(), "Y"))
			   {
				   if(!StringUtil.isEmpty(userEmail))
				   {  
					   user.setUserPwd(userPwd);
					   user.setUserPhone(userPhone);
					   user.setUserName(userName);
					   user.setUserEmail(userEmail);
					   user.setUserNick(userNick);
					   if(userService.userUpdate(user) > 0)
					   {
						   ajaxResponse.setResponse(0, "Success");
					   }
					   else
					   {
						   ajaxResponse.setResponse(500, "Internal server error");
					   }
				   }
				   else
				   {
					   ajaxResponse.setResponse(400, "Bad Request");
				   }
			   }
			   else
			   {
				   //정지된 사용자
				   CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
				   ajaxResponse.setResponse(404, "Not Found");
			   }
		   }
		   else
		   {	
			   //사용자 정보가 없을 때 쿠키 삭제
			   CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	
	   }
		   return ajaxResponse;   
   	}
   
   
   
   	//회원 탈퇴
 	@RequestMapping(value="/myPage/userDelete", method=RequestMethod.POST)
 	@ResponseBody
 	   public Response<Object> userDelete(HttpServletRequest request, HttpServletResponse response)
 	   {
 		   Response<Object> ajaxResponse = new Response<Object>();
 		   String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
 	       User user = null;
 	      
 	       user = userService.userUIDSelect(userUID);
 		   
 		   if(user != null)
 		   { 
 			   if(userService.userDelete(user) > 0)
 			   {
 				  CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
 				   ajaxResponse.setResponse(0, "Success");
 			   }
 			   else
 			   {
 				   ajaxResponse.setResponse(500, "Internal server error");
 			   }  				  
 		   }
 		   else
 		   {	
 			   //사용자 정보가 없을 때 쿠키 삭제
 			  CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
 			   ajaxResponse.setResponse(404, "Not Found");
 		   }
 	   
 	   
 	   if(logger.isDebugEnabled())
        {
          logger.debug("[UserController] /myPage/userDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
        }
 	   
 	   return ajaxResponse;
    }
}
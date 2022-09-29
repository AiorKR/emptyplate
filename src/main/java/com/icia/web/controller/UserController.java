package com.icia.web.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.User;
import com.icia.web.service.ShopService;
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
   
   @Autowired
   private ShopService shopService;
   
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
               if(StringUtil.equals(user.getStatus(), "Y"))
	            {	
            	   	String userUID = user.getUserUID();
	               	CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userUID));
	               	ajaxResponse.setResponse(0, "Success");
            	}
               else
               {
            	   ajaxResponse.setResponse(403, "Not Found");
               }
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
   
   //아이디 중복체크
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
        	 ajaxResponse.setResponse(100, "duplikcate Id");
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
      String userNick = HttpUtil.get(request, "userNick");
      String userPhone = (String) session.getAttribute("userPhone");
      
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
            	  session.removeAttribute("userPhone");
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

 //매장관리자회원가입
   @RequestMapping(value="/user/regManProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> regManProc(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String userUID = UUID.randomUUID().toString();  //uuid생성
      String userId = HttpUtil.get(request, "userId");
      String userPwd = HttpUtil.get(request, "userPwd");
      String userName = HttpUtil.get(request, "userName");
      String userEmail = HttpUtil.get(request, "userEmail");
      String userNick = HttpUtil.get(request, "userNick");
      String userPhone = (String) session.getAttribute("userPhone");
      String bizNum = HttpUtil.get(request, "bizNum");
      String bizName = HttpUtil.get(request, "bizName");
      String accessNum = HttpUtil.get(request, "accessNum"); 
      String shopUID = accessNum;
      
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
	           user.setAdminStatus("Y");
	           user.setUserNick(userNick);
	           user.setBizNum(bizNum);
	           user.setBizName(bizName);
	           
               if(userService.userInsert(user) > 0)
               {
            	  session.removeAttribute("userPhone");
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
     
     //회원가입 절차 후 Shop테이블 userUID컬럼에 값 업데이트해주기
     Shop shop = shopService.shopUIDSelect(shopUID);
     User user = userService.userUIDSelect(userUID);
     
     if(shop != null && user != null) 
	 {
		 shop.setUserUID(user.getUserUID());
		 if(shopService.updateStoreUserUID(shop) > 0)
		 {
			 logger.debug("성공");
		 }
		 else
		 {
			 logger.debug("업뎃실패");
		 }
	 }
	 else
	 {
		 logger.debug("객체없음");
	 }
 
      return ajaxResponse;  
   }
   
   //매장관리자 인증번호 확인
   @RequestMapping(value="/user/accessNumChk", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> accessNumChk(HttpServletRequest request, HttpServletResponse response)
   {
	  Response<Object> ajaxResponse = new Response<Object>();
	  String accessNum = HttpUtil.get(request, "accessNum");
	  
	  if(!StringUtil.isEmpty(accessNum))
	  {
		  if(shopService.shopUIDSelect(accessNum) != null) 
		  {  
			  ajaxResponse.setResponse(0, "susccess");
		  }		  
		  else
		  {
			  ajaxResponse.setResponse(100, "do not match");
		  }
	  }
	  else
	  {
		  ajaxResponse.setResponse(400, "accessNum is Null");
	  }
	  return ajaxResponse;
   }
   
   //사업자번호 상태조회 팝업
   @RequestMapping(value="/user/bizNumPopup", method=RequestMethod.GET)
	public String bizNumPopup(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/bizNumPopup";
	}
   
   //약관동의 팝업
   @RequestMapping(value="/user/signUpPopUp", method=RequestMethod.GET)
   public String signUpPopUp(HttpServletRequest request, HttpServletResponse response)
   {
      return "/user/signUpPopUp";
   }
   
   //문자인증
   HttpSession session;
   @ModelAttribute
	void init(HttpServletRequest request, Model model) {
		
		this.session = request.getSession();
	}
   
   @PostMapping("/user/sendSms")
   @ResponseBody
   public Response<Object> sendSms(HttpServletRequest request, HttpServletResponse response)
   {
	  String userPhone = HttpUtil.get(request, "tel");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userPhone))
      {
         if(userService.userPhoneSelect(userPhone) == null)
         {        	       	 
        	 String code = userService.sendRandomMessage(userPhone);
        	 session.setAttribute("numStr", code);	 
        	 ajaxResponse.setResponse(0, "Success");	
         } 
         else
         {
        	 ajaxResponse.setResponse(100, "duplikcate phone");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      if(logger.isDebugEnabled())
          {
             logger.debug("[UserController] /user/poneChk response\n" + JsonUtil.toJsonPretty(ajaxResponse));
          }
      
      return ajaxResponse;
   }
   
   //회원가입용
   @PostMapping("/user/sendSms4")
   @ResponseBody
   public Response<Object> sendSms4(HttpServletRequest request, HttpServletResponse response)
   {
	  String userPhone = HttpUtil.get(request, "tel");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userPhone))
      {
         if(userService.userPhoneSelect(userPhone) == null)
         {        	       	 
        	 String code = userService.sendRandomMessage(userPhone);
        	 session.setAttribute("numStr", code);
        	 session.setAttribute("userPhone", userPhone);
        	 ajaxResponse.setResponse(0, "Success");	
         } 
         else
         {
        	 ajaxResponse.setResponse(100, "duplikcate phone");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      if(logger.isDebugEnabled())
          {
             logger.debug("[UserController] /user/poneChk response\n" + JsonUtil.toJsonPretty(ajaxResponse));
          }
      
      return ajaxResponse;
   }
   
	@PostMapping("/user/sendSmsOk")
   	@ResponseBody
   	public Response<Object> sendSmsOk(HttpServletRequest request) {
		Response<Object> ajaxResponse = new Response<Object>();
		String code1 = (String) session.getAttribute("numStr");
   	    String code = (String) request.getParameter("code");

   	    System.out.println(code1 + " : " + code);

   	    if (code1.equals(code)) {
   	        session.removeAttribute("numStr");
   	        ajaxResponse.setResponse(0, "Success");	
   	    } 
   	    else {
   	    ajaxResponse.setResponse(100, "not equal phone");
   	    }
   	    return ajaxResponse;
   	}
   	
	//비밀번호 변경용 문자인증
	@PostMapping("/user/sendSms2")
	   @ResponseBody
	   public Response<Object> sendSms2(HttpServletRequest request, HttpServletResponse response)
	   {
		  String userUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		  String userPhone = HttpUtil.get(request, "tel");
		  User user = userService.userUIDSelect(userUID);
	      Response<Object> ajaxResponse = new Response<Object>();
	      String phone = user.getUserPhone();
	      if(!StringUtil.isEmpty(userPhone))
	      {
	         if(StringUtil.equals(phone, userPhone))
	         {        	       	 
	        	 String code = userService.sendRandomMessage(userPhone);
	        	 session.setAttribute("numStr", code);	 
	        	 ajaxResponse.setResponse(0, "Success");	
	         } 
	         else
	         {
	        	 ajaxResponse.setResponse(100, "duplikcate phone");
	         }
	      }
	      else
	      {
	         ajaxResponse.setResponse(400, "Bad Request");
	      }
	      
	      if(logger.isDebugEnabled())
	          {
	             logger.debug("[UserController] /user/poneChk response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	          }
	      
	      return ajaxResponse;
	   }
   
	
	//비밀번호찾기 팝업
	@RequestMapping(value="/user/pwdSearch_popup", method=RequestMethod.GET)
	public String pwdSearch_popup(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/pwdSearch_popup";
	}
   
	
	//비밀번호 찾기용 문자인증
	@PostMapping("/user/sendSms3")
	@ResponseBody
	   public Response<Object> sendSms3(HttpServletRequest request, HttpServletResponse response)
	   {
		  String userPhone = HttpUtil.get(request, "tel");
		  String userId = HttpUtil.get(request, "userId");
	      Response<Object> ajaxResponse = new Response<Object>();
	      User user = userService.userSelect(userId);
	      if(!StringUtil.isEmpty(user))
	      {
	    	 String phone = user.getUserPhone();
	         if(StringUtil.equals(phone, userPhone))
	         {        	       	 
	        	 String code = userService.sendRandomMessage(userPhone);
	        	 session.setAttribute("numStr", code);
	        	 session.setAttribute("userId", userId);
	        	 ajaxResponse.setResponse(0, "Success");	
	         } 
	         else
	         {
	        	 ajaxResponse.setResponse(100, "duplikcate phone");
	         }
	      }
	      else
	      {
	         ajaxResponse.setResponse(400, "Bad Request");
	      }
	      
	      if(logger.isDebugEnabled())
	          {
	             logger.debug("[UserController] /user/poneChk response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	          }
	      
	      return ajaxResponse;
	   }
	
	//비밀번호 수정
    @RequestMapping(value="/user/PwdUpdate", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> PwdUpdate(HttpServletRequest request, HttpServletResponse response)
    {
 	   Response<Object> ajaxResponse = new Response<Object>();
 	   String userPwd = HttpUtil.get(request, "userPwd");
 	   String userId = (String) session.getAttribute("userId");
 	   session.removeAttribute("userId");
 	   
 	   if(!StringUtil.isEmpty(userId))
 	   {
 		   User user = userService.userSelect(userId);
 		   if(user != null)
 		   {
 			   String userPhone = user.getUserPhone();
 			   String userNick = user.getUserNick();
 			   String userName = user.getUserName();
 			   String userEmail = user.getUserEmail();
 			   if(StringUtil.equals(user.getStatus(), "Y"))
 			   {
 				   if(!StringUtil.isEmpty(userPhone))
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
    
    
    
    //카카오셋
    @RequestMapping(value="/user/kakaoSet", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> kakoSet(HttpServletRequest request, HttpServletResponse response)
    {
 	   Response<Object> ajaxResponse = new Response<Object>();
 	   String kuserId = HttpUtil.get(request, "userId");
 	   String kuserPwd = HttpUtil.get(request, "userPwd");
 	   String kuserEmail = HttpUtil.get(request, "userEmail");
 	   String kuserNick = HttpUtil.get(request, "userNick");
 	   session.setAttribute("userId", kuserId);
 	   session.setAttribute("userPwd", kuserPwd);
 	   session.setAttribute("userEmail", kuserEmail);
 	   session.setAttribute("userNick", kuserNick);
 	   String userId = (String) session.getAttribute("userId");
 	   if(!StringUtil.isEmpty(userId))
 	   {
 		  ajaxResponse.setResponse(0, "success");
 	   }	   
 	   else
 	   {
 		   ajaxResponse.setResponse(400, "Bad Request");
 	   }	  
 	   return ajaxResponse;   
   }
    
    
  //카카오 팝업
  	@RequestMapping(value="/user/kakao_popup", method=RequestMethod.GET)
  	public String kakao_popup(HttpServletRequest request, HttpServletResponse response)
  	{
  		return "/user/kakao_popup";
  	}
  	
  //카카오 회원가입
    @RequestMapping(value="/user/kakaoProc", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> kakaoProc(HttpServletRequest request, HttpServletResponse response)
    {
       Response<Object> ajaxResponse = new Response<Object>();
       String userUID = UUID.randomUUID().toString();  //uuid생성
       
       String userId = (String) session.getAttribute("userId");
       String userPwd = (String) session.getAttribute("userPwd");
       String userEmail = (String) session.getAttribute("userEmail");
       String userNick = (String) session.getAttribute("userNick");
       String userName = HttpUtil.get(request, "userName");
       String userPhone = HttpUtil.get(request, "userPhone");
       
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
            ajaxResponse.setResponse(100, "duplikcate Uid");
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
    
  //카카오 최초 로그인
    @RequestMapping(value="/user/kloginOk", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> kloginOk(HttpServletRequest request, HttpServletResponse response)
    {
       Response<Object> ajaxResponse = new Response<Object>();
       
       String userPwd = HttpUtil.get(request, "userPwd");
       String userId = (String) session.getAttribute("userId");
       if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
       {
          User user = userService.userSelect(userId);
          
          if(user != null)
          {
             if(StringUtil.equals(user.getUserPwd(), userPwd))
             {
                if(StringUtil.equals(user.getStatus(), "Y"))
 	            {	
             	   	String userUID = user.getUserUID();
 	               	CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userUID));
 	               	ajaxResponse.setResponse(0, "Success");
             	}
                else
                {
             	   ajaxResponse.setResponse(403, "Not Found");
                }
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
       session.removeAttribute("userId");
       session.removeAttribute("userPwd");
       session.removeAttribute("userEmail");
       session.removeAttribute("userNick");
       return ajaxResponse;
    }
    
  //문자인증 팝업로드
    @RequestMapping(value="/user/phone_popup", method=RequestMethod.GET)
    public String phone_popup(HttpServletRequest request, HttpServletResponse response)
    {          
        return "/user/phone_popup";
    }
    
}   
   
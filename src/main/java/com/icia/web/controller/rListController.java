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
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.ShopReview;
import com.icia.web.model.User;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("rListController")
public class rListController
{
   private static Logger logger = LoggerFactory.getLogger(rListController.class);
   //쿠키명 지정
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   @Autowired
   private ShopService shopService;
   
   @Autowired
   private UserService userService;
   
   private static final int LIST_COUNT = 5;   //게시물 수
   private static final int PAGE_COUNT = 5;   //페이징 수
   
   
   
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
      List<OrderMenu> list2 = null;
      //페이징 객체
      Paging paging = null;
      
      totalCount = shopService.myOrderListCount(userUID);
      
      if(totalCount > 0)
      {
         paging = new Paging("/myPage/rList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         paging.addParam("curPage", curPage);
         
         order.setStartRow(paging.getStartRow());
         order.setEndRow(paging.getEndRow());
         order.setUserUID(userUID);
         
         list = shopService.myOrderList(order);
      }
      if(list != null)
      {
         logger.debug("list size() : " + list.size());
   
         for(int i=0; i < list.size(); i++)
         {   
            String orderUID = "";
            String om = "";
            String oq = "";
            String finalMenu = "";
            Double shopScore = 0.0;
            orderUID = list.get(i).getOrderUID();
            logger.debug("orderUID : " + orderUID);
            shopScore = list.get(i).getShopScore();
            logger.debug("++++++++++++++++" + shopScore);
            list2 = shopService.myOrderMenu(orderUID);
            for(int j=0; j < list2.size(); j++)
            {
               om = list2.get(j).getOrderMenuName();
               oq = Integer.toString(list2.get(j).getOrderMenuQuantity());
               finalMenu += om + "(" + oq + ")";
               
               if(j < (list2.size() -1)) {
                  finalMenu += ", ";
               }
            }
            list.get(i).setFinalMenu(finalMenu); 
         }
   
         
         for(int i=0; i < list.size(); i++)
         {
            String shopName = list.get(i).getShopName();
            if(shopName.length() > 9)
            {
               String dot = "..";
               String subShopName = shopName.substring(0, 9);
               String shopName2 = subShopName += dot;
               list.get(i).setShopName(shopName2);
            }
            logger.debug("+++++++++++++++++++++++++++++ : " + list.get(i).getShopName());
         }
      
      }
      
      //닉넴띄우기
      User user2 = new User();
      user2 = userService.userUIDSelect(userUID);
      model.addAttribute("cookieUserNick", user2.getUserNick());
      
      model.addAttribute("list", list);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      
      return "/myPage/rList";
   }
   
   //한줄평 등록
   @RequestMapping(value="/myPage/regReqOne")
   @ResponseBody
   public Response<Object> regReqOne(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String orderUID = HttpUtil.get(request, "orderUID");
      String shopUID = HttpUtil.get(request, "shopUID");
      String reviewScore = HttpUtil.get(request, "reviewScore");
      String shopReviewContent = HttpUtil.get(request, "reviewContent");
      double shopScore = Double.parseDouble(reviewScore);
      
      ShopReview shopReview = new ShopReview();
      if(!StringUtil.isEmpty(cookieUserUID)) 
      {
	      shopReview.setUserUID(cookieUserUID);
	      shopReview.setOrderUID(orderUID);
	      shopReview.setShopUID(shopUID);
	      shopReview.setShopScore(shopScore);
	      shopReview.setShopReviewContent(shopReviewContent);
	      
	      if(shopService.countReqOne(shopReview) == 0)
	      {
	    	  shopService.regReqOne(shopReview);
	    	  ajaxResponse.setResponse(0, "success");
	      }
	      else if(shopService.countReqOne(shopReview) == 1)
	      {
	    	  shopService.updateReqOne(shopReview);
	    	  ajaxResponse.setResponse(-1, "proc success");
	      }
	      else
	      {
	    	  ajaxResponse.setResponse(404, "error");
	      }
      }
      else
      {
    	  ajaxResponse.setResponse(400, "not Found");
      }
      

      return ajaxResponse;
   }
   
   
   //한줄평 삭제
   @RequestMapping(value="/myPage/delReqOne")
   @ResponseBody
   public Response<Object> delReqOne(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String orderUID = HttpUtil.get(request, "orderUID");
      
      ShopReview shopReview = new ShopReview();
      if(!StringUtil.isEmpty(cookieUserUID)) 
      {
	      shopReview.setUserUID(cookieUserUID);
	      shopReview.setOrderUID(orderUID);
	      
	      if(shopService.delReqOne(shopReview) > 0)
	      {
	    	  ajaxResponse.setResponse(0, "success");
	      }
	      else
	      {
	    	  ajaxResponse.setResponse(404, "error");
	      }
      }
      else
      {
    	  ajaxResponse.setResponse(400, "not Found");
      }
      

      return ajaxResponse;
   }
   
}
   
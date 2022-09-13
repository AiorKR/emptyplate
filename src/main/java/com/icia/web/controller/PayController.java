package com.icia.web.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Order;
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.Toss;
import com.icia.web.model.User;
import com.icia.web.service.PayService;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("payController")
public class PayController {
	
	private static Logger logger = LoggerFactory.getLogger(PayController.class);
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//통신할 기본 호스트 주소
	@Value("#{env['toss.host']}")
	private String TOSS_HOST;
	
	//시크릿키 (카카오페이의 어드민키 처럼 권한이 높음)
	@Value("#{env['toss.secret.key']}")
	private String TOSS_SECRET_KEY;
	
	//브라우저 단에서 사용될 키
	@Value("#{env['toss.client.key']}")
	private String TOSS_CLIENT_KEY;
	
	//상점 아이디
	@Value("#{env['toss.mid']}")
	private String TOSS_MID;
	
	//결재승인 URL
	@Value("#{env['toss.confirm.url']}")
	private String TOSS_CONFIRM_URL;
		
	//결제 성공  URL
	@Value("#{env['toss.success.url']}")
	private String TOSS_SUCCESS_URL;
	
	//결재 취소 URL
	@Value("#{env['toss.cancel.url']}")
	private String TOSS_CANCEL_URL;

	
	//결재 실패 URL
	@Value("#{env['toss.fail.url']}")
	private String TOSS_FAIL_URL;

	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private PayService payService;
	
	@RequestMapping(value="/pay/orderMenu", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> pay(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajax = new Response<Object>(); //ajax
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); //userUID
		Order order = new Order(); //주문객체
		List<OrderMenu> orderMenuList = new ArrayList<OrderMenu>(); //주문한 메뉴 목록 객체
		order.setShopUID(HttpUtil.get(request, "shopUID")); //shopUID
		String reservationDate = HttpUtil.get(request, "reservationDate"); //예약일
		String reservationTime = HttpUtil.get(request, "reservationTime"); //예약시간
		String reservationPeople = HttpUtil.get(request, "reservationPeople"); //예약인원
		ArrayList<String> requstOrderMenuList = new ArrayList<String>(); //jsp에서 주문목록 받아올때 사용할 arrayList
		Toss toss = new Toss();
		order.setTotalAmount(HttpUtil.get(request, "totalAmount", 0));
		
		
		logger.debug("shopUID : " + order.getShopUID());
		logger.debug("reservationDate : " + reservationDate);
		logger.debug("reservationTime : " + reservationTime);
		logger.debug("reservationPeople : " + reservationPeople);
		order.setShopUID(order.getShopUID());
		
		toss.setTossClientKey(TOSS_CLIENT_KEY);
		toss.setTossSecretKey(TOSS_SECRET_KEY);
		toss.setTossMid(TOSS_MID);
		toss.setTossConfrimUrl(TOSS_CONFIRM_URL);
		toss.setTossSuccessUrl(TOSS_SUCCESS_URL);
		toss.setTossCancelUrl(TOSS_CANCEL_URL);
		toss.setTossFailUrl(TOSS_FAIL_URL);
	
		
		order.setToss(toss);
		
		if(!StringUtil.isEmpty(cookieUserUID)) {
			User user = userService.userUIDSelect(cookieUserUID);
			if(!StringUtil.isEmpty(order.getShopUID()) && user != null) {
				order.setUserName(user.getUserName());
				order.setUserUID(user.getUserUID());
				Shop shop = shopService.shopViewSelect(order.getShopUID());
				if(shop != null) {
					for(int i=0; i < shop.getShopMenu().size(); i++) {
						String requestName = "orderMenu" + i;
						requstOrderMenuList.add(HttpUtil.get(request, requestName));
						
						logger.debug("orderMenuList[" + i + "]" + requstOrderMenuList.get(i));
		
						String[] split = requstOrderMenuList.get(i).split(","); // 구분자","로 잘라서 배열에 담음
						
						OrderMenu orderMenu = new OrderMenu();
						
						orderMenu.setOrderMenuName(split[0]);
						orderMenu.setOrderMenuQuantity(Integer.parseInt(split[1]));
						
						if(orderMenu.getOrderMenuQuantity() > 0) {
							orderMenuList.add(orderMenu);
						}
					}
					
					order.setOrderMenu(orderMenuList);
					
					if(order.getOrderMenu().size() > 0 && order.getTotalAmount() > 0) {
						long count = shopService.orderUIDcreate();
						if(count != 0) {
							order.setOrderUID(shop.getShopUID() + "_" +count);
							ajax.setResponse(0, "success", order);
						}
						else {
							ajax.setResponse(400, "badRequest");
						}
						
					}
					else {
						ajax.setResponse(400, "menu is empty");
					}
				}
			}
			else {
				ajax.setResponse(404, "shopUID is empty"); //가게 정보 조회에 실패했을때. (매장 리스트로 이동)
			}
		}
		else {
			ajax.setResponse(403, "cookieuid is empty"); //사용자 정보 조회에 실패했을때 (로그인페이지로 이동)
		}
		
		return ajax;
	}
	@RequestMapping(value="/pay/paySuccess", method=RequestMethod.GET)
	public String tossPayReady(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("페이 성공 들어옴");
		
		String orderId = HttpUtil.get(request, "orderId");
		String paymentKey = HttpUtil.get(request, "paymentKey");
		String amount = HttpUtil.get(request, "amount");
		
		Order order = new Order();
		Toss toss = new Toss();
		
		toss.setPaymentKey(paymentKey);
		order.setToss(toss);
		order.setOrderUID(orderId);
		order.setTotalAmount(Integer.parseInt(amount));
		
		logger.debug("orderId : " + orderId);
		logger.debug("paymentKey : " + paymentKey);
		logger.debug("amount : " + amount);
		
		payService.toss(order);
		
		
		
		return "/reservation/list";
	}
}

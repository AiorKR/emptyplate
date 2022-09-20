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
import com.icia.web.model.ShopReservationTable;
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

	//브라우저 단에서 사용될 키
	@Value("#{env['toss.client.key']}")
	private String TOSS_CLIENT_KEY;

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
		int reservationPeople = Integer.parseInt((HttpUtil.get(request, "reservationPeople"))); //예약인원
		ShopReservationTable shopReservationTable = new ShopReservationTable();
		
		logger.debug("parsInt : " + Integer.parseInt(reservationDate));
		
		
		ArrayList<String> requstOrderMenuList = new ArrayList<String>(); //jsp에서 주문목록 받아올때 사용할 arrayList
		Toss toss = new Toss();
		
		order.setTotalAmount(HttpUtil.get(request, "totalAmount", 0));
		order.setReservationPeople(reservationPeople);
		order.setShopUID(order.getShopUID());
		
		toss.setTossClientKey(TOSS_CLIENT_KEY);
		toss.setTossSuccessUrl(TOSS_SUCCESS_URL);
		toss.setTossCancelUrl(TOSS_CANCEL_URL);
		toss.setTossFailUrl(TOSS_FAIL_URL);

		order.setToss(toss);
		
		if(!StringUtil.isEmpty(cookieUserUID)) {
			User user = userService.userUIDSelect(cookieUserUID);
			if(!StringUtil.isEmpty(order.getShopUID()) && user != null) {
				order.setReservationName(user.getUserName());
				order.setReservationPhon(user.getUserPhone());
				order.setUserUID(user.getUserUID());
				shopReservationTable.setShopReservationDate(reservationDate);
				shopReservationTable.setShopReservationTime(reservationTime);
			
				order.setShopReservationTable(shopReservationTable);
				
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
						
						if(StringUtil.equals(orderMenu.getOrderMenuName(), shop.getShopMenu().get(i).getShopMenuName())) { //메뉴 이름과 같은 메뉴이름을 찾아서 가격 세팅
							orderMenu.setOrderMenuPrice(shop.getShopMenu().get(i).getShopMenuPrice());
						}
						
						if(orderMenu.getOrderMenuQuantity() > 0) {
							orderMenuList.add(orderMenu);
						}
					}
					
					order.setOrderMenu(orderMenuList);
					order.setShopName(shop.getShopName());
					
					if(order.getOrderMenu().size() > 0 && order.getTotalAmount() > 0) {
						long count = shopService.orderUIDcreate(); //count는 orderuid에 사용될 seq값을 가져옴
						if(count != 0) {
							order.setOrderUID(shop.getShopUID() + "_" +count);
							CookieUtil.addCookie(response, "/", -1, "reservationDate", CookieUtil.stringToHex(order.getShopReservationTable().getShopReservationDate())); //예약일 쿠키 추가
							CookieUtil.addCookie(response, "/", -1, "reservationTime", CookieUtil.stringToHex(order.getShopReservationTable().getShopReservationDate())); //예약시간 쿠키 추가
							CookieUtil.addCookie(response, "/", -1, "reservationPeople", CookieUtil.stringToHex(Integer.toString(order.getReservationPeople()))); //예약인원
							CookieUtil.addCookie(response, "/", -1, "reservationTotalAmount", CookieUtil.stringToHex(Integer.toString(order.getTotalAmount()))); //총 금액
							CookieUtil.addCookie(response, "/", -1, "shopUID", CookieUtil.stringToHex(order.getShopUID())); //매장 UID
								
							CookieUtil.addCookie(response, "/", -1, "orderMenuSize", CookieUtil.stringToHex(Integer.toString(order.getOrderMenu().size())));
							for(int i=0; i < order.getOrderMenu().size(); i++) {
								String cookieOrderMenuName = "orderMenuName" + i; //동적으로 쿠키 이름 생성
								String cookieOrderMenuPrice = "orderMenuPrice" + i;
								String cookieOrderMenuQuantity = "orderMenuQuantity" + i;
								
								CookieUtil.addCookie(response, "/", -1, cookieOrderMenuName, CookieUtil.stringToHex(order.getOrderMenu().get(i).getOrderMenuName()));
								CookieUtil.addCookie(response, "/", -1, cookieOrderMenuPrice, CookieUtil.stringToHex(Integer.toString(order.getOrderMenu().get(i).getOrderMenuPrice())));
								CookieUtil.addCookie(response, "/", -1, cookieOrderMenuQuantity, CookieUtil.stringToHex(Integer.toString(order.getOrderMenu().get(i).getOrderMenuQuantity())));
							}
							
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
		String orderId = HttpUtil.get(request, "orderId");
		String paymentKey = HttpUtil.get(request, "paymentKey");
		String amount = HttpUtil.get(request, "amount");
		String url = "";
		Order RequestOrder = new Order(); //값 세팅할 order
		Order order = null;
		Toss toss = new Toss();
		String shopUID = CookieUtil.getHexValue(request, "shopUID");
		
		List<OrderMenu> orderMenuList = new ArrayList<OrderMenu>();
		OrderMenu orderMenu = new OrderMenu();
		
		int orderMenuSize = Integer.parseInt(CookieUtil.getHexValue(request, "orderMenuSize"));
		CookieUtil.deleteCookie(request, response, "/", "orderMenuSize");
		
		String totalAmount = CookieUtil.getHexValue(request, "reservationTotalAmount");
		if(StringUtil.equals(totalAmount, amount)) { //totalAmount는 쿠키로 받은 값 (토스에 보낸 값), amount는 parameter로 받은 값 (토스에서 보내준 값)
			int reservtionPeple = Integer.parseInt(CookieUtil.getHexValue(request, "reservationPeople"));
			String reservationDate = CookieUtil.getHexValue(request, "reservationDate");
			String reservationTime = CookieUtil.getHexValue(request, "reservationTime");
			
			
			for(int i=0; i < orderMenuSize; i++) {
				String cookieOrderMenuName = "orderMenuName" + i; //동적으로 쿠키 이름 생성
				String cookieOrderMenuPrice = "orderMenuPrice" + i;
				String cookieOrderMenuQuantity = "orderMenuQuantity" + i;
				
				orderMenu.setOrderMenuName(CookieUtil.getHexValue(request, cookieOrderMenuName));
				orderMenu.setOrderMenuPrice(Integer.parseInt(CookieUtil.getHexValue(request, cookieOrderMenuPrice)));
				orderMenu.setOrderMenuQuantity(Integer.parseInt(CookieUtil.getHexValue(request, cookieOrderMenuQuantity)));
				orderMenuList.add(orderMenu);
				
				CookieUtil.deleteCookie(request, response, "/", cookieOrderMenuName);
				CookieUtil.deleteCookie(request, response, "/", cookieOrderMenuPrice);
				CookieUtil.deleteCookie(request, response, "/", cookieOrderMenuQuantity);
			}
			
			
			toss.setPaymentKey(paymentKey);
			RequestOrder.setToss(toss);
			RequestOrder.setOrderUID(orderId);
			RequestOrder.setTotalAmount(Integer.parseInt(amount));
			RequestOrder.setOrderMenu(orderMenuList);
						
			order = payService.toss(RequestOrder);
			Shop shop = shopService.shopViewSelect(shopUID);
			shop.setReservationDate(order.getShopReservationTable().getShopReservationDate());
			shop.setReservationTime(order.getShopReservationTable().getShopReservationTime());
			shop.setShopTotalTable(shopService.shopReservationCheck(shop));
			
			
		}
		if( order != null) {
			url = "/pay/paySuccess"; 
		}
		else {
			url = "/pay/payFail"; //order객체가 null이라면 결제 실패페이지로 이동
		}
		
		return url;
	}
}

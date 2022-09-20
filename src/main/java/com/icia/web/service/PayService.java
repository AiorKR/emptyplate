package com.icia.web.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.icia.common.util.StringUtil;
import com.icia.web.dao.ShopDao;
import com.icia.web.model.Order;
import com.icia.web.model.Toss;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopReservationTable;

@Service("payService")
public class PayService {

	private static Logger logger = LoggerFactory.getLogger(PayService.class);

	// 통신할 기본 호스트 주소
	@Value("#{env['toss.host']}")
	private String TOSS_HOST;

	// 시크릿키 (카카오페이의 어드민키 처럼 권한이 높음)
	@Value("#{env['toss.secret.key']}")
	private String TOSS_SECRET_KEY;

	// 결재승인 URL
	@Value("#{env['toss.confirm.url']}")
	private String TOSS_CONFIRM_URL;
	
	@Autowired
	private ShopDao shopDao;

	public Order toss(Order requestOrder) {
		Order order = null;
		if (requestOrder != null) {
			Toss toss = new Toss();
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			// 서버로 요청할 header
			HttpHeaders headers = new HttpHeaders();

			String secretKey = TOSS_SECRET_KEY + ":";

			byte[] targetBytes = secretKey.getBytes();

			// double amount = order.getTotalAmount();

			String base64data = Base64.getEncoder().encodeToString(targetBytes);
			logger.debug("base64data : " + base64data);

			headers.add("Authorization", "Basic " + base64data); // 시크릿키를 base64로 암호화 한 후에 넘김
			headers.add("Content-type", "application/json");
			// 서버로 요청할 body
			HashMap<String, String> params = new HashMap<String, String>();

			params.put("amount", Integer.toString(requestOrder.getTotalAmount()));
			params.put("orderId", requestOrder.getOrderUID());
			params.put("paymentKey", requestOrder.getToss().getPaymentKey());

			HttpEntity<HashMap<String, String>> body = new HttpEntity<HashMap<String, String>>(params, headers);

			try {
				@SuppressWarnings("unchecked")
				HashMap<String, String> response = restTemplate.postForObject(new URI(TOSS_HOST + TOSS_CONFIRM_URL),
						body, HashMap.class);

				if (response != null) {
					order = new Order();
					if (StringUtil.equals(response.get("status"), "DONE")) { // 토스에서 결제가 완료 되었는가 (DONE - 결제 완료됨)
						order.setOrderStatus("Y");
						order.setOrderUID(response.get("orderId")); // 예약번호
						order.setOrderRegDate(response.get("approvedAt").substring(0, 10).replace("-", ""));
						toss.setPaymentKey(response.get("paymentKey")); // 토스에서 부여해주는 결제 건에 대한 고유한 키 값, 최대 길이 200
						order.setToss(toss);
						order.setTotalAmount((requestOrder.getTotalAmount())); // 총합 금액
						if (StringUtil.equals(response.get("method"), "카드")) {
							order.setOrderPayType("C");
						} 
						else {
							order.setOrderPayType("E");
						}

					} else {
						order = null;
					}
				}

			} catch (RestClientException e) {
				logger.error("[PayService]toss RestClientException", e);
			} catch (URISyntaxException e) {
				logger.error("[PayService]toss URISyntaxException", e);
			}
		} else {
			logger.error("[PayService]toss order is null");
		}
		return order;

	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class) // 최종결제 및 DB에 정보 INSERT
	public String payResult(Shop shop, Order order) throws Exception {

		int count = 0;
		int count2 = 0;
		String result = "";
		List<ShopReservationTable> shopReservationTableList = new ArrayList<ShopReservationTable>();

		if (shop != null && order != null) { // 예약 자리가 있는지 다시 조회 및 자리 설정 여기서 실패하면 fail url return 할것
			if (!StringUtil.isEmpty(order.getUserUID())) {
				if (order.getReservationPeople() > 0) {
					for (int i = 0; i < shop.getShopTotalTable().size(); i++) {
						for (int j = 0; j < shop.getShopTotalTable().get(i).getShopTable().size(); j++) {
							if (StringUtil.equals(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
								count++;
							}
						}
						if (shop.getShopTotalTable().get(i).getShopTotalTable() == count) { // 예약된 테이블 갯수가 식당의 있는 테이블 수량과 같다면
							shop.getShopTotalTable().get(i).setShopTotalTableStatus("Y"); // 예약이 다 차있다면 Y를 세팅함. 디폴트값 N
							if (StringUtil.equals("Y", shop.getShopTotalTable().get(i).getShopTotalTableStatus())) {
								count2++;
							}
						} 
						else {
							shop.getShopTotalTable().get(i).setShopTotalTableRmains(shop.getShopTotalTable().get(i).getShopTotalTable() - count); // 남아있는 자리 숫자 세팅
						}
						count = 0; // 카운트 초기화 (j가 다 돌고 나면 첨부터 다시 카운트를 세야하므로 초기화)
					}
					if(count2 == shop.getShopTotalTable().size()) {
						result = "-1, 예약을 더 받을 수 없음";
					}
					else if (shop.getShopTotalTable() != null && StringUtil.equals(order.getCounterSeatYN(), "N")) { //모든 자리 조회
						for (int i = 0; i < shop.getShopTotalTable().size(); i++) {
							
							if (order.getReservationPeople() / 2 == 0) { // 예약인원이 짝수 일때
								int quantity = order.getReservationPeople() % shop.getShopTotalTable().get(i).getShopTotalTableCapacity();
								logger.debug("짝수 수량 : " + quantity);
								if (StringUtil.equals(shop.getShopTotalTable().get(i).getShopTotalTableStatus(), "N")) { // 자리가 있는 테이블 종류 확인
									if (shop.getShopTotalTable().get(i).getShopTotalTableRmains() >= quantity) {
										for (int j = 0; j < shop.getShopTotalTable().get(i).getShopTable().size(); j++) {
											if (!StringUtil.equals(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
												ShopReservationTable shopReservationTable = new ShopReservationTable();
												shopReservationTable.setShopTableUID(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopTableUID());
												shopReservationTable.setShopReservationDate(shop.getReservationDate());
												shopReservationTable.setShopReservationTime(shop.getReservationTime());
												shopReservationTable.setShopTableStatus("Y");
												shopReservationTable.setOrderUID(order.getOrderUID());
												shopReservationTableList.add(shopReservationTable);

												if ((j + 1 ) == quantity) break;
											}
										}
										order.setShopReservationTableList(shopReservationTableList);
										result = "0, 예약가능";
										break;
									} 
									else {
										result = "-2, 예약인원이 남은 테이블 수량보다 큼";
									}
								}
							} 
							else { // 예약인원이 홀수 일때
								int tmp = order.getReservationPeople() + 1;  // 1명 추가해서 짝수로 만들어 계산
								int quantity = tmp / shop.getShopTotalTable().get(i).getShopTotalTableCapacity();
								logger.debug("홀수 수량 : " + quantity);
									if (StringUtil.equals(shop.getShopTotalTable().get(i).getShopTotalTableStatus(),"N")) { // 자리가 있는 테이블 종류 확인
										if (shop.getShopTotalTable().get(i).getShopTotalTableRmains() >= quantity) {
											for (int j = 0; j < shop.getShopTotalTable().get(i).getShopTable().size(); j++) {
												if (!StringUtil.equals(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
													ShopReservationTable shopReservationTable = new ShopReservationTable();
													shopReservationTable.setShopTableUID(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopTableUID());
													shopReservationTable.setShopReservationDate(shop.getReservationDate());
													shopReservationTable.setShopReservationTime(shop.getReservationTime());
													shopReservationTable.setShopTableStatus("Y");
													shopReservationTable.setOrderUID(order.getOrderUID());
													shopReservationTableList.add(shopReservationTable);
													
													if ((j + 1 ) == quantity) break;
												}
											}
											order.setShopReservationTableList(shopReservationTableList);
											result = "0, 예약가능";
											break;
										} 
										else {
											result = "-2, 예약인원이 남은 테이블 수량보다 큼";
										}
									}
							}
						}
					}
					else { // 카운터석만 조회
						for (int i = 0; i < shop.getShopTotalTable().size(); i++) {
							if (shop.getShopTotalTable().get(i).getShopTotalTableCapacity() == 1) { // 카운터석만 확인
								for (int j = 0; j < shop.getShopTotalTable().get(i).getShopTable().size(); j++) {
									if (StringUtil.equals(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) { // 자리 조회 중
										count++;
									}
								}
								if (shop.getShopTotalTable().get(i).getShopTotalTable() == count) { // 예약된 테이블 갯수가 식당의  테이블 수량과 같다면
									shop.getShopTotalTable().get(i).setShopTotalTableStatus("Y"); // 예약이 다 차있다면 Y를 세팅함. (디폴트값 N)
									result = "-2, 예약인원이 남은 테이블 수량보다 큼";
								} 
								else {
									shop.getShopTotalTable().get(i).setShopTotalTableRmains(
									shop.getShopTotalTable().get(i).getShopTotalTable() - count); // 남아있는 자리 숫자 세팅
									if (order.getReservationPeople() > shop.getShopTotalTable().get(i).getShopTotalTableRmains()) { // 1인테이블이므로 예약인원보다 남은 자리가 적으면 안됨
										result = "-2, 예약인원이 남은 테이블 수량보다 큼";
									} 
									else {
										for (int j = 0; j < shop.getShopTotalTable().get(i).getShopTable().size(); j++) {
											if (!StringUtil.equals(shop.getShopTotalTable().get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
												ShopReservationTable shopReservationTable = new ShopReservationTable();
												shopReservationTable.setShopTableUID(shop.getShopTotalTable().get(i).getShopTable().get(i).getShopTableUID());
												shopReservationTable.setShopReservationDate(shop.getReservationDate());
												shopReservationTable.setShopReservationTime(shop.getReservationTime());
												shopReservationTable.setShopTableStatus("Y");
												shopReservationTable.setOrderUID(order.getOrderUID());
												shopReservationTableList.add((shopReservationTable));
												if ((j + 1 ) == order.getReservationPeople()) break;
											}
										}
										order.setShopReservationTableList(shopReservationTableList);
										result = "0, 예약가능";
										break;
									}
								}
							} 
							else {
								result = "-3, 카운터석이 없음";
							}
						}
					}
					
					if(StringUtil.equals("0, 예약가능", result)) {
						if(shopDao.orderInsert(order) > 0) {
							if(shopDao.orderMenuInsert(order.getOrderMenu()) > 0 && shopDao.reservationTableInser( order.getShopReservationTableList()) > 0) {
								result = "0, 예약성공";
							}
						}
					}
					else {
						result = "-4, DB insert 실패";
					}
				}
				else {
					result = "400, 예약인원이 0명임";
				}
			}
			else {
				result = "403, 로그인이 안되어있음";
			}
		}
		else {
			result = "404, 매장을 찾을 수 없음";
		}
		return result;
	}
	
	public String payCancel(String paymentKey, String cancelReason, int cancelAmount) { //환불
		String result = "";
		
		if(!StringUtil.isEmpty(paymentKey) &&  !StringUtil.isEmpty(cancelReason) && cancelAmount > 0) {
			String cancelUrl = "/v1/payments/" + paymentKey + "/cancel";
			String Amount = Integer.toString(cancelAmount);
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			// 서버로 요청할 header
			HttpHeaders headers = new HttpHeaders();

			String secretKey = TOSS_SECRET_KEY + ":";

			byte[] targetBytes = secretKey.getBytes();

			String base64data = Base64.getEncoder().encodeToString(targetBytes);

			headers.add("Authorization", "Basic " + base64data); // 시크릿키를 base64로 암호화 한 후에 넘김
			headers.add("Content-type", "application/json");
			// 서버로 요청할 body
			HashMap<String, String> params = new HashMap<String, String>();
	
			params.put("cancelReason", cancelReason); //취소 이유
			params.put("cancelAmount", Amount); //환불 금액

			HttpEntity<HashMap<String, String>> body = new HttpEntity<HashMap<String, String>>(params, headers);

			try {
				@SuppressWarnings("unchecked")
				HashMap<String, String> response = restTemplate.postForObject(new URI(TOSS_HOST + cancelUrl), body, HashMap.class);

				if (response != null) {
					result = "-998, 결제 취소됨";
				} 
				else {
					result = "-997, 결제취소 실패";
				}
			}
			catch (RestClientException e) {
				logger.error("[PayService]toss RestClientException", e);
			} 
			catch (URISyntaxException e) {
				logger.error("[PayService]toss URISyntaxException", e);
			}
		}
		else {
			result = "400, 필수 파라미터  부족";
		}
		
		logger.debug("result : " + result);
		
		return result;
	}

}

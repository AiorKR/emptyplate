package com.icia.web.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Base64;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.Order;
import com.icia.web.model.Toss;

@Service("payService")
public class PayService {

	private static Logger logger = LoggerFactory.getLogger(PayService.class);
	
	//통신할 기본 호스트 주소
	@Value("#{env['toss.host']}")
	private String TOSS_HOST;
	
	//시크릿키 (카카오페이의 어드민키 처럼 권한이 높음)
	@Value("#{env['toss.secret.key']}")
	private String TOSS_SECRET_KEY;
	
	//결재승인 URL
	@Value("#{env['toss.confirm.url']}")
	private String TOSS_CONFIRM_URL;
	
	public Order toss(Order requestOrder) {   
		Order order = null;
		if(requestOrder != null)
	      {
	         RestTemplate restTemplate = new RestTemplate();
	         restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
	         //서버로 요청할 header
	         HttpHeaders headers = new HttpHeaders();
	         
	         String secretKey = TOSS_SECRET_KEY + ":";
	         
	         byte[] targetBytes = secretKey.getBytes();
	         
	         //double amount = order.getTotalAmount();
	         
	         String base64data = Base64.getEncoder().encodeToString(targetBytes);
	         logger.debug("base64data : " + base64data);
	         
	         headers.add("Authorization", "Basic " + base64data ); //시크릿키를 base64로 암호화 한 후에 넘김
	         headers.add("Content-type", "application/json");
	         //서버로 요청할 body
	         HashMap<String,String> params = new HashMap<String, String>();
	         
	         params.put("amount", Integer.toString(requestOrder.getTotalAmount()));
	         params.put("orderId", requestOrder.getOrderUID());
	         params.put("paymentKey", requestOrder.getToss().getPaymentKey());
	         
	         HttpEntity<HashMap<String,String>> body = new HttpEntity<HashMap<String,String>>(params, headers);
	         
	         try
	         {
	        	 @SuppressWarnings("unchecked")
				HashMap<String,String> response = restTemplate.postForObject(new URI(TOSS_HOST + TOSS_CONFIRM_URL), body, HashMap.class);
	
	            if(response != null)
	            {
	            	logger.debug("결과 : " + response);
	               order = new Order();
	               if(StringUtil.equals(response.get("status"), "DONE")) { //토스에서 결제가 완료 되었는가  (DONE - 결제 완료됨)
		               order.setOrderStatus("Y");
			               order.setOrderUID(response.get("orderId")); //예약번호
			               order.setOrderRegDate(response.get("approvedAt").substring(0, 10).replace("-", "")); //토스에서 결제 완료 된 시간 (yyyy-mm-dd 까지 남기고 자른 후 -를 "" 바꿈)
			               order.getToss().setPaymentKey(requestOrder.getToss().getPaymentKey()); //토스에서 부여해주는 결제 건에 대한 고유한 키 값, 최대 길이 200
			               order.setTotalAmount((requestOrder.getTotalAmount())); // 총합 금액

	               }
	               else {
	            	   order = null;
	               }
	            }

	         }
	         catch(RestClientException e)
	         {
	            logger.error("[PayService]toss RestClientException", e);
	         }
	         catch(URISyntaxException e)
	         {
	            logger.error("[PayService]toss URISyntaxException", e);
	         }
	      }
	      else
	      {
	         logger.error("[PayService]toss order is null");
	      }
		return order;

	}
	
	
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //최종결제 및 DB에 정보 INSERT
//	public int payResult(Order Order) throws Exception
//	{
//		long 
//		
//		int count = boardDao.boardInsert(board);
//		
//		//첨부파일 등록
//		if(count > 0 && board.getBoardFile() != null)
//		{	
//			BoardFile boardFile = board.getBoardFile();
//			boardFile.setBbsSeq(board.getBbsSeq());
//			boardFile.setFileOrgName(Long.toString(bbsSeq) + "."+ boardFile.getFileExt());
//			boardFile.setFileSeq((short)1);
//			
//			boardDao.boardFileInsert(board.getBoardFile());
//		}
//		
//		return count;
//	}
}

package com.icia.web.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Base64;
import java.util.HashMap;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
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

	
	public void toss(Order order) {      
		if(order != null)
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
	         
	         params.put("amount", Integer.toString(order.getTotalAmount()));
	         params.put("orderId", order.getOrderUID());
	         params.put("paymentKey", order.getToss().getPaymentKey());
	         
	         HttpEntity<HashMap<String,String>> body = new HttpEntity<HashMap<String,String>>(params, headers);
	         
	         try
	         {
	        	 HashMap response = restTemplate.postForObject(new URI(TOSS_HOST + TOSS_CONFIRM_URL), body, HashMap.class);
	            logger.debug(" response : " + response);
	           
	            if(response != null)
	            {
	               logger.debug("[PayService]toss : " + response);
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

	}
}

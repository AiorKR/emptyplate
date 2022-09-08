package com.icia.web.util;

import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONObject;



public class SmsMessage {
	   private static String projectId = "ncp:sms:kr:291066128144:empty_plate";
	    private static String accessKey = "HS2Ryo7LFEfMGasOeE6J";
	    private static String secretKey = "iWOBJIYJ7cHXIuZIGpqGeo65n7yvx6oiLTVfhdnA";

	    private static String url = "/sms/v2/services/"+projectId+"/messages";
	    private static String requestUrl = "https://sens.apigw.ntruss.com"+url;

	    private static String timestamp = Long.toString(System.currentTimeMillis()); 
	    private static String method = "POST";


	    //public static void main(String[] args) throws Exception {
	    public String sendsms(String userPhone, String numStr) {

	            JSONObject bodytJson = new JSONObject();
	            JSONObject toJson = new JSONObject();
	            JSONArray toArr = new JSONArray();
	            toJson.put("subject" , "제목");
	            toJson.put("content" , "["+numStr+"]");
	            toJson.put("to" , userPhone);
	            toArr.put(toJson);

	            bodytJson.put("type" , "SMS");
	            bodytJson.put("contentType" , "COMM");
	            bodytJson.put("countryCode" , "82");
	            bodytJson.put("from" , "01020940841");
	            bodytJson.put("subject" , "제목");
	            bodytJson.put("content" , "내용");
	            bodytJson.put("messages" , toArr );
	            String body = bodytJson.toString();
	            String result2 = post(requestUrl , body);
	            System.out.println(result2);
	            return numStr;
	    }
	
	    // Signature생성
	    public static String makeSignature() throws Exception {

	        String space = " ";        // one space
	        String newLine = "\n";    // new line

	        String message = new StringBuilder()
	            .append(method)
	            .append(space)
	            .append(url)
	            .append(newLine)
	            .append(timestamp)
	            .append(newLine)
	            .append(accessKey)
	            .toString();

	        String encodeBase64String = null;
	        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
	        Mac mac = Mac.getInstance("HmacSHA256");
	        mac.init(signingKey);

	        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	        encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

	      return encodeBase64String;
	    };
	

	
	
	
	    public static String post(String requestURL, String jsonMessage) {

		  try {

		        HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성

		        HttpPost postRequest = new HttpPost(requestURL); //POST 메소드 URL 새성

		        postRequest.setHeader("Accept", "application/json; charset=UTF-8");

		        postRequest.setHeader("Connection", "keep-alive");

		        postRequest.setHeader("Content-Type", "application/json; charset=UTF-8");
		        
		        //postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
		        postRequest.addHeader("x-ncp-apigw-timestamp", timestamp );
		        postRequest.addHeader("x-ncp-iam-access-key", accessKey );
		        postRequest.addHeader("x-ncp-apigw-signature-v2", makeSignature() );

		        //postRequest.addHeader("Authorization", token); // token 이용시



		        postRequest.setEntity(new StringEntity(jsonMessage)); //json 메시지 입력



		        HttpResponse response = client.execute(postRequest);



		        //Response 출력

		        if (response.getStatusLine().getStatusCode() == 200) {

		        ResponseHandler<String> handler = new BasicResponseHandler();

		        String body = handler.handleResponse(response);

		        System.out.println(body);

		        } else {

		        System.out.println("response is error : " + response.getStatusLine().getStatusCode());

		        }

		  } catch (Exception e){
		      System.err.println(e.toString());
		  }
		return jsonMessage;
		  
		}
}

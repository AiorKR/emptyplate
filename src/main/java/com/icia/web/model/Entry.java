package com.icia.web.model;

import java.io.Serializable;

public class Entry implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long entrySeq;	//문의번호
	private String shopName;	//문의매장명
	private String userName;	//문의자이름
	private String userPhone;	//문의자전화번호
	private String userEmail;	//문의자이메일
	private String agreement;	//약관동의여부
	private String status;		//처리상황(문의-접수-처리-완료)
	private String resultStatus;//승인여부(승인-거절)
	private String regDate;		//문의일시
	
	
	
	public Entry()
	{
		entrySeq = 0;	
		shopName = "";	
		userName = "";	
		userPhone = "";	
		userEmail = "";	
		agreement = "";	
		status = "";		
		resultStatus = "";
		regDate = "";		
	}



	public long getEntrySeq() {
		return entrySeq;
	}



	public void setEntrySeq(long entrySeq) {
		this.entrySeq = entrySeq;
	}



	public String getShopName() {
		return shopName;
	}



	public void setShopName(String shopName) {
		this.shopName = shopName;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getUserPhone() {
		return userPhone;
	}



	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}



	public String getUserEmail() {
		return userEmail;
	}



	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}



	public String getAgreement() {
		return agreement;
	}



	public void setAgreement(String agreement) {
		this.agreement = agreement;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getResultStatus() {
		return resultStatus;
	}



	public void setResultStatus(String resultStatus) {
		this.resultStatus = resultStatus;
	}



	public String getRegDate() {
		return regDate;
	}



	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
	
	
	
	
}

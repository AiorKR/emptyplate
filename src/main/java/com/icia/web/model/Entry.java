package com.icia.web.model;

import java.io.Serializable;

public class Entry implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long entrySeq;
	private String shopName;
	private String userName;
	private String userPhone;
	private String userEmail;
	private char agreement;
	private String status;
	private String resultStatus;
	private String regDate;
	
	public Entry()
	{
		entrySeq=0;
		shopName="";
		userName="";
		userPhone="";
		userEmail="";
		agreement=' ';
		status="";
		resultStatus="";
		regDate="";
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

	public char getAgreement() {
		return agreement;
	}

	public void setAgreement(char agreement) {
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

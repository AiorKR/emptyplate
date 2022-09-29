package com.icia.web.model;

import java.io.Serializable;

public class Toss implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String tossSecretKey;
	private String tossClientKey;
	private String tossMid;
	private String tossConfrimUrl;
	private String tossSuccessUrl;
	private String tossCancelUrl;
	private String tossFailUrl;
	private String paymentKey;
	
	
	public Toss() {
		tossSecretKey = "";
		tossClientKey = "";
		tossMid = "";
		tossConfrimUrl = "";
		tossSecretKey = "";
		tossCancelUrl = "";
		tossFailUrl = "";
		paymentKey = "";
	}


	public String getTossSecretKey() {
		return tossSecretKey;
	}


	public void setTossSecretKey(String tossSecretKey) {
		this.tossSecretKey = tossSecretKey;
	}


	public String getTossClientKey() {
		return tossClientKey;
	}


	public void setTossClientKey(String tossClientKey) {
		this.tossClientKey = tossClientKey;
	}


	public String getTossMid() {
		return tossMid;
	}


	public void setTossMid(String tossMid) {
		this.tossMid = tossMid;
	}


	public String getTossConfrimUrl() {
		return tossConfrimUrl;
	}


	public void setTossConfrimUrl(String tossConfrimUrl) {
		this.tossConfrimUrl = tossConfrimUrl;
	}


	public String getTossSuccessUrl() {
		return tossSuccessUrl;
	}


	public void setTossSuccessUrl(String tossSuccessUrl) {
		this.tossSuccessUrl = tossSuccessUrl;
	}


	public String getTossCancelUrl() {
		return tossCancelUrl;
	}


	public void setTossCancelUrl(String tossCancelUrl) {
		this.tossCancelUrl = tossCancelUrl;
	}


	public String getTossFailUrl() {
		return tossFailUrl;
	}


	public void setTossFailUrl(String tossFailUrl) {
		this.tossFailUrl = tossFailUrl;
	}


	public String getPaymentKey() {
		return paymentKey;
	}


	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	

}

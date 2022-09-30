package com.icia.web.model;

import java.io.Serializable;

public class ShopTime implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String shopUID;
	private String shopOrderTime;
	private String shopTimeType;
	
	public ShopTime() {
		shopUID = "";
		shopOrderTime = "";
		shopTimeType = ""; //런치면 L, 디너면 D 시간기준은 1700
	}

	public String getShopUID() {
		return shopUID;
	}

	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}

	public String getShopOrderTime() {
		return shopOrderTime;
	}

	public void setShopOrderTime(String shopOrderTime) {
		this.shopOrderTime = shopOrderTime;
	}

	public String getShopTimeType() {
		return shopTimeType;
	}

	public void setShopTimeType(String shopTimeType) {
		this.shopTimeType = shopTimeType;
	}
	
}

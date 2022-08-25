package com.icia.web.model;

import java.io.Serializable;

public class ShopTime implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String shopUID;
	private String shopOrderTime;
	
	public ShopTime() {
		shopUID = "";
		shopOrderTime = "";
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
	
}

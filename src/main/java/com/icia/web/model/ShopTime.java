package com.icia.web.model;

import java.io.Serializable;

public class ShopTime implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String shopUid;
	private String shopOrderTime;
	
	public ShopTime() {
		shopUid = "";
		shopOrderTime = "";
	}

	public String getShopUid() {
		return shopUid;
	}

	public void setShopUid(String shopUid) {
		this.shopUid = shopUid;
	}

	public String getShopOrderTime() {
		return shopOrderTime;
	}

	public void setShopOrderTime(String shopOrderTime) {
		this.shopOrderTime = shopOrderTime;
	}
	
}

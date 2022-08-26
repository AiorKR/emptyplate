package com.icia.web.model;

import java.io.Serializable;

public class ShopBookmark implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String userUID;
	private String shopUID;
	
	ShopBookmark() {
		userUID = "";
		shopUID = "";
	}

	public String getUserUID() {
		return userUID;
	}

	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}

	public String getShopUID() {
		return shopUID;
	}

	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}
	
	
}

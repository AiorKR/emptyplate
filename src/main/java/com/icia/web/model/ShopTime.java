package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class ShopTime implements Serializable {

	private static final long serialVersionUID = 1L;
	
<<<<<<< HEAD
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
=======
	private String shopUid;
	private List<String> shopTime;
	public ShopTime() {
		shopUid = "";
		shopTime = null;
	}
	public String getShopUid() {
		return shopUid;
	}
	public void setShopUid(String shopUid) {
		this.shopUid = shopUid;
>>>>>>> User_
	}
	public List<String> getShopTime() {
		return shopTime;
	}
	public void setShopTime(List<String> shopTime) {
		this.shopTime = shopTime;
	}
}

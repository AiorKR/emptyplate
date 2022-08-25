package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class ShopMenu implements Serializable {

	private static final long serialVersionUID = 1L;
	
<<<<<<< HEAD
	private String shopUID;
	private String shopMenuCode;
	private String shopMenuName;
	private int shopMenuPrice;
	
	
	public ShopMenu() {
		shopUID = "";
		shopMenuCode = "";
		shopMenuName = "";
		shopMenuPrice = 0;
	}


	public String getShopUID() {
		return shopUID;
	}


	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
=======
	private String shopUid;
	private List<String> menuCode;
	private List<String> menuName;
	private List<Integer> menuPrice;
	
	public ShopMenu() {
		shopUid = "";
		menuCode = null;
		menuName = null;
		menuPrice = null;
	}

	public String getShopUid() {
		return shopUid;
	}

	public void setShopUid(String shopUid) {
		this.shopUid = shopUid;
>>>>>>> User_
	}

	public List<String> getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(List<String> menuCode) {
		this.menuCode = menuCode;
	}

	public List<String> getMenuName() {
		return menuName;
	}

	public void setMenuName(List<String> menuName) {
		this.menuName = menuName;
	}

	public List<Integer> getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(List<Integer> menuPrice) {
		this.menuPrice = menuPrice;
	}
}
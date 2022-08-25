package com.icia.web.model;

import java.io.Serializable;

public class OrderMenu implements  Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String orderUID;
	private String orderMenuName;
	private String orderMenuPrice;
	private int orderMenuQuantity;
	
	public OrderMenu() {
		orderUID = "";
		orderMenuName = "";
		orderMenuPrice = "";
		orderMenuQuantity = 0;
	}

	public String getOrderUID() {
		return orderUID;
	}

	public void setOrderUID(String orderUID) {
		this.orderUID = orderUID;
	}

	public String getOrderMenuName() {
		return orderMenuName;
	}

	public void setOrderMenuName(String orderMenuName) {
		this.orderMenuName = orderMenuName;
	}

	public String getOrderMenuPrice() {
		return orderMenuPrice;
	}

	public void setOrderMenuPrice(String orderMenuPrice) {
		this.orderMenuPrice = orderMenuPrice;
	}

	public int getOrderMenuQuantity() {
		return orderMenuQuantity;
	}

	public void setOrderMenuQuantity(int orderMenuQuantity) {
		this.orderMenuQuantity = orderMenuQuantity;
	}
	
}

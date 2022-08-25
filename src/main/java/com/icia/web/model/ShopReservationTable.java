package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class ShopReservationTable implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String shopTableUID;
	private String shopTableStatus;
	private String shopReservationDate;
	private String shopReservationTime;
	private String orderUID;
	
	
	public ShopReservationTable() {
		shopTableUID = "";
		shopTableStatus = "";
		shopReservationDate = "";
		shopReservationTime = "";
		orderUID = "";
	}


	public String getShopTableUID() {
		return shopTableUID;
	}


	public void setShopTableUID(String shopTableUID) {
		this.shopTableUID = shopTableUID;
	}


	public String getShopTableStatus() {
		return shopTableStatus;
	}


	public void setShopTableStatus(String shopTableStatus) {
		this.shopTableStatus = shopTableStatus;
	}


	public String getShopReservationDate() {
		return shopReservationDate;
	}


	public void setShopReservationDate(String shopReservationDate) {
		this.shopReservationDate = shopReservationDate;
	}


	public String getShopReservationTime() {
		return shopReservationTime;
	}


	public void setShopReservationTime(String shopReservationTime) {
		this.shopReservationTime = shopReservationTime;
	}


	public String getOrderUID() {
		return orderUID;
	}


	public void setOrderUID(String orderUID) {
		this.orderUID = orderUID;
	}
	
}

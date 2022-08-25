package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class Order implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String orderUID;
	private String shopUID;
	private String userUID;
	private String reservationName;
	private String reservationPhon;
	private String reservationPeople;
	private String orderStatus;
	private String orderPayType;
	private String orderRegDate;
	
	private List<OrderMenu> orderMenu;
	private List<ShopReservationTable> shopReservationTable;
	
	public Order() {
		orderUID = "";
		shopUID = "";
		userUID = "";
		reservationName = "";
		reservationPhon = "";
		reservationPeople = "";
		orderStatus = "";
		orderPayType = "";
		orderRegDate = "";
		
		orderMenu = null;
		shopReservationTable = null;
	}

	public String getOrderUID() {
		return orderUID;
	}

	public void setOrderUID(String orderUID) {
		this.orderUID = orderUID;
	}

	public String getShopUID() {
		return shopUID;
	}

	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}

	public String getUserUID() {
		return userUID;
	}

	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}

	public String getReservationName() {
		return reservationName;
	}

	public void setReservationName(String reservationName) {
		this.reservationName = reservationName;
	}

	public String getReservationPhon() {
		return reservationPhon;
	}

	public void setReservationPhon(String reservationPhon) {
		this.reservationPhon = reservationPhon;
	}

	public String getReservationPeople() {
		return reservationPeople;
	}

	public void setReservationPeople(String reservationPeople) {
		this.reservationPeople = reservationPeople;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderPayType() {
		return orderPayType;
	}

	public void setOrderPayType(String orderPayType) {
		this.orderPayType = orderPayType;
	}

	public String getOrderRegDate() {
		return orderRegDate;
	}

	public void setOrderRegDate(String orderRegDate) {
		this.orderRegDate = orderRegDate;
	}

	public List<OrderMenu> getOrderMenu() {
		return orderMenu;
	}

	public void setOrderMenu(List<OrderMenu> orderMenu) {
		this.orderMenu = orderMenu;
	}

	public List<ShopReservationTable> getShopReservationTable() {
		return shopReservationTable;
	}

	public void setShopReservationTable(List<ShopReservationTable> shopReservationTable) {
		this.shopReservationTable = shopReservationTable;
	}
	
	
	
}

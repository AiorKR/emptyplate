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
	private int reservationPeople;
	private String orderStatus;
	private String orderPayType;
	private String orderRegDate;
	private int totalAmount;
	private String userName;
	
	private Toss toss;
	
	private String rDate;
	private long rNum;			
	private long startRow;		
	private long endRow;
	private String shopName;
	
	private List<OrderMenu> orderMenu;
	private List<ShopReservationTable> shopReservationTable;
	
	public Order() {
		orderUID = "";
		shopUID = "";
		userUID = "";
		reservationName = "";
		reservationPhon = "";
		reservationPeople = 0;
		orderStatus = "";
		orderPayType = "";
		orderRegDate = "";
		totalAmount = 0;
		userName = "";
		
		orderMenu = null;
		shopReservationTable = null;
		
		toss = null;
		
		rDate = "";
	    rNum = 0;
	    shopName = "";
		startRow = 0;
		endRow = 0;
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

	public int getReservationPeople() {
		return reservationPeople;
	}

	public void setReservationPeople(int reservationPeople) {
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

	public Toss getToss() {
		return toss;
	}

	public void setToss(Toss toss) {
		this.toss = toss;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getRDate() {
		return rDate;
	}

	public void setRDate(String rDate) {
		this.rDate = rDate;
	}
	
	public long getrNum() {
		return rNum;
	}


	public void setrNum(long rNum) {
		this.rNum = rNum;
	}


	public long getStartRow() {
		return startRow;
	}


	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}


	public long getEndRow() {
		return endRow;
	}


	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	
	public String getShopName() {
		return shopName;
	}


	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	
}

package com.icia.web.model;

import java.io.Serializable;

public class ShopTable implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String shopTableUID;
	private String shopTotalTableUID;
	
	private ShopReservationTable shopReservationTable;
	
	public ShopTable() {
		shopTableUID = "";
		shopTotalTableUID = "";
		
		shopReservationTable = null;
	}


	public String getShopTableUID() {
		return shopTableUID;
	}


	public void setShopTableUID(String shopTableUID) {
		this.shopTableUID = shopTableUID;
	}


	public String getShopTotalTableUID() {
		return shopTotalTableUID;
	}


	public void setShopTotalTableUID(String shopTotalTableUID) {
		this.shopTotalTableUID = shopTotalTableUID;
	}


	public ShopReservationTable getShopReservationTable() {
		return shopReservationTable;
	}


	public void setShopReservationTable(ShopReservationTable shopReservationTable) {
		this.shopReservationTable = shopReservationTable;
	}
	
}

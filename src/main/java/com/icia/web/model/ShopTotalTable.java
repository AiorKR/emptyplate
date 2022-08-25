package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class ShopTotalTable implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String shopTotalTableUID; //테이블 총 수량 uid
	private String shopUID; //매장 고유번호
	private int shopTotalTableCapacity; //테이블 몇인용인지  (수용인원)
	private int shopTotalTable; //테이블 총 갯수
	
	private List<ShopTable> shopTable;
	
	public ShopTotalTable(){
		shopTotalTableUID = "";
		shopUID = "";
		shopTotalTableCapacity = 0;
		shopTotalTable = 0;
		
		shopTable = null;
	}

	public String getShopTotalTableUID() {
		return shopTotalTableUID;
	}

	public void setShopTotalTableUID(String shopTotalTableUID) {
		this.shopTotalTableUID = shopTotalTableUID;
	}

	public String getShopUID() {
		return shopUID;
	}

	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}

	public int getShopTotalTableCapacity() {
		return shopTotalTableCapacity;
	}

	public void setShopTotalTableCapacity(int shopTotalTableCapacity) {
		this.shopTotalTableCapacity = shopTotalTableCapacity;
	}

	public int getShopTotalTable() {
		return shopTotalTable;
	}

	public void setShopTotalTable(int shopTotalTable) {
		this.shopTotalTable = shopTotalTable;
	}

	public List<ShopTable> getShopTable() {
		return shopTable;
	}

	public void setShopTable(List<ShopTable> shopTable) {
		this.shopTable = shopTable;
	}

	
	
}

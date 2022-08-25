package com.icia.web.model;

import java.io.Serializable;

public class Shop implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String shopUid;			//매장 고유번호
	private String userUid;			//관지자(유저)고유번호
	private String shopName;		//매장이름
	private String shopType;		//매장타입
	private String shopHoliday;		//매장휴일
	private String shopHashtag;
	private String shopLocation1;	//매장위치1 (도 시)
	private String shopLocation2;	//매장위치2 (시 군 구)
	private String shopLocation3;	//매장위치3 (동 면 읍)
	private String shopAddress;		//매장상세 주소
	private String shopTelephone;	//매장전화번호
	private String shopIntro;		//매장한줄소개
	private String shopContent;	//매장내용
	private String shopRegDate;		//매장등록일
	
	
	private long startRow;		//시작 rownum
	private long endRow;		//끝 rownum
	
	private String searchType;	//조회항목(0: 전체, 1: 파인다이닝. 2:오마카세)
	private String searchValue;	//검색값
	
	private ShopFile shopFile;
	
	
	public Shop() {
		shopUid = "";
		userUid = "";
		shopName = "";
		shopType = "";
		shopHoliday = "";
		shopHashtag = "";
		shopLocation1 = "";
		shopLocation2 = "";
		shopLocation3 = "";
		shopAddress = "";
		shopTelephone = "";
		shopIntro = "";
		shopContent = "";
		shopRegDate = "";
		
		shopFile = null;
		
	}


	public String getShopUid() {
		return shopUid;
	}


	public void setShopUid(String shopUid) {
		this.shopUid = shopUid;
	}


	public String getUserUid() {
		return userUid;
	}


	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}


	public String getShopName() {
		return shopName;
	}


	public void setShopName(String shopName) {
		this.shopName = shopName;
	}


	public String getShopType() {
		return shopType;
	}


	public void setShopType(String shopType) {
		this.shopType = shopType;
	}


	public String getShopHoliday() {
		return shopHoliday;
	}


	public void setShopHoliday(String shopHoliday) {
		this.shopHoliday = shopHoliday;
	}


	public String getShopHashtag() {
		return shopHashtag;
	}


	public void setShopHashtag(String shopHashtag) {
		this.shopHashtag = shopHashtag;
	}


	public String getShopLocation1() {
		return shopLocation1;
	}


	public void setShopLocation1(String shopLocation1) {
		this.shopLocation1 = shopLocation1;
	}


	public String getShopLocation2() {
		return shopLocation2;
	}


	public void setShopLocation2(String shopLocation2) {
		this.shopLocation2 = shopLocation2;
	}


	public String getShopLocation3() {
		return shopLocation3;
	}


	public void setShopLocation3(String shopLocation3) {
		this.shopLocation3 = shopLocation3;
	}


	public String getShopAddress() {
		return shopAddress;
	}


	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}


	public String getShopTelephone() {
		return shopTelephone;
	}


	public void setShopTelephone(String shopTelephone) {
		this.shopTelephone = shopTelephone;
	}


	public String getShopIntro() {
		return shopIntro;
	}


	public void setShopIntro(String shopIntro) {
		this.shopIntro = shopIntro;
	}


	public String getShopContent() {
		return shopContent;
	}


	public void setShopContent(String shopContent) {
		this.shopContent = shopContent;
	}


	public String getShopRegDate() {
		return shopRegDate;
	}


	public void setShopRegDate(String shopRegDate) {
		this.shopRegDate = shopRegDate;
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


	public String getSearchType() {
		return searchType;
	}


	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	public String getSearchValue() {
		return searchValue;
	}


	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}


	public ShopFile getShopFile() {
		return shopFile;
	}


	public void setShopFile(ShopFile shopFile) {
		this.shopFile = shopFile;
	}
	
}

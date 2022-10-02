package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class Shop implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String shopUID;			//매장 고유번호
	private String userUID;			//관지자(유저)고유번호
	private String shopName;		//매장이름
	private String shopType;		//매장타입
	private String shopHoliday;		//매장휴일
	private String shopHashtag;
	private String shopLocation1;	//매장위치1 도로명
	private String shopLocation2;	//매장위치2 지번
	private String shopAddress;		//매장상세 주소
	private String shopTelephone;	//매장전화번호
	private String shopIntro;		//매장한줄소개
	private String shopContent;	 	//매장내용
	private double reviewScore;
	private int reviewCount;
	private String shopRegDate;		//매장등록일
	private List<ShopReview> reviewList;
	private long startRow;		//시작 rownum
	private long endRow;		//끝 rownum
	
	private String searchType;	//조회항목(0: 전체, 1: 파인다이닝. 2:오마카세)
	private String searchValue;	//검색값
	
	private String reservationDate; //예약 날짜
	private String reservationTime; //예약 시간
	
	private ShopFile shopFile; //가게사진
	
	private List<ShopFile> shopFileList; //매장사진 리스트
	
	private List<ShopMenu> shopMenu; //매장 메뉴 리스트

	private List<ShopTime> shopTime; //매장 영업시간 리스트
	
	private List<ShopTotalTable> shopTotalTable; //매장 테이블 합계
	
	private List<Order> order; //매장 주문
	
	private int[] tableTypeArray;
	private int[] tableArray;
	private int tableArraySize;

	private String[] timeTypeArray;
	private String[] timeArray;
	private int timeArraySize;
	
	private String[] menuTypeArray;
	private String[] menuNameArray;
	private int[] menuPriceArray;
	private int menuArraySize;
	
	
	public Shop() {
		shopUID = "";
		userUID = "";
		shopName = "";
		shopType = "";
		shopHoliday = "";
		shopHashtag = "";
		shopLocation1 = "";
		shopLocation2 = "";
		shopAddress = "";
		shopTelephone = "";
		shopIntro = "";
		shopContent = "";
		reviewScore = 0;
		reviewCount = 0;
		shopRegDate = "";
		
		reservationDate = "";
		reservationTime = "";
		reviewList = null;
		shopFile = null;
		shopFileList = null;
		shopMenu = null;
		shopTime = null;
		shopTotalTable = null;
		order = null;
		
		tableTypeArray=null;
		tableArray=null;
		tableArraySize=0;
		
		timeTypeArray=null;
		timeArray=null;
		timeArraySize=0;
		
		menuTypeArray=null;
		menuNameArray=null;
		menuPriceArray=null;
		menuArraySize=0;
		
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

	public List<ShopMenu> getShopMenu() {
		return shopMenu;
	}


	public void setShopMenu(List<ShopMenu> shopMenu) {
		this.shopMenu = shopMenu;
	}


	public List<ShopTime> getShopTime() {
		return shopTime;
	}


	public void setShopTime(List<ShopTime> shopTime) {
		this.shopTime = shopTime;
	}


	public List<ShopTotalTable> getShopTotalTable() {
		return shopTotalTable;
	}


	public void setShopTotalTable(List<ShopTotalTable> shopTotalTable) {
		this.shopTotalTable = shopTotalTable;
	}


	public List<Order> getOrder() {
		return order;
	}


	public void setOrder(List<Order> order) {
		this.order = order;
	}


	public ShopFile getShopFile() {
		return shopFile;
	}


	public void setShopFile(ShopFile shopFile) {
		this.shopFile = shopFile;
	}


	public List<ShopFile> getShopFileList() {
		return shopFileList;
	}


	public void setShopFileList(List<ShopFile> shopFileList) {
		this.shopFileList = shopFileList;
	}


	public String getReservationDate() {
		return reservationDate;
	}


	public void setReservationDate(String reservationDate) {
		this.reservationDate = reservationDate;
	}


	public String getReservationTime() {
		return reservationTime;
	}


	public void setReservationTime(String reservationTime) {
		this.reservationTime = reservationTime;
	}


	public double getReviewScore() {
		return reviewScore;
	}


	public void setReviewScore(double reviewScore) {
		this.reviewScore = reviewScore;
	}


	public int getReviewCount() {
		return reviewCount;
	}


	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}


	public List<ShopReview> getReviewList() {
		return reviewList;
	}


	public void setReviewList(List<ShopReview> reviewList) {
		this.reviewList = reviewList;
	}


	public String[] getTimeTypeArray() {
		return timeTypeArray;
	}


	public void setTimeTypeArray(String[] timeTypeArray) {
		this.timeTypeArray = timeTypeArray;
	}


	public String[] getTimeArray() {
		return timeArray;
	}


	public void setTimeArray(String[] timeArray) {
		this.timeArray = timeArray;
	}


	public int getTimeArraySize() {
		return timeArraySize;
	}


	public void setTimeArraySize(int timeArraySize) {
		this.timeArraySize = timeArraySize;
	}


	public int[] getTableTypeArray() {
		return tableTypeArray;
	}


	public void setTableTypeArray(int[] tableTypeArray) {
		this.tableTypeArray = tableTypeArray;
	}


	public int[] getTableArray() {
		return tableArray;
	}


	public void setTableArray(int[] tableArray) {
		this.tableArray = tableArray;
	}


	public int getTableArraySize() {
		return tableArraySize;
	}


	public void setTableArraySize(int tableArraySize) {
		this.tableArraySize = tableArraySize;
	}


	public String[] getMenuTypeArray() {
		return menuTypeArray;
	}


	public void setMenuTypeArray(String[] menuTypeArray) {
		this.menuTypeArray = menuTypeArray;
	}


	public String[] getMenuNameArray() {
		return menuNameArray;
	}


	public void setMenuNameArray(String[] menuNameArray) {
		this.menuNameArray = menuNameArray;
	}


	public int[] getMenuPriceArray() {
		return menuPriceArray;
	}


	public void setMenuPriceArray(int	[] menuPriceArray) {
		this.menuPriceArray = menuPriceArray;
	}


	public int getMenuArraySize() {
		return menuArraySize;
	}


	public void setMenuArraySize(int menuArraySize) {
		this.menuArraySize = menuArraySize;
	}
	
	
	
}

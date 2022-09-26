package com.icia.web.model;

import java.io.Serializable;

public class ShopReview implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String orderUID;
	private String userUID;
	private String shopUID;
	private String shopReviewContent;
	private double shopScore;
	private String shopReviewRegDate;
	
	public ShopReview() {
		orderUID = "";
		userUID = "";
		shopUID = "";
		shopReviewContent = "";
		shopScore = 0;
		shopReviewRegDate = "";
	}

	public String getOrderUID() {
		return orderUID;
	}

	public void setOrderUID(String orderUID) {
		this.orderUID = orderUID;
	}

	public String getUserUID() {
		return userUID;
	}

	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}

	public String getShopUID() {
		return shopUID;
	}

	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}

	public String getShopReviewContent() {
		return shopReviewContent;
	}

	public void setShopReviewContent(String shopReviewContent) {
		this.shopReviewContent = shopReviewContent;
	}

	public double getShopScore() {
		return shopScore;
	}

	public void setShopScore(double shopScore) {
		this.shopScore = shopScore;
	}

	public String getShopReviewRegDate() {
		return shopReviewRegDate;
	}

	public void setShopReviewRegDate(String shopReviewRegDate) {
		this.shopReviewRegDate = shopReviewRegDate;
	}
	
}

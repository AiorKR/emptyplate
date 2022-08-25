package com.icia.web.model;

import java.io.Serializable;

public class ShopFile implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String shopUID;
	private long shopFileSeq;
	private String shopFileOrgName;
	private String shopFileName;
	private String shopFileExt;
	private String shopFileSize;
	private String shopFileRegDate;
	
	
	public ShopFile() {
		shopUID = "";
		shopFileSeq = 0;
		shopFileOrgName = "";
		shopFileName = "";
		shopFileExt = "";
		shopFileSize = "";
		shopFileRegDate = "";
	}


	public String getShopUID() {
		return shopUID;
	}


	public void setShopUID(String shopUID) {
		this.shopUID = shopUID;
	}


	public long getShopFileSeq() {
		return shopFileSeq;
	}


	public void setShopFileSeq(long shopFileSeq) {
		this.shopFileSeq = shopFileSeq;
	}


	public String getShopFileOrgName() {
		return shopFileOrgName;
	}


	public void setShopFileOrgName(String shopFileOrgName) {
		this.shopFileOrgName = shopFileOrgName;
	}


	public String getShopFileName() {
		return shopFileName;
	}


	public void setShopFileName(String shopFileName) {
		this.shopFileName = shopFileName;
	}


	public String getShopFileExt() {
		return shopFileExt;
	}


	public void setShopFileExt(String shopFileExt) {
		this.shopFileExt = shopFileExt;
	}


	public String getShopFileSize() {
		return shopFileSize;
	}


	public void setShopFileSize(String shopFileSize) {
		this.shopFileSize = shopFileSize;
	}


	public String getShopFileRegDate() {
		return shopFileRegDate;
	}


	public void setShopFileRegDate(String shopFileRegDate) {
		this.shopFileRegDate = shopFileRegDate;
	}
	
	
}

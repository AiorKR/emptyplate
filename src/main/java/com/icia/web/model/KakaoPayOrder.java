package com.icia.web.model;

import java.io.Serializable;

public class KakaoPayOrder implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String partnerOrderId;		//가맹점 주문번호 최대 100자
	private String partnerUserId;		//가맹점 회원id 최대 100자
	private String itemName;			//상품명 최대 100자
	private String itemCode;			//상품코드 최대 100자
	private int quantity;				//상품 수량
	private int totalAmount;			//상품 총액
	private int taxFreeAmount;			//상품 비과세 금액
	private int vatAmount;				//부가새 금액(보내지 않으면 자동계산 : (삼품총액 - 상품 비과세 금액)/11 = 소수점이하 버림)
	
	private String tId;					//결제 고유 번호 20자
	private String pgToken;				//결제스인요청을 인증하는 토큰 사용자 결제수단 (선택 완료시, approvla_url로 redirectint해줄때
										//pg_token을 query String으로 전달)
	
	
	public KakaoPayOrder()
	{
		partnerOrderId = "";
		partnerUserId = "";
		itemName = "";
		itemCode = "";
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;
		tId = "";
		pgToken = "";
	}
	//밑에는 source getter setter로 자동완성

	public String getPartnerOrderId() {
		return partnerOrderId;
	}


	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}


	public String getPartnerUserId() {
		return partnerUserId;
	}


	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}


	public String getItemName() {
		return itemName;
	}


	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public String getItemCode() {
		return itemCode;
	}


	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public int getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}


	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}


	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}


	public int getVatAmount() {
		return vatAmount;
	}


	public void setVatAmount(int vatAmount) {
		this.vatAmount = vatAmount;
	}


	public String gettId() {
		return tId;
	}


	public void settId(String tId) {
		this.tId = tId;
	}


	public String getPgToken() {
		return pgToken;
	}


	public void setPgToken(String pgToken) {
		this.pgToken = pgToken;
	}
	
	
	
}
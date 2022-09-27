package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Order;
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopReservationTable;
import com.icia.web.model.ShopReview;
import com.icia.web.model.ShopTotalTable;
import com.icia.web.model.User;

@Repository("shopdDao")
public interface ShopDao {
	
	//인덱스 매장 리스트
	public List<Shop> indexShopList(Shop shop);
	
	public long shopListTotlaCount(Shop shop); //매장 카운트
	
	public List<Shop> shopList(Shop shop); //매장 리스트
	
	public int shopInsert(Shop shop); //매장 insert
	
	public int shopFileInsert(List<ShopFile> list); //매장 file insert
	
	public Shop shopViewSelect(String shopUID); //매장 view select
	
	public List<ShopTotalTable> shopReservationCheck(Shop shop); //예약 자리 있는지 select
	
	public long orderUIDcreate(); //주문번호 생성을 위한 시퀀스 조회
	
	public List<Order> myOrderList(Order order);

	public long myOrderListCount(String userUID); 
	//동일 즐겨찾기 여부 확인
	public int shopMarkCheck(Shop shop);
		
	//즐겨찾기 추가
	public int shopMarkUpdate(Shop shop);
	
	//즐겨찾기 취소
	public int shopMarkDelete(Shop shop);
	
	//즐겨찾기 리스트
	public List<Shop> shopMarkList(String shopUID);
	
	//게시물 즐겨찾기 총 게시물 수
	public long shopMarkListCount(Shop shop);
	public int orderInsert(Order order);
	
	public int orderMenuInsert(List<OrderMenu> list);
	
	public int reservationTableInser(List<ShopReservationTable> list);

	public List<OrderMenu> myOrderMenu(String orderUID);
	
	public int regReqOne(ShopReview shopReview);

	public int countReqOne(ShopReview shopReview);

	public int updateReqOne(ShopReview shopReview);

	public int delReqOne(ShopReview shopReview);

	public Order selectRes(String orderUID);

	public int delRes(String orderUID);

	public int delTable(String orderUID);

	public int delTableN(String orderUID);
	
	//SHOP UID SELECT
	public Shop shopUIDSelect(String shopUID);
	
	//Shop테이블 userUID컬럼에 매장가입자(userUID)추가
	public int updateStoreUserUID(Shop shop);
}
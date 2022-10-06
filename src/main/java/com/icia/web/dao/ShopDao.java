package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Order;
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopMenu;
import com.icia.web.model.ShopReservationTable;
import com.icia.web.model.ShopReview;
import com.icia.web.model.ShopTable;
import com.icia.web.model.ShopTime;
import com.icia.web.model.ShopTotalTable;

@Repository("shopdDao")
public interface ShopDao {
	
	//인덱스 매장 리스트
	public List<Shop> indexShopList(Shop shop);
	
	public long shopListTotlaCount(Shop shop); //매장 카운트
	
	public List<Shop> shopList(Shop shop); //매장 리스트
	
	public int shopInsert(Shop shop); //매장 insert
	
	public List<ShopFile> shopFileList(String shopUID);
	
	public Shop shopViewSelect(String shopUID); //매장 view select
	
	public Shop shopManagerUIDSelect(String userUID); //매장관리자 페이지
	
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
	
	public int delResX(String orderUID);

	public int delTable(String orderUID);

	public int delTableN(String orderUID);
	
	//SHOP UID SELECT
	public Shop shopUIDSelect(String shopUID);
	
	//Shop테이블 userUID컬럼에 매장가입자(userUID)추가
	public int updateStoreUserUID(Shop shop);
	
	public List<ShopTime> shopListTime();
	
	public List<Order> noShowImminent(); //NOSHOW 마감 임박
	
	public List<Order> noShow(Shop shop); // NOSHOW
	
	public Order noShowSelect(String orderUID); // NOSHOW
	
	public List<ShopTotalTable> shopCheckTable(String shopUID); //테이블 현황
	
	public List<ShopTime> shopCheckTime(String shopUID); //영업시간 현황
	
	public List<ShopMenu> shopCheckMenu(String shopUID); //메뉴 현황
	
	public int shopUpdate(Shop shop);
	
	public Order orderSelect(String orderUID);
	
	public int reservationTableUpdate(Order order);
	
	public int shopTableInsert(ShopTotalTable shopTotalTable);
	
	public int shopTableCheck(ShopTotalTable shopTotalTable);
	
	public int shopTableUpdate(ShopTotalTable shopTotalTable);
	
	public int shopTableZeroUpdate(ShopTotalTable shopTotalTable); //매장 테이블 비활성화
	
	public int shopTimeInsert(ShopTime shopTime);
	
	public int shopTimeCheck(ShopTime shopTime);
	
	public int shopTimeDelete(ShopTime shopTime);
	
	public int shopMenuInsert(ShopMenu shopMenu);
	
	public int shopMenuCheck(ShopMenu shopMenu);
	
	public int shopMenuDelete(ShopMenu shopMenu);	
	
	public int shopFileInsert(List<ShopFile> list); //매장 file insert
	
	public List<ShopFile> shopFileSelect(String shopUID);
	
	public int shopFileDelete(String shopUID);
	
	public int shopTableInsert2(List<ShopTable> list);
}
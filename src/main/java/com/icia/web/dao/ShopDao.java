package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopTotalTable;

@Repository("shopdDao")
public interface ShopDao {
	
	public long shopListTotlaCount(Shop shop); //매장 카운트
	
	public List<Shop> shopList(Shop shop); //매장 리스트
	
	public int shopInsert(Shop shop); //매장 insert
	
	public int shopFileInsert(List<ShopFile> list); //매장 file insert
	
	public Shop shopViewSelect(String shopUID); //매장 view select
	
	public List<ShopTotalTable> shopReservationCheck(Shop shop); //예약 자리 있는지 select
}
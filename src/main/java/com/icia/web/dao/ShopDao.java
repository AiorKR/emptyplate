package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Shop;

@Repository("shopdDao")
public interface ShopDao {
	
	public long shopListTotlaCount(Shop shop);
	
	public List<Shop> shopList(Shop shop);
}

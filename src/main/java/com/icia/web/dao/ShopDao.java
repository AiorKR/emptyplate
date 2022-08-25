package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;

@Repository("shopdDao")
public interface ShopDao {
	
	public long shopListTotlaCount(Shop shop);
	
	public List<Shop> shopList(Shop shop);
	
	public int shopInsert(Shop shop);
	
	public int ShopFileInsert(List<ShopFile> list);

}
package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopMenu;
import com.icia.web.model.ShopTime;

@Repository("shopdDao")
public interface ShopDao {
	
	public long shopListTotlaCount(Shop shop);
	
	public List<Shop> shopList(Shop shop);
	
	public int shopInsert(Shop shop);
	
	public int shopFileInsert(List<ShopFile> list);
	
	public Shop shopSelect(String shopUID);
	
	public List<ShopFile> shopFileSelect(String shopUID);
	
	public List<ShopMenu> shopMenuSelect(String shopUID);

	public List<ShopTime> shopTimeSelect(String shopUID);
}
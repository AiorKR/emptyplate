package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.ShopDao;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopTotalTable;

@Service("shopService")
public class ShopService {
	
	private static Logger logger = LoggerFactory.getLogger(ShopService.class);
	
	//파일 저장 경로
	@Value("#{env['shop.upload.dir']}")
	private String SHOP_UPLOAD_DIR;
	
	@Autowired
	private ShopDao shopDao;
	
		public long shopListCount(Shop shop) //매장 총 갯수
		{
			long count = 0;
			
			try {
				count = shopDao.shopListTotlaCount(shop);
			}
			catch(Exception e) {
				logger.error("[ShopService] shopListCount Exception", e);
			}
			logger.debug("searchType : " +  shop.getSearchType());
			logger.debug("count : " +  count);
			
			return count;
		}
		
		//게시물 리스트
		public List<Shop> shopList(Shop shop) { //shop 조회 
			
			List<Shop> list = null;
			
			
			logger.debug("searchType : " +  shop.getSearchType());
			
			try
			{	
				list = shopDao.shopList(shop);
				
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopList Exception", e);
			}
			
			
			return list;
		}
		//매장 상세페이지
		public Shop shopViewSelect(String shopUID) {
			Shop shop = null;
			
			logger.debug("들어옴1");
			logger.debug("shopUID : " + shopUID);
			try {
				
			   shop = shopDao.shopViewSelect(shopUID);
			
			   logger.debug("파일 사이즈 : " + shop.getShopFileList().size());	
			   
			   logger.debug("메뉴 사이즈 : " + shop.getShopMenu().size());
		   
			   logger.debug("시간 사이즈 : " + shop.getShopTime().size());
				   
			}
			
			catch(Exception e) {
				logger.error("[ShopService] ShopViewSelect", e);
			}
			
			logger.debug("들어옴3");
			
			return shop;
		}
		
		public List<ShopTotalTable> shopReservationCheck(Shop shop) {
			List<ShopTotalTable> shopTotlaTable = null;
			
			try {
				shopTotlaTable = shopDao.shopReservationCheck(shop);
			}
			catch(Exception e) {
				logger.error("[ShopService] shopReservationCheck", e);
			}
			return shopTotlaTable;
		}
		
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int shopInsert(Shop shop) throws Exception
		{	//Propagation.REQUIRED : 트랜젝션이 있으면 그 트랜젝션에서 실행,
			//없으면 새로운 트랜젝션을 실행(기본설정)
		
			int count = shopDao.shopInsert(shop);
			logger.debug("shop.getShopFileList() : " + shop.getShopFileList());
			//게시물 등록 후 첨부파일이 잇으면 첨부파일 등록
			if(count > 0 && shop.getShopFileList() != null) {
				List<ShopFile> shopFileList = shop.getShopFileList();	
				
				logger.debug("ShopFileList(쿼리 날리기 마지막 전) : " + shopFileList);
				logger.debug("ShopFile이름(쿼리 날리기 마지막 전) : " + shopFileList.get(0).getShopFileName());
				logger.debug("ShopFile원본이름(쿼리 날리기 마지막 전) : " + shopFileList.get(0).getShopFileOrgName());
				logger.debug("ShopFile사이즈(쿼리 날리기 마지막 전) : " + shopFileList.get(0).getShopFileSize());
				logger.debug("ShopFile확장자(쿼리 날리기 마지막 전) : " + shopFileList.get(0).getShopFileExt());
				
				shopDao.shopFileInsert(shopFileList);
			}
			
			return count;
		}
}

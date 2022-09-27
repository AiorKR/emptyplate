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
import com.icia.web.model.Order;
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopReview;
import com.icia.web.model.ShopTotalTable;

@Service("shopService")
public class ShopService {
	
	private static Logger logger = LoggerFactory.getLogger(ShopService.class);
	
	//파일 저장 경로
	@Value("#{env['shop.upload.dir']}")
	private String SHOP_UPLOAD_DIR;
	
	@Autowired
	private ShopDao shopDao;
		
		public List<Shop> indexShopList(Shop shop)
		{
			List<Shop> list = null;
			
			try
			{	
				list = shopDao.indexShopList(shop);
				
			}
			catch(Exception e)
			{
				logger.error("[ShopService] indexShopList Exception", e);
			}
			
			
			return list;
		}
	
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
		
		public List<ShopTotalTable> shopReservationCheck(Shop shop) {  //매장 빈자리 확인
			List<ShopTotalTable> shopTotlaTable = null;
			
			try {
				shopTotlaTable = shopDao.shopReservationCheck(shop);
			}
			catch(Exception e) {
				logger.error("[ShopService] shopReservationCheck", e);
			}
			return shopTotlaTable;
		}
		
		public long orderUIDcreate() {
			long count = 0;
			
			try {
				count = shopDao.orderUIDcreate();
			}
			catch(Exception e) {
				logger.debug("[Shopservice] orderUIDcreate", e);
			}
			
			return count;
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
		
		//내 주문내역 리스트
	      public List<Order> myOrderList(Order order) {
	          
	          List<Order> list = null;
	          
	          try
	          {   
	             list = shopDao.myOrderList(order);
	             
	          }
	          catch(Exception e)
	          {
	             logger.error("[ShopService] myOrderList Exception", e);
	          }
					
			return list;
		}
	      
        //내 주문 매뉴
		public List<OrderMenu> myOrderMenu(String orderUID) {
			List<OrderMenu> list = null;
	          
	          try
	          {   
	             list = shopDao.myOrderMenu(orderUID);
	             
	          }
	          catch(Exception e)
	          {
	             logger.error("[ShopService] myOrderMenu Exception", e);
	          }
					
			return list;
		}
		
	      //주문내역 총 수
	      public long myOrderListCount(String userUID)
	      {
	         long count = 0;
	         
	         try
	         {
	            count = shopDao.myOrderListCount(userUID);
	         }
	         catch(Exception e)
	         {
	            logger.error("[BoardService] userListCount Exception", e);
	         }
	         
	         return count;
	      }
		
		//동일 즐겨찾기 여부 확인
		public int shopMarkCheck(Shop shop)
		{
			int count = 0;
			
			try
			{
				count = shopDao.shopMarkCheck(shop);
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopMarkCheck Exception", e);
			}
			
			return count;
		}
		
		//즐겨찾기 추가
		public int shopMarkUpdate(Shop shop)
		{
			int count = 0;
			
			try
			{
				count = shopDao.shopMarkUpdate(shop);
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopMarkUpdate Exception", e);
			}
			
			return count;
		}
		
		//즐겨찾기 취소
		public int shopMarkDelete(Shop shop)
		{
			int count = 0;
			
			try
			{
				count = shopDao.shopMarkDelete(shop);
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopMarkDelete Exception", e);
			}
			
			return count;
		}
		
		//즐겨찾기 리스트
		public List<Shop> shopMarkList(String shopUID)
		{
			List<Shop> shopMarklist = null;
			
			try
			{
				shopMarklist = shopDao.shopMarkList(shopUID);
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopMarkList Exception", e);
			}
			
			return shopMarklist;
		}
		
		public long shopMarkListCount(Shop shop)
		{
			long count = 0;
			
			try
			{
				count = shopDao.shopMarkListCount(shop);
			}
			catch(Exception e)
			{
				logger.error("[ShopService] shopMarkListCount Exception", e);
			}
			
			return count;
		}
		
		   public int regReqOne(ShopReview shopReview) {
		         int count = 0;
		            
		            try
		            {
		               count = shopDao.regReqOne(shopReview);
		            }
		            catch(Exception e)
		            {
		               logger.error("[ShopService]regOne Exception", e);
		            }
		            return count;
		      }

		      public int countReqOne(ShopReview shopReview) {
		         int count = 0;
		            
		            try
		            {
		               count = shopDao.countReqOne(shopReview);
		            }
		            catch(Exception e)
		            {
		               logger.error("[ShopService]countReqOne Exception", e);
		            }
		            return count;
		      }

		      public int updateReqOne(ShopReview shopReview) {
		         int count = 0;
		            
		            try
		            {
		               count = shopDao.updateReqOne(shopReview);
		            }
		            catch(Exception e)
		            {
		               logger.error("[ShopService]updateReqOne Exception", e);
		            }
		            return count;
		      }

			public int delReqOne(ShopReview shopReview) {
				int count = 0;
	            
	            try
	            {
	               count = shopDao.delReqOne(shopReview);
	            }
	            catch(Exception e)
	            {
	               logger.error("[ShopService]delReqOne Exception", e);
	            }
	            return count;
			}

			public Order selectRes(String orderUID)
			{	
				Order order = null;
				try
				{
					order = shopDao.selectRes(orderUID);
				}
				catch(Exception e)
				{
					logger.error("[ShopService]selectRes Exception", e);
				}
				
				return order;
			}

			public int delRes(String orderUID) {
				int count = 0;
	           
	            try
	            {
	               count = shopDao.delRes(orderUID);
	            }
	            catch(Exception e)
	            {
	               logger.error("[ShopService]delRes Exception", e);
	            }
	            return count;
			}

			public int delTable(String orderUID) {
				int count = 0;
		           
	            try
	            {
	               count = shopDao.delTable(orderUID);
	            }
	            catch(Exception e)
	            {
	               logger.error("[ShopService]delTable Exception", e);
	            }
	            return count;
			}

			public int delTableN(String orderUID) {
				int count = 0;
		           
	            try
	            {
	               count = shopDao.delTableN(orderUID);
	            }
	            catch(Exception e)
	            {
	               logger.error("[ShopService]delTableN Exception", e);
	            }
	            return count;
			}
}

package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.dao.ShopDao;
import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.Order;
import com.icia.web.model.OrderMenu;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopMenu;
import com.icia.web.model.ShopReview;
import com.icia.web.model.ShopTime;
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
		
		public Shop shopManagerUIDSelect(String userUID)
		{
			Shop shop = new Shop();
			ShopFile shopFile = new ShopFile();
			try
			{
				shop = shopDao.shopManagerUIDSelect(userUID);
			}
			catch(Exception e){
				logger.error("[ShopService] ShopViewSelect", e);
			}
			
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
		
		public List<ShopFile> shopFileList(String shopUID)
		{
			List<ShopFile> list = null;
			try
			{
				list = shopDao.shopFileList(shopUID);
			}
			catch(Exception e)
			{
				logger.debug("[Shopservice] shopFileList", e);
			}
			return list;
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

		public List<Order> noShowImminent() {
			List<Order> list = null;
			
			try {
				list = shopDao.noShowImminent();
				logger.debug("noshow 임박 갯수 : " + list.size());
			}
			catch(Exception e) {
				logger.error("[Shopservice] noShowImminent", e);
			}
			
			return list;
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
			
			public int delResX(String orderUID) {
				int count = 0;
	           
	            try
	            {
	               count = shopDao.delResX(orderUID);
	            }
	            catch(Exception e)
	            {
	               logger.error("[ShopService]delResX Exception", e);
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

		
			public Shop shopUIDSelect(String shopUID)
			{
				Shop shop = null;
				
				try
				{
					shop = shopDao.shopUIDSelect(shopUID);
				}
				catch(Exception e)
				{
					logger.error("[UserService] userSelect Exception", e);
				}
				
				return shop;
			}
			
			public int updateStoreUserUID(Shop shop)
			{
				int count = 0;
				
				try
				{
					count = shopDao.updateStoreUserUID(shop);
				}
				catch(Exception e)
				{
					logger.error("[ShopService] updateStoreUserUID exception", e);
				}
				
				return count;
			}		

		public List<ShopTime> shopListTime() {
			List<ShopTime> list = null;
			
			try {
				list = shopDao.shopListTime();
				logger.debug("가져온 리스트 시간 목록 size : " + list.size());
			}
			catch(Exception e) {
				logger.error("[Shopservice] shopListTimeList", e);
			}
			
			return list;
		}
			
		public List<Order> noShow(Shop shop) {
			List<Order> list = null;
			
			try {
				list = shopDao.noShow(shop);
				logger.debug("noshow 갯수 : " + list.size());
			}
			catch(Exception e) {
				logger.error("[Shopservice] noShow", e);
			}
			
			return list;
		}
		
		public Order noShowSelect(String orderUID) {
			Order order = null;
			
			try {
				order = shopDao.noShowSelect(orderUID);
			}
			catch(Exception e) {
				logger.error("[Shopservice] noShowSelect", e);
			}
			
			return order;
		}
		
		public Order orderSelect(String orderUID) {
			Order order = null;
			
			try {
				order = shopDao.orderSelect(orderUID);
			}
			catch(Exception e) {
				logger.error("[Shopservice] orderSelect", e);
			}
			
			return order;
		}
		
		//테이블 현황
		public List<ShopTotalTable> shopCheckTable(String shopUID) {
			List<ShopTotalTable> list = null;
			
			try
            {
               list = shopDao.shopCheckTable(shopUID);
            }
            catch(Exception e)
            {
               logger.error("[ShopService]ShopCheckTable Exception", e);
            }
			
            return list;
		}
		
		//영업시간 현황
		public List<ShopTime> shopCheckTime(String shopUID){
			List<ShopTime> list = null;
			
			try
            {
               list = shopDao.shopCheckTime(shopUID);
            }
            catch(Exception e)
            {
               logger.error("[ShopService]ShopCheckTime Exception", e);
            }
			
            return list;
		}
		
		//메뉴 현황
		public List<ShopMenu> shopCheckMenu(String shopUID){
			List<ShopMenu> list = null;
			
			try
            {
               list = shopDao.shopCheckMenu(shopUID);
            }
            catch(Exception e)
            {
               logger.error("[ShopService]ShopCheckMenu Exception", e);
            }
			
            return list;
		}
		
		
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int shopUpdate(Shop shop) throws Exception
		{
			int count = shopDao.shopUpdate(shop);	
			ShopTime shopTime = new ShopTime();
			ShopTotalTable shopTotalTable = new ShopTotalTable();
			ShopMenu shopMenu = new ShopMenu();

			if(count > 0)
			{
				//매장시간
				shopTime.setShopUID(shop.getShopUID());
				shopDao.shopTimeDelete(shopTime);
				if(shopDao.shopTimeCheck(shopTime) == 0)
				{
					for(int i=1;i<=shop.getTimeArraySize();i++)
					{
						shopTime.setShopTimeType(shop.getTimeTypeArray()[i]);
						shopTime.setShopOrderTime(shop.getTimeArray()[i]);
						if(StringUtil.isEmpty(shop.getTimeTypeArray()[i]) || StringUtil.isEmpty(shop.getTimeArray()[i]))
						{
							break;
						}
						shopDao.shopTimeInsert(shopTime);
						logger.debug("################## ShopTime Insert Complete " +i+ " ##################");
					}
				}
				
				//매장테이블
				shopTotalTable.setShopUID(shop.getShopUID());
				shopDao.shopTableZeroUpdate(shopTotalTable);
				for(int i=1; i<=shop.getTableArraySize();i++)
				{
					shopTotalTable.setShopTotalTableUID(shop.getShopUID()+"_"+shop.getTableTypeArray()[i]);
					shopTotalTable.setShopTotalTableCapacity(shop.getTableTypeArray()[i]);
					shopTotalTable.setShopTotalTable(shop.getTableArray()[i]);
					if(shop.getTableTypeArray()[i] == 0 || shop.getTableArray()[i] == 0)
					{
						break;
					}
					if(shopDao.shopTableCheck(shopTotalTable) > 0)
					{
						shopDao.shopTableUpdate(shopTotalTable);
					}
					else
					{
						shopDao.shopTableInsert(shopTotalTable);
					}
					
					logger.debug("################## ShopTable Update Complete " +i+ " ##################");
				}
				
				//메뉴
				shopMenu.setShopUID(shop.getShopUID());
				shopDao.shopMenuDelete(shopMenu);
				if(shopDao.shopMenuCheck(shopMenu) == 0)
				{
					for(int i=1;i<=shop.getMenuArraySize();i++)
					{
						shopMenu.setShopMenuCode(shop.getMenuTypeArray()[i]);
						shopMenu.setShopMenuName(shop.getMenuNameArray()[i]);
						shopMenu.setShopMenuPrice(shop.getMenuPriceArray()[i]);
						if(StringUtil.isEmpty(shop.getMenuTypeArray()[i]) || StringUtil.isEmpty(shop.getMenuNameArray()[i]) || StringUtil.isEmpty(shop.getMenuPriceArray()[i]))
						{
							break;
						}
						shopDao.shopMenuInsert(shopMenu);
						logger.debug("################## ShopMenu Insert Complete " +i+ " ##################");
					}
				}
			
			}
			return count;
		}
}

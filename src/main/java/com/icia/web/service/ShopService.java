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

@Service("shopService")
public class ShopService {
	
	private static Logger logger = LoggerFactory.getLogger(ShopService.class);
	
	//파일 저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
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
		public List<Shop> shopList(Shop shop) //shop 조회
		{
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
}

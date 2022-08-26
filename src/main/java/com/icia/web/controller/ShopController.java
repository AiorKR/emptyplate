package com.icia.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.HttpUtil;

@Controller("shopController")
public class ShopController {
	
	private static Logger logger = LoggerFactory.getLogger(ShopController.class);
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['shop.upload.image.dir']}")
	private String SHOP_UPLOAD_IMAGE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	private static final int LIST_COUNT = 5;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
	
	
	//게시판 리스트
		@RequestMapping(value="/reservation/list")
		public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			//조회항목
			String searchType = HttpUtil.get(request, "searchType");
			//조회값
			String searchValue = HttpUtil.get(request, "searchValue", "");
			//현재페이지
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			//총 게시물 수
			long totalCount = 0;
			//게시물 리스트
			List<Shop> list = null;
			//페이징 객체
			Paging paging = null;
			
			String backslash = "\\";
			
			logger.debug(backslash);
			//조회 객체
			Shop search = new Shop();
			
			if(StringUtil.equals(searchType, "1") || StringUtil.equals(searchType, "2")) { // 1: 파인다이닝 2:오마카세
				
				search.setSearchType(searchType);
			}
			else { //searchType을 선택 안했거나 또는 값이 이상한 경우는 무족건 0: 전체 로 고정
				search.setSearchType("0");
			}
			
			if(!StringUtil.isEmpty(searchValue) && !StringUtil.equals(searchValue, "")) { //검색 값이 있냐 또는 공백이냐를 체크
				search.setSearchValue(searchValue);
			}
			
			totalCount = shopService.shopListCount(search); //총 매장 수를 확인
			
			logger.debug("totalCount : " + totalCount);
			
			if(totalCount > 0)
			{
				paging = new Paging("/reservation/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				
				logger.debug("starRow : " + search.getStartRow());
				logger.debug("endRow : " + search.getEndRow());
				
				list = shopService.shopList(search);
			}
			
			for(int i = 0; i < list.size(); i++) {
				logger.debug("받아온  shop이름 list 내역 : " +list.get(i).getShopName());
				logger.debug("받아온  shop이름 list 내역 : " +list.get(i).getShopFile().getShopFileName());
			}
			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("backslash", backslash);
			
			return "/reservation/list";
		}
		
		
		
		//임시 매장 정보 인서트
		@RequestMapping(value="/reservation/shopInsert")
		public String shopInsert(HttpServletRequest request, HttpServletResponse response) {
			return "/reservation/shopInsert";
		}
		
		
		@RequestMapping(value="/reservation/shopInsertProc")
		@ResponseBody
		public Response<Object> shopInsertProc(MultipartHttpServletRequest request, HttpServletResponse response) {
			Response<Object> ajax = new Response<Object>();
					
			int fileQuantity = HttpUtil.get(request, "fileQuantity", 0);
			
			List<ShopFile> shopFileList = new ArrayList<ShopFile>();
			
			String shopUID = "Shop_a93d61d0-3d15-4060-9bbe-9fd5e22c397b";
			String userUID = "a93d61d0-3d15-4060-9bbe-9fd5e22c397b";
			String shopName = HttpUtil.get(request, "shopName");
			String shopType = HttpUtil.get(request, "shopType");
			String shopHoliday = HttpUtil.get(request, "shopHoliday");
			String shopLocation1 = HttpUtil.get(request, "shopLocation1");
			String shopLocation2 = HttpUtil.get(request, "shopLocation2");
			String shopLocation3 = HttpUtil.get(request, "shopLocation3");
			String shopAddress = HttpUtil.get(request, "shopAddress");
			String shopHashtag = HttpUtil.get(request, "shopHashtag");
			String shopTelephon = HttpUtil.get(request, "shopTelephon");
			String shopIntro = HttpUtil.get(request, "shopIntro");
			String shopContent = HttpUtil.get(request, "shopContent");
			
			String[] name = new String[100];
			
			
			for(int i=0; i < fileQuantity; i++) {
				logger.debug("i값 : " + i);
				name[i] = "shopFile";
				name[i] += Integer.toString(i);;
				
				logger.debug("name[i] : " + name[i]);
				
				if(StringUtil.equals(name[i], "shopFile0")) {
					logger.debug("값이 같음!!!!0");
				}
				
				if(StringUtil.equals(name[i], "shopFile1")) {
					logger.debug("값이 같음!!!!1");
				}
				
				if(StringUtil.equals(name[i], "shopFile2")) {
					logger.debug("값이 같음!!!!2");
				}
				
				FileData fileData = new FileData();
				fileData = (HttpUtil.getFile(request, name[i], SHOP_UPLOAD_IMAGE_DIR));
       		 	
				logger.debug("fileData(첨 파일 받을때) : " + fileData);
				logger.debug("fileData이름(첨 파일 받을때) : " + fileData.getFileName());
				logger.debug("fileData원본이름(첨 파일 받을때) : " + fileData.getFileOrgName());
				logger.debug("fileData사이즈(첨 파일 받을때) : " + fileData.getFileSize());
				logger.debug("fileData확장자(첨 파일 받을때) : " + fileData.getFileExt());
				
				ShopFile shopFile = new ShopFile();
				
				if(fileData != null) {
					shopFile.setShopUID(shopUID);
			   		shopFile.setShopFileSeq(i);
			   		shopFile.setShopFileName(fileData.getFileName());
			   		shopFile.setShopFileOrgName(fileData.getFileOrgName());
			   		shopFile.setShopFileExt(fileData.getFileExt());
			   		shopFile.setShopFileSize(fileData.getFileSize());
				}
		   		logger.debug("shopFileName : " + shopFile.getShopFileName());
		   		 
		   		 shopFileList.add(shopFile);
			}
			logger.debug("shopFileList : " + shopFileList);
			
		      Shop shop = new Shop();
		      shop.setShopFileList(shopFileList);
    
		      shop.setShopUID(shopUID);
		      shop.setUserUID(userUID);
		      shop.setShopName(shopName);
		      shop.setShopType(shopType);
		      shop.setShopHoliday(shopHoliday);
		      shop.setShopLocation1(shopLocation1);
		      shop.setShopLocation2(shopLocation2);
		      shop.setShopLocation3(shopLocation3);
		      shop.setShopAddress(shopAddress);
		      shop.setShopHashtag(shopHashtag);
		      shop.setShopTelephone(shopTelephon);
		      shop.setShopIntro(shopIntro);
		      shop.setShopContent(shopContent);
		      
				logger.debug("ShopFileList(서비스 날리기 마지막 전) : " + shopFileList);
				logger.debug("ShopFile이름(서비스 날리기 마지막 전) : " + shopFileList.get(0).getShopFileName());
				logger.debug("ShopFile원본이름(서비스 날리기 마지막 전) : " + shopFileList.get(0).getShopFileOrgName());
				logger.debug("ShopFile사이즈(서비스 날리기 마지막 전) : " + shopFileList.get(0).getShopFileSize());
				logger.debug("ShopFile확장자(서비스 날리기 마지막 전) : " + shopFileList.get(0).getShopFileExt());
				
		      
		         //service호출
		         try
		         {
		            if(shopService.shopInsert(shop) > 0)
		            {
		            	ajax.setResponse(0, "success");
		            }
		            else
		            {
		            	ajax.setResponse(500, "internal server error");
		            }
		         }
		         catch(Exception e)
		         {
		            logger.error("ShopController]/Shop writeProc Exception", e);
		            ajax.setResponse(500, "internal server error");
		         }
		         
			return ajax;
		}
}

package com.icia.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopTotalTable;
import com.icia.web.service.ShopService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;


@Controller("shopController")
public class ShopController {
	
	private static Logger logger = LoggerFactory.getLogger(ShopController.class);
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['shop.upload.save.dir']}")
	private String SHOP_UPLOAD_DIR;
	
	
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
			
			//데이터피커에서 선택한 예약일
			String reservationDate = HttpUtil.get(request, "reservationDate");
			
			//데이터피커에서 선택한 예약시간
			String reservationTime = HttpUtil.get(request, "reservationTime");
			
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
			
			if(!StringUtil.isEmpty(reservationDate) && !StringUtil.isEmpty(reservationTime)) {
				search.setShopHoliday(Integer.toString((StringUtil.getDayOfweek(reservationDate))));
				logger.debug("휴일 확인 : " + search.getShopHoliday());
				search.setReservationTime(reservationTime);
			}
			
			totalCount = shopService.shopListCount(search); //총 매장 수를 확인
			
			if(totalCount > 0)
			{
				paging = new Paging("/reservation/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				paging.addParam("reservationDate", reservationDate);
				paging.addParam("reservationTime", reservationTime);
				
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				
				list = shopService.shopList(search);
			}
			
			model.addAttribute("reservationDate", reservationDate);
			model.addAttribute("reservationTime", reservationTime);
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			
			return "/reservation/list";
			
		}
		
		//매장 상세정보 페이지
		@RequestMapping(value="/reservation/view")
		public String shopView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
			
		   //쿠키 값
		   String cookieUserUID= CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		   //게시물 번호		   
		   String shopUID = HttpUtil.get(request, "shopUID");
		   
		   String address = "";
		   
		   //조회항목(0 모두 1 파인다이닝 2오마카세)
		   String searchType = HttpUtil.get(request, "searchType", "0");
		   String searchValue = HttpUtil.get(request, "searchValue", "");
		   
		   //예약일 예약시간
		   String reservationDate = HttpUtil.get(request, "reservationDate");
		   String reservationTime = HttpUtil.get(request, "reservationTime");
		   
	       //즐겨찾기 여부 체크
	       String shopMarkActive = "N";
		   
		   int standardTime = 1700; //점심 저녁 나눌 기준 시간
		   
		   //현제페이지
		   long curPage = HttpUtil.get(request, "curPage", (long)1);
		   //관리자 본인 여부
		   String ManagerMe = "N";
		   
		   Shop shop = null;
		   
		   String url = "";
		   
		   
		   if(!StringUtil.isEmpty(shopUID) && !StringUtil.equals(shopUID, "")) {
			   shop = shopService.shopViewSelect(shopUID);
			   
			   
			   for(int i=0; i < shop.getShopTime().size(); i++ ) {	   
				   if(Integer.parseInt(shop.getShopTime().get(i).getShopOrderTime().replaceAll(":", "")) >= standardTime) { //시간에서 :제거후 int형으로 변환해서 기준시간과 비교
					   shop.getShopTime().get(i).setShopTimeType("D");
				   }
				   else {
					   shop.getShopTime().get(i).setShopTimeType("L"); //기준 시간  보다 작다면 점심시간
				   }
			   }
			   	   
			   url = "/reservation/view";
		   }
		   else {
			  url =  "/reservation/list";
		   }
		   if(shop.getShopLocation1() != null && !StringUtil.equals("", shop.getShopLocation1())) { //도 가 있는 지역이라면
			   address = shop.getShopLocation1() + " " + shop.getShopLocation2() + " " +shop.getShopLocation3() +" " + shop.getShopAddress();
		   }
		   
		   else { //도가 없는 지역이라면
			   address = shop.getShopLocation2() + " " + shop.getShopLocation3() + " " + shop.getShopAddress();
		   }
		   
		   if(!StringUtil.isEmpty(cookieUserUID) && shopUID != "")
		    {
				shop.setUserUID(cookieUserUID);
				shop.setShopUID(shopUID);
				
				if(shopService.shopMarkCheck(shop) == 0)                 
		         {
		        	 shopMarkActive = "N";
		         }
		         else
		         {
		        	 shopMarkActive = "Y";
		         }
		        
		     }
		   			
		   model.addAttribute("address", address);		   
		   model.addAttribute("shop", shop);
		   model.addAttribute("shopUID", shopUID);
		   model.addAttribute("boardMe", ManagerMe);
		   model.addAttribute("searchType", searchType);
		   model.addAttribute("searchValue", searchValue);
		   model.addAttribute("curPage", curPage);
		   model.addAttribute("reservationDate", reservationDate);
		   model.addAttribute("reservationTime", reservationTime);
		   model.addAttribute("shopMarkActive", shopMarkActive);
		   
		   return url;
		}
		
		@RequestMapping(value="/reservation/reservationCheckProc", method=RequestMethod.GET) //매장 자리 조회
		@ResponseBody
		public Response<Object> reservationCheck(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
			Response<Object> ajax = new Response<Object>();		
			String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);		
			String shopUID = HttpUtil.get(request, "shopUID");
			String reservationDate = HttpUtil.get(request, "reservationDate");
			String reservationTime = HttpUtil.get(request, "reservationTime");
			int reservationPeople = Integer.parseInt(HttpUtil.get(request, "reservationPeople", "0"));
			String counterSeatYN = HttpUtil.get(request, "counterSeatYN", "N"); //카운터석으로 예약할건지 여부
			
			int count = 0;
			int count2 = 0;
			
			if(!StringUtil.isEmpty(shopUID)) {
				Shop shop = new Shop();
				
				shop.setShopUID(shopUID);
				shop.setReservationDate(reservationDate);
				shop.setReservationTime(reservationTime);
				
				if(!StringUtil.isEmpty(cookieUserUID) && cookieUserUID != null) {
					List<ShopTotalTable> shopTotalTable = shopService.shopReservationCheck(shop);
					if(reservationPeople > 0) {
						if(shopTotalTable != null && StringUtil.equals(counterSeatYN, "N")) { //모든 자리를 카운터석으로만 예약할게 아니라면 모든 자리 조회, 예약인원이 1명 이상일 경우					
							for(int i=0; i < shopTotalTable.size(); i++ ) {
								for(int j=0; j < shopTotalTable.get(i).getShopTable().size(); j++) {
									if(StringUtil.equals(shopTotalTable.get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
										count++;
									}
								}
								if(shopTotalTable.get(i).getShopTotalTable() == count) { //예약된 테이블 갯수가 식당의 있는 테이블 수량과 같다면
									shopTotalTable.get(i).setShopTotalTableStatus("Y"); //예약이 다 차있다면 Y를 세팅함. 디폴트값 N
									if(StringUtil.equals("Y", shopTotalTable.get(i).getShopTotalTableStatus())) {
										count2++;
									}
								}
								else {
									shopTotalTable.get(i).setShopTotalTableRmains(shopTotalTable.get(i).getShopTotalTable() - count); //남아있는 자리 숫자 세팅
								}
								count = 0; //카운트 초기화 (j가 다 돌고 나면 첨부터 다시 카운트를 세야하므로 초기화)
							}
							if(count2 == shopTotalTable.size()) {
								ajax.setResponse(-1, "해당 시간에 예약이 꽉 찼음");
							}
							else {
								for(int i=0; i < shopTotalTable.size(); i++ ) {
									if(reservationPeople % 2 == 0) { //예약인원이 짝수 일때
										if(StringUtil.equals(shopTotalTable.get(i).getShopTotalTableStatus(), "N")) { //자리가 있는 테이블 종류 확인
											if(shopTotalTable.get(i).getShopTotalTableRmains() >= (reservationPeople % shopTotalTable.get(i).getShopTotalTableCapacity())) {
												ajax.setResponse(0, "예약 가능");
												break;
											}
											else {
												ajax.setResponse(-2, "남은 테이블이 예약인원보다 적음");
											}
										}
									}
									else { //예약인원이 홀수 일때
										reservationPeople = reservationPeople + 1; //1명 추가해서 짝수로 만들어 계산
										
										if(StringUtil.equals(shopTotalTable.get(i).getShopTotalTableStatus(), "N")) { //자리가 있는 테이블 종류 확인
											if(shopTotalTable.get(i).getShopTotalTableRmains() >= (reservationPeople % shopTotalTable.get(i).getShopTotalTableCapacity())) {
												ajax.setResponse(0, "예약 가능");
												break;
											}
											else {
												ajax.setResponse(-2, "남은 테이블이 예약인원보다 적음");
											}
										}
									}
								}
							}
						}
						else {  //카운터석만 조회
							for(int i=0; i < shopTotalTable.size(); i++) {
								if(shopTotalTable.get(i).getShopTotalTableCapacity() == 1) { //카운터석만 확인
									for(int j=0; j < shopTotalTable.get(i).getShopTable().size(); j++) { 
										if(StringUtil.equals(shopTotalTable.get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) { //자리 조회 중
											count++;
										}
									}	
									if(shopTotalTable.get(i).getShopTotalTable() == count) { //예약된 테이블 갯수가 식당의 있는 테이블 수량과 같다면
										shopTotalTable.get(i).setShopTotalTableStatus("Y"); //예약이 다 차있다면 Y를 세팅함. 디폴트값 N
										ajax.setResponse(-2, "카운터석 예약 최대로 예약되있음");
									}
									else {
										shopTotalTable.get(i).setShopTotalTableRmains(shopTotalTable.get(i).getShopTotalTable() - count); //남아있는 자리 숫자 세팅
										if(reservationPeople > shop.getShopTotalTable().get(i).getShopTotalTableRmains()) { //1인테이블이므로 예약인원보다 남은 자리가 적으면 안됨
											ajax.setResponse(-2, "남은 테이블이 예약인원보다 적음");
										}
										else {
											ajax.setResponse(0, "카운터석 자리 있음");
										}
									}
								}
								else {
									ajax.setResponse(-3, "카운터석이 존재하지 않음");
								}
							}
						}
					}
					else {
						ajax.setResponse(400, "요청된 예약인원 0명");
					}
				}

				else {
					ajax.setResponse(403, "로그인이 되어있지 않음");
				}
			}
			else {
				ajax.setResponse(404, "매장 고유번호가 없음");
			}
			
			return ajax;
		}
		
		//임시 매장 정보 인서트
		@RequestMapping(value="/reservation/shopInsert")
		public String shopInsert(HttpServletRequest request, HttpServletResponse response) {
			return "/reservation/shopInsert";
		}
		
		
		@RequestMapping(value="/reservation/shopInsertProc") //아직 루트나, 수정을 덜 했으므로 많이 바꾸어야함.
		@ResponseBody
		public Response<Object> shopInsertProc(MultipartHttpServletRequest request, HttpServletResponse response) {
			Response<Object> ajax = new Response<Object>();
					
			int fileQuantity = HttpUtil.get(request, "fileQuantity", 0);
			
			List<ShopFile> shopFileList = new ArrayList<ShopFile>();
			
			ShopFile shopFile = new ShopFile();
			
			String shopUID = "Shop_";
			String userUID = "1";
			String subDir = "";
			String mainDir = "";
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
			
			shopUID += userUID;
			
			subDir += SHOP_UPLOAD_DIR;
			subDir += "\\sub\\";
			subDir += shopUID;

			mainDir += SHOP_UPLOAD_DIR;	
			mainDir += "\\main\\";
			
			String[] name = new String[100];
			
			
			
			for(int i=0; i < fileQuantity; i++) {
				
				logger.debug("i값 : " + i);
				
				name[i] = "shopFile";
				name[i] += Integer.toString(i);;

				if(i == 0) {
					
					File mainFolder = new File(mainDir);

					// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
					if (!mainFolder.exists()) {
						try{
							mainFolder.mkdir(); //폴더 생성합니다.
						    	logger.debug("폴더가 생성됨");
					        } 
					        catch(Exception e){
					        	logger.debug("폴더 생성 중 오류");
					        	e.getStackTrace();
						}        
				         }else {
				        	 logger.debug("폴더가 존재함");
					}
						
					FileData fileData = new FileData();
					fileData = (HttpUtil.getFile(request, name[i], mainDir));
					
					if(fileData != null) {
						
						File subFolder = new File(subDir);

						// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
						if (!subFolder.exists()) {
							try{
								subFolder.mkdir(); //폴더 생성합니다.
							    	logger.debug("폴더가 생성됨");
						        } 
						        catch(Exception e){
						        	logger.debug("폴더 생성 중 오류");
						        	e.getStackTrace();
							}        
					         }else {
					        	 logger.debug("폴더가 존재함");
						}
						
						shopFile.setShopUID(shopUID);
				   		shopFile.setShopFileSeq(i);
				   		shopFile.setShopFileName(fileData.getFileName());
				   		shopFile.setShopFileOrgName(fileData.getFileOrgName());
				   		shopFile.setShopFileExt(fileData.getFileExt());
				   		shopFile.setShopFileSize(fileData.getFileSize());
					}
				}
				
				else {
					FileData fileData = new FileData();
					fileData = (HttpUtil.getFile(request, name[i], subDir));
					
					if(fileData != null) {
						shopFile.setShopUID(shopUID);
				   		shopFile.setShopFileSeq(i);
				   		shopFile.setShopFileName(fileData.getFileName());
				   		shopFile.setShopFileOrgName(fileData.getFileOrgName());
				   		shopFile.setShopFileExt(fileData.getFileExt());
				   		shopFile.setShopFileSize(fileData.getFileSize());
					}
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
		
		//즐겨찾기 추가
	  	@RequestMapping(value="/shop/mark", method=RequestMethod.POST)
	  	@ResponseBody
	  	public Response<Object> shopMark(HttpServletRequest request, HttpServletResponse response)
	  	{
	  		Response<Object> ajaxResponse = new Response<Object>();
	  		//조회객체
	  		Shop shop = new Shop();
	  		//쿠키값
	  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	  		//게시물 번호
	  		String shopUID = HttpUtil.get(request, "shopUID", "");
	  		
	  		if(!StringUtil.isEmpty(cookieUserUID) && shopUID != "")
	  		{
	   			try
	  			{
	   				shop.setShopUID(shopUID);
	   				shop.setUserUID(cookieUserUID);
	   				
	  				if(shopService.shopMarkCheck(shop) == 0)  					
	  				{
	  					shopService.shopMarkUpdate(shop);
	  					ajaxResponse.setResponse(0, "shopmark insert success");
	  				}
	  				else
	  				{
	  					shopService.shopMarkDelete(shop);
	  					ajaxResponse.setResponse(1, "shopmark delete success");
	  				}
	  			}
	  			catch(Exception e)
	  			{
	  				logger.error("[ShopController] /shop/mark Exception", e);
	  				ajaxResponse.setResponse(500, "internal server error");
	  			}	
	  		}
	  		else
	  		{
	  			ajaxResponse.setResponse(400, "Bad Request");
	  		}
	  		
	  		return ajaxResponse;
	  	}
	  	
	  	
		//게시물 즐겨찾기 리스트
		@RequestMapping(value="/shop/shopMarkList")
		public String shopMarkList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			//조회 객체
			Shop shop = new Shop();
			//쿠키값
	        String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);  
			//조회항목
			String searchType = HttpUtil.get(request, "searchType");
			//조회값
			String searchValue = HttpUtil.get(request, "searchValue", "");
			//현재페이지
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			//총 게시물 수
			long totalCount = 0;
			//게시물 리스트
			List<Shop> shopMarkList = null;
			//페이징 객체
			Paging paging = null;
			
			if(!StringUtil.isEmpty(cookieUserUID))
			{
				shop.setUserUID(cookieUserUID);
			}
			
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				shop.setSearchType(searchType);
				shop.setSearchValue(searchValue);
			}
			
			totalCount = shopService.shopMarkListCount(shop);
			
			if(totalCount > 0)
			{	
				paging = new Paging("/shop/shopMarkList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				
				shop.setStartRow(paging.getStartRow());
				shop.setEndRow(paging.getEndRow());
				
				shopMarkList = shopService.shopMarkList(shop);
			}
			
			model.addAttribute("shopMarkList", shopMarkList);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			
			return "/shop/shopMarkList";
		}
}

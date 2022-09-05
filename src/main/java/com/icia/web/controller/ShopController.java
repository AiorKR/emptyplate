package com.icia.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;

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
import com.icia.web.service.UserService;
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
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	private static final int LIST_COUNT = 5;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
	
	
	//게시판 리스트
		@RequestMapping(value="/reservation/list")
		public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception
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
			
			logger.debug("datepicker [day] : " + reservationDate);
			
			logger.debug("datepicker [time] : " + reservationTime);
			
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
			
			logger.debug("totalCount : " + totalCount);
			
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
				
				logger.debug("starRow : " + search.getStartRow());
				logger.debug("endRow : " + search.getEndRow());
				
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
		   
		   logger.debug("shopUID : " + shopUID);
		   
		   //조회항목(0 모두 1 파인다이닝 2오마카세)
		   String searchType = HttpUtil.get(request, "searchType", "0");
		   String searchValue = HttpUtil.get(request, "searchValue", "");
		   
		   //예약일 예약시간
		   String reservationDate = HttpUtil.get(request, "reservationDate");
		   String reservationTime = HttpUtil.get(request, "reservationTime");
		   
		   
		   //현제페이지
		   long curPage = HttpUtil.get(request, "curPage", (long)1);
		   //관리자 본인 여부
		   String ManagerMe = "N";
		   
		   Shop shop = null;
		   
		   String url = "";
		   
		   
		   if(!StringUtil.isEmpty(shopUID) && !StringUtil.equals(shopUID, "")) {
			   shop = shopService.shopViewSelect(shopUID);
			   
			   logger.debug("파일 사이즈 : " + shop.getShopFileList().size());	
			   
			   logger.debug("메뉴 사이즈 : " + shop.getShopMenu().size());
			   
			   logger.debug("시간 사이즈 : " + shop.getShopTime().size());
			   
			   for(int i=0; i < shop.getShopFileList().size(); i++ ) {
				   logger.debug("파일 이름 : " + shop.getShopFileList().get(i).getShopFileOrgName());
			   }
			   
			   for(int i=0; i < shop.getShopMenu().size(); i++ ) {
				   logger.debug("메뉴 이름 : " + shop.getShopMenu().get(i).getShopMenuName());
			   }
			   
			   for(int i=0; i < shop.getShopTime().size(); i++ ) {
				   logger.debug("시간 : " + shop.getShopTime().get(i).getShopOrderTime());
			   }
			   	   
			   url = "/reservation/view";
			   
			   if(shop != null && StringUtil.equals(shop.getShopUID(), cookieUserUID)) {
				   ManagerMe = "Y";
				   
				   url = "/"; //관리자 페이지로 이동
			   }
		   }
		   else {
			  url =  "/reservation/list";
		   }
		   if(shop.getShopLocation1() != null && !StringUtil.equals("", shop.getShopLocation1())) { //도 가 있는 지역이라면
			   address = shop.getShopLocation1(); //도
			   address += " ";
			   address += shop.getShopLocation2(); //시 군
			   address += " ";
			   address += shop.getShopLocation3(); // 구
			   address += " ";
			   address += shop.getShopAddress(); //상세주소
		   }
		   
		   else { //도가 없는 지역이라면
			   address += shop.getShopLocation2();
			   address += " ";
			   address += shop.getShopLocation3();
			   address += " ";
			   address += shop.getShopAddress();
		   }
		   			
		   model.addAttribute("address", address);		   
		   model.addAttribute("shop", shop);
		   model.addAttribute("boardMe", ManagerMe);
		   model.addAttribute("searchType", searchType);
		   model.addAttribute("searchValue", searchValue);
		   model.addAttribute("curPage", curPage);
		   model.addAttribute("reservationDate", reservationDate);
		   model.addAttribute("reservationTime", reservationTime);
		   
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
			String reservationPeople = HttpUtil.get(request, "reservationPeople");
			
			int count = 0;
			
			logger.debug("매장 번호 : " + shopUID);
			logger.debug("예약일 : " + reservationDate);
			logger.debug("예약시간" + reservationTime);
			logger.debug("예약인원" + reservationPeople);
			
			
			if(!StringUtil.isEmpty(shopUID)) {
				Shop shop = new Shop();
				
				shop.setShopUID(shopUID);
				shop.setReservationDate(reservationDate);
				shop.setReservationTime(reservationTime);
				
				if(!StringUtil.isEmpty(cookieUserUID) && cookieUserUID != null) {
					List<ShopTotalTable> shopTotalTable = shopService.shopReservationCheck(shop);
					
					if(shopTotalTable != null) {
						logger.debug(" 매장 테이블 사이즈  : " + shopTotalTable.size());
						
						for(int i=0; i < shopTotalTable.size(); i++ ) {
							logger.debug("" + shopTotalTable.get(i).getShopTotalTableUID());
							for(int j=0; j < shopTotalTable.get(i).getShopTable().size(); j++) {
								if(StringUtil.equals(shopTotalTable.get(i).getShopTable().get(j).getShopReservationTable().getShopTableStatus(), "Y")) {
									count++;
									logger.debug("count : " + count);
								}
							}
							if(shopTotalTable.get(i).getShopTotalTable() == count) { //예약된 테이블 갯수가 식당의 있는 테이블 수량과 같다면
								logger.debug("자리 꽉참 : " + count);
								shopTotalTable.get(i).setShopTotalTableStatus("Y"); //예약이 다 차있다면 Y를 세팅함. 디폴트값 N
							}
							else {
								shopTotalTable.get(i).setShopTotalTableRmains(shopTotalTable.get(i).getShopTotalTable() - count); //남아있는 자리 파악
								logger.debug("총합 테이블 수량 : " + shopTotalTable.get(i).getShopTotalTable());
								logger.debug("남아있는 테이블 : " + shopTotalTable.get(i).getShopTotalTableRmains());
							}
							count = 0; //카운트 초기화 (j가 다 돌고 나면 첨부터 다시 카운트를 세야하므로 초기화)
						}
						ajax.setResponse(0, "셀렉트 성공", shopTotalTable);
						model.addAttribute("shopTotalTable", shopTotalTable);
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
		
		
		@RequestMapping(value="/reservation/shopInsertProc")
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
}

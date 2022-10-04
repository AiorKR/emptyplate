package com.icia.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.Shop;
import com.icia.web.model.ShopFile;
import com.icia.web.model.ShopMenu;
import com.icia.web.model.ShopTime;
import com.icia.web.model.ShopTotalTable;
import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.ShopService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("managerController")
public class ManagerController {
	
	private static Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ShopService shopService;
	
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['shop.upload.save.dir']}")
	private String SHOP_UPLOAD_SAVE_DIR;
	
	@RequestMapping(value="/manager/shopManage")
	public String shopManage(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userUIDSelect(cookieUserUID);
		Shop shop = shopService.shopManagerUIDSelect(cookieUserUID); 
		String address = shop.getShopLocation1() + " " + shop.getShopAddress();
		//매장테이블 현황
		List<ShopTotalTable> tableList = shopService.shopCheckTable(shop.getShopUID());
		model.addAttribute("list1", tableList);
		
		//영업시간 현황
		List<ShopTime> timeList = shopService.shopCheckTime(shop.getShopUID());
		model.addAttribute("list2", timeList);
		
		//메뉴 현황
		List<ShopMenu> menuList = shopService.shopCheckMenu(shop.getShopUID());
		model.addAttribute("list3", menuList);
		
		model.addAttribute("shop", shop);
		model.addAttribute("address", address);
		if(user != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user.getUserNick());
				model.addAttribute("adminStatus", user.getAdminStatus());
				if(!StringUtil.isEmpty(user.getBizName())&& !StringUtil.isEmpty(user.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[ManagerController] /manager/shopManage shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[ManagerController] /manager/shopManage cookieUserNick NullPointerException", e);
			}
		}
		
		logger.debug("##############################정상");
		return "/manager/shopManage";
	}
	
	@RequestMapping(value="/manager/shopUpdate")
	public String shopUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userUIDSelect(cookieUserUID);
		Shop shop = shopService.shopManagerUIDSelect(cookieUserUID);
		ShopFile shopFile = new ShopFile();
		List<ShopFile> listFile = shopService.shopFileList(shop.getShopUID());
		model.addAttribute("listFile", listFile);
		logger.debug("##############################");
		logger.debug("# listSize : " + listFile.size());
		logger.debug("##############################");
		model.addAttribute("listSize", listFile.size());
		
		
		String address = shop.getShopLocation1() + " " + shop.getShopAddress();
		model.addAttribute("address", address);
		
		//요일출력
		String holiday = shop.getShopHoliday();
		String[] day = holiday.split(",");
		int i=0, j=0;
		for(i=0; i<day.length; i++)
		{
			for(j=StringUtil.stringToInteger(day[i],-1); j<7;j++)
			{
				model.addAttribute("day"+j, 1);
				break;
			}
		}
		
		//해시태그
		String hashTag = shop.getShopHashtag();
		String[] tag = hashTag.split("#");
		List<String> list = new ArrayList<String>(Arrays.asList(tag));
		list.remove(0);
		logger.debug("# hashTag : " + hashTag);
		logger.debug("# tag : " + tag);
		logger.debug("# list : " + list);
		model.addAttribute("list", list);
		
		//매장테이블 현황
		List<ShopTotalTable> tableList = shopService.shopCheckTable(shop.getShopUID());
		model.addAttribute("list1", tableList);
		
		//영업시간 현황
		List<ShopTime> timeList = shopService.shopCheckTime(shop.getShopUID());
		model.addAttribute("list2", timeList);
		
		//메뉴 현황
		List<ShopMenu> menuList = shopService.shopCheckMenu(shop.getShopUID());
		model.addAttribute("list3", menuList);
		
		model.addAttribute("shop", shop);
		
		if(user != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user.getUserNick());
				model.addAttribute("adminStatus", user.getAdminStatus());
				if(!StringUtil.isEmpty(user.getBizName())&& !StringUtil.isEmpty(user.getBizNum()))
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[ManagerController] /manager/shopUpdate shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[ManagerController] /manager/shopUpdate cookieUserNick NullPointerException", e);
			}
		}
		
		
		return "/manager/shopUpdate";
	}
	
	@RequestMapping(value="/manager/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse= new Response<Object>();
		
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		Shop shop = shopService.shopManagerUIDSelect(cookieUserUID);
		/***********
		 * 매장기본정보
		 ***********/
		//상호명
		String shopTitle = HttpUtil.get(request, "shopTitle", "");
		//매장 주소
		String shopLocation1 = HttpUtil.get(request, "shopLocation1", "");
		//매장 상세주소
		String shopAddress = HttpUtil.get(request, "shopAddress", "");
		//매장 상세주소
		String shopTelephone = HttpUtil.get(request, "shopTelephone", "");
		//매장 형태
		String shopType = HttpUtil.get(request, "shopType", "");
		//요일
		String dayList="";
  		for(int i=0; i<7; i++)
  		{
  			String str = "day"+ Integer.toString(i);
  			String day = HttpUtil.get(request, str);
  			
  			if(!StringUtil.isEmpty(HttpUtil.get(request, str,"")))
  			{
  				if(i==6)
  				{
  					dayList += day;  					
  				}
  				else
  				{
  					day = day + ",";
  					dayList += day;
  				}
  			}
  		}
  		
		/***********
		 * 소개글
		 ***********/
		//가게소개
  		String shopIntro = HttpUtil.get(request, "shopIntro", "");
  		//공지사항
  		String shopContent = HttpUtil.get(request, "shopContent", "");
		
		/***********
		 * 매장추가정보
		 ***********/
  		//해시태그
  		String hashTagList="";
  		for(int i=1; i<9; i++)
  		{
  			String str = "hashTag"+ Integer.toString(i);
  			String hashTag = HttpUtil.get(request, str);
  			
  			if(!StringUtil.isEmpty(HttpUtil.get(request, str,"")))
  			{
  				if(hashTag.indexOf("#") == -1)
  	  			{
  	  				hashTag = "#" + hashTag;
  	  			}
  				hashTagList += hashTag;
  			}
  			else
  			{
  				break;
  			}

  		}
  		
  		//테이블
  		int[] tableArray =new int[9];
  		int[] tableTypeArray = new int[9];
  		int tableArraySize = 0;
  		for(int i=1; i<9; i++)
  		{
  			String str = "tableselect"+ Integer.toString(i);
  			String str2 = "table"+ Integer.toString(i);
  			if(!StringUtil.isEmpty(HttpUtil.get(request, str)) || !StringUtil.isEmpty(HttpUtil.get(request, str2)))
  			{  				
  				tableTypeArray[i] =  Integer.parseInt(HttpUtil.get(request, str));
  				tableArray[i] = Integer.parseInt(HttpUtil.get(request, str2));
  				tableArraySize=i;
  			}
  			else
  			{
  				tableArraySize=i;
  				break;
  			}
  		}
  		
  		//매장시간
  		String[] timeArray =new String[9];
  		String[] timeTypeArray = new String[9];
  		int timeArraySize = 0;
  		for(int i=1; i<9; i++)
  		{
  			String str = "timeselect"+ Integer.toString(i);
  			String str2 = "time"+ Integer.toString(i);
  			if(!StringUtil.isEmpty(HttpUtil.get(request, str)) || !StringUtil.isEmpty(HttpUtil.get(request, str2)))
  			{  				
  				timeTypeArray[i] = HttpUtil.get(request, str);
  				timeArray[i] = HttpUtil.get(request, str2);
  				timeArraySize=i;
  			}
  			else
  			{
  				timeArraySize=i;
  				break;
  			}
  		}
  		
  		//메뉴
  		String[] menuTypeArray = new String[9];
  		int[] menuPriceArray =new int[9];
  		String[] menuNameArray =new String[9];
  		int menuArraySize = 0;
  		for(int i=1; i<9; i++)
  		{
  			String str = "menuselect"+ Integer.toString(i);
  			String str2 = "menuPrice"+ Integer.toString(i);
  			String str3 = "menuName"+ Integer.toString(i);
  			if(!StringUtil.isEmpty(HttpUtil.get(request, str)) || !StringUtil.isEmpty(HttpUtil.get(request, str2)) || !StringUtil.isEmpty(HttpUtil.get(request, str3)))
  			{  				
  				menuTypeArray[i] = HttpUtil.get(request, str);
  				menuPriceArray[i] = Integer.parseInt(HttpUtil.get(request, str2));
  				menuNameArray[i] = HttpUtil.get(request, str3);
  				menuArraySize=i;
  			}
  			else
  			{
  				menuArraySize=i;
  				break;
  			}
  		}
  		
  		List<ShopFile> shopFileList = new ArrayList<ShopFile>();
  	  
 	   
 	   String mainDir = "";
 	   mainDir += SHOP_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + shop.getShopUID()+ FileUtil.getFileSeparator();
 	   int i = 0;
 	   String imageStr = "";
 	   File mainFolder = new File(mainDir);
 	   // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
 	   if (!mainFolder.exists())
 	   {
 		   try
 		   {
 			   mainFolder.mkdir(); //폴더 생성합니다.
 			   logger.debug("###########");
 			   logger.debug("폴더가 생성됨");
 			   logger.debug("###########");
 		   } 
 		   catch(Exception e)
 		   {
 			   logger.debug("폴더 생성 중 오류");
 			   e.getStackTrace();
 		   }        
 	   }
 	   else
 	   {
 		   logger.debug("###########");
 		   logger.debug("폴더가 존재함");
 		   logger.debug("###########");
 	   }
 	   
 	   for(i=0; ; i++)
 	   {
 	      logger.debug("@@@@@@@@@@@@@@@@@@@@@@i값 : " + i);
 	      imageStr="shopImage"+Integer.toString(i);
 	      logger.debug("################ imageStr :" + imageStr);
 	      ShopFile shopFile = new ShopFile();
 	      FileData fileData = new FileData();
 	
 	         
 	         fileData = HttpUtil.getFile(request, imageStr, mainDir);
 	
 	         if(fileData != null)
 	         {
 	            
 	           shopFile.setShopUID(shop.getShopUID());
                shopFile.setShopFileSeq(i);
                shopFile.setShopFileName(fileData.getFileName());
                shopFile.setShopFileOrgName(fileData.getFileOrgName());
                shopFile.setShopFileExt(fileData.getFileExt());
                shopFile.setShopFileSize(fileData.getFileSize());
                logger.debug("####################### i : " + Integer.toString(i));
                logger.debug("shopFileName : " + shopFile.getShopFileName());	          
                shopFileList.add(shopFile);
                logger.debug("#### size : " + shopFileList.size());
                logger.debug("#############");
                for(int j =0;j<shopFileList.size();j++)
                {
             	   logger.debug("# i : " + j + shopFileList.get(j).getShopFileName());
                }
                logger.debug("#############");
 	         }
 	         else
 	         {
 	        	 break;
 	         }
 	         logger.debug("########################################################");
 	         logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	      }
 	      	
 	   	logger.debug("shopFileList : " + shopFileList);

  		

  		if(!StringUtil.isEmpty(shop.getShopUID()) && !StringUtil.isEmpty(shopTitle) && !StringUtil.isEmpty(shopLocation1) && !StringUtil.isEmpty(shopTelephone) )
  		{
  			//기본정보
  			shop.setShopName(shopTitle);
			shop.setShopLocation1(shopLocation1);
			shop.setShopAddress(shopAddress);
			shop.setShopTelephone(shopTelephone);
			shop.setShopHoliday(dayList);
			
			//소개글
			shop.setShopIntro(shopIntro);
			shop.setShopContent(shopContent);
			
			//추가정보
			shop.setShopHashtag(hashTagList);
			
			shop.setTableArray(tableArray);
			shop.setTableTypeArray(tableTypeArray);
			shop.setTableArraySize(tableArraySize);
			
	  		shop.setTimeArray(timeArray);
	  		shop.setTimeTypeArray(timeTypeArray);
	  		shop.setTimeArraySize(timeArraySize);
	  		
	  		shop.setMenuTypeArray(menuTypeArray);
	  		shop.setMenuPriceArray(menuPriceArray);
	  		shop.setMenuNameArray(menuNameArray);
	  		shop.setMenuArraySize(menuArraySize);
	  		
	  	 	shop.setShopFileList(shopFileList);
	  		
  			try
  			{
  				if(shopService.shopUpdate(shop) > 0)
  				{
  					ajaxResponse.setResponse(0, "Success");
  				}
  				else
  				{
  					ajaxResponse.setResponse(500, "Internal server error");
  				}
  			}
  			catch(Exception e)
  			{
  				logger.error("[ManagerController] /Manager/UpdateProc Exception", e);
				ajaxResponse.setResponse(500, "Internal server error");
  			}
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad request");
  		}
  		
  		
  		/*
		//첨부파일
		FileData fileData = HttpUtil.getFile(request, "shopFile", SHOP_UPLOAD_SAVE_DIR);
		
		if(!StringUtil.isEmpty(shop.getShopUID()) && !StringUtil.isEmpty(shopTitle) && !StringUtil.isEmpty(shopLocation1) && !StringUtil.isEmpty(shopTelephone) && !StringUtil.isNull(shopType))
  		{

  			if(shop != null)
  			{	
  				if(StringUtil.equals(shop.getUserUID(), cookieUserUID))
  				{	
  					shop.setShopName(shopTitle);
  					shop.setShopLocation1(shopLocation1);;
  					
  					//첨부파일 여부
  					if(fileData != null && fileData.getFileSize() > 0)
  					{	
  						ShopFile shopFile = new ShopFile();
  						shopFile.setShopFileName(fileData.getFileName());
  						shopFile.setShopFileOrgName(fileData.getFileOrgName());
  						shopFile.setShopFileExt(fileData.getFileExt());
  						shopFile.setShopFileSize(fileData.getFileSize());
  						
  						shop.setShopFile(shopFile);
  					}

  					try
  					{
  						if(managerService.boardUpdate(board) > 0)
  						{
  							ajaxResponse.setResponse(0, "Success");
  						}
  						else
  						{
  							ajaxResponse.setResponse(500, "Internal server error");
  						}
  					}
  					catch(Exception e)
  					{
  						logger.error("[ManagerController] /Manager/UpdateProc Exception", e);
  						ajaxResponse.setResponse(500, "Internal server error");
  					}

  				}
  				else
  				{
  					ajaxResponse.setResponse(403, "Server error");
  				}
  			}
  			else
  			{
  				ajaxResponse.setResponse(404, "Not found");
  			}
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad request");
  		}
		*/
		return ajaxResponse;
	}
}

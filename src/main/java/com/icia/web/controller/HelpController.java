package com.icia.web.controller;

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
import com.icia.common.util.StringUtil;
import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("helpController")
public class HelpController {
	
	private static Logger logger = LoggerFactory.getLogger(HelpController.class);
	
	@Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
   
	//파일 저장 경로
	@Value("#{env['board.upload.save.dir']}")
	private String BOARD_UPLOAD_SAVE_DIR;
   
    @Autowired
    private UserService userService;
    
    @Autowired
	private BoardService boardService;
	
	private static final int LIST_COUNT = 5;	//게시물 수
	private static final int PAGE_COUNT = 5;	//페이징 수
    
	@RequestMapping(value="/help/index")
	public String helpIndex(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		User user = null;
		  
		user = userService.userUIDSelect(cookieUserUID);
		          
		model.addAttribute("user", user);
		
		//조회 객체
		Board board = new Board();
		for(int i=1; i<5; i++)
		{
			board.setBbsNo(i);
			board.setStartRow(1);
			board.setEndRow(4);
			long totalCount = boardService.helpListCount(board);
			if(totalCount >0)
			{
				switch(i)
				{
					case 1: 
						List<Board> list1 = boardService.helpList(board);
						model.addAttribute("list1", list1);
						model.addAttribute("listSize1", list1.size());
						break;
					case 2:
						List<Board> list2 = boardService.helpList(board);
						model.addAttribute("list2", list2);
						model.addAttribute("listSize2", list2.size());
						break;
					case 3:
						List<Board> list3 = boardService.helpList(board);
						model.addAttribute("list3", list3);
						model.addAttribute("listSize3", list3.size());
						break;
					case 4:
						List<Board> list4 = boardService.helpList(board);
						model.addAttribute("list4", list4);
						model.addAttribute("listSize4", list4.size());
						break;
					default:
						break;
				}

			}
		}
				
		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		if(user2 != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user2.getUserNick());
				model.addAttribute("adminStatus", user2.getAdminStatus());
				if(user2.getBizNum() != null)
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[HelpController] /help/index shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] /help/index cookieUserNick NullPointerException", e);
			}
		}
		
		model.addAttribute("bbsSeq", bbsSeq);
		return "/help/index";
	}
	
	@RequestMapping(value="/help/helpList")
	public String helpList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회 객체
		Board board = new Board();
		//조회항목
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//분류값
	    long sortValue = HttpUtil.get(request, "sortValue", (long)4);
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Board> list = null;
		//페이징 객체
		Paging paging = null;
		//게시판 번호
		int bbsNo = HttpUtil.get(request, "bbsNo", (int) 0);
		board.setBbsNo(bbsNo);
		
		User user = null;
		user = userService.userUIDSelect(cookieUserUID);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			board.setSearchType(searchType);
			board.setSearchValue(searchValue);
		}
		
		board.setSortValue(sortValue);
		totalCount = boardService.helpListCount(board);
		
		if(totalCount > 0)
		{
			paging = new Paging("/help/helpList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("bbsNo", bbsNo);
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("sortValue", sortValue);
			paging.addParam("curPage", curPage);
			
			board.setStartRow(paging.getStartRow());
			board.setEndRow(paging.getEndRow());
			
			list = boardService.helpList(board);
		}
		
		model.addAttribute("user", user);
		model.addAttribute("bbsNo", bbsNo);
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("sortValue", sortValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);

		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		if(user2 != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user2.getUserNick());
				model.addAttribute("adminStatus", user2.getAdminStatus());
				if(user2.getBizNum() != null)
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[HelpController] /help/helpList shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] /help/helpList cookieUserNick NullPointerException", e);
			}
		}
		
		return "/help/helpList";
	}
	
	@RequestMapping(value="/help/helpView", method=RequestMethod.POST)
	public String helpView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		 //조회 객체
	       Board board = null;
	       
	       //쿠키 값
	       String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	       User user2 = new User();
	       user2 = userService.userUIDSelect(cookieUserUID);
	       //게시물 번호
	       long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
	       //조회항목(1:작성자, 2:제목, 3:내용)
	       String searchType = HttpUtil.get(request, "searchType");
	       //조회 값
	       String searchValue = HttpUtil.get(request, "searchValue", "");
	       //현재 페이지
	       long curPage = HttpUtil.get(request, "curPage", (long)1);
	       //본인글 여부
	       String admin = "N";
	      
	       if(bbsSeq > 0)
	       {
	          board = boardService.boardView(bbsSeq);
	          
	          //본인 게시물 여부
	          if(board != null && StringUtil.equals(board.getUserUID(), cookieUserUID))
	          {
	        	  admin = "Y";
	          }
	          
		      if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
		      {
		         board.setBbsSeq(bbsSeq);
		         board.setUserUID(cookieUserUID);
		      }
	       }
	       model.addAttribute("bbsSeq", bbsSeq);
	       model.addAttribute("board", board);
	       model.addAttribute("admin", admin);
	       model.addAttribute("cookieUserUID",cookieUserUID);
	       model.addAttribute("searchType", searchType);
	       model.addAttribute("searchValue", searchValue);
	       model.addAttribute("curPage", curPage);
	       
			if(user2 != null)
			{
				try
				{
					model.addAttribute("cookieUserNick", user2.getUserNick());
					model.addAttribute("adminStatus", user2.getAdminStatus());
					if(user2.getBizNum() != null)
					{
						try
						{
							model.addAttribute("shopStatus","Y");
						}
						catch(NullPointerException e)
						{
							logger.error("[HelpController] /help/helpView shopStatus NullPointerException", e);
						}
					}
					else
					{
						model.addAttribute("shopStatus","N");
					}
				}
				catch(NullPointerException e)
				{
					logger.error("[HelpController] /help/helpView cookieUserNick NullPointerException", e);
				}
			}

	       return "/help/helpView";
	}
	@RequestMapping(value="/help/helpWriteForm", method=RequestMethod.POST)
	public String helpWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		//조회 객체
		Board board = null;
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시판 번호
		int bbsNo = HttpUtil.get(request, "bbsNo", 0);
		User user = userService.userSelect(cookieUserUID);
		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		//게시물 번호
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		//조회항목(1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType");
		//조회 값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		      
	       if(bbsSeq > 0)
	       {
	          board = boardService.boardView(bbsSeq);
	          
		      if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
		      {
		         board.setBbsSeq(bbsSeq);
		         board.setUserUID(cookieUserUID);
		      }
	       }
	       model.addAttribute("bbsSeq", bbsSeq);
	       model.addAttribute("board", board);
	       model.addAttribute("cookieUserUID",cookieUserUID);
	       model.addAttribute("user", user);
	       model.addAttribute("admin", user2.getAdminStatus());
	       model.addAttribute("searchType", searchType);
	       model.addAttribute("searchValue", searchValue);
	       model.addAttribute("curPage", curPage);
	       model.addAttribute("bbsNo", bbsNo);
	      
	     	if(user2 != null)
			{
				try
				{
					model.addAttribute("cookieUserNick", user2.getUserNick());
					model.addAttribute("adminStatus", user2.getAdminStatus());
					if(user2.getBizNum() != null)
					{
						try
						{
							model.addAttribute("shopStatus","Y");
						}
						catch(NullPointerException e)
						{
							logger.error("[HelpController] /help/helpWriteForm shopStatus NullPointerException", e);
						}
					}
					else
					{
						model.addAttribute("shopStatus","N");
					}
				}
				catch(NullPointerException e)
				{
					logger.error("[HelpController] /help/helpWriteForm cookieUserNick NullPointerException", e);
				}
			}
			
	       return "/help/helpWriteForm";
	}
	//게시물 등록
	@RequestMapping(value="/help/helpWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> helpWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//제목
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		//내용
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		//첨부파일
		FileData fileData = HttpUtil.getFile(request, "bbsFile", BOARD_UPLOAD_SAVE_DIR);
		//게시판 번호
		int bbsNo = HttpUtil.get(request, "bbsNo", 0);
		//댓글
		String bbsComment = HttpUtil.get(request, "bbsComment", "");

		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent) && !StringUtil.isEmpty(bbsComment))
		{
	        Board board = new Board();
	         
	        board.setBbsNo(bbsNo);
	        board.setUserUID(cookieUserUID);
	        board.setBbsTitle(bbsTitle);
	        board.setBbsContent(bbsContent);
	        board.setBbsComment(bbsComment);
			
	        //첨부파일이 있을 때
		    if(fileData != null && fileData.getFileSize() > 0)
		    {
				BoardFile boardFile = new BoardFile();	
				
				boardFile.setFileName(fileData.getFileName());
				boardFile.setFileOrgName(fileData.getFileOrgName());
				boardFile.setFileExt(fileData.getFileExt());
				boardFile.setFileSize(fileData.getFileSize());
				
				board.setBoardFile(boardFile);	
		    }

		    try
			{
				if(boardService.boardInsert(board) > 0)
				{
					ajaxResponse.setResponse(0, "success");
					ajaxResponse.setData(bbsNo);
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[HelpController] /help/helpWriteProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}	
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	 //게시물 수정 form
   	@RequestMapping(value="/help/helpUpdateForm")
  	public String helpUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse rseponse)
  	{
   		//조회 객체
  		Board board = null;
  		//조회 유저 객체
  		User user = null;
   		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		//조회항목(1:작성자, 2:제목, 3:내용)
  		String searchType = HttpUtil.get(request, "searchType", "");
  		//조회값
  		String searchValue = HttpUtil.get(request, "searchValue", "");
  		//현재페이지
  		long curPage = HttpUtil.get(request, "curPage", (long)1);
  		
  		if(bbsSeq > 0)
  		{
  			board = boardService.boardViewUpdate(bbsSeq);
  			
  			if(board != null)
  			{
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{
  					user = userService.userSelect(cookieUserUID);
  				}
  				else
  				{
  					board = null;
  				}
  			}
  		}
  		
  		model.addAttribute("searchType", searchType);
  		model.addAttribute("searchValue", searchValue);
  		model.addAttribute("curPage", curPage);
  		model.addAttribute("board", board);
  		model.addAttribute("user", user);
  		
  		User user2 = new User();
		user2 = userService.userUIDSelect(cookieUserUID);
		if(user2 != null)
		{
			try
			{
				model.addAttribute("cookieUserNick", user2.getUserNick());
				model.addAttribute("adminStatus", user2.getAdminStatus());
				if(user2.getBizNum() != null)
				{
					try
					{
						model.addAttribute("shopStatus","Y");
					}
					catch(NullPointerException e)
					{
						logger.error("[HelpController] /help/helpUpdateForm shopStatus NullPointerException", e);
					}
				}
				else
				{
					model.addAttribute("shopStatus","N");
				}
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] /help/helpUpdateForm cookieUserNick NullPointerException", e);
			}
		}
		
  		return "/help/helpUpdateForm";
  	}
  	
   	
  	//게시물 수정
  	@RequestMapping(value="/help/helpUpdateProc", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> helpUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		
  		long bbsNo = HttpUtil.get(request, "bbsNo", (long)0);
  		//제목
  		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
  		//내용
  		String bbsContent = HttpUtil.get(request, "bbsContent", "");
  		//첨부파일
  		FileData fileData = HttpUtil.getFile(request, "bbsFile", BOARD_UPLOAD_SAVE_DIR);
  		
  		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
  		{
  			Board board = boardService.boardSelect(bbsSeq);
  			
  			if(board != null)
  			{	
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{	
  					board.setBbsTitle(bbsTitle);
  					board.setBbsContent(bbsContent);
  					
  					//첨부파일 여부
  					if(fileData != null && fileData.getFileSize() > 0)
  					{	
  						BoardFile boardFile = new BoardFile();
  						boardFile.setFileName(fileData.getFileName());
  						boardFile.setFileOrgName(fileData.getFileOrgName());
  						boardFile.setFileExt(fileData.getFileExt());
  						boardFile.setFileSize(fileData.getFileSize());
  						
  						board.setBoardFile(boardFile);
  					}
  					
  					try
  					{
  						if(boardService.boardUpdate(board) > 0)
  						{
  							ajaxResponse.setResponse(0, "Success");
  							ajaxResponse.setData(bbsNo);
  						}
  						else
  						{
  							ajaxResponse.setResponse(500, "Internal server error");
  						}
  					}
  					catch(Exception e)
  					{
  						logger.error("[BoardController] updateProc Exception", e);
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
  				ajaxResponse.setData(bbsNo);
  			}
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad request");
  		}
  		
  		return ajaxResponse;
  	}
  	
  	
  	//게시물 삭제
  	@RequestMapping(value="/help/helpDelete", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> helpDelete(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		long bbsNo = HttpUtil.get(request, "bbsNo", (long) 0);
  		if(bbsSeq > 0)
  		{			
  			Board board = boardService.boardSelect(bbsSeq);
  			
  			if(board != null)
  			{	
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{	
  					try
  					{
						if(boardService.boardDelete(board.getBbsSeq()) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
							ajaxResponse.setData(bbsNo);
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal server error");
						}
  					}
  					catch(Exception e)
  					{
  						logger.error("[BoardController] delete Exception", e);
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
  		
  		return ajaxResponse;
  	}
}

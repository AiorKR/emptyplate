package com.icia.web.controller;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.BoardReport;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.BoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("boardController")
public class BoardController
{
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	//쿠키명 지정
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
	
	//게시판 리스트
	@RequestMapping(value="/board/list")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
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
		board.setBbsNo(5);
		//인기게시물리스트 
		List<Board> hotLikeList = null;
		List<Board> hotReadList = null;
		Board hot = new Board();
		hot.setBbsNo(5);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			board.setSearchType(searchType);
			board.setSearchValue(searchValue);
		}
		
		board.setSortValue(sortValue);
		totalCount = boardService.boardListCount(board);
		
		if(totalCount > 0)
		{
			paging = new Paging("/board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("bbsNo", board.getBbsNo());
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("sortValue", sortValue);
			paging.addParam("curPage", curPage);
			
			board.setStartRow(paging.getStartRow());
			board.setEndRow(paging.getEndRow());
			hot.setStartRow(1);
			hot.setEndRow(4);
			
			list = boardService.boardList(board);
			hotLikeList = boardService.boardHotLikeList(hot);
			hotReadList = boardService.boardHotReadList(hot);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("hotLikeList", hotLikeList);
		model.addAttribute("hotReadList", hotReadList);
		model.addAttribute("bbsNo", board.getBbsNo());
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("sortValue", sortValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		
		return "/board/list";
	}
	
	
	//게시물 등록 form(글쓰기)
	@RequestMapping(value="/board/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시판 번호
		int bbsNo = HttpUtil.get(request, "bbsNo", 0);
		//사용자 정보 조회
		User user = userService.userSelect(cookieUserUID);
		
		model.addAttribute("bbsNo", bbsNo);
		model.addAttribute("user", user);
				
		return "/board/writeForm";
	}
	
	
	//게시물 등록(AJAX)
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
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
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[BoardController] /board/writeProc Exception", e);
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
	@RequestMapping(value="/board/markList")
	public String markList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//조회 객체
		Board board = new Board();
		//쿠키값
        String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);  
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
		List<Board> marklist = null;
		//페이징 객체
		Paging paging = null;
		//게시판 번호
		board.setBbsNo(5);
		
		if(!StringUtil.isEmpty(cookieUserUID))
		{
			board.setUserUID(cookieUserUID);
		}
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			board.setSearchType(searchType);
			board.setSearchValue(searchValue);
		}
		
		board.setSortValue(sortValue);
		totalCount = boardService.markListCount(board);
		
		if(totalCount > 0)
		{	
			paging = new Paging("/board/markList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("bbsNo", board.getBbsNo());
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("sortValue", sortValue);
			paging.addParam("curPage", curPage);
			
			board.setStartRow(paging.getStartRow());
			board.setEndRow(paging.getEndRow());
			
			marklist = boardService.markList(board);
		}
		
		model.addAttribute("marklist", marklist);
		model.addAttribute("bbsNo", board.getBbsNo());
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("sortValue", sortValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/board/markList";
	}	
	
	
	//유저 게시물 리스트
	@RequestMapping(value="/board/userList")
	public String userList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//조회 객체
		Board board = new Board();
		//조회 유저 객체
		User user = new User();
		//쿠키값
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//해당 유저
        String userUID = HttpUtil.get(request, "userUID");
		//해당 유저 즐겨찾기
        String markUserUID = HttpUtil.get(request, "userUID");
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
		List<Board> userList = null;
		//페이징 객체
		Paging paging = null;
		//게시판 번호
		board.setBbsNo(5);
        //본인글 여부
        String boardMe = "N";
		//즐겨찾기 여부 체크
		String userMarkActive = "N";
		
		if(!StringUtil.isEmpty(userUID))
		{
			board.setUserUID(userUID);
		}
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			board.setSearchType(searchType);
			board.setSearchValue(searchValue);
		}		
		
		board.setSortValue(sortValue);
		totalCount = boardService.userListCount(board);

		if(totalCount > 0)
		{	
			paging = new Paging("/board/userList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("bbsNo", board.getBbsNo());
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("sortValue", sortValue);
			paging.addParam("curPage", curPage);
			
			board.setStartRow(paging.getStartRow());
			board.setEndRow(paging.getEndRow());
			
			userList = boardService.userList(board);
			user = userService.userUIDSelect(userUID);
		}
		
		if(!StringUtil.isEmpty(cookieUserUID) && !StringUtil.isEmpty(markUserUID))
	    {
			user.setUserUID(cookieUserUID);
			user.setMarkUserUID(markUserUID);
			
			//본인 게시물 여부
			if(StringUtil.equals(user.getUserUID(), user.getMarkUserUID()))
	        {
				boardMe = "Y";
	        }	
			
			//유저 즐겨찾기 여부
	        if(userService.userMarkCheck(user) == 0 && boardMe == "N")                 
	        {
	        	userMarkActive = "N";
	        }
	        else
	        {
	        	userMarkActive = "Y";
	        }
	        
	     }
        
		model.addAttribute("userNick", user.getUserNick());
		model.addAttribute("userList", userList);
		model.addAttribute("userUID", userUID);
		model.addAttribute("bbsNo", board.getBbsNo());
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("sortValue", sortValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("markUserUID", userUID);
	    model.addAttribute("boardMe", boardMe);
		model.addAttribute("userMarkActive", userMarkActive);
		
		return "/board/userList";
	}
	
	
	//유저 즐겨찾기 추가(AJAX)
  	@RequestMapping(value="/board/userMark", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> userMark(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
		//조회 유저 객체
		User user = new User();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//즐겨찾기 해당 유저
        String markUserUID = HttpUtil.get(request, "markUserUID");
  		
  		if(!StringUtil.isEmpty(cookieUserUID))
  		{
   			try
  			{
   				user.setUserUID(cookieUserUID);
   				user.setMarkUserUID(markUserUID);
   				
  				if(userService.userMarkCheck(user) == 0)  					
  				{
  					userService.userMarkUpdate(user);
  					ajaxResponse.setResponse(0, "userMark insert success");
  				}
  				else
  				{
  					userService.userMarkDelete(user);
  					ajaxResponse.setResponse(1, "userMark delete success");
  				}
  			}
  			catch(Exception e)
  			{
  				logger.error("[BoardController] /board/userMark Exception", e);
  				ajaxResponse.setResponse(500, "internal server error");
  			}	
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad Request");
  		}
  		
  		return ajaxResponse;
  	}
	
  	
	//게시물 조회
    @RequestMapping(value="/board/view")
    public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
    {
       //조회 객체
       Board board = null;
       //댓글 리스트
       List<Board> comment = null;
       //쿠키 값
       String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
       //게시물 번호
       long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
       //조회항목(1:작성자, 2:제목, 3:내용)
       String searchType = HttpUtil.get(request, "searchType");
       //조회 값
       String searchValue = HttpUtil.get(request, "searchValue", "");
       //현재 페이지
       long curPage = HttpUtil.get(request, "curPage", (long)1);
       //본인글 여부
       String boardMe = "N";
       //좋아요 여부 체크
       String bbsLikeActive = "N";
       //즐겨찾기 여부 체크
       String bbsMarkActive = "N";
       //댓글허용체크
       String bbsComment = "";
       
       if(bbsSeq > 0)
       {
          board = boardService.boardView(bbsSeq);
          comment = boardService.commentList(board);
          
          //본인 게시물 여부
          if(board != null && StringUtil.equals(board.getUserUID(), cookieUserUID))
          {
             boardMe = "Y";
          }
       
	      if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
	      {
	         board.setBbsSeq(bbsSeq);
	         board.setUserUID(cookieUserUID);
	         
	         //게시물 좋아요
	         if(boardService.boardLikeCheck(board) == 0)                 
	         {
	        	 bbsLikeActive = "N";
	         }
	         else
	         {
	        	 bbsLikeActive = "Y";
	         }   
	         
	         //게시물 즐겨잦기
	         if(boardService.boardMarkCheck(board) == 0)                 
	         {
	        	 bbsMarkActive = "N";
	         }
	         else
	         {
	        	 bbsMarkActive = "Y";
	         }
	      }
       }
       model.addAttribute("bbsSeq", bbsSeq);
       model.addAttribute("board", board);
       model.addAttribute("boardMe", boardMe);
       model.addAttribute("bbsComment", bbsComment);
       model.addAttribute("searchType", searchType);
       model.addAttribute("searchValue", searchValue);
       model.addAttribute("curPage", curPage);
       model.addAttribute("list", comment);
       model.addAttribute("bbsLikeActive", bbsLikeActive);
       model.addAttribute("bbsMarkActive", bbsMarkActive);
       
       return "/board/view";
    }
    
    
    //게시물 수정 form
   	@RequestMapping(value="/board/updateForm")
  	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse rseponse)
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
  		
  		return "/board/updateForm";
  	}
  	
   	
  	//게시물 수정
  	@RequestMapping(value="/board/updateProc", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
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
  			}
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad request");
  		}
  		
  		return ajaxResponse;
  	}
  	
  	
  	//게시물 삭제
  	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);

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
  	
  	
	//좋아요 추가
  	@RequestMapping(value="/board/like", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> boardLike(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//조회객체
  		Board board = new Board();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);  		
  		
  		if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
  		{
   			try
  			{
   				board.setBbsSeq(bbsSeq);
   				board.setUserUID(cookieUserUID);
   				
  				if(boardService.boardLikeCheck(board) == 0)  					
  				{
  					boardService.boardLikeUpdate(board);
  					ajaxResponse.setResponse(0, "boardlike insert success");
  				}
  				else
  				{
  					boardService.boardLikeDelete(board);
  					ajaxResponse.setResponse(1, "boardlike delete success");
  				}
  				
  				boardService.boardLikeCntUpdate(board);
  			}
  			catch(Exception e)
  			{
  				logger.error("[BoardController] /board/like Exception", e);
  				ajaxResponse.setResponse(500, "internal server error");
  			}	
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad Request");
  		}
  		
  		return ajaxResponse;
  	}
  	
  	
  	//즐겨찾기 추가
  	@RequestMapping(value="/board/mark", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> boardMark(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//조회객체
  		Board board = new Board();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		
  		if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
  		{
   			try
  			{
   				board.setBbsSeq(bbsSeq);
   				board.setUserUID(cookieUserUID);
   				
  				if(boardService.boardMarkCheck(board) == 0)  					
  				{
  					boardService.boardMarkUpdate(board);
  					ajaxResponse.setResponse(0, "boardmark insert success");
  				}
  				else
  				{
  					boardService.boardMarkDelete(board);
  					ajaxResponse.setResponse(1, "boardmark delete success");
  				}
  			}
  			catch(Exception e)
  			{
  				logger.error("[BoardController] /board/mark Exception", e);
  				ajaxResponse.setResponse(500, "internal server error");
  			}	
  		}
  		else
  		{
  			ajaxResponse.setResponse(400, "Bad Request");
  		}
  		
  		return ajaxResponse;
  	}
  	
  	
	//첨부파일 다운로드
  	@RequestMapping(value="/board/download")
  	public ModelAndView download(HttpServletRequest request, HttpServletResponse response)
  	{
  		ModelAndView modelAndView = null;
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		
  		if(bbsSeq > 0)
  		{
  			BoardFile boardFile = boardService.boardFileSelect(bbsSeq);
  			
  			if(boardFile != null)
  			{
  				File file = new File(BOARD_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + boardFile.getFileName());
  				
  				if(FileUtil.isFile(file))
  				{
  					modelAndView = new ModelAndView();

  					modelAndView.setViewName("fileDownloadView");
  					modelAndView.addObject("file", file);
  					modelAndView.addObject("fileName", boardFile.getFileOrgName());
  					
  					return modelAndView;
  				}
  			}
  		}
  		
  		return modelAndView;
  	}
  	
  	
  	//댓글등록
  	@RequestMapping(value="/board/commentProc", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> commentProc(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//댓글 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		//댓글 내용
  		String bbsContent = HttpUtil.get(request, "bbsContent", "");  		
		
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsContent))
		{
	  		Board parentBoard = boardService.boardSelect(bbsSeq);
	  		
			if(parentBoard != null)
			{
				Board board = new Board();
				
				board.setUserUID(cookieUserUID);
				board.setBbsContent(bbsContent);
				board.setCommentGroup(parentBoard.getCommentGroup());
				board.setCommentOrder(parentBoard.getCommentOrder() + 1);
				board.setCommentIndent(parentBoard.getCommentIndent() + 1);
				board.setCommentParent(bbsSeq);
				
				try
				{
					if(boardService.boardCommentInsert(board) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(500, "internal server error");
					}	
				}
				catch(Exception e)
				{
					logger.error("[BoardController] /board/commentProc Exception", e);
					ajaxResponse.setResponse(500, "internal server error2");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		return ajaxResponse;
  	}
  	
  	
  	//댓글 삭제
  	@RequestMapping(value="/board/commentDelete", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> commentDelete(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//댓글 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		
  		if(bbsSeq > 0)
  		{			
  			Board board = boardService.boardSelect(bbsSeq);
  			
  			if(board != null)
  			{	  		  		
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{	
  					try
  					{
						if(boardService.commentDelete(board.getBbsSeq()) > 0)
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
  						logger.error("[BoardController] commentDelete Exception", e);
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
  	
  	
  	//게시물 신고(AJAX)
  	@RequestMapping(value="/board/reportProc", method=RequestMethod.POST)
  	@ResponseBody
  	public Response<Object> reportProc(HttpServletRequest request, HttpServletResponse response)
  	{
  		Response<Object> ajaxResponse = new Response<Object>();
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물,댓글 번호 구분
  		String bbsSeqChk = HttpUtil.get(request, "bbsSeqChk", "");
        //게시물 번호
        long bbsSeq = 0;
        
        if(!StringUtil.isEmpty(bbsSeqChk) && StringUtil.equals(bbsSeqChk, "Y"))
        {
        	bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
        }
        else
        {
        	bbsSeq = HttpUtil.get(request, "bbsSeqCom", (long)0);
        }
        
        //신고사유
  		String report1 = HttpUtil.get(request, "report1", "");
  		String report2 = HttpUtil.get(request, "report2", "");
  		String report3 = HttpUtil.get(request, "report3", "");
  		String report4 = HttpUtil.get(request, "report4", "");
  		String etcReport = HttpUtil.get(request, "etcReport", "");
  		
  		if(!StringUtil.isEmpty(cookieUserUID) && bbsSeq > 0)
  		{
  	        BoardReport boardReport = new BoardReport();

	  	    boardReport.setUserUID(cookieUserUID);
	  	    boardReport.setBbsSeq(bbsSeq);
	  	    boardReport.setReport1(report1);
	  	    boardReport.setReport2(report2);
	  	    boardReport.setReport3(report3);
	  	    boardReport.setReport4(report4);
	  	    boardReport.setEtcReport(etcReport);
	  	   
		  	try
	  		{
	  			if(boardService.boardReport(boardReport) > 0)
	  			{
	  				ajaxResponse.setResponse(0, "success");
	  			}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[BoardController] /board/reportProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}	
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
  	}
  
  	
}
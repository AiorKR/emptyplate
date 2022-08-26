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

@Controller("boardController")
public class BoardController
{
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	//쿠키명 지정
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
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
		//조회항목
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Board> list = null;
		//페이징 객체
		Paging paging = null;
		//조회 객체
		Board search = new Board();
		//**순
		List<Board> sort = null;
		//게시판 번호
		search.setBbsNo(5);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		totalCount = boardService.boardListCount(search);
		
		if(totalCount > 0)
		{
			paging = new Paging("/board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("bbsNo", search.getBbsNo());
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			paging.addParam("sort", sort);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = boardService.boardList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("bbsNo", search.getBbsNo());
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("sort", sort);
		model.addAttribute("paging", paging);
		
		return "/board/list";
	}
	
	//게시물 등록 form(글쓰기)
	@RequestMapping(value="/board/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 조회
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		int bbsNo = HttpUtil.get(request, "bbsNo", 0);
		
		//사용자 정보 조회
		User user = userService.userSelect(cookieUserUID);
		
		model.addAttribute("bbsNo", bbsNo);
		model.addAttribute("user", user);	//user객체에 받아 writeForm 에서 사용할 이름 "user"
				
		return "/board/writeForm";
	}
	
	//게시물 등록(AJAX)
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");	//writeForm에서 name이 넘어옴
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);	//getFile메서드는 보내준 파일을 유효 아이디 값 생성 > 해당경로에 파일 업로드, FileData객체 생성후 값 세팅을 함. > getFile의 시작주소를 fileData가 바라봄.
		int bbsNo = HttpUtil.get(request, "bbsNo", 0);
		
		//서버에서 다이렉트로 들어올 경우 체크
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			Board board = new Board();
			
			board.setBbsNo(bbsNo);
			board.setUserUID(cookieUserUID);
			board.setBbsTitle(bbsTitle);
			board.setBbsContent(bbsContent);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{	
				BoardFile boardFile = new BoardFile();	
				
				boardFile.setFileName(fileData.getFileName());
				boardFile.setFileOrgName(fileData.getFileOrgName());
				boardFile.setFileExt(fileData.getFileExt());
				boardFile.setFileSize(fileData.getFileSize());
				
				board.setBoardFile(boardFile);	
			}
			
			//service호출
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
	
	//게시물 조회
    @RequestMapping(value="/board/view")
    public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
    {
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
       
       Board board = null;
       
       if(bbsSeq > 0)
       {
          board = boardService.boardView(bbsSeq);
                
          if(board != null && StringUtil.equals(board.getUserUID(), cookieUserUID))
          {
             boardMe = "Y";
          }
       }
       
       model.addAttribute("bbsSeq", bbsSeq);
       model.addAttribute("board", board);
       model.addAttribute("boardMe", boardMe);
       model.addAttribute("searchType", searchType);
       model.addAttribute("searchValue", searchValue);
       model.addAttribute("curPage", curPage);
       
       return "/board/view";
    }
    
    //게시물 수정 form
   	@RequestMapping(value="/board/updateForm")
  	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse rseponse)
  	{
  		//쿠키값
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		//게시물 번호
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		//조회항목(1:작성자, 2:제목, 3:내용)
  		String searchType = HttpUtil.get(request, "searchType", "");	//같은 클래스 안에 오버로딩
  		//조회값
  		String searchValue = HttpUtil.get(request, "searchValue", "");
  		//현재페이지
  		long curPage = HttpUtil.get(request, "curPage", (long)1);
  		
  		Board board = null;
  		User user = null;
  		
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
  		
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
  		String bbsContent = HttpUtil.get(request, "bbsContent", "");
  		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);
  		
  		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
  		{
  			Board board = boardService.boardSelect(bbsSeq);
  			
  			if(board != null)
  			{	
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{	
  					board.setBbsTitle(bbsTitle);
  					board.setBbsContent(bbsContent);
  					
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
  		String cookieUserUID = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
  		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
  		
  		Response<Object> ajaxResponse = new Response<Object>();
  		
  		if(bbsSeq > 0)
  		{			
  			Board board = boardService.boardSelect(bbsSeq);
  			if(board != null)
  			{	
  				if(StringUtil.equals(board.getUserUID(), cookieUserUID))
  				{	//내 게시물인지 확인 //다이렉트로 들어올 경우 방지
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
  				{	//내 게시글이 아닐 경우
  					ajaxResponse.setResponse(403, "Server error");
  				}
  			}
  			else
  			{	//게시물이 없을 때
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
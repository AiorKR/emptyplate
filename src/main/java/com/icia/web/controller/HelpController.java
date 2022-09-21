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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Board;
import com.icia.web.model.Paging;
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
						List<Board> list1 = boardService.boardList(board);
						model.addAttribute("list1", list1);
						model.addAttribute("listSize1", list1.size());
						break;
					case 2:
						List<Board> list2 = boardService.boardList(board);
						model.addAttribute("list2", list2);
						model.addAttribute("listSize2", list2.size());
						break;
					case 3:
						List<Board> list3 = boardService.boardList(board);
						model.addAttribute("list3", list3);
						model.addAttribute("listSize3", list3.size());
						break;
					case 4:
						List<Board> list4 = boardService.boardList(board);
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
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] help/index NullPointerException", e);
			}
		}
		
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
		String bbsNo = HttpUtil.get(request, "bbsNo");
		board.setBbsNo(Integer.parseInt(bbsNo));
		
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
			
			list = boardService.boardList(board);
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
			}
			catch(NullPointerException e)
			{
				logger.error("[HelpController] help/helpList NullPointerException", e);
			}
		}
		
		return "/help/helpList";
	}
	
	@RequestMapping(value="/help/helpView")
	public String helpView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
		      }
	       }
	       model.addAttribute("bbsSeq", bbsSeq);
	       model.addAttribute("board", board);
	       model.addAttribute("cookieUserUID",cookieUserUID);
	       model.addAttribute("bbsComment", bbsComment);
	       model.addAttribute("searchType", searchType);
	       model.addAttribute("searchValue", searchValue);
	       model.addAttribute("curPage", curPage);
	       model.addAttribute("list", comment);
	       User user2 = new User();
			user2 = userService.userUIDSelect(cookieUserUID);
			if(user2 != null)
			{
				try
				{
					model.addAttribute("cookieUserNick", user2.getUserNick());
				}
				catch(NullPointerException e)
				{
					logger.error("[helController] /help/helpView NullPointerException", e);
				}
			}
	       return "/help/helpView";
	}
}

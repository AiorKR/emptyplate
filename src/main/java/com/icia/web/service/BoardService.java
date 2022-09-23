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
import com.icia.web.dao.BoardDao;
import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.BoardReport;

@Service("boardService")
public class BoardService 
{
	private static Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	//파일 저장 경로
	@Value("#{env['board.upload.save.dir']}")
	private String BOARD_UPLOAD_SAVE_DIR;
	
	@Autowired
	private BoardDao boardDao;
		
	//게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(Board board) throws Exception
	{
		long bbsSeq = boardDao.beforeInsert();
		board.setBbsSeq(bbsSeq);
		int count = boardDao.boardInsert(board);
		
		//첨부파일 등록
		if(count > 0 && board.getBoardFile() != null)
		{	
			BoardFile boardFile = board.getBoardFile();
			boardFile.setBbsSeq(board.getBbsSeq());
			boardFile.setFileOrgName(Long.toString(bbsSeq) + "."+ boardFile.getFileExt());
			boardFile.setFileSeq((short)1);
			
			boardDao.boardFileInsert(board.getBoardFile());
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<Board> boardList(Board board)
	{
		List<Board> list = null;
		
		try
		{
			list = boardDao.boardList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardList Exception", e);
		}
		
		return list;
	}
	
	//총 게시물 수
	public long boardListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count = boardDao.boardListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardListCount Exception", e);
		}
		
		return count;
	}
	
	//인기좋아요순 리스트
	public List<Board> boardHotLikeList(Board board)
	{
		List<Board> list = null;
		
		try
		{
			list = boardDao.boardHotLikeList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardHotLikeList Exception", e);
		}
		return list;
	}
	
	//인기조회순 리스트
	public List<Board> boardHotReadList(Board board)
	{
		List<Board> list = null;
		
		try
		{
			list = boardDao.boardHotReadList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardHotReadList Exception", e);
		}
		return list;
	}
	
	//유저 게시물 리스트
	public List<Board> userList(Board board)
	{
		List<Board> userList = null;
		
		try
		{
			userList = boardDao.userList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] userList Exception", e);
		}
		
		return userList;
	}
	
	//유저 총 게시물 수 
	public long userListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count = boardDao.userListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] userListCount Exception", e);
		}
		
		return count;
	}
	
	//**순
	public List<Board> boardSort(Board board)
	{
		List<Board> sort = null;
		
		try
		{
			sort = boardDao.boardSort(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardSort Exception", e);
		}
		
		return sort;
	}
	
	//게시물 조회
	public Board boardSelect(long bbsSeq)
	{
		Board board = null;
		
		try
		{
			board = boardDao.boardSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardSelect Exception", e);
		}
		return board;
	}
	
	//게시물 조회(첨부파일 포함)
	public Board boardView(long bbsSeq)
	{
		Board board = null;
		try
		{
			board = boardDao.boardSelect(bbsSeq);
			
			if(board != null)
			{
				//게시물 조회수 증가
				boardDao.boardReadCntPlus(bbsSeq);
				
				//첨부파일 조회
				BoardFile boardFile = boardDao.boardFileSelect(bbsSeq);
				
				if(boardFile != null)
				{
					board.setBoardFile(boardFile);
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardView Exception", e);
		}
		
		return board;
	}
	
	//게시물 수정form 조회(첨부파일 포함)
	public Board boardViewUpdate(long bbsSeq)
	{
		Board board = null;
		
		try
		{
			board = boardDao.boardSelect(bbsSeq);
			
			if(board != null)
			{
				//첨부파일 조회
				BoardFile boardFile = boardDao.boardFileSelect(bbsSeq);
				
				if(boardFile != null)
				{
					board.setBoardFile(boardFile);
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardViewUpdate Exception", e);
		}
		
		return board;
	}
	
	//게시물 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(Board board) throws Exception
	{
		int count = boardDao.boardUpdate(board);	
		
		if(count > 0 && board.getBoardFile() != null)
		{
			BoardFile delBoardFile = boardDao.boardFileSelect(board.getBbsSeq());	
			
			//기존 첨부파일 삭제
			if(delBoardFile != null)
			{
				FileUtil.deleteFile(BOARD_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delBoardFile.getFileName());
				boardDao.boardFileDelete(board.getBbsSeq());
			}
			//새로운 첨부파일 등록
			board.getBoardFile().setBbsSeq(board.getBbsSeq());			
			board.getBoardFile().setFileSeq((short)1);
		
			boardDao.boardFileInsert(board.getBoardFile());
		}	
		
		return count;
	}
	
	//게시물 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardDelete(long bbsSeq) throws Exception
	{
		int count = 0;
		Board board = boardViewUpdate(bbsSeq);
		
		if(board != null)
		{
			BoardFile boardFile = board.getBoardFile();
			
			if(boardFile != null)
			{	
				//첨부파일 삭제
				if(boardDao.boardFileDelete(bbsSeq) > 0)
				{
					FileUtil.deleteFile(BOARD_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + boardFile.getFileName());
				}
			}
			
			count = boardDao.boardDelete(bbsSeq);
		}
		
		return count;
	}
	
	//동일 게시글 좋아요 여부 확인
	public int boardLikeCheck(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardLikeCheck(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardLikeCheck Exception", e);
		}
		
		return count;
	}
	
	//좋아요 추가
	public int boardLikeUpdate(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardLikeUpdate(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardLikeUpdate Exception", e);
		}
		
		return count;
	}
	
	//좋아요 취소
	public int boardLikeDelete(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardLikeDelete(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardLikeDelete Exception", e);
		}
		
		return count;
	}
	
	//좋아요 수 업데이트
	public int boardLikeCntUpdate(Board board)
	{
		int count = 0;
      
		try
		{
			count = boardDao.boardLikeCntUpdate(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardLikeCntUpdate Exception", e);
		}
      
		return count;
	}
	
	//동일 게시물  즐겨찾기 여부 확인
	public int boardMarkCheck(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardMarkCheck(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardMarkCheck Exception", e);
		}
		
		return count;
	}
	
	//게시물 즐겨찾기 추가
	public int boardMarkUpdate(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardMarkUpdate(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardMarkUpdate Exception", e);
		}
		
		return count;
	}
	
	//게시물 즐겨찾기 취소
	public int boardMarkDelete(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardMarkDelete(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardMarkDelete Exception", e);
		}
		
		return count;
	}
	
	//게시물 즐겨찾기 리스트
	public List<Board> markList(Board board)
	{
		List<Board> marklist = null;
		
		try
		{
			marklist = boardDao.markList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] markList Exception", e);
		}
		
		return marklist;
	}
	
	//게시물 즐겨찾기 총 게시물 수
	public long markListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count = boardDao.markListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] markListCount Exception", e);
		}
		
		return count;
	}
		
	//첨부파일 조회
	public BoardFile boardFileSelect(long bbsSeq)
	{
		BoardFile boardFile = null;
		
		try
		{
			boardFile = boardDao.boardFileSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardFileSelect Exception", e);
		}
		
		return boardFile;
	}
	
	//댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardCommentInsert(Board board) throws Exception
	{
		int count = 0;
		
		boardDao.commentGroupOrderUpdate(board);
		count = boardDao.boardCommentInsert(board);
		
		return count;
	}
	
	//댓글 리스트
	public List<Board> commentList(Board board)
	{
		List<Board> list = null;
		try
		{
			list = boardDao.commentList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardList Exception", e);
		}
		
		return list;
	}
	
	//댓글 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commentDelete(long bbsSeq) throws Exception
	{
		int count = 0;
	      
		try
		{
			count = boardDao.commentDelete(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] commentDelete Exception", e);
		}
		
		return count;
	}
	
	//게시물 신고
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public long boardReport(BoardReport boardReport)
	{
		long count = boardDao.boardReport(boardReport);		
		
		return count;
	}
	
	/***************************
	 * help
	 ***************************/
	//총 게시물 수
	public long helpListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count = boardDao.helpListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] helpListCount Exception", e);
		}
		
		return count;
	}
	
}

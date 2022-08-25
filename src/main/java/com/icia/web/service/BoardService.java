package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.BoardDao;
import com.icia.web.model.Board;

@Service("boardService")
public class BoardService 
{
	private static Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	//파일 저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private BoardDao boardDao;
		
	//게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(Board board) throws Exception
	{
		int count = boardDao.boardInsert(board);
		
		//게시물 등록 후 첨부파일 있으면 등록
		
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
			logger.debug("count : " + count);
			logger.error("[BoardService] boardListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 조회
	public Board boardSelect(int bbsSeq)
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

}

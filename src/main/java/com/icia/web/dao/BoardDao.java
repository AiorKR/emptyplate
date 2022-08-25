package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Board;

@Repository("boardDao")
public interface BoardDao 
{
	//게시물 등록
	public int boardInsert(Board board);
	
	//게시물 리스트
	public List<Board> boardList(Board board);
	
	//총 게시물 수
	public long boardListCount(Board board);
	
	//게시물 조회
	public Board boardSelect(int bbsSeq);
	
	//게시물 조회수 증가
	public int boardReadCntPlus(int bbsSeq);
	
	//**순
	public List<Board> boardSort(Board board);
}

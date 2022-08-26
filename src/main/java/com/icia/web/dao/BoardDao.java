package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;

@Repository("boardDao")
public interface BoardDao 
{
	//게시물 등록
	public int boardInsert(Board board);
	
	//게시물 첨부파일 등록
	public int boardFileInsert(BoardFile boardFile);
	
	//게시물 리스트
	public List<Board> boardList(Board board);
	
	//총 게시물 수
	public long boardListCount(Board board);
	
	//게시물 조회
	public Board boardSelect(long bbsSeq);
	
	//게시물 조회수 증가
	public int boardReadCntPlus(long bbsSeq);
	
	//**순
	public List<Board> boardSort(Board board);
	
	//첨부파일 조회
	public BoardFile boardFileSelect(long bbsSeq);
	
	//게시물 수정
	public int boardUpdate(Board board);
	
	//게시물 삭제
	public int boardDelete(long bbsSeq);
	
	//첨부파일 삭제
	public int boardFileDelete(long bbsSeq);
	
	//동일 게시글 좋아요 여부 확인
	public int boardLikeCheck(Board board);
	
	//좋아요 추가
	public int boardLikeUpdate(long bbsSeq);
	
	//좋아요 취소
	public int boardLikeDelete (long bbsSeq);
	
	/*//좋아요 갯수 조회
	public long boardLikeCount(Board board);*/

}

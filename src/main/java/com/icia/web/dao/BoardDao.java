package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Board;
import com.icia.web.model.BoardFile;
import com.icia.web.model.BoardReport;

@Repository("boardDao")
public interface BoardDao 
{
	//시퀀스 선행처리
	public long beforeInsert();
	
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
	public int boardLikeUpdate(Board board);
	
	//좋아요 취소
	public int boardLikeDelete(Board board);
	
	//좋아요 수 업데이트
	public int boardLikeCntUpdate(Board board);
	
	//댓글 등록
	public int boardCommentInsert(Board board);
	
	//댓글 그룹 순서 변경
	public int commentGroupOrderUpdate(Board board);
	
	//댓글 리스트
	public List<Board> commentList(Board board);

	//댓글 삭제
	public int commentDelete(long bbsSeq);
	
	//인기좋아요순 게시물 리스트
	public List<Board> boardHotLikeList(Board board);
	
	//인기조회순 게시물 리스트
	public List<Board> boardHotReadList(Board board);
	
	//동일 게시물 즐겨찾기 여부 확인
	public int boardMarkCheck(Board board);
		
	//게시물 즐겨찾기 추가
	public int boardMarkUpdate(Board board);
	
	//게시물 즐겨찾기 취소
	public int boardMarkDelete(Board board);
	
	//게시물 즐겨찾기 리스트
	public List<Board> markList(Board board);
	
	//게시물 즐겨찾기 총 게시물 수
	public long markListCount(Board board);
	
	//게시물 신고
	public long boardReport(BoardReport boardReport);
}

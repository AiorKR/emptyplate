package com.icia.web.model;

import java.io.Serializable;

public class Board implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;		//게시물고유번호
	private String userUID;		//회원고유번호
	private int bbsNo;			//게시판 번호
	private String bbsTitle;	//게시물 제목
	private String bbsContent;	//내용
	private int bbsLikeCnt;		//게시물 좋아요수
	private int bbsReadCnt;		//게시물 조회수
	private String regDate;		//게시물 등록일
	private String modDate;		//게시물 수정일
	private String bbsComment;	//댓글허용
	private long commentParent;	//부모 게시물번호
	private long commentGroup;	//댓글 그룹번호
	private int commentOrder;	//댓글 그룹내순서
	private int commentIndent;	//댓글 들여쓰기
	private String status;     	//게시물 상태(N:게시물 활성화, Y:게시물 삭제)
	
	private String userNick;	//사용자 닉네임
	
	private long rNum;			//게시물번호 RNUM
	
	private long startRow;		//시작 rownum
	private long endRow;		//끝 rownum
	
	private String searchType;	//조회항목(1:작성자, 2:제목, 3:내용)
	private String searchValue;	//조회값
	
	private long sortValue;     //**순 정렬(1:최신글순, 2:좋아요순, 3:조회순)
	
	private BoardFile boardFile;//첨부파일

	
	public Board()
	{
		bbsSeq = 0;
		userUID = "";
		bbsNo = 0;
		bbsTitle = "";
		bbsContent = "";
		bbsLikeCnt = 0;
		bbsReadCnt = 0;
		regDate = "";
		modDate = "";
		bbsComment = "";
		commentParent = 0;
		commentGroup = 0;
		commentOrder = 0;
		commentIndent = 0;
		status = "";
		
		userNick = "";
		
		rNum = 0;
		
		startRow = 0;
		endRow = 0;
		
		sortValue = 0;
		
		searchType = "";
		searchValue = "";
		
		boardFile = null;
	}


	public long getBbsSeq() {
		return bbsSeq;
	}


	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}


	public String getUserUID() {
		return userUID;
	}


	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}


	public int getBbsNo() {
		return bbsNo;
	}


	public void setBbsNo(int bbsNo) {
		this.bbsNo = bbsNo;
	}


	public String getBbsTitle() {
		return bbsTitle;
	}


	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}


	public String getBbsContent() {
		return bbsContent;
	}


	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}


	public int getBbsLikeCnt() {
		return bbsLikeCnt;
	}


	public void setBbsLikeCnt(int bbsLikeCnt) {
		this.bbsLikeCnt = bbsLikeCnt;
	}


	public int getBbsReadCnt() {
		return bbsReadCnt;
	}


	public void setBbsReadCnt(int bbsReadCnt) {
		this.bbsReadCnt = bbsReadCnt;
	}


	public String getRegDate() {
		return regDate;
	}

		
	public String getModDate() {
		return modDate;
	}


	public void setModDate(String modDate) {
		this.modDate = modDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getBbsComment() {
		return bbsComment;
	}


	public void setBbsComment(String bbsComment) {
		this.bbsComment = bbsComment;
	}


	public long getCommentParent() {
		return commentParent;
	}


	public void setCommentParent(long commentParent) {
		this.commentParent = commentParent;
	}


	public long getCommentGroup() {
		return commentGroup;
	}


	public void setCommentGroup(long commentGroup) {
		this.commentGroup = commentGroup;
	}


	public int getCommentOrder() {
		return commentOrder;
	}


	public void setCommentOrder(int commentOrder) {
		this.commentOrder = commentOrder;
	}


	public int getCommentIndent() {
		return commentIndent;
	}


	public void setCommentIndent(int commentIndent) {
		this.commentIndent = commentIndent;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getUserNick() {
		return userNick;
	}


	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}


	public long getrNum() {
		return rNum;
	}


	public void setrNum(long rNum) {
		this.rNum = rNum;
	}


	public long getStartRow() {
		return startRow;
	}


	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}


	public long getEndRow() {
		return endRow;
	}


	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}


	public String getSearchType() {
		return searchType;
	}


	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	public String getSearchValue() {
		return searchValue;
	}


	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}


	public long getSortValue() {
		return sortValue;
	}


	public void setSortValue(long sortValue) {
		this.sortValue = sortValue;
	}


	public BoardFile getBoardFile() {
		return boardFile;
	}


	public void setBoardFile(BoardFile boardFile) {
		this.boardFile = boardFile;
	}

}

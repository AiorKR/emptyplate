package com.icia.web.model;

import java.io.Serializable;

public class Board implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private int bbsSeq;			//게시물고유번호
	private String userUid;		//회원고유번호
	private int bbsNo;		//게시판 번호
	private String bbsTitle;	//게시물 제목
	private String bbsContent;	//내용
	private int bbsLikeCnt;		//게시물 좋아요수
	private int bbsReadCnt;		//게시물 조회수
	private String regDate;		//게시물 등록일
	private String bbsComment;	//댓글허용
	private int commentParent;	//댓글 부모번호
	private int commentGroup;	//댓글 그룹번호
	private int commentOrder;	//댓글 그룹내순서
	private int commentIndent;	//댓글 들여쓰기
	
	private String userNick;	//사용자 닉네임
	
	private long startRow;		//시작 rownum
	private long endRow;		//끝 rownum
	
	private String searchType;	//조회항목(1:작성자, 2:제목, 3:내용)
	private String searchValue;	//조회값
	
	private String sort;		//**순 정렬(1:최신글술, 2:좋아요순, 3:조회순)
	
	
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public Board()
	{
		bbsSeq = 0;
		userUid = "";
		bbsNo = 0;
		bbsTitle = "";
		bbsContent = "";
		bbsLikeCnt = 0;
		bbsReadCnt = 0;
		regDate = "";
		bbsComment = "";
		commentParent = 0;
		commentGroup = 0;
		commentOrder = 0;
		commentIndent = 0;
		
		userNick = "";
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
	}


	public int getBbsSeq() {
		return bbsSeq;
	}


	public void setBbsSeq(int bbsSeq) {
		this.bbsSeq = bbsSeq;
	}


	public String getUserUid() {
		return userUid;
	}


	public void setUserUid(String userUid) {
		this.userUid = userUid;
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


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getBbsComment() {
		return bbsComment;
	}


	public void setBbsComment(String bbsComment) {
		this.bbsComment = bbsComment;
	}


	public int getCommentParent() {
		return commentParent;
	}


	public void setCommentParent(int commentParent) {
		this.commentParent = commentParent;
	}


	public int getCommentGroup() {
		return commentGroup;
	}


	public void setCommentGroup(int commentGroup) {
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


	public String getUserNick() {
		return userNick;
	}


	public void setUserNick(String userNick) {
		this.userNick = userNick;
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
	
}

package com.icia.web.model;

import java.io.Serializable;

public class BoardLike implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;		//게시물고유번호
	private String userUID;		//회원고유번호
	
	public BoardLike()
	{
		bbsSeq = 0;
		userUID = "";
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
	
	
}

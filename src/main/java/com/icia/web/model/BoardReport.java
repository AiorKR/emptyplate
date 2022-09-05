package com.icia.web.model;

import java.io.Serializable;

public class BoardReport implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;		//게시물고유번호
	private String userUID;		//회원고유번호
	private String report1;		//스팸
	private String report2;		//성격에 맞지 않는 글
	private String report3;		//과도한 욕설
	private String report4;		//분위기를 어지럽히는 글
	private String etcReport;	//기타신고사요
	private String regDate;		//게시물 등록일
	
	private String userNick;	//사용자 닉네임
	
	
	public BoardReport()
	{
		bbsSeq = 0;
		userUID = "";
		report1 = "";
		report2 = "";
		report3 = "";
		report4 = "";
		etcReport = "";
		regDate = "";
		
		userNick = "";
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


	public String getReport1() {
		return report1;
	}


	public void setReport1(String report1) {
		this.report1 = report1;
	}


	public String getReport2() {
		return report2;
	}


	public void setReport2(String report2) {
		this.report2 = report2;
	}


	public String getReport3() {
		return report3;
	}


	public void setReport3(String report3) {
		this.report3 = report3;
	}


	public String getReport4() {
		return report4;
	}


	public void setReport4(String report4) {
		this.report4 = report4;
	}


	public String getEtcReport() {
		return etcReport;
	}


	public void setEtcReport(String etcReport) {
		this.etcReport = etcReport;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getUserNick() {
		return userNick;
	}


	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}

}
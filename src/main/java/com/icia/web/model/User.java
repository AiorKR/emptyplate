/**
 * <pre>
 * 프로젝트명 : BasicBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : User.java
 * 작성일     : 2021. 1. 12.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.model;

import java.io.Serializable;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : User.java
 * 작성일     : 2021. 1. 12.
 * 작성자     : daekk
 * 설명       : 사용자 모델
 * </pre>
 */
public class User implements Serializable
{
	private static final long serialVersionUID = 8638989512396268543L;
	
	private String userUID;	   // 사용자유아이디
	private String userId;     // 사용자 아이디
	private String userPwd;    // 비밀번호
	private String userPhone;  // 전화번호
	private String userName;   // 사용자 명
	private String userNick;   // 사용자 닉네임
	private String userEmail;  // 사용자 이메일 
	private String adminStatus;// 관리자 상태 ("Y":사용, "N":정지)
	private String status;     // 상태 ("Y":사용, "N":정지)
	private String regDate;    // 등록일
	private String bizNum;	   // 사업자번호
	private String bizName;    // 사업자명

	private String userFile; //첨부파일
	private String fileName; //프로필 사진
	
	private String markUserUID;	//즐겨찾기 대상자
	
	/**
	 * 생성자 
	 */
	public User()
	{
		userUID = "";
		userId = "";
		userPwd = "";
		userPhone = "";
		userName = "";
		userNick = "";
		userEmail = "";
		adminStatus = "";
		status = "";
		regDate = "";
		bizNum = "";
		bizName = "";
		userFile = "";
		fileName = "";
		
		markUserUID = "";
	}
	
	
	public String getMarkUserUID() {
		return markUserUID;
	}

	public void setMarkUserUID(String markUserUID) {
		this.markUserUID = markUserUID;
	}

	public String getUserFile() {
		return userFile;
	}

	public void setUserFile(String userFile) {
		this.userFile = userFile;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * <pre>
	 * 메소드명   : getUserId
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getUserId()
	{
		return userId;
	}

	/**
	 * <pre>
	 * 메소드명   : setUserId
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param userId
	 */
	public void setUserId(String userId)
	{
		this.userId = userId;
	}

	/**
	 * <pre>
	 * 메소드명   : getUserPwd
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getUserPwd()
	{
		return userPwd;
	}

	/**
	 * <pre>
	 * 메소드명   : setUserPwd
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param userPwd
	 */
	public void setUserPwd(String userPwd)
	{
		this.userPwd = userPwd;
	}

	/**
	 * <pre>
	 * 메소드명   : getUserName
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getUserName()
	{
		return userName;
	}

	/**
	 * <pre>
	 * 메소드명   : setUserName
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param userName
	 */
	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	/**
	 * <pre>
	 * 메소드명   : getUserEmail
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getUserEmail()
	{
		return userEmail;
	}

	/**
	 * <pre>
	 * 메소드명   : setUserEmail
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param userEmail
	 */
	public void setUserEmail(String userEmail)
	{
		this.userEmail = userEmail;
	}

	/**
	 * <pre>
	 * 메소드명   : getStatus
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getStatus()
	{
		return status;
	}

	/**
	 * <pre>
	 * 메소드명   : setStatus
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param status
	 */
	public void setStatus(String status)
	{
		this.status = status;
	}

	/**
	 * <pre>
	 * 메소드명   : getRegDate
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getRegDate()
	{
		return regDate;
	}

	/**
	 * <pre>
	 * 메소드명   : setRegDate
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param regDate
	 */
	public void setRegDate(String regDate)
	{
		this.regDate = regDate;
	}
	
	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserNick() {
		return userNick;
	}

	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}

	public String getAdminStatus() {
		return adminStatus;
	}

	public void setAdminStatus(String adminStatus) {
		this.adminStatus = adminStatus;
	}

	public String getBizNum() {
		return bizNum;
	}

	public void setBizNum(String bizNum) {
		this.bizNum = bizNum;
	}

	public String getUserUID() {
		return userUID;
	}

	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}

	public String getBizName() {
		return bizName;
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
}

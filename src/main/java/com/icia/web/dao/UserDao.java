/**
 * <pre>
 * 프로젝트명 : EmptyPlate
 * 패키지명   : com.icia.web.dao
 * 파일명     : UserDao.java
 * 작성일     : 2021. 1. 19.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.dao;

import org.springframework.stereotype.Repository;

import com.icia.web.model.User;
import com.icia.web.model.UserFile;


/**
 * <pre>
 * 패키지명   : com.icia.web.dao
 * 파일명     : UserDao.java
 * 작성일     : 2021. 1. 19.
 * 작성자     : daekk
 * 설명       : 사용자 DAO
 * </pre>
 */
@Repository("userDao")
public interface UserDao
{

	/**
	 * <pre>
	 * 메소드명   : userSelect
	 * 작성일     : 2021. 1. 12.
	 * 작성자     : daekk
	 * 설명       : 사용자 조회
	 * </pre>
	 * @param userId 사용자 아이디
	 * @return  com.icia.web.model.User
	 */
	public User userSelect(String userId);
	
	public User userUIDSelect(String userUID);
	
	public User userPhoneSelect(String userPhone);
	
	//사용자 등록
	public int userInsert(User user);
   
	//사용자 정보 수정
	public int userUpdate(User user);

	//프로필사진 등록
	public int userFileInsert(UserFile userFile);
	
	//프로필사진 변경
	public int userFileUpdate(UserFile userFile);
	
	public int userFileDelete(UserFile userFile);
	
	//사용자 탈퇴
	public int userDelete(User user);
	
	//동일 유저 즐겨찾기 여부 확인
	public int userMarkCheck(User user);
		
	//유저 즐겨찾기 추가
	public int userMarkUpdate(User user);
	
	//유저 즐겨찾기 취소
	public int userMarkDelete(User user);
	
	//사용자 탈퇴시 좋아요 삭제
	public int boardLikeDelete(User user);
	
	//사용자 탈퇴시 게시물 즐겨찾기 삭제
	public int boardMarkDelete(User user);
	
	//사용자 탈퇴시 유저 즐겨찾기 삭제
	public int userLikeDelete(User user);
	

}

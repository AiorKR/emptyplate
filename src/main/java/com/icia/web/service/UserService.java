/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.service
 * 파일명     : UserService.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.service;

import java.util.List;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.icia.web.dao.UserDao;
import com.icia.web.model.BoardLike;
import com.icia.web.model.Order;
import com.icia.web.model.User;
import com.icia.web.model.UserFile;
import com.icia.web.util.SmsMessage;


/**
 * <pre>
 * 패키지명   : com.icia.web.service
 * 파일명     : UserService.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * 설명       : 사용자 서비스
 * </pre>
 */
@Service("userService")
public class UserService
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	/**
	 * @Autowired : IoC컨테이너 안에 존재하는 Bean을 자동으로 주입한다.
	 */
	@Autowired
	private UserDao userDao;
	
	/**
	 * <pre>
	 * 메소드명   : userSelect
	 * 작성일     : 2021. 1. 20.
	 * 작성자     : daekk
	 * 설명       : 사용자 조회
	 * </pre>
	 * @param userId 사용자 아이디
	 * @return User
	 */
	public User userSelect(String userId)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}

	
	//사용자 정보 등록
	   public int userInsert(User user)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = userDao.userInsert(user);
	      }
	      catch(Exception e)
	      {
	         logger.error("[UserService]userInsert Exception", e);
	      }
	      return count;
	   }
	   
	   //사용자 정보 수정
	   public int userUpdate(User user)
	   {
		   int count = 0;
		   
		   try
		   {
			   count = userDao.userUpdate(user);
		   }
		   catch(Exception e)
		   {
			   logger.error("UserService]userUpdate Exception", e);
		   }
		   
		   return count;
	   }

	public User userUIDSelect(String userUID) 
	{
			
		User user = null;
		
		try
		{
			user = userDao.userUIDSelect(userUID);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	public int userDelete(User user)
	   {
		   int count = 0;
		   
		   try
		   {
			   count = userDao.userDelete(user);
		   }
		   catch(Exception e)
		   {
			   logger.error("[UserService] userDelete", e);
		   }
		   
		   return count;
	   }
	
	//프로필 사진 등록
	   public int userFileInsert(UserFile userFile)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = userDao.userFileInsert(userFile);
	      }
	      catch(Exception e)
	      {
	         logger.error("[UserService]userFileInsert Exception", e);
	      }
	      return count;
	   }
	   

	 //프로필 사진 변경
	   public int userFileUpdate(UserFile userFile)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = userDao.userFileUpdate(userFile);
	      }
	      catch(Exception e)
	      {
	         logger.error("[UserService]userFileUpdate Exception", e);
	      }
	      return count;
	   }
	   
	   //기본프로필 설정
	   public int userFileDelete(UserFile userFile)
	   {
		   int count = 0;
		   
		   try
		   {
			   count = userDao.userFileDelete(userFile);
		   }
		   catch(Exception e)
		   {
			   logger.error("[UserService] PicDelete", e);
		   }
		   
		   return count;
	   }
	   
	  
	   public User userPhoneSelect(String userPhone)
		{
			User user = null;
			
			try
			{
				user = userDao.userPhoneSelect(userPhone);
			}
			catch(Exception e)
			{
				logger.error("[UserService] userSelect Exception", e);
			}
			
			return user;
		}


	public String sendRandomMessage(String userPhone) {
		
		SmsMessage message = new SmsMessage();
	    Random rand = new Random();
	    String numStr = "";
	    for (int i = 0; i < 6; i++) {
	        String ran = Integer.toString(rand.nextInt(10));
	        numStr += ran;
	    }

	    message.sendsms(userPhone, numStr);

	    return numStr;
	}

	//동일 유저 즐겨찾기 여부 확인
	public int userMarkCheck(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userMarkCheck(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userMarkCheck Exception", e);
		}
		
		return count;
	}
	
	//유저 즐겨찾기 추가
	public int userMarkUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userMarkUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userMarkUpdate Exception", e);
		}
		
		return count;
	}
	
	//유저 즐겨찾기 취소
	public int userMarkDelete(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userMarkDelete(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userMarkDelete Exception", e);
		}
		
		return count;
	}
	
	//사용자 탈퇴시 좋아요 삭제
	public int boardLikeDelete(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.boardLikeDelete(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] boardLikeDelete Exception", e);
		}
		
		return count;
	}
	
	//탈퇴시 좋아요 수 업데이트
	public List<BoardLike> likeList(User user)
	{
		List<BoardLike> likeList = null;
		
		try
		{
			likeList = userDao.likeList(user);
		}
		catch(Exception e)
		{
			logger.error("[userService] likeList Exception", e);
		}
		
		return likeList;
	}
	
	//사용자 탈퇴시 게시물 즐겨찾기 삭제
	public int boardMarkDelete(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.boardMarkDelete(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] boardMarkDelete Exception", e);
		}
		
		return count;
	}
	
	//사용자 탈퇴시 유저 즐겨찾기 삭제
	public int userLikeDelete(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userLikeDelete(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userLikeDelete Exception", e);
		}
		
		return count;
	}


	public List<User> markUserList(String userUID) {
		List<User> list = null;
		
		try
		{	
			list = userDao.markUserList(userUID);
			
		}
		catch(Exception e)
		{
			logger.error("[UserService] markUserList Exception", e);
		}
		
		
		return list;
	}
}

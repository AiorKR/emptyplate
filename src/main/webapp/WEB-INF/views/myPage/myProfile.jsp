<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script src="https://kit.fontawesome.com/def66b134a.js" crossorigin="anonymous"></script>
<script type="text/javascript">
</script>
<style>
.btn-upload {
  width: 150px;
  height: 30px;
  border-radius: 10px;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
}

#file {
  display: none;
}
</style> 
</head>

<body style="background:linear-gradient(grey,antiquewhite);">
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <!-- ====== MyPage ======= -->
  <main id="main">
   <section class="mypage">
        <!--마이페이지-->
 	</br></br>
    <container class="mypage-cont">
     <div class="mypage-title">내 프로필</div>         
       <hr role="tournament1">
    </container>
    </br>

        <div class="d-flex justify-content-between align-items-center">
          <div id="mypage" class="user-edit">
            <div class = "profile-card">
                <div class = "profile-img-div">
                    <img src="/image/${login.memberImg}" class = 'profile-card-img'>
                    <div>
                    <form action="user/userImgFile" method="post" enctyoe="multipart/form-data">
                    	<input type="hidden" name="memberId" id="memberId" value="${login.memberId}">
                    	<label for="file">
  							<div class="btn-upload"><p type="submit" class = "mypage-profile-btn">프로필사진변경<i class="fa-solid fa-pen-to-square"></i></p></div>
						</label>
							<input type="file" name="file" id="file">
                    	</div>
              		</form>  
              		</div>
                <div class = "profile-card-name"><span>유저닉네임</span><button class = "mypage-profile-btn"><i class="fa-solid fa-pen-to-square"></i></button></div>
                <div class = "profile-card-intro">
                  <form style="margin-top: 20px;">아이디 : <span>brown</span></form>
                  <hr>
                  <form style="margin-top: 20px;">이메일 : <span>brown@icia.co.kr</span>&nbsp;<button><i class="fa-solid fa-pen-to-square"></i></button></form>
                  <hr>
                  <form style="margin-top: 20px;">이름 : <span>브라운 킴</span>&nbsp;</form>    
                  <hr>
                  <form style="margin-top: 20px;">전화번호 : <span>010-1234-1234</span>&nbsp;<button><i class="fa-solid fa-pen-to-square"></i></button></form>
                  <hr>
                  <form style="margin-top: 20px;"><button class="btn-password">비밀번호변경</button></form><br/><br/>
                  <form style="margin-top: 20px;"><button style="color: gray; text-decoration:underline; float: right;">회원탈퇴</button></form>
                </div>                
            </div>
        </div>     
    </div>
    </section>

  </main><!-- End #main --> 

 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
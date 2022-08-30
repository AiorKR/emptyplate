<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnDelete").on("click", function(){
		   if(confirm("정말 탈퇴하시겠습니까?") == true)
			{  	
				$.ajax({
					type:"POST",
					url:"/myPage/userDelete",
					data:{
						userId : $("#userId").val()
					},
					datatype:"JSON",
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response){
						if(response.code == 0)
						{
							alert("탈퇴가 완료되었습니다.");
							location.href = "/index";
						}
						else if(response.code == 500)
						{
							alert("회원 정보를 찾을 수 없습니다. 메인 페이지로 돌아갑니다.");
							location.href = "/index";
						}
						else if(response.code == 404)
						{
							alert("사용자가 아닙니다.");
							location.href = "/index";
						}
						else
						{
							alert("회원 탈퇴 중 오류가 발생했습니다.");
							location.href = "/index";
						}
					},
					complete:function(data)
					{
						icia.common.log(data);
					},
					error:function(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
			}
	});

	})


//닉네임 변경 시작
function showPopupNick() { 
	var popHeight = 130;                                      // 띄울 팝업창 높이   
	var popWidth = 460;                                       // 띄울 팝업창 너비
	var winHeight = document.body.clientHeight;	  		      // 현재창의 높이
	var winWidth = document.body.clientWidth;	              // 현재창의 너비
	var winX = window.screenLeft;	                          // 현재창의 x좌표
	var winY = window.screenTop;	                          // 현재창의 y좌표
	var popX = winX + (winWidth - popWidth)/2;
	var popY = winY + (winHeight - popHeight)/2;

	window.open("./nick_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};
//닉네임 변경 끝


//이메일 변경 시작
function showPopupEmail() { 
	var popHeight = 130;                                      // 띄울 팝업창 높이   
	var popWidth = 460;                                       // 띄울 팝업창 너비
	var winHeight = document.body.clientHeight;	  		      // 현재창의 높이
	var winWidth = document.body.clientWidth;	              // 현재창의 너비
	var winX = window.screenLeft;	                          // 현재창의 x좌표
	var winY = window.screenTop;	                          // 현재창의 y좌표
	var popX = winX + (winWidth - popWidth)/2;
	var popY = winY + (winHeight - popHeight)/2;
	
	window.open("./email_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};
//이메일 변경 끝

//사진 변경 시작
function showPopupFile() { 
	var popHeight = 130;                                      // 띄울 팝업창 높이   
	var popWidth = 460;                                       // 띄울 팝업창 너비
	var winHeight = document.body.clientHeight;	  		      // 현재창의 높이
	var winWidth = document.body.clientWidth;	              // 현재창의 너비
	var winX = window.screenLeft;	                          // 현재창의 x좌표
	var winY = window.screenTop;	                          // 현재창의 y좌표
	var popX = winX + (winWidth - popWidth)/2;
	var popY = winY + (winHeight - popHeight)/2;
	
	var file_popup = window.open("./file_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};
//사진 변경 끝

function updateSuccess() {
	location.href = "/myPage/myProfile";
}

function ParmError(){
	alert("파라미터 값이 올바르지 않습니다.");
}

function userError(){
	alert("회원정보가 존재하지 않습다.");
}

function updateError(){
	alert("회원정보 수정 중 오류가 발생하였습니다.");
}

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
                    <c:if test="${user.fileName eq ''}">
                    <img src="/resources/upload/user/userDefault.jpg" class = 'profile-card-img'>
                    </c:if>
                    <c:if test="${user.fileName ne ''}">
                     <img src="/resources/upload/user/${user.fileName}" class = 'profile-card-img'>
		            </c:if>       
                    <div>
                   

                       <label for="file">
                       <div class="btn-upload"><p type="button" class = "mypage-profile-btn" onclick="showPopupFile()">프로필사진변경<i class="fa-solid fa-pen-to-square"></i></p></div>
                  </label>
                     <input type="button" onclick="showPopupFile()" name="file" id="file">
                       </div>
                    
                    </div>
                <div class = "profile-card-name"><span>${user.userNick}</span><button class = "mypage-profile-btn"  onclick="showPopupNick()"><i class="fa-solid fa-pen-to-square"></i></button></div>
                <div class = "profile-card-intro">
                  <form style="margin-top: 20px;">아이디 : <span><c:out value="${user.userId}" /></span></form>
                  <hr>
                  <form style="margin-top: 20px;">이메일 : <span><c:out value="${user.userEmail}" /></span>&nbsp;<button class = "mypage-profile-btn" onclick="showPopupEmail()"><i class="fa-solid fa-pen-to-square"></i></button></form>
                  <hr>
                  <form style="margin-top: 20px;">이름 : <span><c:out value="${user.userName}" /></span>&nbsp;</form>    
                  <hr>
                  <form style="margin-top: 20px;">전화번호 : <span><c:out value="${user.userPhone}" /></span>&nbsp;<button><i class="fa-solid fa-pen-to-square"></i></button></form>
                  <hr>
                  <form style="margin-top: 20px;"><button class="btn-password">비밀번호변경</button></form><br/><br/>
                   <form style="margin-top: 20px;"><button id="btnDelete" style="color: gray; text-decoration:underline; float: right;">회원탈퇴</button></form>
                </div>                
            </div>
        </div>     
    </div>
    </section>

  </main><!-- End #main --> 

 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
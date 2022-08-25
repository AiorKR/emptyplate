<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#userId").focus();
	
	$("#userId").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});
	
	$("#userPwd").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});
		
	$("#btnLogin").on("click", function() {
		
		fn_loginCheck();
		
	});
	
	$("#btnReg").on("click", function() {
		location.href = "/user/regForm";
	});
	
});
 
function fn_loginCheck()
{
	if($.trim($("#userId").val()).length <= 0)
	{
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		return;
	}
	
	if($.trim($("#userPwd").val()).length <= 0)
	{
		alert("비밀번호를 입력하세요.");
		$("#userPwd").focus();
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "/user/loginOk",
		data : {
			userId: $("#userId").val(),
			userPwd: $("#userPwd").val() 
		},
		datatype : "JSON",
		beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", "true");
        },
		success : function(response) {
			
			if(!icia.common.isEmpty(response))
			{
				icia.common.log(response);
				
				// var data = JSON.parse(obj);
				var code = icia.common.objectValue(response, "code", -500);
				
				if(code == 0)
				{
					location.href = "/index";
				}
				else
				{
					if(code == -1)
					{
						alert("비밀번호가 올바르지 않습니다.");
						$("#userPwd").focus();
					}
					else if(code == 404)
					{
						alert("아이디와 일치하는 사용자 정보가 없습니다.");
						$("#userId").focus();
					}
					else if(code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#userId").focus();
					}
					else
					{
						alert("오류가 발생하였습니다.");
						$("#userId").focus();
					}	
				}	
			}
			else
			{
				alert("오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},
		complete : function(data) 
		{ 
			// 응답이 종료되면 실행, 잘 사용하지않는다
			icia.common.log(data);
		},
		error : function(xhr, status, error) 
		{
			icia.common.error(error);
		}
	});
}
</script>
 
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

   <!-- ======= Login Section ======= -->
  <section id="log" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start" data-aos="zoom-in" data-aos-delay="100" style="margin-top: 150px;">
      <div class="row">
        <!--로그인-->
        <div class="cont" style="margin:auto;">
          <div class="form sign-in">
            <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">매장관리자 회원가입</h2>
            <label>
              <span>아이디</span>
              <input type="text" placeholder="아이디를 입력하세요." />
            </label>
            <label>
              <span>Name</span>
              <input type="text" placeholder="이름을 입력하세요." />
            </label>
            <label>
              <span>Password</span>
              <input type="password" placeholder="비밀번호를 입력하세요." />
            </label>
            <label>
              <span>Password확인</span>
              <input type="password" placeholder="비밀번호를 한번 더 입력하세요." />
            </label>
            <label>
              <span>Email</span>
              <input type="email" placeholder="이메일 주소를 입력하세요."/>
            </label>
            <label>
              <span>전화번호</span>
              <input type="text" placeholder="전화번호를 입력하세요." />
            </label>
            <label>
              <span>사업자번호</span>
              <input type="text" placeholder="사업자번호를 입력하세요." /><br />
              <button class="submit" style="width: 90px; height: 20px; font-size: 11px; margin: auto;">사업자번호확인</button>
            </label>
            <br />
            <label>
              <span>매장명</span>
              <input type="text" placeholder="매장명을 입력하세요." />
            </label>
            <label>
              <span>대표명</span>
              <input type="text" placeholder="대표명을 입력하세요." />
            </label>
            <button type="button" class="submit">회원가입</button>              
            <button type="button"><img src="/resources/images/kakao_login_medium_wide.png" style="margin:auto;" /></button><br />
          </div>
          <div class="sub-cont">
            <div class="img">
              <div class="img__text m--up">
                <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">이미 회원이신가요?</h2>
                <p>아래 버튼을 클릭하여 <br/> 더 많은 미식세계를 누려보세요!</p>
              </div>
              <div class="img__text m--in">
                <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">처음오셨나요?</h2>
                <p>엠프티플레이트에 가입하고 <br/> 더 많은 미식세계를 누려보세요!</p>
              </div>
              <div class="img__btn">
                <span class="m--up" style="font-family:'cafe24Dangdanghae';">로그인하기</span>
                <span class="m--in" style="font-family:'cafe24Dangdanghae';">회원가입</span>
              </div>
            </div>
            <div class="form sign-up">
              <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">어서오세요, empty plate에.</h2>
                          <label for="userId">
              <span>아이디</span>
              <input type="text" id="userId" name="userId" placeholder="아이디" />
            </label>
            <label for="userPwd">
              <span>비밀번호</span>
              <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호"/>
            </label>
            <button type="button"><p class="forgot-pass" style="font-family:'cafe24Dangdanghae';">비밀번호 찾기</p></button>
            <button type="button" id="btnLogin" class="submit">로그인</button>
            <button type="button"><img src="/resources/images/kakao_login_medium_wide.png" style="margin:auto;" /></button><br />
              <p class="forgot-pass"><a href="#" style="color: #270d0d; text-decoration:underline;">매장가입</a></p>
              <br />
              <br />
            </div>
          </div>
        </div>
        <!--로그인 끝-->
        </div>
       <!-- <div class="col-lg-4 d-flex align-items-center justify-content-center position-relative" data-aos="zoom-in" data-aos-delay="200">
          <a href="https://www.youtube.com/watch?v=u6BOC7CDUTQ" class="glightbox play-btn"></a>
        </div>-->

      </div>
    </div>
  </section><!-- End log -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
 <script>
 document.querySelector('.img__btn').addEventListener('click', function() {
 document.querySelector('.cont').classList.toggle('s--signup');
 });
 
 window.onload = function() {
 function onClick() {
   document.querySelector('.modal_wrap').style.display ='block';
   document.querySelector('.black_bg').style.display ='block';
 }
 function offClick() {
   document.querySelector('.modal_wrap').style.display ='none';
   document.querySelector('.black_bg').style.display ='none';
 }
 document.getElementById('modal_btn').addEventListener('click', onClick);
 document.querySelector('.modal_close').addEventListener('click', offClick); };
</script>

</body>

</html>
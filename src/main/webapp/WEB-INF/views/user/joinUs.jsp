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
		fn_userReg();
	});
	
});

$("#userId2").focus();

$("#btnReg").on("click", function() {
   
   // 모든 공백 체크 정규식
   var emptCheck = /\s/g;
   // 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
   var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
         
   if($.trim($("#userId2").val()).length <= 0)
   {
      alert("사용자 아이디를 입력하세요.");
      $("#userId2").val("");
      $("#userId2").focus();
      return;
   }
   
   if (emptCheck.test($("#userId2").val())) 
   {
      alert("사용자 아이디는 공백을 포함할 수 없습니다.");
      $("#userId2").focus();
      return;
   }
   
   if (!idPwCheck.test($("#userId2").val())) 
   {
      alert("사용자 아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요");
      $("#userId2").focus();
      return;
   }
   
   if($.trim($("#userPwd2").val()).length <= 0)
   {
      alert("비밀번호를 입력하세요.");
      $("#userPwd2").val("");
      $("#userPwd2").focus();
      return;
   }
   
   if (emptCheck.test($("#userPwd2").val())) 
   {
      alert("비밀번호는 공백을 포함할 수 없습니다.");
      $("#userPwd2").focus();
      return;
   }
   
   if (!idPwCheck.test($("#userPwd2").val())) 
   {
      alert("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
      $("#userPwd2").focus();
      return;
   }
   
   if ($("#userPwd2").val() != $("#userPwd3").val()) 
   {
      alert("비밀번호가 일치하지 않습니다.");
      $("#userPwd3").focus();
      return;
   }
   
   if($.trim($("#userName").val()).length <= 0)
   {
      alert("사용자 이름을 입력하세요.");
      $("#userName").val("");
      $("#userName").focus();
      return;
   }
   
   if($.trim($("#userPhone").val()).length <= 0)
   {
      alert("사용자 전화번호를 입력하세요.");
      $("#userPhone").val("");
      $("#userPhone").focus();
      return;
   }
      
   if(!fn_validateEmail($("#userEmail").val()))
   {
      alert("사용자 이메일 형식이 올바르지 않습니다.");
      $("#userEmail").focus();
      return;   
   }
   
   $("#userPwd2").val($("#userPwd3").val());
   

   //아이디중복체크 ajax
   $.ajax({
     type:"POST",
     url:"/user/idCheck",
     data:{
        userId: $("#userId2").val()
     },
     datatype:"JSON",
     beforeSend:function(xhr){
        xhr.setRequestHeader("AJAX", "true");
     },
     success:function(response){
        if(response.code == 0)
        {
           fn_userReg(); 
        }
        else if(response.code == 100)
        {
           alert("중복된 아이디 입니다.");
        }
        else if(response.code == 400)
        {
           alert("파라미터 값이 올바르지 않습니다.");
        }
        else
        {
           alert("오류가 발생하였습니다. ");
           $("#userId").focus();
        }
     }, 
     error:function(xhr, status, error){
        icia.common.error(error);
     }
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

function fn_userReg()
{	
	$.ajax({
       type:"POST",
       url:"/user/regProc",
       data:{
    	  userUId: $("#userUId").val(),
          userId: $("#userId2").val(),
          userPwd: $("#userPwd2").val(),
          userName: $("#userName").val(),
          userPhone: $("#userPhone").val(),
          userEmail: $("#userEmail").val()
       },
       datatype:"JSON",
       beforeSend:function(xhr){
          xhr.setRequestHeader("AJAX", "true");
       },
       success:function(response)
       {
         if(response.code == 0)
         {
             alert("회원 가입이 되었습니다. ");
             location.href = "/"; //"/bord/list";
         }
         else if(response.code == 100)
         {
            alert("회원 아이디가 중복 되었습니다.");
            $("#userId2").focus();
         }
         else if(response.code == 400)
         {
            alert("파라미터 값이 올바르지 않습니다.");
            $("#userId2").focus();
         }
         else if(response.code == 500)
         {
            alert("회원가입 중 오류가 발생하였습니다.");
            $("#userId2").focus();
         }
         else
         {
            alert("회원가입 중 오류가 발생하였습니다.");
            $("#userId2").focus();
         }
       },
      error:function(xhr, status, error)
      {
          icia.common.error(error);
      }
  });
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
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
        
        
        <!-- 회원가입 시작 -->
        <div class="cont" style="margin:auto;">
          <div class="form sign-in">
            <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">회원가입</h2>
            	<form id="regForm" method="post">
		            <label>
		              <span >아이디</span>
		              <input type="text" id="userId2" name="userId2" placeholder="아이디를 입력하세요." maxlength="12"/>
		            </label>	    
		            <label>
		              <span>Password</span>
		              <input type="password" id="userPwd2" name="userPwd2" placeholder="비밀번호를 입력하세요." maxlength="12" />
		            </label>
		            <label>
		              <span>Password확인</span>
		              <input type="password" id="userPwd3" name="userPwd3"placeholder="비밀번호를 한번 더 입력하세요." maxlength="12" />
		            </label>
		            <label>
		              <span>Name</span>
		              <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요." maxlength="12" />
		            </label>
		            <label>
		              <span>Email</span>
		              <input type="email" id="userEmail" name="userEmail" placeholder="이메일 주소를 입력하세요." maxlength="20" />
		            </label>
		            <label>
		              <span>전화번호</span>
		              <input type="text" id="userPhone" name="userPhone" placeholder="전화번호를 입력하세요." maxlength="11" />
		            </label>
		                <label class="Membership-Terms">
		                <button class="Membership-Terms" type="button" id="modal_btn" style="color: #C2A383;">회원약관</button>
		                <div class="black_bg"></div>
		                <div class="modal_wrap">
		                  <div class="modal_close"><a href="#">close</a></div>
		                    <div>
		                      <br /><br /><br />엠프티플레이트 이용 및 회원가입 약관<br /> [제 1 장 총칙] 제 1 조 목적<br /><br />
		
		이 약관은 전기통신사업법령 및 정보통신망 이용촉진 등에 관한 법령에 의하여 엠프티플레이트(이하 "회사"라 한다)가 제공하는 인터넷 서비스(이하 "서비스"라 한다)의 이용 조건 및 절차에 관한 사항을 규정함을 목적으로 합니다.<br /><br />
		
		제 2 조 약관의 효력과 변경<br /><br />
		
		(1) 이 약관은 그 내용을 회사의 웹사이트에 게시하거나 기타의 방법으로 회원에게 공지하고, 이에 동의한 회원이 서비스에 가입함으로써 효력이 발생합니다.<br />
		(2) 회사가 필요하다고 인정하는 경우에는 이 약관을 변경할 수 있으며, 약관을 변경할 경우, 최소 7일 이상의 기간 동안 초기화면의 공지사항 또는 팝업화면 등을 통해 고지를 하고, 고지 후 7일 이상의 기간이 경과된 후에야 변경된 약관의 효력을 갖는 것으로 합니다.<br /><br />
		
		제 3 조 약관의 명시와 개정<br /><br />
		
		(1) 회사는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처 등을 이용자가 알 수 있도록 초기 화면에 게시하거나 기타의 방법으로 이용자에게 공지해야 합니다. <br />
		(2) 회사는 약관의 규제 등에 관한 법률, 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br />
		(3) 이용자는 변경된 약관에 대해 거부할 권리가 있습니다. 이용자는 변경된 약관이 공지된 지 15일 이내에 거부의사를 표명할 수 있습니다. 이용자가 거부하는 경우 본 서비스 제공자인 회사는 15일의 기간을 정하여 이용자에게 사전 통지 후 당해 이용자와의 계약을 해지할 수 있습니다. 만약, 이용자가 거부의사를 표시하지 않고 서비스를 계속 이용하는 경우에는 동의하는 것으로 간주합니다.<br />
		(4) 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있습니다.<br /><br />
		
		제 4 조 약관 외 준칙<br /><br />
		
		이 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신망이용촉진및정보보호등에관한법률 등 관련 법령 및 회사가 정한 서비스 세부이용지침 등의 규정에 따릅니다. <br /><br />
		
		                    </div>
		                    <span style="color: black;">약관에 동의합니다.<input type="checkbox" required/></span>
		                 </div>
		            <button type="button" id="btnReg" class="submit">회원가입</button>
		    	</form> 
            <button type="button"><img src="/resources/images/kakao_login_medium_wide.png" style="margin:auto;" /></button><br />
          </div>
        <!-- 회원가입 끝 -->  
          
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
              <p class="forgot-pass"><a href="/user/storeJoinUs" style="color: #270d0d; text-decoration:underline;">매장가입</a></p>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#userId2").focus();
	
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
		   
		   if($.trim($("#userEmail").val()).length <= 0)
		   {
		      alert("사용자 이메일을 입력하세요.");
		      $("#userEmail").val("");
		      $("#userEmail").focus();
		      return;
		   }
		   
		   if($("#userPhone").val().length != 7)
		   {
		      alert("사용자 전화번호를 입력하세요.");
		      return;
		   }
		      
		   if(!fn_validateEmail($("#userEmail").val()))
		   {
		      alert("사용자 이메일 형식이 올바르지 않습니다.");
		      $("#userEmail").focus();
		      return;   
		   }
		   
		   if($.trim($("#userNick").val()).length <= 0)
		   {
		      alert("사용하실 닉네임을 입력하세요.");
		      $("#userNick").val("");
		      $("#userNick").focus();
		      return;
		   }
		   
		   $("#userPwd2").val($("#userPwd3").val());
		   
		   if($.trim($("#bizNum").val()).length <= 0)
		   {
		      alert("사업자번호를 입력하세요.");
		      $("#bizNum").val("");
		      $("#bizNum").focus();
		      return;
		   }
		   
		   if($.trim($("#bizName").val()).length <= 0)
		   {
		      alert("매장 이름을 입력하세요.");
		      $("#bizName").val("");
		      $("#bizName").focus();
		      return;
		   }
		   
		   if($.trim($("#accessNum").val()).length <= 0)
		   {
			  alert("인증번호를 입력하세요.");
			  $("#accessNum").val();
			  $("#accessNum").focus();
			  return;
		   }   
function fn_idCheck()
{
		   //아이디 중복체크 ajax
		   $.ajax({
		     type:"POST",
		     url:"/user/idCheck",
		     data:{
		        userId: $("#userId2").val(),
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
}		   
		   //매장 인증번호 확인 ajax
		   $.ajax({	 
		     type:"POST",
		     url:"/user/accessNumChk",
		     data:{
		        accessNum: $("#accessNum").val()
		     },
		     datatype:"JSON",
		     beforeSend:function(xhr){
		        xhr.setRequestHeader("AJAX", "true");
		     },
		     success:function(response){
		        if(response.code == 0)
		        {
		           fn_idCheck(); 
		        }
		        else if(response.code == 100)
		        {
		           alert("인증번호가 올바르지 않습니다.");
		        }
		        else if(response.code == 400)
		        {
		           alert("인증번호가 올바르지 않습니다.");
		        }
		        else
		        {
		           alert("오류가 발생하였습니다. ");
		           $("#accessNum").focus();
		        }
		     }, 
		     error:function(xhr, status, error){
		        icia.common.error(error);
		     }
		   });
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
					else if(code == 403)
	               	{
	                	  alert("사용이 중지된 사용자 입니다.");
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
       url:"/user/regManProc",
       data:{
    	  userUId: $("#userUId").val(),
          userId: $("#userId2").val(),
          userPwd: $("#userPwd2").val(),
          userName: $("#userName").val(),
          userNick: $("#userNick").val(),
          userEmail: $("#userEmail").val(),
          bizNum: $("#bizNum").val(),
          bizName: $("#bizName").val(),
          accessNum :$("#accessNum").val()
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
             location.href = "/user/login"; //"/bord/list";
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

Kakao.init('37cdbda3af5494984233ca8e8d7d9f7b'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
        success: function (authObj) {
            console.log(authObj); // access토큰 값
            Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
         
            getInfo();
            
        },
        fail: function (err) {
            console.log(err);
        }
    });
}

// 4. 엑세스 토큰을 발급받고, 아래 함수를 호출시켜서 사용자 정보를 받아옴.
function getInfo() {
   Kakao.API.request({
        url: '/v2/user/me',
        success: function (res) {
            console.log(res);
            // 이메일, 닉네임, 프로필이미지
            var id = res.id;
            var email = res.kakao_account.email;
            var nickname = res.kakao_account.profile.nickname;
            var profile_image = res.kakao_account.profile.thumbnail_image_url;
            var pw = "kaP";
            console.log(id, email, nickname, profile_image);
              
            $.ajax({
               type:"POST",
               url:"/user/idCheck",
               data:{
                  userId: id
               },
               datatype:"JSON",
               beforeSend:function(xhr){
                  xhr.setRequestHeader("AJAX", "true");
               },
               success:function(response){
                  if(response.code == 0)
                  {//카카오 최초 로그인
                	  $.ajax({
                          type : "POST",
                          url : "/user/kakaoSet",
                          data : {
                             userId: id,
                             userPwd: pw,
                             userEmail: email,
                             userNick: nickname
                          },
                          datatype : "JSON",
                          beforeSend : function(xhr){
                                xhr.setRequestHeader("AJAX", "true");
                            },
                          success : function(response) {
                             
                                if(response.code == 0)
                                {
                                   kakaoLogout();
                                   showPopupKakao();
                                }
                                else
                                {    
                                   kakaoLogout();	
                                   if(response.code == 400)
                                   {
                                      alert("파라미터 값이 올바르지 않습니다.");
                                   }
                                   else
                                   {
                                      alert("오류가 발생하였습니다.");
                                   }   
                                } 
                          }
                      });
                  }
                  else if(response.code == 100)
                  {//카카오 자동로그인
                    $.ajax({
                        type : "POST",
                        url : "/user/loginOk",
                        data : {
                           userId: id,
                           userPwd: pw 
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
                                 kakaoLogout();
                                 location.href = "/index";
                              }
                              else
                              {
                                 kakaoLogout();
                                 if(code == -1)
                                 {
                                    alert("비밀번호가 올바르지 않습니다.");         
                                 }
                                 else if(code == 404)
                                       {
                                          alert("아이디와 일치하는 사용자 정보가 없습니다.");                 
                                       }
                                       else if(code == 403)
                                       {
                                          alert("사용이 중지된 사용자 입니다.");
                                     }                  
                                 else if(code == 400)
                                 {
                                    alert("파라미터 값이 올바르지 않습니다.");
                                 }
                                 else
                                 {
                                    alert("오류가 발생하였습니다.");
                                 }   
                              }   
                           }
                           else
                           {
                              kakaoLogout();
                              alert("오류가 발생하였습니다.");
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
                         //자동로그인 종료
                  }
                  else if(response.code == 400)
                  {
                     kakaoLogout();
                     alert("파라미터 값이 올바르지 않습니다.");
                  }
                  else
                  {
                    kakaoLogout();
                     alert("오류가 발생하였습니다. ");
                  }
               }, 
               error:function(xhr, status, error){
                  icia.common.error(error);
               }
             });
        },
        fail: function (error) {
            alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
        }
    });
}
//카카오 로그인 끝

function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
           console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  


function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

//비밀번호 찾기 시작
function showPopupPwdSearch() {
	
   var popHeight = 160;                                      // 띄울 팝업창 높이   
   var popWidth = 460;                                       // 띄울 팝업창 너비
   var winHeight = document.body.clientHeight;                 // 현재창의 높이
   var winWidth = document.body.clientWidth;                 // 현재창의 너비
   var winX = window.screenLeft;                             // 현재창의 x좌표
   var winY = window.screenTop;                             // 현재창의 y좌표
   var popX = winX + (winWidth - popWidth)/2;
   var popY = winY + (winHeight - popHeight)/2;
   
   window.open("./pwdSearch_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
  
};
//비밀번호 찾기 끝

//카카오 전화번호 시작
function showPopupKakao() { 
   var popHeight = 130;                                      // 띄울 팝업창 높이   
   var popWidth = 500;                                       // 띄울 팝업창 너비
   var winHeight = document.body.clientHeight;                 // 현재창의 높이
   var winWidth = document.body.clientWidth;                 // 현재창의 너비
   var winX = window.screenLeft;                             // 현재창의 x좌표
   var winY = window.screenTop;                             // 현재창의 y좌표
   var popX = winX + (winWidth - popWidth)/2;
   var popY = winY + (winHeight - popHeight)/2;
   
   window.open("./kakao_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};

function updateSuccess() {
	var pw = "kaP";
	$.ajax({
	    type : "POST",
	    url : "/user/kloginOk",
	    data : {
	       userPwd: pw 
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
	             }
	             else if(code == 404)
	                   {
	                      alert("아이디와 일치하는 사용자 정보가 없습니다.");                 
	                   }
	                   else if(code == 403)
	                   {
	                      alert("사용이 중지된 사용자 입니다.");
	                 }                  
	             else if(code == 400)
	             {
	                alert("파라미터 값이 올바르지 않습니다.");
	             }
	             else
	             {
	                alert("오류가 발생하였습니다.");
	             }   
	          }   
	       }
	       else
	       {
	          alert("오류가 발생하였습니다.");
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
                          
//카카오 전화번호  끝

//전화번호 인증 시작
function showPopupPhone() { 
   var popHeight = 220;                                      // 띄울 팝업창 높이   
   var popWidth = 460;                                       // 띄울 팝업창 너비
   var winHeight = document.body.clientHeight;                 // 현재창의 높이
   var winWidth = document.body.clientWidth;                 // 현재창의 너비
   var winX = window.screenLeft;                             // 현재창의 x좌표
   var winY = window.screenTop;                             // 현재창의 y좌표
   var popX = winX + (winWidth - popWidth)/2;
   var popY = winY + (winHeight - popHeight)/2;
   
   window.open("./phone_popup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};
function phonefOk() { 
const userPhone = document.getElementById("userPhone")
userPhone.value = "인증되었습니다"
};

//전화번호 인증 끝

var openWin;
//사업자번호 상태조회 시작
function bizNumPopup() { 
   window.name = "storeJoinUs";
   var popHeight = 130;                                      // 띄울 팝업창 높이   
   var popWidth = 500;                                       // 띄울 팝업창 너비
   var winHeight = document.body.clientHeight;                 // 현재창의 높이
   var winWidth = document.body.clientWidth;                 // 현재창의 너비
   var winX = window.screenLeft;                             // 현재창의 x좌표
   var winY = window.screenTop;                             // 현재창의 y좌표
   var popX = winX + (winWidth - popWidth)/2;
   var popY = winY + (winHeight - popHeight)/2;
   
   openWin = window.open("/user/bizNumPopup", "pop", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+"resizable=yes"); 
};
function NumfOk() { 
 openWin.document.getElementById("search").value = document.getElementById("bizNum").value;
};

//사업자번호 상태조회 끝

</script>
 
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

   <!-- ======= Login Section ======= -->
  <section id="log" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start" data-aos="zoom-in" data-aos-delay="100" style="margin-top: 150px;">
      <div class="row" style="margin-bottom:40px; margin-top:40px;">
        <!--로그인-->
        <div class="cont" style="margin:auto;">
          <div class="form sign-in">
            <h2 style="font-family: 'cafe24Dangdanghae'; color: #cda45e;">매장관리자 회원가입</h2>
            <label>
              <span>아이디</span>
              <input type="text" id="userId2" name="userId2" placeholder="아이디를 입력하세요." />
            </label>            
            <label>
              <span>Password</span>
              <input type="password" id="userPwd2" name="userPwd2" placeholder="비밀번호를 입력하세요." />
            </label>
            <label>
              <span>Password확인</span>
              <input type="password" id="userPwd3" name="userPwd3" placeholder="비밀번호를 한번 더 입력하세요." />
            </label>
            <label>
              <span>Name</span>
              <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요." />
            </label>
			<label>
              <span>닉네임</span>
              <input type="text" id="userNick" name="userNick" placeholder="닉네임을 입력하세요." maxlength="12" />
            </label>	            
            <label>
              <span>Email</span>
              <input type="email" id="userEmail" name="userEmail" placeholder="이메일 주소를 입력하세요."/>
            </label>
            <label>
		     <span>전화번호</span>
		     <input type="button" id="userPhone" name="userPhone" value="전화번호를 입력하세요." onclick="showPopupPhone()"/>
		    </label>
            <label>
              <span>사업자번호</span>        
              <input type="text" id="bizNum" name="bizNum" value="사업자번호를 입력하세요." maxlength="10" onclick="bizNumPopup()" readonly/>
            </label>
            <label>
              <span>매장명</span>
              <input type="text" id="bizName" name="bizName" placeholder="매장명을 입력하세요." maxlength="12"/>
            </label>
            <label>
              <span>매장가입 인증번호</span><br />
              <span>(고객센터에 문의하세요.)</span>        
              <input type="text" id="accessNum" name="accessNum" placeholder="매장가입 인증번호를 입력하세요." maxlength="10"/>
            </label>
            <button type="button" id="btnReg" class="submit">회원가입</button><br />
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
            <button type="button" onclick="showPopupPwdSearch()"><p class="forgot-pass" style="font-family:'cafe24Dangdanghae';">비밀번호 찾기</p></button>
            <button type="button" id="btnLogin" class="submit">로그인</button>
            <button type="button" onclick="kakaoLogin()"><img src="/resources/images/kakao_login_medium_wide.png" style="margin:auto;" /></button><br />
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
 
 </script>

</body>

</html>
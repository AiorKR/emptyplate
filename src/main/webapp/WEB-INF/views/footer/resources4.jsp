<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
  
    $(document).ready(function() {
      $("#shopName").focus();

      $("#inquiryBtn").on("click", function() {
        var emptCheck = /\s/g;
        var idPwCheck = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
        var regExp = /^\d{3}\d{3,4}\d{4}$/;
       	var 


        if($.trim($("#shopName").val()).length <= 0)
        {
         alert("매장명을 입력하세요.");
         $("#shopname").val("");
         $("#shopname").focus();
         return;
        }        

        if($.trim($("#userName").val()).length <= 0)
        {
         alert("문의자이름을 입력하세요.");
         $("#username").val("");
         $("#username").focus();
         return;
        }
        
        if (!idPwCheck.test($("#userName").val())) 
        {
         alert("문의자이름은 2~10자의 영문 대소문자와 숫자로만 입력하세요");
         $("#username").focus();
         return;
        }        

        if (!regExp.test($("#userPhone").val())) 
        {
         alert("문의자전화번호를 맞게 입력하세요");
         $("#userPhone").focus();
         return;
        }
        
        if($.trim($("#userPhone").val()).length <= 0)
        {
         alert("문의자전화번호를 입력하세요.");
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
        
      }) 
      
    })  
function fn_entryReg()
{
	$.ajax({
		type:"POST",
		url:"/footer/entryForm",
		data:{
			userId:$("#shopName").val(),
			userName:$("#userName").val(),
			userPhone:$("#userPhone").val(),
			
			userEmail:$("#userEmail").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("입점문의등록 되었습니다.");
				location.href = "/";  //"/board/list";
			}	
			else if(response.code == 100)
			{
				alert("회원 아이디가 중복 되었습니다.");
				$("#userId").focus();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#userId").focus();
			}	
			else if(response.code == 500)	
			{
				alert("회원 가입 중 오류가 발생하였습니다.");
				$("#userId").focus();
			}
			else
			{
				alert("회원 가입 중 오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
}    
  </script>

</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   
  <!-- ======= term Section ======= -->
    <section id="term4" class="term4">
        <div class="container"> <!--class="container"시작-->
            <div class="row" data-aos="fade-up" data-aos-delay="100"> <!--class="row"시작-->
              
                <!--term 메뉴시작-->
                <div class="nav nav-pills nav-justified" id="pills-tab" role="tablist">
                  <li class="nav-item" >
                  	<a href="/footer/resources">
                    	<button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button">개인정보 처리방침</button>
                    </a>
                  </li>
                  <li class="nav-item">
                  	<a href="/footer/resources2">
                    	<button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button">서비스 이용약관</button>
                    </a>
                  </li>
                  <li class="nav-item">
                  	<a href="/footer/resources3">
                    	<button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button">위치정보 이용약관</button>
                    </a>
                  </li>
                  <li class="nav-item">
                  	<a href="/footer/resources4">
                    	<button class="nav-link active" id="pills-contact-tab2" data-bs-toggle="pill" data-bs-target="#pills-contact2" type="button">입점문의</button>
                    </a>
                  </li>
                </div>
                <!--term 메뉴끝-->  
                               

                  <!--입점문의 시작(1220~1312)-------------------------------------------------->
                <div class="tab-content">   
                  <div class="tab-pane active" id="pills-contact2" role="tabpanel" aria-labelledby="pills-contact-tab">
                    <div class="title-area">
                        <br>
                        <h3>입점문의</h3>
                    </div>

                    <div class="storequestion">
                        <form name="form1" id="form1" method="post" action="">
                            
                            <fieldset>
                              

                                <div class="doc">
                                    <div id="doc-inner">
                                        <br>
                                        <br>
                                        <p>
                                            <b>개인정보 수집 및 이용에 대한 안내</b>
                                        </p>
                                        <br>
                                        <p>
                                            (주)와드는 입점,문의사항 접수시 최소한의 범위 내에서 아래와 같이 개인정보를 수집,이용합니다.
                                        </p>                      

                                        <p>
                                            <div>
                                                <ul>-수집하는 개인정보 항목 : 매장명, 이름, 연락처</ul>                                        
                                                <ul>-수집 및 이용목적 : 입점, 문의사항 접수 및 처리결과 회신</ul>
                                                <ul>-개인정보의 이용기간 : 목적 달성 후, 해당 개인정보 지체없이 파기</ul>
                                            </div>                                        
                                        </p>                                          

                                        <br>
                                        <p>
                                            위 개인정보 수집,이용에 대한 동의를 거부할 권리가 있습니다. 다만 동의를 거부하는 경우 입점, 문의사항 접수가 제한될 수 있습니다.
                                        </p>
                                    </div>
                                </div>  



                              <div class="storeblank">  
                                <p>
                                    매장명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                                <input type="text" name="shopName" id="shopName" placeholder="매장명을 입력하세요" size="30">
                                </p>
                                <p>
                                    문의자 이름&nbsp;:
                                <input type="text" name="userName" id="userName" placeholder="문의자이름을 입력하세요" size="30">
                                </p>
                                <p>
                                문의자 전화번호&nbsp;:
                                <input type="tel" name="userPhone" id="userPhone" placeholder="문의자전화번호를 입력하세요" size="30">
                                </p>                                                                
                                <p>
                                문의자 이메일&nbsp;:
                                <input type="tel" name="userEmail" id="userEmail" placeholder="문의자이메일을 입력하세요" size="30">
                                </p>
                              </div>
                                
                                <br>
                                <br>
                                <div class="fieldset-header">
                                    <h4> 약관동의 </h4>
                                    <div class="utils">
                                        <label class="label-checkbox">
                                            <input type="checkbox" id="checkAgree" name="checkAgree">
                                            개인정보 수집 및 이용 동의(필수)
                                        </label>
                                    </div>
                                </div>
                            </fieldset>
                            <br>
                            <div class="inquiry">
                                <button type="submit" id="inquiryBtn" name="inquiryBtn" value="접수하기">                         
                                    접수하기
                                </button>
                            </div>    
                            <br>
                            <br>
                            <br>
                            <br>
                        </form>
                    </div>
                  </div>
                </div> 
                  <!--입점문의 끝(1220~1312)-->               

            </div>  
          </div> <!--class="row"끝--> 
        </div> <!--class="container"끝-->          
        
  </section>        
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
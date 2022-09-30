<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<script type="text/javascript">

$(document).ready(function() {
   
   $("#btnReg").on("click", function(){
	 	  //공백정규표현식
	      var emptyCheck = /\s/g;
	      //가게 이름정규표현식
	      var shopNameCheck = /^[가-힣a-zA-Z0-9\s]{1,20}$/;
	      
	    	 
	      //핸드폰정규표현식
	      let check = /^[0-9]+$/;
	      
	      //매장명
	      if($.trim($("#shopName").val()).length <= 0){
	         alert("매장명을 입력하세요.");
	         $("#shopName").val("");
	         $("#shopName").focus();
	         return;
	      }
	      
	      if (!shopNameCheck.test($("#shopName").val())) 
	      {
	         alert("매장명은 한글,영문,숫자 포함 1~20글자 사이만 가능합니다.");
	         $("#shopName").focus();
	         return;
	      }
	      
	      //문의자이름
	      if($.trim($("#userName").val()).length <= 0){
	         alert("문의자이름을 입력하세요.");
	         $("#userName").val("");
	         $("#userName").focus();
	         return;
	      }
	                 
	      
	      
	      //문의자 핸드폰 번호
	      if($.trim($("#userPhone").val()).length <= 0){
	         alert("핸드폰번호를 입력하세요.");
	         $("#userPhone").val("");
	         $("#userPhone").focus();
	         return;
	      }
	      
	      if(emptyCheck.test($("#userPhone").val())){
	         alert("핸드폰 번호는 공백을 포함할 수 없습니다.");
	         $("#userPhone").focus();
	         return;
	      }
	      
	      if(!check.test($("#userPhone").val())){
	         alert("숫자만 입력 가능합니다.");
	         $("#userPhone").focus();
	         return;
	      }
	      
	      //문의자 이메일주소
	      if($.trim($("#userEmail").val()).length <= 0){
	          alert("이메일주소를 입력하세요.");
	          $("#userEmail").val("");
	          $("#userEmail").focus();
	          return;
	       }
	      
	      if(emptyCheck.test($("#userEmail").val())){
	          alert("이메일주소는 공백을 포함할 수 없습니다.");
	          $("#userEmail").focus();
	          return;
	       }
	      
	      if(!fn_validateEmail($("#userEmail").val()))
	         {
	            alert("사용자 이메일 형식이 올바르지 않습니다.");
	            $("#userEmail").focus();
	            return;   
	      }
	      
	      //약관동의체크      
	      if(!$('#checkAgree').prop('checked') === true)
	      {
	       alert('약관동의버튼을 체크해 주세요');
	       return;
	      }
      
      
      
      fn_shopReg();
      
   });
});

function fn_shopReg(){
   $.ajax({
      type:"POST",
      url:"/footer/regProc",
      data:{
         shopName:$("#shopName").val(),
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
            alert("입점문의신청이 완료 되었습니다.");
            location.href = "/footer/launchingInquiry";
         }
         else if(response.code == 400)
         {
            alert("파라미터 값이 올바르지 않습니다.");
            $("#shopName").focus();
         }
         else if(response.code == 500)
         {
            alert("신청 중 오류가 발생하였습니다.");
            $("#shopName").focus();
         }
         else
         {
            alert("신청 중 오류가 발생하였습니다.");
            $("#shopName").focus();
         }
      },
      error:function(xhr, status, error){
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
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
   <!-- ======= 입점문의 Section ======= -->
   <section id="term4" class="term4">
      <div class="container">
         <!--class="container"시작-->
         <div class="row" data-aos="fade-up" data-aos-delay="100">
            <!--class="row"시작-->

            <!--term 메뉴시작-->
            <div class="nav nav-pills nav-justified" id="pills-tab"
               role="tablist">
               <li class="nav-item">
                  <a href="/footer/privacy">
                     <button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button">개인정보 처리방침</button>         
                  </a>
               </li>
               <li class="nav-item">
                  <a href="/footer/contract">
                     <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button">서비스 이용약관</button>      
                  </a>
               </li>
               <li class="nav-item">
                  <a href="/footer/location">
                     <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button">위치정보 이용약관</button>         
                  </a>
               </li>
               <li class="nav-item">
                  <a href="/footer/launchingInquiry">
                     <button class="nav-link active" id="pills-contact-tab2" data-bs-toggle="pill" data-bs-target="#pills-contact2" type="button">입점문의</button>            
                  </a>
               </li>
            </div>
            <!--term 메뉴끝-->
            <!--입점문의 시작(1220~1312)-------------------------------------------------->
            <div class="content">
               <div class="tab-pane active" id="pills-contact2" role="tabpanel"
                  aria-labelledby="pills-contact-tab">
                  <div class="title-area">
                     <h3>입점문의</h3>
                  </div>
                  <div class="storequestion">
                     <form name="form1" id="form1" method="post" action="">
                        <fieldset>
                           <div class="doc">
                              <div id="doc-inner">
                                 <p>
                                    <b>개인정보 수집 및 이용에 대한 안내</b>
                                 </p>
                                 <p>
                                 	EmptyPlate는 입점,문의사항 접수시 최소한의 범위 내에서 아래와 같이 개인정보를 수집, 이용합니다.
	                                <div>
	                                	- 수집하는 개인정보 항목 : 매장명, 이름, 연락처, 이메일 <br>
	                                    - 수집 및 이용목적 : 입점, 문의사항 접수 및 처리결과 회신 <br>
	                                    - 개인정보의 이용기간 : 목적 달성 후, 해당 개인정보 파기
	                                </div>
                                 </p>
                                 <p class="bottom">개인정보 수집, 이용에 대한 동의를 거부할 권리가 있습니다. 
                                 					다만 동의를 거부하는 경우 입점문의 접수가 제한될 수 있습니다.</p>
                              </div>
                           </div>
                           <div class="storeblank" method="post">
                              <div class="form-group">
                                 <label for="shopName">매장이름</label>
                                 <input type="text" class="form-control" name="shopName" id="shopName" placeholder="매장명을 입력하세요" size="20">   
                              </div><br/>
                              <div class="form-group">
                                 <label for="userName">문의자 이름</label>
                                 <input type="text" class="form-control" name="userName" id="userName" placeholder="문의자이름을 입력하세요" size="20" maxlength="12">   
                              </div><br/>
                              <div class="form-group">
                                 <label for="userPhone">문의자 전화번호</label>
                                 <input type="text" class="form-control" name="userPhone" id="userPhone" placeholder="문의자전화번호를 입력하세요(-빼고 작성해주세요)" size="20" maxlength="11">   
                              </div><br/>
                              <div class="form-group">
                                 <label for="userEmail">문의자 이메일</label>
                                 <input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="문의자이메일을 입력하세요" size="20" maxlength="40">   
                              </div><br/>
                           </div><br/><br/>                           
                           <div class="fieldset-header">
                              <h4>약관동의</h4>
                              <div class="utils">
                                 <label class="label-checkbox">
                                    <input type="checkbox" id="checkAgree" name="checkAgree" value="Y">&nbsp;개인정보 수집 및 이용 동의
                                 </label>
                              </div>
                           </div>
                        </fieldset><br>                        
                        <div class="inquiry">
                           <button type="button" id="btnReg" class="btn">접수하기</button>      
                        </div>                    
                     </form>
                  </div>
               </div>
            </div>
         </div>
      </div>
      </div>
   </section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
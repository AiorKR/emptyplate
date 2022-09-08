<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
    
	$("#btnPay").on("click", function() {
	   
	   $("#btnPay").prop("disabled", true);
	   
	   icia.ajax.post({
		   url: "/kakao/payReady",
           data: {itemName:$("#menuName").val(), quantity:$("#menuPrice").val(), totalAmount:$("#totalAmount").val()},
           success: function (response) 
           {
              icia.common.log(response);
              
              if(response.code == 0)
              {
                 var orderId = response.data.orderId;
                 var tId = response.data.tId;
                 var pcUrl = response.data.pcUrl;
                 
                 $("#orderId").val(orderId);
                 $("#tId").val(tId);
                 $("#pcUrl").val(pcUrl);
                 
                 var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
                   
                 $("#kakaoForm").submit();
                 
                 $("#btnPay").prop("disabled", false);
              }
              else
              {
                 alert("오류가 발생하였습니다.");
                 $("#btnPay").prop("disabled", false);
              }
           },
           error: function (error) 
           {
              icia.common.error(error);
              
              $("#btnPay").prop("disabled", false);
           }
	   });
	});
});   
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
    </br>
        <div class="d-flex justify-content-between align-items-center">
          <div id="mypage" class="user-edit">
            <div class = "profile-card">
            <div class="mypage-title">결제</div>
                <div class = "profile-img-div">
                    <img src="/image/${shop.shopFile.shopFileName}" class = 'img-fluid img-thumbnail' style="height: 300px; width: 300px; margin-top: 10px; margin-bottom: 10px;">
                    <div>
                    <form action="user/userImgFile" method="post" enctyoe="multipart/form-data">
                     <input type="file" name="file" id="file">
                      
                    </form>  
                    </div>
                </div>
                <div class = "pay-card-name"><span>${shop.shopName} "매장 이름"</span></div>
                <div class = "pay-card-intro">
                  <form style="margin-top: 20px;">메뉴 : <span><c:out value="${order.orderMenu.orderMenuName}" /></span></form>
                  <hr>
                  <form style="margin-top: 20px;">예약일 : <span><c:out value="${shop.shopReservationTable.shopReservationDate}" /></span>&nbsp;</form>
                  <hr>
                  <form style="margin-top: 20px;">수량 : <span><c:out value="${order.orderMenu.orderMenuQuantity}" /></span>&nbsp;</form>
                  <hr>
                  <form style="margin-top: 20px;">가격 : <span><c:out value="${order.orderMenu.orderMenuPrice}" /></span>&nbsp;</form>    
                  <hr>
                  <form style="margin-top: 10px; float: right;"><button class="btn btn-primary">결재</button></form><br/><br/>
                </div>                
            </div>
        </div>     
    </div>
    </section>

  </main><!-- End #main --> 
	<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
      <input type="hidden" name="orderId" id="orderId" value="" />
      <input type="hidden" name="tId" id="tId" value="" />
      <input type="hidden" name="pcUrl" id="pcUrl" value="" />
   </form>
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<style>
 .rlist-list-sec {
 	width: 1100px;
 	height: 550px;
 }
 
 .list-card-hr {
 	margin-bottom : 20px;
 }
</style>
<script type="text/javascript">

function reqOne(num) {
	console.log("reqOne" + num);
	const reqOne = document.getElementById("reqOne" + num)
	console.log(reqOne);
	if(reqOne.style.display === 'flex') {
		$(reqOne).attr("style", "display:none");
    } 
    else {
    	$(reqOne).attr("style", "display:flex");
    }
}
//메장 페리지
function fn_view(shopUID)
{
   document.bbsForm.shopUID.value = shopUID;
   document.bbsForm.action = "/reservation/view";
   document.bbsForm.submit();
}

//목록
function fn_list(curPage)
{
   document.bbsForm.orderUID.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/myPage/rList";
   document.bbsForm.submit();   
}

</script>

</head>
<body style="background:linear-gradient(white,antiquewhite);">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<main id="main">
<section class="rlist">
<div class="rlist-title">예약내역</div>         
<hr role="tournament1"><br> 
<div id="rlist" class="user-rlist">
	<div class = "rlist-card">
		<div class = "rlist-profile-img-div">
			<c:if test="${user.fileName eq ''}">
            	<img src="/resources/upload/user/userDefault.jpg" class = 'rlist-profile-card-img'>
            </c:if>
            <c:if test="${user.fileName ne ''}">
          		<img src="/resources/upload/user/${user.fileName}" class = 'rlist-profile-card-img'>
            </c:if>
			<span class = "rlist-profile-card-name">${user.userNick} 님의 예약내역</span>
        </div>   
            

            <div class="rlist-list-sec">      
       		
       		<c:if test="${!empty list}">
             <c:forEach var="Order" items="${list}" varStatus="status1">
       		<!-- 반복 시작 -->
        	<div class="rlist-list">
           		<a class="rlist-list-card" href="javascript:void(0)" onclick="fn_view('${Order.shopUID}')">
					<span class="cardDetailSection">${Order.RDate}</span>
    				<span class="cardDetailSection-store">${Order.shopName}</span>
   					<span class="cardDetailSection-member" >인원 : ${Order.reservationPeople}</span>       
   					<span class="cardDetailSection">총금액 ${Order.totalAmount}원</span>        
				</a>
                <span class="cardDetailSection-status"><button id="cardDetailSection-button" class="cardDetailSection-button" onclick="reqOne(${status1.index})">한줄평 남기기</button></span>
                <div class="rlist-list-detail">세부사항 : ${Order.finalMenu}
                	
                	<!-- 
                	<c:forEach var="orderMenu" items="${Order.orderMenu}" varStatus="status">
                		${orderMenu.orderMenuName}(${orderMenu.orderMenuQuantity})
                	</c:forEach>
                	 -->
                </div>
                
                <div class="reqOne" id="reqOne${status1.index}" style="display:none;">
                	<div class="reqOneText-section"> 
                    	<input class="reqOneText" type="text" placeholder="이곳에 입력해주세요-(최대 30자)" maxlength="30">
                   	</div> 
                    <div class="startRadio">
                    	<label class="startRadio__box">
                    		<input type="radio" name="star" id="">
                 			<span class="startRadio__img"><span class="blind">별 0.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                          	<span class="startRadio__img"><span class="blind">별 1개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                          	<span class="startRadio__img"><span class="blind">별 1.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                         	 <span class="startRadio__img"><span class="blind">별 2개</span></span>
                        </label>
                        <label class="startRadio__box">
                         	 <input type="radio" name="star" id="">
                         	 <span class="startRadio__img"><span class="blind">별 2.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                         	 <span class="startRadio__img"><span class="blind">별 3개</span></span>
                        </label>
                        <label class="startRadio__box">
                         	 <input type="radio" name="star" id="">
                         	 <span class="startRadio__img"><span class="blind">별 3.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                         	 <span class="startRadio__img"><span class="blind">별 4개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                          	<span class="startRadio__img"><span class="blind">별 4.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                          	<input type="radio" name="star" id="">
                          	<span class="startRadio__img"><span class="blind">별 5개</span></span>
                        </label>
                 	</div>
                    <div class="reqOne-btn-section" >
                    	<input  class="reqOne-btn" type="button" value="등 록"/>
                    </div>
              	</div>
                <hr class="list-card-hr">
         	</div>
         	<!-- 반복 끝 -->        
			 </c:forEach>
           </c:if>
			
			</div> 
		
		<div id="rlist-page">
        	
		<div class="page-wrap">
         <ul class="page-nation">
           <c:if test="${paging.prevBlockPage gt 0}">
             <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"><</a></li>
           </c:if>
           <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
             <c:choose>
               <c:when test="${i ne curpage}">
                 <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
           	   </c:when>
               <c:otherwise>
                 <li class="page-item"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
               </c:otherwise>
             </c:choose>
           </c:forEach>
           <c:if test="${paging.nextBlockPage gt 0}">
               <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">></a></li>
           </c:if>
         </ul>
       </div>   	
        	
     	</div>
     	
     	
	</div>
</div>
<form name="bbsForm" id="bbsForm" method="post">
	 <input type="hidden" name="orderUID" value="" />
	 <input type="hidden" name="curPage" value="${curPage}" />	
	 <input type="hidden" name="userUID" value="${userUID}" />
	</form>             
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
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

//목록
function fn_list(curPage)
{
   document.bbsForm.orderUID.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/myPage/rList";
   document.bbsForm.submit();   
}

function regReqOne(num)
{
   const star = document.getElementsByName("star" + num)
   var score;
   for(var i = 0; i < star.length; i++){
      if(star[i].checked){
         score = star[i].value;
      }
   }
   var text = document.getElementById("reqOneText" + num).value;
   var orderUID = document.getElementById("orderUID" + num).value;
   var shopUID = document.getElementById("shopUID" + num).value;
   
   if(score == null)
   {
      alert("별점을 등록해주세요");
      return;
   }
   if(text == "")
   {
      alert("한줄평을 입력해주세요");
      return;
   }
   if(orderUID == null)
   {
      alert("주문정보 조회 오류");
      return;
   }
   if(shopUID == null)
   {
      alert("주문정보 조회 오류");
      return;
   }
   
   else
   {
      $.ajax({
            type:"POST",
            url:"/myPage/regReqOne",
            data:{
               reviewScore : score,
               reviewContent : text,
               orderUID : orderUID,
               shopUID : shopUID
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("한줄평이 등록되었습니다");
               }
               else if(response.code == -1)
               {
                  alert("한줄평이 수정되었습니다.");
               }
               else if(response.code == 404)
               {
                  alert("등록중 오류발생");
               }
               else
               {
                  alert("로그인이 안되있음");
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
                  <input type="hidden" id="orderUID${status1.index}" value="${Order.orderUID}"> 
                  <input type="hidden" id="shopUID${status1.index}" value="${Order.shopUID}">        
            </a>
                <span class="cardDetailSection-status"><button id="cardDetailSection-button" class="cardDetailSection-button" onclick="reqOne(${status1.index})">한줄평 남기기</button></span>
                <div class="rlist-list-detail">세부사항 : ${Order.finalMenu}</div>
                
                <form name="reqOneBox${status1.index}" id="reqOneBox${status1.index}">
                <div class="reqOne" id="reqOne${status1.index}" style="display:none;">
                   <div class="reqOneText-section"> 
                       <input class="reqOneText" type="text" id="reqOneText${status1.index}" placeholder="이곳에 입력해주세요-(최대 30자)" maxlength="30">
                      </div> 
                    <div class="startRadio">
                       <label class="startRadio__box">
                          <input type="radio" name="star${status1.index}" id="" value="0.5">
                          <span class="startRadio__img"><span class="blind">별 0.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="1">
                             <span class="startRadio__img"><span class="blind">별 1개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="1.5">
                             <span class="startRadio__img"><span class="blind">별 1.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="2">
                             <span class="startRadio__img"><span class="blind">별 2개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="2.5">
                             <span class="startRadio__img"><span class="blind">별 2.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="3">
                             <span class="startRadio__img"><span class="blind">별 3개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="3.5">
                             <span class="startRadio__img"><span class="blind">별 3.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="4">
                             <span class="startRadio__img"><span class="blind">별 4개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="4.5">
                             <span class="startRadio__img"><span class="blind">별 4.5개</span></span>
                        </label>
                        <label class="startRadio__box">
                             <input type="radio" name="star${status1.index}" id="" value="5">
                             <span class="startRadio__img"><span class="blind">별 5개</span></span>
                        </label>
                    </div>
                    <div class="reqOne-btn-section" >
                       <input  class="reqOne-btn" type="button" value="등 록" onclick="regReqOne(${status1.index})"/>
                    </div>
                 </div>
                 </form>
                 
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
           
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
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
 
.cardDetailSection-buttonR {
  color:#464545a6;
  font-family: 'cafe24Dangdanghae'; 
  border-radius: 10%;
  box-shadow: 3px 3px 3px 3px rgba(128, 128, 128, 0.575);
}

.cardDetailSection-buttonR:hover {
  box-shadow: 3px 3px 3px 3px rgba(128, 128, 128, 0.575) inset;
}

.cardDetailSection-buttonC {
  color:rgba(153, 051, 051, 0.575);
  font-family: 'cafe24Dangdanghae';
  border-radius: 10%;
  box-shadow: 3px 3px 3px 3px rgba(153, 051, 051, 0.575);
}

#cancleDetail.modal{ 
  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}

#cancleDetail.modal_content{
  color:black;
  width:400px; height:300px;
  background:#fff; border-radius:10px;
  position:relative; top:50%; left:50%;
  margin-top:-100px; margin-left:-200px;
  text-align:center;
  box-sizing:border-box; padding:35px 0;
  line-height:23px; cursor:pointer;
  border-radius: 5%;
  border:solid #cda45e 8px;
  font-size: 20px;
}

.cancleDetail-button-sec{
	margin-top: 50px;
}

.nos{
	color: rgba(153, 051, 051);
	font-size: 18px;
	margin-top: 20px;
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
      alert("매장정보 조회 오류");
      return;
   } 
   else
   {
	   //const reqOne = document.getElementById("reqOne" + num)
		//(reqOne).attr("style", "display:none");
	   
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
                  location.reload();
               }
               else if(response.code == -1)
               {
                  alert("한줄평이 수정되었습니다.");
                  location.reload();
               }
               else if(response.code == 404)
               {
                  alert("등록중 오류발생");
               }
               else
               {
            	  alert("등록중 오류발생");
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

function delReqOne(num)
{
   var orderUID = document.getElementById("orderUID" + num).value;
   var shopUID = document.getElementById("shopUID" + num).value;
   
   if(orderUID == null)
   {
      alert("주문정보 조회 오류");
      return;
   }
   if(shopUID == null)
   {
      alert("매장정보 조회 오류");
      return;
   } 
   else
   {   
      $.ajax({
            type:"POST",
            url:"/myPage/delReqOne",
            data:{
               orderUID : orderUID
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("한줄평이 삭제되었습니다");
                  location.reload();
               }
               else if(response.code == 400)
               {
                  alert("사용자 조회 오류");
               }
               else
               {
            	  alert("삭제중 오류발생");
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

function fn_view(shopUID) {
	   document.bbsForm.shopUID.value = shopUID;
	   document.bbsForm.action = "/reservation/view";
	   document.bbsForm.submit();
	}
		
function cancleDetail(num) {
	const cancleDetail = document.getElementById("cancleDetail")
	console.log(cancleDetail);
	$(cancleDetail).attr("style", "display:flex");
	orderNum.value = num;
	console.log(orderNum);
}  

function closeCnacle() {
	const cancleDetail = document.getElementById("cancleDetail")
	$(cancleDetail).attr("style", "display:none");
}

function delRes() {
	var num = document.getElementById("orderNum").value;
	var orderUID = document.getElementById("orderUID" + num).value;
	$.ajax({
        type:"POST",
        url:"/myPage/delRes",
        data:{
           orderUID : orderUID
        },
        datatype:"JSON",
        beforeSend:function(xhr){
           xhr.setRequestHeader("AJAX", "true");
        },
        success:function(response){
            if(response.code == 0)
            {
               alert("예약이 취소 되었습니다");
               location.reload();
            }
            else if(response.code == -1)
            {
               alert("환불 중 오류가 발생하였습니다");
            }
            else if(response.code == 200)
            {
               alert("환불 파라미터 오류");
            }
            else if(response.code == -3)
            {
               alert("예약 취소 중 오류가 발생하였습니다");
            }
            else if(response.code == -2)
            {
               alert("예약 취소 중 오류가 발생하였습니다");
            }
            else if(response.code == 100)
            {
               alert("이미 만료된 주문입니다");
               location.reload();
            }
            else if(response.code == 404)
            {
               alert("주문 정보를 찾을 수 없습니다");
               location.reload();
            }
            else if(response.code == 400)
            {
               alert("사용자 정보를 찾을 수 없습니다");
               location.href='/index';
            }
            else
            {
               alert("예약 취소 중 오류가 발생하였습니다");
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
                <span class="cardDetailSection-status">
                
                	<c:if test="${Order.orderStatus eq 'R'}">
	                	<button id="cardDetailSection-button" class="cardDetailSection-buttonR" onclick="cancleDetail(${status1.index})">
	                		예약 취소
	                	</button>
                	</c:if>
                	
                	<c:if test="${Order.orderStatus eq 'C'}">
	                	<button id="cardDetailSection-button" class="cardDetailSection-buttonC">
	                		취소된 예약
	                	</button>
                	</c:if>
                	
                	<c:if test="${Order.orderStatus eq 'E'}">
	                	<button id="cardDetailSection-button" class="cardDetailSection-button" onclick="reqOne(${status1.index})">
	                		<c:if test="${Order.shopReviewContent eq ''}">
	                		한줄평 남기기
	                		</c:if>
	                		<c:if test="${Order.shopReviewContent ne ''}">
	                		한줄평 수정하기
	                		</c:if>
	                	</button>
                	</c:if>
                </span>
	                
                <div class="rlist-list-detail">세부사항 : ${Order.finalMenu}</div>
                
                <c:if test="${Order.shopReviewContent eq ''}">
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
                    <div class="reqOne-btn-section">
                      <input class="reqOne-btn" type="button" value="등 록" onclick="regReqOne(${status1.index})"/>
                    </div>
                 </div>
                 </form>
                 </c:if>
                 
                 
                 <c:if test="${Order.shopReviewContent ne ''}">
                <form name="reqOneBox${status1.index}" id="reqOneBox${status1.index}">
                <div class="reqOne" id="reqOne${status1.index}" style="display:none;">
                   <div class="reqOneText-section"> 
                       <input class="reqOneText" type="text" id="reqOneText${status1.index}" placeholder="${Order.shopReviewContent}" maxlength="30">
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
                    <div class="reqOne-btn-section">
                      <input  class="reqOne-btn" type="button" value="수 정" onclick="regReqOne(${status1.index})"/>
                      <input  class="reqOne-btn" type="button" value="삭 제" onclick="delReqOne(${status1.index})"/>
                    </div>
                 </div>
                 </form>
                 </c:if>
                 
                 
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
        		<form name="bbsForm" id="bbsForm" method="post">
				<input type="hidden" name="shopUID" value="" /> 
				</form>
        
   </div>
</div>
	<div id="cancleDetail" class="modal">
	  <div id="cancleDetail" class="modal_content" 
	       title="클릭하면 창이 닫힙니다.">
	   <input type="hidden" id="orderNum" value="">    
		 <div>
			 <환불정책><br>
			  방문 예정일 2일 이전 : 100%<br>
			  방문 예정일 1일 이전 : 50%<br>
			  방문 예정일 당일 : 10%
			 <p class="nos">노쇼 시 환불이 불가하므로 유의하시기 바랍니다.</p>			 
		</div>
		<div class="cancleDetail-button-sec">
			<input type="button" value="예약 취소" class="cancleDetail-button-cancle" onclick="delRes()">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="닫 기" class="cancleDetail-button-close" onclick="closeCnacle()">
		</div>
	  </div>
	</div>           
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
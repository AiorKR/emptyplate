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
<!-- Swiper -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {

    var mySwiper = new Swiper('.swiper-container', {
        slidesPerView: 4,
        slidesPerGroup: 1,
        observer: true,
        observeParents: true,
        spaceBetween: 10,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        breakpoints: {
            1280: {
                slidesPerView: 4,
                slidesPerGroup: 4,
            },
            720: {
                slidesPerView: 4,
                slidesPerGroup: 1,
            }
        },
        loopFillGroupWithBlank : true,
        loop: false
    });
    
});

//마크 유져 페이지

//즐겨찾기 해당 작성자 게시글
function fn_userList(userUID, userNick)
{
   document.bbsForm.userUID.value = userUID;
   document.bbsForm.action = "/board/userList";
   document.bbsForm.submit();
}

//즐겨찾기 매장 페이지 
function fn_shopList(shopUID)
{
   document.bbsForm.shopUID.value = shopUID;
   document.bbsForm.action = "/reservation/view";
   document.bbsForm.submit();
}

function fn_userMarkDelete(markUserUID)
{
	var user = markUserUID;
	$.ajax({
		type:"POST",
		url:"/myPage/userMarkDelete",
		data:{
			markUserUID:user
			},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("즐겨찾기를 취소하셨습니다.");
				location.reload();
			}
			else if(response.code == -1)
			{
				alert("즐겨찾기 내역이 없습니다.");
				location.reload();
			}
			else
			{
				alert("로그인이 되어있지 않습니다.");
				location.reload();
			}				
		},
		error:function(xhr, status, error){
	          icia.common.error(error);
	    }
	});
}

function fn_shopMarkDelete(shopUID)
{
	var shop = shopUID;
	$.ajax({
		type:"POST",
		url:"/myPage/shopMarkDelete",
		data:{
			shopUID:shop
			},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("즐겨찾기를 취소하셨습니다.");
				location.reload();
			}
			else if(response.code == -1)
			{
				alert("즐겨찾기 내역이 없습니다.");
				location.reload();
			}
			else
			{
				alert("로그인이 되어있지 않습니다.");
				location.reload();
			}				
		},
		error:function(xhr, status, error){
	          icia.common.error(error);
	    }
	});
}

</script>
<style>
.myFavo-title-sec{
	margin-top: 60px;
	margin-bottom: 30px;
}

.myFavo-list {
  width: 1300px;
  height: auto;
  color:#cda45e;
  font-family: 'cafe24Dangdanghae';
  margin: auto;
}

.myFavo-title {
  font-family: 'cafe24Dangdanghae';
  font-size: 48px;
  color: #cda45e;
  text-align: center;
  padding-top: 20px;
}

.myFavo-card {
  position:relative;
  margin-top: 20px;
  margin: auto;
  width:1100px;
  height:700px;
  border-radius :3%;
  overflow : hidden;
  background-color: white;
  box-shadow: 5px 5px 5px 5px rgba(128, 128, 128, 0.575);
}

.myFavo-profile-img-div { 
  margin-bottom:15px;
  text-align: left;
  background-color: #cda45e;
  }

.myFavo-profile-card-img {
  margin-top: 10px;
  margin-bottom: 10px;
  margin-left: 20px;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  }
  
 .myFavo-profile-card-name {
  text-align: center;
  font-size : 20px;
  color : black;
  margin-top : 10px;
  margin-left : 10px;
  margin-right : 20px;
  border-bottom : 0.5px solid gray;
  padding-bottom: 10px;
  } 

.userFavorites{
	text-align:center;
}

.storeFavorites{
	text-align:center;
	margin-top:30px;
}

.favorites-profile-card-img{
	width:130px;
	height:130px;
	border-radius:50%;
	border: 5px solid;	
}

.favorites-hr{
	color:black; 
	width:900px; 
	margin:auto;
}

.swiper-slide{
	width:150px;
	height:200px;
	border-radius:50%;
	overflow:hidden;
}

.favorites-star{
	width:30px;
	height:30px;
}

.target-name{
	font-size:20px;
	margin-left:45px;	
	width:150px;
	height:30px;
}

.nothing{
	color:black;
	margin:auto;
	padding-top:10px;
	font-size:20px;
}
.swiper-container {width:1000px; margin-top: 30px;}
.swiper-slide {opacity:0.4; transition:opacity 0.3s;}
.swiper-slide-active,
.swiper-slide-active + .swiper-slide,
.swiper-slide-active + .swiper-slide + .swiper-slide,
.swiper-slide-active + .swiper-slide + .swiper-slide + .swiper-slide {opacity:1}

</style>
</head>
<body style="background:linear-gradient(white,antiquewhite);">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<main id="main">
<section class="myFavo">
<div class="myFavo-title-sec">
<div class="myFavo-title">즐겨찾기</div>         
<hr role="tournament1">
</div>
<div class="myFavo-list">
	<div class = "myFavo-card">
		<div class = "myFavo-profile-img-div">
			<c:if test="${user.fileName eq ''}">
            	<img src="/resources/upload/user/userDefault.jpg" class = 'myFavo-profile-card-img'>
            </c:if>
            <c:if test="${user.fileName ne ''}">
          		<img src="/resources/upload/user/${user.fileName}" class = 'myFavo-profile-card-img'>
            </c:if>
			<span class = "myFavo-profile-card-name">${user.userNick} 님의 즐겨찾기</span>
        </div>
        	<div class="userFavorites">
				<h3>유저 즐겨찾기</h3><hr class="favorites-hr">				
					<div class="swiper-container">
    					<div class="swiper-wrapper">
					      <c:if test="${empty list}"><span class="nothing">즐겨찾기 내역이 없습니다.</span></c:if>  
					      <c:if test="${!empty list}">
             			  <c:forEach var="list" items="${list}" varStatus="status">  
					        <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="javascript:void(0)" onclick="fn_userList('${list.markUserUID}')">
					        			<c:if test="${list.fileName eq ''}">
							            	<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
							            </c:if>
							            <c:if test="${list.fileName ne ''}">
							          		<img src="/resources/upload/user/${list.fileName}" class = 'favorites-profile-card-img'>
							            </c:if>			        			
									</a>
									<div class = 'target-name'>
										${list.userNick}
									</div>
								</div>
									<div>
                              			<button type="button" onclick="fn_userMarkDelete('${list.markUserUID}')"><img src="/resources/images/fullstar.png" class = 'favorites-star'></button>
                           			</div>  
					        </div>	
					        <!-- 반복 끝 -->					        
					    </c:forEach>
           				</c:if>
					        
					    </div>
   							 <div class="swiper-button-next"></div>
   							 <div class="swiper-button-prev"></div>
					</div>
				</div>
			<div class="storeFavorites">
				<h3>매장 즐겨찾기</h3><hr class="favorites-hr">
					<div class="swiper-container">
    					<div class="swiper-wrapper">
					    <c:if test="${empty list2}"><span class="nothing">즐겨찾기 내역이 없습니다.</span></c:if>
					    <c:if test="${!empty list2}">
             			  <c:forEach var="list2" items="${list2}" varStatus="status">  
					        <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="javascript:void(0)" onclick="fn_shopList('${list2.shopUID}')">
							          	<img src="/resources/upload/shop/${list2.shopUID}/${list2.shopFile.shopFileName}" class = 'favorites-profile-card-img'>		        			
									</a>
									<div class = 'target-name'>
										${list2.shopName}
									</div>
								</div>
									<div>
                              			<button type="button" onclick="fn_shopMarkDelete('${list2.shopUID}')"><img src="/resources/images/fullstar.png" class = 'favorites-star'></button>
                           			</div>  
					        </div>	
					        <!-- 반복 끝 -->					        
					    </c:forEach>
           				</c:if>   
					   	     
   						</div>
						    <div class="swiper-button-next"></div>
						    <div class="swiper-button-prev"></div>
					</div>
			</div>
	</div>
	
	<form name="bbsForm" id="bbsForm" method="post">
	 <input type="hidden" name="shopUID" value="${shopUID}" />
	 <input type="hidden" name="curPage" value="${curPage}" />	
	 <input type="hidden" name="userUID" value="${userUID}" />
	</form> 
	
</div>       
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
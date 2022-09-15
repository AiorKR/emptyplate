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
</script>
<style>
.userFavorites{
	text-align:center;
}

.storeFavorites{
	text-align:center;
}

.favorites-profile-card-img{
	width:150px;
	height:150px;
	border-radius:50%;
}

.favorites-hr{
	color:black; 
	width:900px; 
	margin:auto;
}

.swiper-slide{
	width:150px;
	height:150px;
	border-radius:50%;
	overflow:hidden;
}

.swiper-container {width:1000px;}
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
<section class="rlist">
<div class="rlist-title">즐겨찾기</div>         
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
			<span class = "rlist-profile-card-name">${user.userNick} 님의 즐겨찾기</span>
        </div><br />   
        	<div class="userFavorites">
				<h3>유저 즐겨찾기</h3><hr class="favorites-hr"><br />				
					<div class="swiper-container">
    					<div class="swiper-wrapper">
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" href="/mypage/myProfile" class = 'favorites-profile-card-img'></div>	
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>	
					      	<div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>	
					      	<div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>	
					       	<div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>	
					    </div>
   							 <div class="swiper-button-next"></div>
   							 <div class="swiper-button-prev"></div>
					</div>
				</div><br /><br /><br />
			<div class="storeFavorites">
				<h3>매장 즐겨찾기</h3><hr class="favorites-hr"><br />
					<div class="swiper-container">
    					<div class="swiper-wrapper">
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
					        <div class="swiper-slide"><img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'></div>
   						</div>
						    <div class="swiper-button-next"></div>
						    <div class="swiper-button-prev"></div>
					</div>
			</div>
	</div>
</div>             
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
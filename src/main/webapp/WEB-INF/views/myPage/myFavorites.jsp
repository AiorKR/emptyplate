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
	margin:auto;
	width:150px;
	height:30px;
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
					        
					        <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					        
					        
					    </div>
   							 <div class="swiper-button-next"></div>
   							 <div class="swiper-button-prev"></div>
					</div>
				</div>
			<div class="storeFavorites">
				<h3>매장 즐겨찾기</h3><hr class="favorites-hr">
					<div class="swiper-container">
    					<div class="swiper-wrapper">
					       
					          <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					        
					           <!-- 반복시작 -->
					        <div class="swiper-slide">
					        	<div>
					        		<a href="/myPage/myProfile">
					        			<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
									</a>
									<div class = 'target-name'>
										미미미미미미미미미미미
									</div>
									<div>
										<img src="/resources/images/star.png" class = 'favorites-star'>
									</div>
								</div>
					        </div>	
					        <!-- 반복 끝 -->
					       
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
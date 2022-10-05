<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>  
<!DOCTYPE html>
<html>
	<head>
	<c:if test='${popup eq "Y"}'> 
	  <link href="/resources/images/favicon.png" rel="icon">
	  <link href="/resources/images/apple-touch-icon.png" rel="apple-touch-icon">
	  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair Display:wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i|Nanum+Brush+Script|Nanum+Gothic+Coding|Do+Hyeon&display=swap" rel="stylesheet">
	  <link href="/resources/vendor/animate.css/animate.min.css" rel="stylesheet">
	  <link href="/resources/vendor/aos/aos.css" rel="stylesheet">
	  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	  <link href="/resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	  <link href="/resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	  <link href="/resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	  <link href="/resources/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	  <script src="https://kit.fontawesome.com/842f2be68c.js" crossorigin="anonymous"></script>
	  <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	  <script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
	  <script type="text/javascript" src="/resources/js/icia.common.js"></script>
	  <link href="/resources/css/style.css" rel="stylesheet">
	</c:if>
	<c:if test='${popup ne "Y"}'>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
	</c:if>	
		<script type="text/javascript">
		var cnt = 0;
		<c:if test='${popup eq "Y"}'>
			$(document).ready(function(){
				if(cnt == 0) {
					cnt ++;
					window.opener.location.href = "/today/list";
				}
			})
		</c:if>	
		function fn_location() {
			location.href = "/reservation/list";
		}
	</script>
	<style>
		.reservation {
			position: relative;
			z-index: 0;
		}
		
		#btn {
			display: flex;
			text-align: center;
		}
		#failCard, #successCard {
			position: relative;
			z-index: 100;
		}
		body {
			font-size: 30px;
		}
	</style>
	</head>
	<body onbeforeunload="document.bbsForm.submit();">
		<c:if test='${popup ne "Y"}'>
			<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
		</c:if>
		<main id="main">
			<section class="reservation">
			 <div class="container">
 			  <div class="row">
				<c:choose>
					<c:when test="${!empty order}">
						<br/>
						<div class="d-flex justify-content-between align-items-center" id="successCard">
						<div id="mypage" class="user-edit">
									<div class="mypage-title">예약 내역</div>
									<div class="profile-img-div" style="background: rgba(225, 225, 225, 0);">
									<c:if test="${!empty shopFile}">
										<img alt="" src="../resources/upload/shop/${order.shopUID}/${shopFile}"
											class='img-fluid img-thumbnail'
											style="height: 300px; width: 300px; margin-top: 10px; margin-bottom: 10px;">
									</c:if>
									<c:if test="${empty shopFile }">
										<img alt="" src="../resources/upload/shop/${order.shopUID}/${order.shop.shopFile.get(0).shopFileName}"
											class='img-fluid img-thumbnail'
											style="height: 300px; width: 300px; margin-top: 10px; margin-bottom: 10px;">
									</c:if>						
									</div>
									<div class="pay-card-name">
										<span>${order.shopName}</span>
									</div>
									<div class="pay-card-name">
										<span>예약번호 : ${order.orderUID}</span>
									</div>
									<div class="pay-card-name">
										<span>예약인원 : ${order.reservationPeople} 명</span>
									</div>
									<div class="pay-card-intro">
										<hr>
										<form style="margin-top: 20px;">
											예약일 : <span><c:out
													value="${shop.reservationDate}, ${shop.reservationTime}" /></span>&nbsp;
										</form>
										<hr>
										<form style="margin-top: 20px;">
											<c:forEach items="${order.orderMenu}" var="orderMenu" varStatus="status">
												<span><c:out value="${orderMenu.orderMenuName}" /></span>&nbsp;
												X <span><c:out value="${orderMenu.orderMenuQuantity}" /></span> <br />
											</c:forEach>
										</form>
										<hr>
										<form style="margin-top: 20px;">
											가격 : <span><c:out
													value="${order.totalAmount}" /></span>&nbsp;
										</form>
										<hr>
									</div>
								</div>
							</div>
					</c:when>
					<c:otherwise>
					<div class="d-flex justify-content-between align-items-center" id="failCard">
						<div id="mypage" class="user-edit">
						<br/>
							<div class="mypage-title">예약 내역</div>
							<div class="pay-card-name">
							</div>
							<div class="pay-card-name">
								예약이 실패하였습니다
							</div>
								<div class="pay-card-intro">
								<button class="submit" onclick="fn_location()">확인</button>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			  </div>
			 </div>
			</section>
			<form name="bbsForm" id="bbsForm" method="post" action="/pay/payResult">
				<input type="hidden" name="orderUID" value="${order.orderUID}" /> 
			</form>
		</main>
		<!-- End #main -->
		<c:if test='${popup ne "Y"}'>
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
		</c:if>
		<c:if test='${popup eq "Y"}'>
		  <!-- Vendor JS Files -->
			<script src="/resources/vendor/aos/aos.js"></script>
			<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
			<script src="/resources/vendor/glightbox/js/glightbox.min.js"></script>
			<script src="/resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
			<script src="/resources/vendor/swiper/swiper-bundle.min.js"></script>
			<script src="/resources/vendor/php-email-form/validate.js"></script>
			
			<!-- Template Main JS File -->
			<script src="/resources/js/main.js"></script>
			
			<!-- ionic.io-->
			<!-- https://ionic.io/ionicons/usage -->
			<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
			<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
		 </c:if>
	</body>

</html>
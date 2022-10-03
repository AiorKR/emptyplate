<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
		<script type="text/javascript">
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
		<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
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
										<img alt="" src="../resources/upload/shop/${order.shopUID}/${order.shop.shopFile.shopFileName}"
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
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</body>

</html>
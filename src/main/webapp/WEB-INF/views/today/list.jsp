<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 3);

%>
<!DOCTYPE html>
<html lang="en">
<head>
<!--date and time picker-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/resources/datepicker/date_picker.css">
<!--end date and time picker-->  
     
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<!--date and time picker-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<!--end date and time picker-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.colorbox.js"></script>
<link rel="stylesheet" href="/resources/css/jquery.colorbox.css">
<script type="text/javascript">	

$(document).ready(function(){
	
	remaindTime();
	remaindTime2();
	
	//$(".popup").colorbox({iframe:true,scrolling:false, width:"95%", height:"130%"});
	
	$(".select").change(function() { 
    	document.bbsForm.curPage.value = "1";
        document.bbsForm.searchType.value = $(".select").val();
        document.bbsForm.action = "/today/list";
        document.bbsForm.submit();
	});   
	$("#searchBtn").click(function() { 
		document.bbsForm.curPage.value = "1";
		document.bbsForm.searchValue.value = $("#search").val();
		document.bbsForm.action = "/today/list";
		document.bbsForm.submit();
	});
	$("#search").on("keyup",function(key){         
		if(key.keyCode==13) {
			document.bbsForm.curPage.value = "1";
	        document.bbsForm.searchValue.value = $("#search").val();
	        document.bbsForm.action = "/today/list";
	        document.bbsForm.submit();
		}
	});
});

function openWindowPop(shopUID, orderUID) {
	var name = "todayPopup";
    var options = 'width=1000, height=850, status=no, menubar=no, toolbar=no, resizable=no';
    window.open('/today/todayPopupView?shopUID=' + shopUID + '&orderUID=' + orderUID, name, options);
}

//페이징
function fn_list(curPage) {
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/today/list";
	document.bbsForm.submit();   
}

function remaindTime() {
	var now = new Date();

	<c:forEach items="${noShow}" var="noShow" varStatus="status">
	    var yyyy = '${noShow.shopReservationTableList[0].shopReservationDate}'.substring (0, 4);   
	    var mm = '${noShow.shopReservationTableList[0].shopReservationDate}'.substring (4, 6);    
	    var dd = '${noShow.shopReservationTableList[0].shopReservationDate}'.substring (6, 8);
	    var hh = '${noShow.shopReservationTableList[0].shopReservationTime}'.substring (0, 2);    
	    var mi = '${noShow.shopReservationTableList[0].shopReservationTime}'.substring (2, 4);
	    
	    var endcheck = yyyy + '년 ' + (mm-1) + '월 ' + dd + '일 ' + (hh-1) + '시' + mi + '분';
	    
	    var end = new Date(yyyy, mm-1, dd, hh-1, mi);
	
	    var nt = now.getTime();
	    var et = end.getTime();
	  
	   if(nt<et){
	     $(".time").fadeIn();
	     $(".time-end${status.index}").html(endcheck);
	     sec = parseInt(et - nt) / 1000; 
	     day  = parseInt(sec/60/60/24);
	     sec = (sec - (day * 60 * 60 * 24));
	     hour = parseInt(sec/60/60);
	     sec = (sec - (hour*60*60));
	     min = parseInt(sec/60);
	     sec = parseInt(sec-(min*60));
	     if(hour<10){hour="0"+hour;}
	     if(min<10){min="0"+min;}
	     if(sec<10){sec="0"+sec;}
	      $(".hours${status.index}").html(hour);
	      $(".minutes${status.index}").html(min);
	      $(".seconds${status.index}").html(sec);
	      
	      setInterval(remaindTime,1000);
	    }
    </c:forEach>
}

function remaindTime2() {
	var now = new Date();

	<c:forEach items="${noShowImminent}" var="noShowImminent" varStatus="status">
	    var yyyy = '${noShowImminent.shopReservationTableList[0].shopReservationDate}'.substring (0, 4);   
	    var mm = '${noShowImminent.shopReservationTableList[0].shopReservationDate}'.substring (4, 6);    
	    var dd = '${noShowImminent.shopReservationTableList[0].shopReservationDate}'.substring (6, 8);
	    var hh = '${noShowImminent.shopReservationTableList[0].shopReservationTime}'.substring (0, 2);    
	    var mi = '${noShowImminent.shopReservationTableList[0].shopReservationTime}'.substring (2, 4);
	    
	    var endcheck = yyyy + '년 ' + (mm-1) + '월 ' + dd + '일 ' + (hh-1) + '시' + mi + '분';
	    
	    var end = new Date(yyyy, mm-1, dd, hh-1, mi);
	
	    var nt = now.getTime();
	    var et = end.getTime();
	  
	   if(nt<et){
	     $(".time").fadeIn();
	     $(".noShowImminent-time-end${status.index}").html(endcheck);
	     sec = parseInt(et - nt) / 1000; 
	     day  = parseInt(sec/60/60/24);
	     sec = (sec - (day * 60 * 60 * 24));
	     hour = parseInt(sec/60/60);
	     sec = (sec - (hour*60*60));
	     min = parseInt(sec/60);
	     sec = parseInt(sec-(min*60));
	     if(hour<10){hour="0"+hour;}
	     if(min<10){min="0"+min;}
	     if(sec<10){sec="0"+sec;}
	      $(".noShowImminent-hours${status.index}").html(hour);
	      $(".noShowImminent-minutes${status.index}").html(min);
	      $(".noShowImminent-seconds${status.index}").html(sec);
	      
	      setInterval(remaindTime2,1000);
	    }
    </c:forEach>
}

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
	<!-- ======= reservations Section ======= -->
	<section id="today" class="today">
		<div class="today-container container">
		  <div class="row">
			<div class="today-slider swiper">
				<container style="color: #2536;">
				<hr class="hr-5">
				<h2 style="margin-left: 30px">
					<strong> No-Show 마감임박 </strong>
				</h2>
				<hr class="hr-5">
				</container>
				<div class="swiper-wrapper">
					<c:if test="${!empty noShowImminent}">
						<c:forEach items="${noShowImminent}" var="noShowImminent" varStatus="status">
							<div class="swiper-slide" style="height: auto; width: 100%; background-color: rgba(240, 240, 240, 0.7);">
								<div class="reservation-item" style="height: 350px;" id="viewPopup" style="cursor:pointer;" onclick="openWindowPop('${noShowImminent.shopUID}', '${noShowImminent.orderUID}');">
									<img alt="" src="../resources/upload/shop/${noShowImminent.shop.shopFile.shopFileName}" style="height: 300px; width: 300px; position: relative; left: 150px; top: 25px;">
									<span style="position: relative; bottom: 250px; left: 600px;">
										<h3>${noShowImminent.shop.shopName}</h3>
										<ul>
											<li><i class="fa-regular fa-star"></i>별점  <fmt:formatNumber value="${noShowImminent.shop.reviewScore}" pattern=".00"/> (${noShowImminent.shop.reviewCount})</li>	
											<li>
												<i class="fa-solid fa-percent"></i> <c:if test='${noShowImminent.orderStatus eq "X"}'>70 할인</c:if> <c:if test='${noShowImminent.orderStatus eq "C"}'>50 할인</c:if>
								                            할인 전 : <span id="totalAmount">${noShowImminent.totalAmount}
                								할인 후 : <c:if test='${noShowImminent.orderStatus eq "X"}'><c:set value="${noShowImminent.totalAmount * 0.3}" var="totalAmount" />${totalAmount}</c:if> &nbsp;
                                                <c:if test='${noShowImminent.orderStatus eq "C"}'><c:set value="${noShowImminent.totalAmount * 0.5}" var="totalAmount" />${totalAmount}</c:if> </span>
											</li>
											<li><i class="fa-solid fa-map-location-dot" style="color: #cda45e;"></i>
												<c:if test="${noShowImminent.shop.shopLocation1 ne null}">${noShowImminent.shop.shopLocation1}</c:if> ${noShowImminent.shop.shopLocation2} ${noShowImminent.shop.shopAddress}
											</li>
											<li><i class="fa-solid fa-people" style="color: #cda45e;">예약 인원 : ${noShowImminent.reservationPeople}</i></li>
											<li>
												<i class="fa-solid fa-pen" style="color: #cda45e;">
													<c:out value="${noShowImminent.shop.shopIntro}" />
												</i>
											</li>
											<li class="font15 noShowImminent-time-end${status.index}">예약시간</li>
										<li class="font15 time-title${status.index}">Today 마감까지</li>
										<li>
										<span class="noShowImminent-hours${status.index}"></span> <span class="col">:</span>
										<span class="noShowImminent-minutes${status.index}"></span> <span class="col">:</span>
										<span class="noShowImminent-seconds${status.index}"></span>
										</li>
										</ul>
										
									</span>
								</div>
							</a>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty noShowImminent}">
						<div class="swiper-slide" style="height: auto; width: 100%; background-color: rgba(240, 240, 240, 0.7);">
								<div class="reservation-item" style="height: 350px; style="cursor:pointer;">
									<img alt=""
										style="height: 300px; width: 300px; position: relative; left: 150px; top: 25px;">
									<span style="position: relative; bottom: 250px; left: 600px;">

										<h1><c:out value="No-Show 마감 임박 건이 없습니다." /></h1>
										<ul>	
											<li><i class="fa-solid fa-map-location-dot" style="color: #cda45e;"></i>
												
											</li>
											<li> <i class="fa-solid fa-people" style="color: #cda45e;"></i></li>
											<li>
												<i class="fa-solid fa-pen" style="color: #cda45e;">
												
												</i>
											</li>
											<li class="font15 time-end"></li>
										<li class="font15 time-title"></li>
										<li>
										<span class="hours"></span> <span class="col">:</span>
										<span class="minutes"></span> <span class="col">:</span>
										<span class="seconds"></span>
										</li>
										</ul>
										
									</span>
								</div>
							</div>
					</c:if>
				</div>
				<div class="swiper-pagination" style="margin-top: -20px"></div>

				<!--메뉴-->
				<div class="container" id="noshowlist">
					<div class="col-12">
						<table class="table table-image">
							<container>
							<hr class="hr-5">
							</container>
							<h3>NO SHOW</h3>
							<container>
							<hr class="hr-5">
							</container>
							<nav class="navbar navbar-expand-lg navbar-light bg-translucent">
								<div class="container-fluid">
									<button class="navbar-toggler" type="button"
										data-bs-toggle="collapse"
										data-bs-target="#navbarSupportedContent"
										aria-controls="navbarSupportedContent" aria-expanded="false"
										aria-label="Toggle navigation">
										<span class="navbar-toggler-icon"></span>
									</button>
									<form>
										<!--datepicker-->
										&nbsp;&nbsp;&nbsp;
										<div class="collapse navbar-collapse" id="navbarSupportedContent">
											<ul class="navbar-nav me-auto ">
												<select class="select" aria-label="Default select example" style="width: 150px; height: 38px; cursor: pointer;">
													<option value="0" selected
														style="width: 150px; height: 35px; cursor: pointer;"
														selected <c:if test="${searchType eq '0'}">selected</c:if>>전체</option>
													<option value="1"
														style="width: 150px; height: 35px; cursor: pointer;"
														<c:if test="${searchType eq '1'}">selected</c:if>>파인다이닝</option>
													<option value="2"
														style="width: 150px; height: 35px; cursor: pointer;"
														<c:if test="${searchType eq '2'}">selected</c:if>>오마카세</option>
												</select>
											</ul>
									</form>
									<div style="border: 1px solid #C2A384">
										<input type="text" name="text" id="search"
											<c:if test="${searchValue ne null and searchValue ne ''}">value="${searchValue}"</c:if>>
										<button class="btn" type="submit" id="searchBtn">검 색</button>
									</div>
								</div>
							</nav>
								<tbody class="menutable">
								<c:if test="${!empty noShow}">
									<c:forEach var="i" begin="0" end="6" step="3">
										<tr>
											<c:forEach var="j" begin="0" end="2">
											 <c:if  test="${!empty noShow[i+j]}">
											<th scope="row"> 
												<td>
													<div class="card"
														 onclick="openWindowPop('${noShow[i + j].shopUID}',' ${noShow[i + j].orderUID}');">
														<img src='../resources/upload/shop/${noShow[i + j].shop.shopFile.shopFileName}' class="img-fluid img-thumbnail" style="height: 300px; width: 400px;">
															<div class="card-body-right">
															<p class="card-title">${noShow[i + j].shop.shopName}</p>
															<p> ${noShow[i + j].shop.shopLocation1} ${noShow[i + j].shop.shopLocation2} ${noShow[i + j].shop.shopAddress}</p>
															<i class="fa-regular fa-star"></i>별점  <fmt:formatNumber value="${noShow[i + j].shop.reviewScore}" pattern=".00"/> (${noShow[i + j].shop.reviewCount}) <br />
															<i class="fa-solid fa-person"></i> 예약 가능 인원 : ${noShow[i + j].reservationPeople} 명<br />
															<i class="fa-solid fa-percent"></i> <c:if test='${noShow[i + j].orderStatus eq "X"}'>70 할인</c:if> <c:if test='${noShow[i + j].orderStatus eq "C"}'>50 할인</c:if> <br />
															 	할인 전 : <span id="totalAmount"><strike><fmt:formatNumber value="${noShow[i + j].totalAmount}" pattern=""/> 원 </strike>&nbsp;
                    											<span style="color: red;">할인 후 : <c:if test='${noShow[i + j].orderStatus eq "X"}'><c:set value="${noShow[i + j].totalAmount * 0.3}" var="totalAmount" /><span style="color: red;"><fmt:formatNumber value="${totalAmount}" pattern=""/> 원</span></c:if> </span>
                                                            	<c:if test='${noShow[i + j].orderStatus eq "C"}'><c:set value="${noShow[i + j].totalAmount * 0.5}" var="totalAmount" /><span style="color: red;"><fmt:formatNumber value="${totalAmount}" pattern=""/> 원</span></c:if> </span>
															<div class="sec7-text-box">
															<i class="fa-solid fa-pen" style="color: #cda45e; font-size: 15px;">
																<c:out value="${noShow[i + j].shop.shopIntro}"/>
															</i>
															<br />
															<span class="hours${i+j}"></span> <span class="col">:</span>
															<span class="minutes${i+j}"></span> <span class="col">:</span>
															<span class="seconds${i+j}"></span>
															</div>
														</div>
													</div>
												</a>
												</td>
											 </c:if>

											</c:forEach>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty noShow}">
									<th scope="row"> 
									 	noShow건이 없습니다.
									</th>
								</c:if>
							</tbody>
						</table>
						<div class="page-wrap">
							<ul class="page-nation">
								<c:if test="${paging.prevBlockPage gt 0}">
									<li class="page-item"><a class="page-link"
										href="javascript:void(0)"
										onclick="fn_list(${paging.prevBlockPage})"> < </a></li>
								</c:if>
								<c:forEach var="i" begin="${paging.startPage}"
									end="${paging.endPage}">
									<c:choose>
										<c:when test="${i ne curpage}">
											<li class="page-item"><a class="page-link"
												href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link"
												href="javascript:void(0)" style="cursor: default;">${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.nextBlockPage gt 0}">
									<li class="page-item"><a class="page-link"
										href="javascript:void(0)"
										onclick="fn_list(${paging.nextBlockPage})"> > </a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<form name="bbsForm" id="bbsForm" method="post">
				<input type="hidden" name="shopUID" id="shopUID" value="" /> <input
					type="hidden" name="searchType" value="${searchType}" /> <input
					type="hidden" name="searchValue" value="${searchValue}" /> <input
					type="hidden" name="curPage" value="${curPage}" /> <input
					type="hidden" name="reservationDate" value="${reservationDate}" />
				<input type="hidden" name="reservationTime" value="${reservationTime}" />
			</form>
		</div>
	</section>
	<!-- End today Section -->

	<!--footer-->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>
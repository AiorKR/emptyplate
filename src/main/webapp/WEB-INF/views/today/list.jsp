<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<script type="text/javascript">
$(document).ready(function(){
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
//shopUID 전송
function fn_view(shopUID) {
	document.bbsForm.shopUID.value = shopUID;
	document.bbsForm.action = "/reservation/view";
	document.bbsForm.submit();
}
//페이징
function fn_list(curPage) {
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/today/list";
	document.bbsForm.submit();   
}
//해시태그 클릭시 검색
function fn_search(shopHashtag) {
	document.bbsForm.searchValue.value = shopHashtag	;
	document.bbsForm.action = "/today/list";
	document.bbsForm.submit();
}
</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>

<!-- ======= Today Section ======= -->
<section id="today" class="today">
	<div class="today-container container">
	  <div class="row">
		<div class="today-slider swiper">
			<container>
			<hr class="hr-5">
			</container>
			<h2 style="color: #000; margin-left: 30px;">
				<strong>Today 마감</strong>
			</h2>
			<container>
			<hr class="hr-5">
			</container>

			<!--메뉴-->
			<div class="row2">
				<div class="col-12">
					<table class="table table-image">
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
									&nbsp;&nbsp;&nbsp;
									<div class="collapse navbar-collapse"
										id="navbarSupportedContent">
										<ul class="navbar-nav me-auto ">
											<select class="select" aria-label="Default select example"
												style="width: 150px; height: 35px;">
												<option value="0" selected
													style="width: 150px; height: 35px;"
													<c:if test="${searchType eq '0'}">selected</c:if>>전체</option>
												<option value="1" style="width: 150px; height: 35px;"
													<c:if test="${searchType eq '1'}">selected</c:if>>오마카세</option>
												<option value="2" style="width: 150px; height: 35px;"
													<c:if test="${searchType eq '2'}">selected</c:if>>파인다이닝</option>
											</select>
										</ul>
								</form>
								<div style="border: 1px solid #C2A384; margin-bottom: 14px;">
									<input type="text" name="text" id="search"
										<c:if test="${searchValue ne null and searchValue ne ''}">value="${searchValue}"</c:if>>
									<button class="btn" type="submit" id="searchBtn">검 색</button>
								</div>
							</div>
						</nav>
						<tbody class="menutable">
							<c:if test="${!empty list}">
								<c:forEach var="i" begin="0" end="6" step="3">
									<tr>
										<c:forEach var="j" begin="0" end="2">
										<c:if test="${!empty list[i+j]}">
										<th scope="row"> 
											<td>
												<div class="card" onClick="fn_view('${list[i + j].shopUID}')"
													style="cursor: pointer; text-align:center;">
													<img
														src='../resources/upload/shop/${list[i + j].shopFile.shopFileName}'
														class="img-fluid img-thumbnail"
														style="height: 300px; width: 300px; display: block; margin: 0px auto;">
														<div class="card-body-right">
														<h5 class="card-title">${list[i + j].shopName}</h5>
														<div class="sec7-text-box">
															<p class="font15 time-end1">예약시간</p>
															<p class="font15 time-title1">Today 마감까지</p>
															<div class="time font20">
																<span class="hours"></span> <span class="col">:</span>
																<span class="minutes"></span> <span class="col">:</span>
																<span class="seconds"></span>
															</div>
														</div>
													</div>
												</div>
											</td>
										 </c:if>
										</c:forEach>
									</tr>
								</c:forEach>
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
			<input type="hidden" name="shopUID" value="" /> <input
				type="hidden" name="searchType" value="${searchType}" /> <input
				type="hidden" name="searchValue" value="${searchValue}" /> <input
				type="hidden" name="curPage" value="${curPage}" /> <input
				type="hidden" name="reservationDate" value="${reservationDate}" />
			<input type="hidden" name="reservationTime"
				value="${reservationTime}" />
		</form>
		</div>
	</div>
</section>
<!-- End today Section -->

<!--count down-->
<script src="./assets/countdown/countdown.js"></script>
<!--count down-->

<!--footer-->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>
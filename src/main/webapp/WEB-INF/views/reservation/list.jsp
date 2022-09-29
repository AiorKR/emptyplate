<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
pageContext.setAttribute("newLine", "\n");
// Community 번호
request.setAttribute("No", 2);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<!--date and time picker-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/resources/datepicker/date_picker.css">
<!--end date and time picker-->

<%@ include file="/WEB-INF/views/include/head.jsp"%>

<!--date and time picker-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<!--end date and time picker-->

<script type="text/javascript">
$(document).ready(function() {
	if('${reservationDate}' != "") { // 값이 있다면 datepicker에 보여줌
		$(".datepicker").val('${reservationDate}');
	}
	
	
   $(".select").change(function() { 
      document.bbsForm.curPage.value = "1";
       document.bbsForm.searchType.value = $(".select").val();
       document.bbsForm.action = "/reservation/list";
       document.bbsForm.submit();
   });   
   $("#searchBtn").click(function() { 
       document.bbsForm.curPage.value = "1";
       document.bbsForm.searchValue.value = $("#search").val();
       document.bbsForm.action = "/reservation/list";
       document.bbsForm.submit();
   });
   $("#search").on("keyup",function(key) {         
       if(key.keyCode==13) {
            document.bbsForm.curPage.value = "1";
           document.bbsForm.searchValue.value = $("#search").val();
           document.bbsForm.action = "/reservation/list";
           document.bbsForm.submit();
         }
   });      
});
//shopUID 전송
function fn_view(shopUID) {
   event.stopPropagation();
   document.bbsForm.shopUID.value = shopUID;
   document.bbsForm.action = "/reservation/view";
   document.bbsForm.submit();
}
//페이징
function fn_list(curPage) {
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/reservation/list";
	document.bbsForm.submit();   
}
//해시태그 클릭시 검색
function fn_search(shopHashtag) {
	event.stopPropagation();
	document.bbsForm.searchValue.value = shopHashtag   ;
	document.bbsForm.action = "/reservation/list";
	document.bbsForm.submit();
}
//해시태그 클릭시 검색
function fn_search(shopHashtag) {
   event.stopPropagation();
   document.bbsForm.searchValue.value = "#" + shopHashtag   ;
   document.bbsForm.action = "/reservation/list";
   document.bbsForm.submit();
}

$(document).ready(function(){
	$(".datepicker").change(function() {
		$("#datepicker-ul").attr('style', "display:inline;");
	});
	
    $('.datepicker').datepicker({
		format: 'yyyy.mm.dd',
		autoclose: true,
		startDate: '0d',
		endDate: '+1m'
    });
	//데이트피커에서 선택시 시간 선택지 나오게 하는 함수
    $('.dptime').click(function(){
      $('.dptime').removeClass('select');
      $(this).addClass('select');
      $("#datepicker-ul").attr('style', "display:none;");
      document.bbsForm.reservationDate.value = $('.datepicker').val().replaceAll(".", "");//날짜에서 . 제거
      document.bbsForm.reservationTime.value = $(this).text();
      document.bbsForm.reservationTime.value = $(this).text().replaceAll(":", "");//시간에서 : 제거
	  $('.datepicker').val($('.datepicker').val() + ' ' + $(this).text());
	  document.bbsForm.action = "/reservation/list";
	  document.bbsForm.submit();
    });
});

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
	<!-- ======= reservations Section ======= -->
	<section id="reservation" class="reservation">
		<div class="reservation-container container">
		  <div class="row">
			<div class="reservation-slider swiper">
				<container style="color: #2536;">
				<hr class="hr-5">
				<h2 style="margin-left: 30px">
					<strong> 오늘의 추천식당 </strong>
				</h2>
				<hr class="hr-5">
				</container>
				<div class="swiper-wrapper">
					<c:if test="${!empty list}">
						<c:forEach items="${list}" var="shop" varStatus="status">
							<div class="swiper-slide"
								style="height: auto; width: 100%; background-color: rgba(240, 240, 240, 0.7);">
								<div class="reservation-item" style="height: 350px;"
									onclick="fn_view('${shop.shopUID}')" style="cursor:pointer;">
									<img alt=""
										src="../resources/upload/shop/${shop.shopUID}/${shop.shopFile.shopFileName}"
										style="height: 300px; width: 300px; position: relative; left: 150px; top: 25px;">
									<span style="position: relative; bottom: 250px; left: 600px;">
										<h3>${shop.shopName}</h3>
										<ul>
											<li><i class="fa-solid fa-map-location-dot"></i>
												${shop.shopLocation1} ${shop.shopLocation2}
												${shop.shopLocation3} ${shop.shopAddress}</li>
											<li><i class="fa-regular fa-star"></i> 별점 4.3 (500)</li>
											<li><ion-icon name="information-circle-outline"></ion-icon> ${shop.shopIntro}</li>
											<c:forTokens items="${shop.shopHashtag}" delims="#"	var="shopHashtag">
												<span onclick="fn_search('${shopHashtag}')" class="hashtag"> 
												<i class="fa-solid fa-hashtag"><c:out value='${shopHashtag}' /></i>
												</span>
											</c:forTokens>
										</ul>
										
									</span>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="swiper-pagination" style="margin-top: -20px"></div>


				<!--메뉴-->
				<div class="container">
					<div class="col-12">
						<table class="table table-image">
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
										<div class="card">
											<div class="content">
												<input type="text" class="datepicker" placeholder="날짜를 선택해주세요" name="date" readonly>
											</div>
											<div class="box">
												<ul id="datepicker-ul">
													<li id="datepicker-li">
														<c:forEach items="${timeList}" var="timeList" varStatus="status">
															<div class="dptime">${timeList.shopOrderTime}</div>
	                               						</c:forEach> 
													</li>
												</ul>
											</div>
										</div>
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
							<tbody class="menutable" style="height: auto; width: 100%;">
								<c:if test="${!empty list}">
									<c:forEach items="${list}" var="shop" varStatus="status">
										<tr onclick="fn_view('${shop.shopUID}')"
											style="cursor: pointer;">
											<td class="w-25" colspan="4"><img
												src='../resources/upload/shop/${shop.shopUID}/${shop.shopFile.shopFileName}'
												class="img-fluid img-thumbnail"
												style="height: 200px; width: 200px;"></td>
											<td>
												<h2>
													<c:out value="${shop.shopName}" />
												</h2>
												<br /> <c:forTokens items="${shop.shopHashtag}" delims="#"
													var="shopHashtag">
													<span onclick="fn_search('${shopHashtag}')" style="cursor: pointer;"> <i class="fa-solid fa-hashtag" style="font-size: 18px; color: #FF7F50;"><c:out value='${shopHashtag}' /></i>
													</span>
												</c:forTokens><br />
											<br /> <i class="fa-solid fa-map-location-dot"
												style="font-size: 18px;"> <c:out value="${shop.shopLocation1}" /> <c:out value="${shop.shopLocation2}" /> <c:out value="${shop.shopLocation3}" />
											</i><br />
											<li><i class="fa-regular fa-star"></i> ${shop.reviewScore} (${shop.reviewCount})</li> </br />
											<br /> <i class="fa-solid fa-pen"
												style="color: #cda45e; font-size: 19px;"> <c:out value="${shop.shopIntro}" />
											</i>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								                          <!-- Modal -->
                          <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                              <div class="modal-content">
                                <div class="modal-header">
                                  <h5 class="modal-title" id="m">예약</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                  	<div id="shopName">${shop.shopName}</div>
                                  	<div id="selectcontent" style="position: relative;z-index: 1500;">
                                    	<div class="personnel-select">
                                        	<div class="personnel-selected">
                                          		<div class="personnel-selected-value">인원을 선택해주세요</div>
                                        	</div>
                                        	<ul id="select-ul">
                                          		<li class="option">1명</li>
                                          		<li class="option">2명</li>
                                          		<li class="option">3명</li>
                                          		<li class="option">4명</li>
                                          		<li class="option">5명</li>
                                          		<li class="option">6명</li>
                                          		<li class="option">7명</li>
                                          		<li class="option">8명</li>
                                         		<li class="option">9명</li>
                                       		</ul>
                                    	</div>
	                                    <input type="text" class="datepicker" placeholder="날자를 선택해주세요" name="date" readonly>
	                                    <div class="box">
	                                        <ul id="datepicker-ul">
	                                            <li id="datepicker-li">
	                                            	<c:forEach items="${shop.shopTime}" var="shopTime" varStatus="status">
														<div class="dptime" id="shopTime${status.index}">${shopTime.shopOrderTime}</div>
	                               					</c:forEach>  
	                                            </li>
	                                        </ul>
	                                    </div>
	                                    <c:if test="${shop.shopType eq 2}"> <!-- 오마카세일때 적용 -->
	                                    	카운터석 : <input type="checkbox" id="counterSeat" class="counterSeat"/>
	                                    	* 카운터석은 연속되게 앉을 수 없을 수도 있습니다. *
                                  		</c:if>
                                  	</div>	
                              		<div id="tableCheck">

									</div>
                                    <div class="menuQuantity">
                                   		<ul class="menuQuantity">
                                   			<table>
                                       			<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
													<tr id="shopMenu${status.index}">
														<td>
															${shopMenu.shopMenuName}
														</td>
														
														<td>
															 ${shopMenu.shopMenuPrice} 원
														</td>
														<td>
															<input type="button" value="+" onclick="fn_MenuAdd('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})"  class="btn btn-primary" style="height:30px;width:30px;"/>
															<input type="button" value="-" onclick="fn_MenuSub('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})"  class="btn btn-primary" style="height:30px;width:30px;" />
															<input type="button" value="삭제" onclick="fn_Menudel('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})" class="btn btn-primary" style="height:30px;width:60px;" />
														</td>
													</tr>
                        			  			</c:forEach>
                        			  		</table>
                                      	</ul>
                                	</div>
	                                	<div style="border:1px solid black;">
	                                		<p>주문 메뉴</p>
	                                		<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
	                                			<div>
	                              	  				<span id="shopOrderMenu${status.index}" class="shopOrderMenu"></span>
	                                				<span id="shopOrderMenuQuantity${status.index}" class="shopOrderMenu"></span>
	                                			</div>
	                                		</c:forEach>
	                                		<p style="border:1px solid blakc;">총 금액 : <span id="totalAmount">0</span></p>
	                                	</div>
                                    </div>
                                   <div class="modal-footer">
 							  			<button class="btn btn-primary" style="border:none;" id="pay">결제</button>
                             	  </div>
                                </div>
                              </div>
                             </div>
								
								<c:if test="${empty list}">
									<p>매장이 없습니다</p>
								</c:if>
							</tbody>
						</table>
						<div class="page-wrap">
							<ul class="page-nation">
							<c:if test ="${!empty list}">
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
										<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})"> > </a></li>
									</c:if>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			  </div>
			</div>
			<form name="bbsForm" id="bbsForm" method="post">
				<input type="hidden" name="shopUID" value="" /> 
				<input type="hidden" name="searchType" value="${searchType}" /> 
				<input type="hidden" name="searchValue" value="${searchValue}" /> 
				<input type="hidden" name="curPage" value="${curPage}" /> 
				<input type="hidden" name="reservationDate" value="${reservationDate}" /> 
				<input type="hidden" name="reservationTime" value="${reservationTime}" />
			</form>
		</div>
	</section>

	<!-- End reservation Section -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
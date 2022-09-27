<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 2);
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#btnMark").on("click", function(){
					 document.manageForm.action = "/manager/shopUpdate";
				     document.manageForm.submit();
				});
			});
		</script>
	</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<!-- ======= reservations Section ======= -->
<section id="view" class="view">
 <div class="container">
  <div class="row">
	<div style="border-right: 2px solid #C2A383; float:left;width: 50%;">
	  <div class="d-flex flex-column justify-content-center">
		<div class="main_image">
		  <img src="../resources/upload/shop/${shop.shopUID}/${shop.shopFileList.get(1).shopFileName}"
			   id="main_product_image" height="400px" width="400px">
		</div>
		<br />
		<div class="thumbnail_images">
		  <ul id="thumbnail">
			<c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status" begin="1" end="5">
			  <li><img onclick="changeImage(this)"
						src="../resources/upload/shop/${shop.shopUID}/${shopFileList.shopFileName}"
						width="100px" height="100px">&nbsp;
			  </li>
			</c:forEach>
		  </ul>
		</div>
		<div class="view-text">
		  <p class="title">공지사항</p>
		  <p class="view-content">${shop.shopContent}</p>
		</div>
	  </div>
	</div>
	<div class="p-3 right-side">
	  <div class="d-flex justify-content-between align-items-center">
		<h3>${shop.shopName}</h3>
		<div class="bookmark">
			  <button type="button" id="btnMark"><ion-icon name="construct-outline"></ion-icon>&nbsp;&nbsp;수정</button>
		</div>
	  </div>
	  <div class="intro mt-2 pr-3 content">
		<p>${shop.shopIntro}</p>
	  </div>
	  <ul class="intro2">
		<li><i class="fa-solid fa-map-location-dot"></i>&nbsp;&nbsp;${address}</li>
		<li><i class="fa-regular fa-star"></i>&nbsp;&nbsp;별점 4.5 (100)</li>
		<li><i class="fa fa-phone" aria-hidden="true"></i>&nbsp;&nbsp;${shop.shopTelephone}</li>
	  </ul>
	  <c:forTokens items="${shop.shopHashtag}" delims="#" var="shopHashtag">
		<span onclick="fn_search('${shopHashtag}')" class="hashtag"> 
		 <i class="fa-solid fa-hashtag">
		  <c:out value='${shopHashtag}' />
		 </i>
		</span>
	  </c:forTokens>
	  <div id="map" style="width: 100%; height: 320px; margin-top: 15px;"></div>
		<script type="text/javascript"
			    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c114849a120d4c8456de73d6e0e3b3a0&libraries=services"></script>
		<script>
             var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                 mapOption = {center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                     		   level: 2 // 지도의 확대 레벨
                 };  
             // 지도를 생성합니다    
             var map = new kakao.maps.Map(mapContainer, mapOption); 
             // 주소-좌표 변환 객체를 생성합니다
             var geocoder = new kakao.maps.services.Geocoder();
             // 주소로 좌표를 검색합니다
             geocoder.addressSearch('${address}', function(result, status) {
                 // 정상적으로 검색이 완료됐으면 
                  if (status === kakao.maps.services.Status.OK) {
                     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                     // 결과값으로 받은 위치를 마커로 표시합니다
                     var marker = new kakao.maps.Marker({
                         map: map,
                         position: coords
                     });
                     // 인포윈도우로 장소에 대한 설명을 표시합니다
                     var infowindow = new kakao.maps.InfoWindow({
                         content: '<div style="width:150px;text-align:center;padding:6px 0;color:black;">${shop.shopName}</div>'
                     });
                     infowindow.open(map, marker);
                     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                     map.setCenter(coords);
                     map.setDraggable(false); //드래그 막기
                     map.setZoomable(false);  //휠로 줌 막기
                 } 
             });  
             </script>
	</div>
	<div class="buttons d-flex flex-row mt-2 gap-3">
	  
	</div>
	
	<div class="search-option">
		<i class='bx bx-search-alt-2 first-search'></i>
		<div class="inputs">
			<input type="text" name="">
		</div>
		<i class='bx bx-share-alt share'></i>
	</div>
	
	<hr class="hr-5">

		<div class="col-lg-12">
			<div class="setTable">
				<table>
					<tr colspan="2">
						<th>2인 테이블</th>
					</tr>
					<tr>
						<td>테이블 종류</td>
						<td>전체 수량</td>
					</tr>
					<tr>
						<td>2인 테이블</td>
						<td><input type="text" readonly></td>
					</tr>
					<tr>
						<td>4인 테이블</td>
						<td><input type="text" readonly></td>
					</tr>
					<tr>
						<td>6인 테이블</td>
						<td><input type="text" readonly></td>
					</tr>
				</table>
	       </div>
	       <div class="setTime">
		       <table>
					<tr colspan="2">
						<th>매장 시간 설정</th>
					</tr>
					<tr>
						<td>시간 구분</td>
						<td>시간</td>
					</tr>
					<tr>
						<td>Lunch</td>
						<td><input type="text" readonly></td>
					</tr>
					<tr>
						<td>Dinner</td>
						<td><input type="text" readonly></td>
					</tr>
				</table>
	       </div>
	       <div class="setMenu">
		       <table>
					<tr colspan="2">
						<th>메뉴 설정</th>
					</tr>
					<tr>
						<td>시간 구분</td>
						<td>메뉴명</td>
						<td>메뉴가격</td>
					</tr>
					<tr>
						<td>Lunch</td>
						<td><input type="text" readonly></td>
						<td><input type="text" readonly></td>
					</tr>
					<tr>
						<td>Dinner</td>
						<td><input type="text" readonly></td>
						<td><input type="text" readonly></td>
					</tr>
				</table>
	       </div>
       </div>
    
  </div>
   <form name="manageForm" id="manageForm" method="post">
    <input type="hidden" name="shopUID" id="shopUID"  value="${shop.shopUID}"/> 
     <input type="hidden" name="reservationDate" id="reservationDate" value="${reservationDate}" />
     <input type="hidden" name="reservationTime" id="reservationTime" value="${reservationTime}" />
     <input type="hidden" name="reservationPeople" id="reservationPeople" value="" />
     <c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
  		<input type="hidden" name="shopOrderMenu${status.index}" value="${shopMenu.shopMenuName}" />
  		<input type="hidden" name="shopOrderMenuQuantity${status.index}" value="0" />
     </c:forEach>
     <input type="hidden" name="totalAmount2" id="totalAmount2" value="0">
     <input type="hidden" name="counterSeatYN" id="counterSeatYN" value="N"><!-- 카운터석으로 앉을지 여부 Y는 카운터석, N은 카운터석이 아닌자리 -->
  </form>
 </div>
</section>

<script>
  function changeImage(element) {
     var main_prodcut_image = document.getElementById('main_product_image');
     main_prodcut_image.src = element.src; 
  }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
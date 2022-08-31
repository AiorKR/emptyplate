<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">

<script type="text/javascript">
function fn_search(shopHashtag) { //해시태그 클릭시 검색
    document.bbsForm.searchValue.value = shopHashtag	;
    document.bbsForm.action = "/reservation/list";
    document.bbsForm.submit();
}
</script>
</head>
<body> 
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> 
  <!-- ======= reservations Section ======= -->
  <section id="view" class="view">
      <!-- Product Slider -->
      <div class="container">
        <div class="card">
            <div class="row g-0">
                <div class="col-md-6" style="border-right:2px solid #C2A383;">
                    <div class="d-flex flex-column justify-content-center">
                        <div class="main_image"> <img src="../resources/upload/shop/sub/${shop.shopUID}/${shop.shopFileList.get(1).shopFileName}" id="main_product_image" height="400px" width="400px"> </div>
                        <div class="thumbnail_images">
                            <ul id="thumbnail">
            					<c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status" begin="1" end="5">
                                	<li><img onclick="changeImage(this)" src="../resources/upload/shop/sub/${shop.shopUID}/${shopFileList.shopFileName}" width="100px" height="100px"></li>
                            	</c:forEach>  
                            </ul>
                        </div>
                        <div class="view-text" style="margin-left: 10px; border-top:2px solid #C2A383;">
                          <p id="title" style="font-size:20px"> 공지사항 </p>
                          <p class="view-content">
                            ${shop.shopContent}
                          </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 right-side">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>${shop.shopName}</h3><div class="bookmark"><button type="button" id="btnBoomark" class="bookmark"><ion-icon name="star"></ion-icon>&nbsp;&nbsp;즐겨찾기</button></div>
                        </div>
                        <div class="mt-2 pr-3 content">
                            <p>${shop.shopIntro}</p>
                        </div>
                        <ul>
                          <li><i class="fa-solid fa-map-location-dot"></i> ${address} </li>
                          <li><i class="fa-regular fa-star"></i> 별점 4.5 (100)</li>
                        </ul>
                        <c:forTokens items="${shop.shopHashtag}" delims="#" var="shopHashtag">
            				<span onclick="fn_search('${shopHashtag}')" style="cursor: pointer; "><c:out value='${shopHashtag}'/></span>
           				</c:forTokens>	
                        <div id="map" style="width:100%; height:350px; margin-top: 15px;"></div>

						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c114849a120d4c8456de73d6e0e3b3a0&libraries=services"></script>
						<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = {
						        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
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
						    } 
						});  
						</script>
						</div>
                        <div class="buttons d-flex flex-row mt-2 gap-3" style="margin-left: 15px;">
                           <button class="btn btn-outline-dark"><a href="" style="color: white;">Today 확인</a></button>
                           <!-- Button trigger modal -->
                          <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="modal-btn"  style="color:#ffff;">
                            	예약
                          </button>

                          <!-- Modal -->
                          <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                              <div class="modal-content">
                                <div class="modal-header">
                                  <h5 class="modal-title" id="m">예약</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                  <div class="datecard">
                                    <h3 id="view-name">
                                      ${shop.shopName}
                                    </h3>
                                    <div class="content">
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
                                    </div>
                                    <input type="text" class="datepicker" placeholder="날자를 선택해주세요" name="date" readonly>
                                    <div class="box">
                                        <ul id="datepicker-ul">
                                            <li id="datepicker-li">
                                                <div class="dptime">10:00</div>
                                                <div class="dptime">11:00</div>
                                                <div class="dptime">12:00</div>
                                                <div class="dptime">13:00</div>
                                                <div class="dptime">14:00</div>
                                                <div class="dptime">18:00</div>
                                                <div class="dptime">19:00</div>
                                                <div class="dptime">20:00</div>
                                                <div class="dptime">21:00</div>
                                                <div class="dptime">22:00</div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="menuQuantity">
                                      <ul class="menuQuantity">
                                        <li style="list-style: none;">메뉴 목록</li>
                                        <li>
                                          <div>메뉴1<p id="menuQuantity1"></p>
                                          </div>
                                          <div>메뉴2<p id="menuQuantity2"></p></div>
                                          <div>메뉴3<p id="menuQuantity3"></p></div>
                                          <div>메뉴4<p id="menuQuantity4"></p></div>
                                        </li>
                                      </ul>
                                  </div>
                                </div> 
                                <div class="container modal-menu">
                                  <p id="menu-print-title">주문목록</p>
                                    <ul>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                      <li id="menu-print1" class="menu-print"> <p></p> <button>삭제</button></li>
                                    </ul>
                                </div>
                                <script src="./assets/datepicker/date_picker.js"></script>
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="btn btn-primary">예약</button>
                                </div>
                              </div>
                            </div>
                          </div>
                        <div class="search-option"><i class='bx bx-search-alt-2 first-search'></i>
                            <div class="inputs"> <input type="text" name=""> </div> <i class='bx bx-share-alt share'></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <container>
        	<hr class="hr-5">
        </container>
        <div class="review-container1">
          <h5 style="color:#FF7F50; text-align:center;">Review</h5>
        <container>
        	<hr class="hr-5">
        </container>
          <div class="review">
            <ul>
              <li><a href="#">Review text1</a></li>
              <li><a href="#">Review text2</a></li>
              <li><a href="#">Review text3</a></li>
              <li><a href="#">Review text4</a></li>
              <li><a href="#">Review text5</a></li>
            </ul>
          </div>
          	<form name="bbsForm" id="bbsForm" method="post">
		        <input type="hidden" name="shopUID" value=""/> 
	            <input type="hidden" name="searchType" value="${searchType}"/>
	            <input type="hidden" name="searchValue" value="${searchValue}" />
	            <input type="hidden" name="curPage" value="${curPage}" />
	            <input type="hidden" name="reservationDate" value="${reservationDate}" />
	            <input type="hidden" name="reservationTime" value="${reservationTime}" />
            </form>
        </div>
    <script>
      function changeImage(element) {

	      var main_prodcut_image = document.getElementById('main_product_image');
	      main_prodcut_image.src = element.src; 
      }
    </script>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</html>
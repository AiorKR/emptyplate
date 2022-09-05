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
<meta charset="UTF-8">

<script type="text/javascript">
function fn_search(shopHashtag) { //해시태그 클릭시 검색
    document.bbsForm.searchValue.value = "#" + shopHashtag;
    document.bbsForm.action = "/reservation/list";
    document.bbsForm.submit();
}

function fn_MenuAdd(shopMenu) { //메뉴 클릭시 메뉴 출력
	$('#selectMenu').append(shopMenu + "<br />");
}

$(document).ready(function(){ 
	
	$(".personnel-selected-value").click(function(){
		  $("#select-ul").attr('style', "display:inline-block;");
		});

		$(".option").click(function(){
		  $('.option').removeClass('select');
		  $(this).addClass('select');
			  $("#select-ul").attr('style', "display:none;");
			  $(".personnel-selected-value").text($(this).text());
			  document.bbsForm.reservationPeople.value = $(".personnel-selected-value").text();
		});
		
		$(".datepicker").change(function(){
			$("#datepicker-ul").attr('style', "display:inline;");
		});



		$(document).ready(function(){
		    $('.datepicker').datepicker({
				format: 'yyyy.mm.dd',
				autoclose: true,
				startDate: '0d',
				endDate: '+1m',
				daysOfWeekDisabled : [${shop.shopHoliday}],
				immediateUpdates: true
		    });
		    
		    $('.dptime').click(function(){
		      $('.dptime').removeClass('select');
		      $(this).addClass('select');
		      $("#datepicker-ul").attr('style', "display:none;");
		      document.bbsForm.reservationDate.value = $('.datepicker').val().replaceAll(".", "");
		      document.bbsForm.reservationTime.value = $(this).text();
		      document.bbsForm.reservationTime.value = $(this).text().replaceAll(":", "");
			  $('.datepicker').val($('.datepicker').val()+ ' ' + $(this).text());
			  $("#tableCheck").text("");
			  reservationCheck();
		    });
		});
	
	function reservationCheck() {
	      $.ajax({
	          type:"GET",
	          url:"/reservation/reservationCheckProc",
	          data: {
	         	 shopUID: $("#shopUID").val(),
	         	 reservationDate: $("#reservationDate").val(),
	         	 reservationTime: $("#reservationTime").val(),
	         	 reservationPeople:$("#reservationPeople").val()
	          },
	          beforeSend:function(xhr) {
	             xhr.setRequestHeader("AJAX", "true");
	          },
	          success:function(response) {
	             if(response.code == 0) {
	               	if(response.data != null) {
	    				$.each(response.data, function(index, item) { // 데이터 =item
	    					$("#tableCheck").append(item.shopTotalTableCapacity +  '인 테이블 '); // index가 끝날때까지 
	    					$("#tableCheck").append(item.shopTotalTableRmains + "개 남아있음" + '<br />');
	    				});
	               	}
	             }
	             else if(response.code == 400) {
	                alert("파라미터 값이 올바르지 않습니다.");
	             }
	             else if(response.code == 404) {
		                alert("매장을 찾을 수 없습니다.");
						location.href = "/reservation/list"
		          }
	             
	             else if(response.code == 403) {
		                alert("로그인을 해주십시오.");
						location.href = "/user/login" ;
	             }
	             else {
	                alert("예약 조회 중 오류가 발생하였습니다.");
	               }
	          },
	          error:function(error) {
	             icia.common.error(error);
	             alert("예약 조회 중 오류가 발생하였습니다.");
	          }
	      });
		}
   });
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
                        <div class="main_image"> <img src="../resources/upload/shop/${shop.shopUID}/${shop.shopFileList.get(1).shopFileName}" id="main_product_image" height="400px" width="400px"> </div>
                        <div class="thumbnail_images">
                            <ul id="thumbnail">
                           <c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status">
                                   <li><img onclick="changeImage(this)" src="../resources/upload/shop/${shop.shopUID}/${shopFileList.shopFileName}" width="100px" height="100px"></li>
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
                          <li><i class="fa-solid fa-map-location-dot" style="color:#C2A383"></i> ${address} </li>
                          <li><i class="fa-regular fa-star" style="color:#C2A383"></i> 별점 4.5 (100)</li>
                          <li><i class="fa fa-phone" aria-hidden="true"  style="color:#C2A383">${shop.shopTelephone}</i></li>
                        </ul>
                       	<c:forTokens items="${shop.shopHashtag}" delims = "#" var="shopHashtag">
                            <span onclick="fn_search('${shopHashtag}')" style="cursor: pointer; ">
                            	<i class="fa-solid fa-hashtag" style="font-size:18px; color:#FF7F50;"><c:out value='${shopHashtag}'/></i>
                        	</span>
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
                          map.setDraggable(false); //드래그 막기
                          map.setZoomable(false);  //휠로 줌 막기
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
                                  	<div id="shopName">${shop.shopName}</div>
                                  	<div id="selectcontent">
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
														<div class="dptime">${shopTime.shopOrderTime}</div>
	                               					</c:forEach>  
	                                            </li>
	                                        </ul>
	                                    </div>
                                  	</div>
                              		<div id="tableCheck">

									</div>
                                    <div class="menuQuantity">
                                   		<ul class="menuQuantity">
                                       		<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
												<div onclick="fn_MenuAdd('${shopMenu.shopMenuName}')">${shopMenu.shopMenuName} ${shopMenu.shopMenuPrice} 원</div>
                        			  		</c:forEach>  
                                      	</ul>
                                	</div>
                                	<div style="border:1px solid black;" id="selectMenu">
                                		<p>주문 메뉴</p>
                                	</div>
                                    </div>
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
            <ul style="border-bottom:1px solid #C2A383">
              <li><a href="#">Review text1</a></li>
            </ul>
          </div>
             <form name="bbsForm" id="bbsForm" method="post">
              <input type="hidden" name="shopUID" id="shopUID" value="${shop.shopUID}"/> 
               <input type="hidden" name="searchType"  value="${searchType}"/>
               <input type="hidden" name="searchValue" value="${searchValue}" />
               <input type="hidden" name="curPage" value="${curPage}" />
               <input type="hidden" name="reservationDate" id="reservationDate" value="${reservationDate}" />
               <input type="hidden" name="reservationTime" id="reservationTime" value="${reservationTime}" />
               <input type="hidden" name="reservationPeople" value="" />
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Favicons -->
  <link href="/resources/images/favicon.png" rel="icon">
  <link href="/resources/images/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair Display:wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i|Nanum+Brush+Script|Nanum+Gothic+Coding|Do+Hyeon&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
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
  <!-- Template Main CSS File -->
  <link href="/resources/css/style.css" rel="stylesheet">

<script src="https://js.tosspayments.com/v1"></script>


<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">

$(document).ready(function(){
   
   if('${cookieUserUID}' == "null") {
      alert("로그인을 해주세요");
      window.opener.location.href = "/user/login"; //부모창 이동
      window.close();
      return;
   }
   if('${shopUID}' == "null") {
      alert("매장 정보를 찾을 수 없습니다");
      window.opener.location.href = "/today/list";
      window.close();
      return
   }
   if('${orderUID}' == "null") {
      alert("노쇼 정보를 찾을 수 없습니다.");
      window.opener.location.href = "/today/list";
      window.close();
      return
   }
   
   $("#pay").on("click", function fn_pay() {
      
         $.ajax({
            type:"get",
            url:"/pay/noShopReservationProc",
            data: {
               orderUID: '${order.orderUID}'
            },
             beforeSend:function(xhr) {
                xhr.setRequestHeader("AJAX", "true");
             },
             success:function(response) {
                if(response.code == 0) {
                   if(response.data != null) {
                      console.log(response.data);
                   
                      var orderName= "";
                      if(response.data.orderMenu.length == 1) { //메뉴가 하나만 있는 경우
                        orderName = response.data.shopName + ", " + response.data.orderMenu[0].orderMenuName + " X" + response.data.orderMenu[0].orderMenuQuantity;
                         }
                      
                      else { //메뉴가 하나 이상일 경우
                         for(var i=0; i < response.data.orderMenu.length; i++) {
                            orderName = response.data.shopName +  ", " + response.data.orderMenu[0].orderMenuName + "외 " + (response.data.orderMenu.length -1) + "건";
                         }
                      }
                      
                      var clientKey = response.data.toss.tossClientKey;
                      tossPayments = TossPayments(clientKey);

                        tossPayments.requestPayment('카드', {
                           amount: response.data.totalAmount,
                           orderId: response.data.orderUID,
                           orderName: orderName,
                           customerName: response.data.userName,
                           successUrl: response.data.toss.tossSuccessUrl,
                           failUrl: response.data.toss.tossFailUrl,
                      }); 
                   }
                }
                else if(response.code == 400) {
                   alert("파라미터 값이 올바르지 않습니다.");
                }
                else if(response.code == 404) {
                      alert("no-show를 찾을 수 없습니다.");
                      fn_colorbox_close();
                }
                
                else if(response.code == 403) {
                      alert("로그인을 해주십시오.");
                      fn_colorbox_close();
                }
                else {
                   alert("결재 진행 중 오류가 발생했습니다.");
                   fn_colorbox_close();
                  }
             },
             error:function(error) {
                icia.common.error(error);
                alert("결재 진행 중 통신오류가 발생했습니다.");
             }
            });
      });
   });
   
</script>
</head>
<body>
<!-- ======= reservations Section ======= -->
<section id="todayView" class="todayView">
 <div class="container">
  <div class="row">
   <div style="border-right: 2px solid #C2A383; float:left;width: 50%;">
     <div class="d-flex flex-column justify-content-center">
      <div class="main_image">
        <img src="../resources/upload/shop/${shop.shopUID}/${shop.shopFileList.get(1).shopFileName}"
            id="main_product_image" height="400px" width="400px">
      </div>
      <div class="thumbnail_images">
        <ul id="thumbnail">
         <c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status" begin="1" end="5">
           <li><img onclick="changeImage(this)"
                  src="../resources/upload/shop/${shop.shopUID}/${shopFileList.shopFileName}"
                  width="100px" height="100px" style="margin: 5px;">
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
      <c:choose>
        <c:when test="${shopMarkActive eq 'Y'}">
         <div class="bookmark">
           <button type="button" id="btnMark" class="bookmark">
            <ion-icon name="star"></ion-icon>&nbsp;&nbsp;즐겨찾기
           </button>
         </div>
        </c:when>
        <c:when test="${shopMarkActive eq 'N'}">
         <div class="bookmark">
           <button type="button" id="btnMark" class="bookmark">
            <ion-icon name="star-outline"></ion-icon>&nbsp;&nbsp;즐겨찾기
           </button>
         </div>
        </c:when>
      </c:choose>
     </div>
     <div class="intro mt-2 pr-3 content">
      <p>${shop.shopIntro}</p>
     </div>
     <ul class="intro2">
      <li><i class="fa-solid fa-map-location-dot"></i>&nbsp;&nbsp;${shop.shopLocation1} ${shop.shopLocation2} ${shop.shopAddress}</</</li>
      <li><i class="fa-regular fa-star"></i>&nbsp;&nbsp;별점 <fmt:formatNumber value="${shop.reviewScore}" pattern=".00"/> (${shop.reviewCount})</li>
      <li><i class="fa fa-phone" aria-hidden="true"></i>&nbsp;&nbsp;${shop.shopTelephone}</li>
     </ul>
     <c:forTokens items="${shop.shopHashtag}" delims="#" var="shopHashtag">
      <span class="hashtag"> 
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
             geocoder.addressSearch('${shop.shopLocation1} ${shop.shopLocation2} ${shop.shopAddress}', function(result, status) {
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
     <!-- Button trigger modal -->
     <button type="button" class="btn btn-primary"
           data-bs-toggle="modal" data-bs-target="#exampleModal"
           id="modal-btn">예 약
     </button>

     <!-- Modal -->
     <div class="modal fade" id="exampleModal" tabindex="-1"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="m">noShow 예약</h5>
               <button type="button" class="btn-close"
                      data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
               <div id="shopName">${shop.shopName}</div> <br />
               <div id="selectcontent">
                  <p>예약인원 : ${order.reservationPeople} 명</p>
                  </div>
                  <p>예약날짜 : ${order.shopReservationTableList[0].shopReservationDate} / ${order.shopReservationTableList[0].shopReservationTime}</p>
                  <br />
                  <br />
               </div>
               <div class="order">
                  <p>주문 메뉴</p>
                  <c:forEach items="${order.orderMenu}" var="orderMenu" varStatus="status">
                     <div>
                        <span id="shopOrderMenu${status.index}"
                             class="shopOrderMenu">${orderMenu.orderMenuName}</span> X  
                        <span id="shopOrderMenuQuantity${status.index}"
                             class="shopOrderMenu">${orderMenu.orderMenuQuantity}</span>
                     </div>
                  </c:forEach>
                  <p class="total">
                         할인 전 : <span id="totalAmount"><strike><fmt:formatNumber value="${order.totalAmount}" pattern=""/> 원 </strike> &nbsp;
                     <span style="color:red;">할인 후 : </span><c:if test='${order.orderStatus eq "X"}'><c:set value="${order.totalAmount * 0.3}" var="totalAmount" /><span style="color:red;'"><fmt:formatNumber value="${totalAmount}" pattern=""/></span></c:if> 
                           <c:if test='${order.orderStatus eq "C"}'><c:set value="${order.totalAmount * 0.5}" var="totalAmount" /><span style="color:red;"><fmt:formatNumber value="${totalAmount}" pattern=""/></span></c:if> </span>
                  </p>
               </div>
               <button class="btn btn-primary" id="pay">결 제</button>
            </div>
         </div>
      </div>
     </div>
   </div>
 </div>
</section>

<script>
  function changeImage(element) {
     var main_prodcut_image = document.getElementById('main_product_image');
     main_prodcut_image.src = element.src; 
  }
</script>

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
</body>
</html>
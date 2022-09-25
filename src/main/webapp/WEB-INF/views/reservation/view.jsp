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

<script src="https://js.tosspayments.com/v1"></script>


<meta charset="UTF-8">

<script type="text/javascript">
$(document).ready(function(){
	
	$("#counterSeat").on("click", function() {
		
		console.log($("#counterSeat").is(":checked"));
																																																																																													
		if($("#counterSeat").is(":checked")) {
			document.bbsForm.counterSeatYN.value = "Y";
			if(document.bbsForm.reservationDate.value != "" && document.bbsForm.reservationTime.value != "") {
				reservationCheck();
			}
		}
		else {
			document.bbsForm.counterSeatYN.value = "N";
		}
		
	});
	
	//게시물 즐겨찾기
   $("#btnMark").on("click", function(){
	   $.ajax({
	       type:"POST",
	       url:"/shop/mark",
	       data:{
	          shopUID:'<c:out value="${shopUID}" />'
	       },
	       datatype:"JSON",
	       beforeSend:function(xhr){
	          xhr.setRequestHeader("AJAX", "true");
	       },
	       success:function(response){
	          if(response.code == 0)
	          {
	             alert("즐겨찾기를 하셨습니다.");
	             location.reload();
	          }
	          else if(response.code == 1)
	          {
	             alert("즐겨찾기를 취소하셨습니다.");
	             location.reload();
	          }
	          else if(response.code == 400)
	          {
	             alert("로그인 후, 즐겨찾기 버튼을 사용하실 수 있습니다.");
		         location.href = "/user/login";
	          }
	          else
	          {
	             alert("즐겨찾기 중 오류가 발생하였습니다.");
	          }
	       },
	       error:function(xhr, status, error){
	          icia.common.error(error);
	       }
	    });
	});
	
	//리뷰로 변경 필요
	$("#btnSearch").on("click", function(){
		document.bbsForm.bbsSeq.value = "";
		document.bbsForm.searchType.value = $("#_searchType").val();
		document.bbsForm.searchValue.value = $("#_searchValue").val();
		document.bbsForm.curPage.value = "1";
		document.bbsForm.action = "/board/list";
		document.bbsForm.submit();
	});
	
	$("#btn-primary").on("click", function() { 
	      document.bbsForm.bbsSeq.value = "";
	      document.bbsForm.action = "/purcx/hase/pay";
	      document.bbsForm.submit();
	   });
	   
	$(".personnel-selected-value").click(function(){
		  $("#select-ul").attr('style', "display:inline-block;");
		});

		$(".option").click(function(){
		  $('.option').removeClass('select');
		  $(this).addClass('select');
			  $("#select-ul").attr('style', "display:none;");
			  $(".personnel-selected-value").text($(this).text());
			  document.bbsForm.reservationPeople.value = $(".personnel-selected-value").text().replaceAll("명", "");;
			  if($("#pay").is(":disabled")) { //disabled 처리 되있다면 풀어줌
         		 $("#pay").attr("disabled", false);
     			 if(document.bbsForm.reservationDate.value != "" && document.bbsForm.reservationTime.value != "") {
    				 reservationCheck();
    			 }
         	 }
		}); 
		$(".datepicker").change(function() {
			
			var tDate = new Date();
			var month = (tDate.getMonth() + 1);month = month >= 10 ? month : '0' + month;
			today = tDate.getFullYear() + "." + month + "." + tDate.getDate();
			var curHours = (tDate.getHours() + 3); curHours = curHours >= 10 ? curHours : '0' + curHours + 3;
			var curTime = curHours + "00";
			
			console.log("todat : " +today);
			console.log(' $(".datepicker").val()' + $(".datepicker").val());
			
			if($(".datepicker").val() == today) {
				console.log("오늘임");
				console.log("curTime : " + curTime);
				<c:forEach items="${shop.shopTime}" var="shopTime" varStatus="status">
				var orderTime = ('${shopTime.shopOrderTime}').replace(":", "");
				console.log("orderTime : " + orderTime);
				if(orderTime <= curTime) {
					$("#shopTime${status.index}").attr('style', "display:none;");
				}
				</c:forEach>
			}
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
	      	if($(this).text() != "" && $(this).text() != null) {
				<c:forEach items="${shop.shopTime}" var="shopTime" varStatus="status">
					if($(this).text() ==  '${shopTime.shopOrderTime}') {
					 	type = '${shopTime.shopTimeType}';
					 	<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status2">
						if(type != '${shopMenu.shopMenuCode}'){
							console.log("type : " + type);
							console.log("type : " + type);
					 		$("#shopMenu${status2.index}").attr('style', "display:none;");
					 	}
						if(type == '${shopMenu.shopMenuCode}'){
							console.log("type : " + type);
							console.log("type : " + type);
					 		$("#shopMenu${status2.index}").attr('style', "display:inline;");
					 	} 
						</c:forEach>
					 	$(".shopOrderMenu").text("");
					 	$("#totalAmount").text(0);
					 	shopOrderMenuTotalAmount = 0;
					}
				</c:forEach>
	      	}
	      	document.bbsForm.reservationTime.value = $(this).text().replaceAll(":", "");
		  	$('.datepicker').val($('.datepicker').val()+ ' ' + $(this).text());
		  	$("#tableCheck").text("");
		  	reservationCheck();	
	    	});
		});
	
	$("#pay").on("click", function fn_pay() {
		
		var menuList = [];
		
		for(var i=0; i < ${shop.shopMenu.size()}; i++) {
			if($("input[name=shopOrderMenuQuantity" + i + ']').val() != '0') {
				var quantity = ($("input[name=shopOrderMenu" + i + ']').val()  + "," + $("input[name=shopOrderMenuQuantity" + i + ']').val());
				
				menuList[i] = quantity;
			}
			else {
				menuList[i] = ($("input[name=shopOrderMenu" + i + ']').val()  + "," + '0');
			}
			
			console.log("[i] : " + i + " menuList[i] : " + menuList[i]);
		}
		
	      $.ajax({
	    	  type:"POST",
	    	  url:"/pay/orderMenu",
	    	  data: {
	    		  shopUID: $("#shopUID").val(),
         	 	  reservationDate: $("#reservationDate").val(),
		          reservationTime: $("#reservationTime").val(),
		          reservationPeople:$("#reservationPeople").val(),
		          counterSeatYN: $("#counterSeatYN ").val(),
		          totalAmount: $("#totalAmount2").val(),
		          <c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
		          orderMenu${status.index}: menuList[${status.index}],
		          </c:forEach>
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
	            		 console.log(clientKey);
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
		                alert("매장을 찾을 수 없습니다.");
						location.href = "/reservation/list"
		          }
	             
	             else if(response.code == 403) {
		                alert("로그인을 해주십시오.");
						location.href = "/user/login" ;
	             }
	             else {
	                alert("결재 진행 중 오류가 발생했습니다.");
	                location.href = "/reservation/list"
	               }
	          },
	          error:function(error) {
	             icia.common.error(error);
	             alert("결재 진행 중 통신오류가 발생했습니다.");
	          }
	      });
		});
		
		function reservationCheck() { //자리 확인
		      $.ajax({
		          type:"GET",
		          url:"/reservation/reservationCheckProc",
		          data: {
		         	 shopUID: $("#shopUID").val(),
		         	 reservationDate: $("#reservationDate").val(),
		         	 reservationTime: $("#reservationTime").val(),
		         	 counterSeatYN: $("#counterSeatYN").val(),
		         	 reservationPeople:$("#reservationPeople").val()
		          },
		          beforeSend:function(xhr) {
		             xhr.setRequestHeader("AJAX", "true");
		          },
		          success:function(response) {
		             if(response.code == 0) {
		            	 if($("#pay").is(":disabled")) { //disabled 처리 되있다면 풀어줌
		            		 $("#pay").attr("disabled", false);
		            	 }
		             }
		             else if(response.code == 400) {
		            	$("#pay").attr("disabled", true);
		                alert("인원을 선택해주세요");
		             }
		             else if(response.code == 404) {
							location.href = "/reservation/list"
			          }
		             
		             else if(response.code == 403) {
							location.href = "/user/login" ;
		             }
		             else if(response.code == -1) {
		            	 $("#pay").attr("disabled", true);
		            	 alert("매장의 해당 시간은 예약이 모두 찼습니다.");
		             }
		             else if(response.code == -2) {
		            	 $("#pay").attr("disabled", true);
		            	 alert("예약을 원하시는 인원 수만큼 남은 자리가 없습니다.");
		             }
		             else if(response.code == -3) {
		            	 $("#pay").attr("disabled", true);
		            	 alert("해당 매장은 카운터석이 없습니다.");
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
			};
   });
   

var type = "";
var shopOrderMenuTotalAmount = 0;

function fn_search(shopHashtag) { //해시태그 클릭시 검색
    document.bbsForm.searchValue.value = "#" + shopHashtag;
    document.bbsForm.action = "/reservation/list";
    document.bbsForm.submit();
}

function fn_MenuAdd(shopOrderMenu, shopOrderMenuPrice, shopMenuCode, shopMenuid) { //메뉴 클릭시 메뉴 추가
	if(type != "") {
		if(type == shopMenuCode) {
				$("#shopOrderMenu" + shopMenuid).text(shopOrderMenu + "x"); //메뉴 하나 선택시 추가
				if($("#shopOrderMenuQuantity" + shopMenuid).text() == "") {
					$("#shopOrderMenuQuantity" + shopMenuid).text(1);
					
					  $("input[name=shopOrderMenuQuantity" + shopMenuid + ']').attr('value', '1');
				}
				else {
					var cnt = $("#shopOrderMenuQuantity" + shopMenuid).text();
					cnt++;
					if(cnt >= 10) {
						return;
					}
					$("input[name=shopOrderMenuQuantity" + shopMenuid + ']').val(cnt);
					$("#shopOrderMenuQuantity" + shopMenuid).text(cnt);
					$("#quantity" + shopMenuid).text(cnt);
				}
			shopOrderMenuTotalAmount += shopOrderMenuPrice;
			$("#totalAmount").text(shopOrderMenuTotalAmount);
			$('input[name=totalAmount2]').val(shopOrderMenuTotalAmount);
		}
	}
	else {
		alert("날짜와 시간을 먼저 선택해주세요");
	}
}

function fn_MenuSub(shopOrderMenu, shopOrderMenuPrice, shopMenuCode, shopMenuid) { //메뉴 빼기
	if(type == shopMenuCode) {
		var cnt = $("#shopOrderMenuQuantity" + shopMenuid).text();
		if(cnt <= 0) {
			$("#shopOrderMenu" + shopMenuid).text("");
			$("#shopOrderMenuQuantity" + shopMenuid).text("");
			$("input[name=shopOrderMenuQuantity" + shopMenuid + ']').attr('value', '0');
		}
		else{
			$("#shopOrderMenu" + shopMenuid).text(shopOrderMenu + "x"); //메뉴 하나 선택시 추가
			cnt--;
			shopOrderMenuTotalAmount -= shopOrderMenuPrice;
			$("#totalAmount").text(shopOrderMenuTotalAmount);		
			$("#shopOrderMenuQuantity" + shopMenuid).text(cnt);
			$("input[name=shopOrderMenuQuantity" + shopMenuid + ']').attr('value', cnt);
			$("#quantity" + shopMenuid).text(cnt);
			$('input[name=totalAmount2]').val(shopOrderMenuTotalAmount);
		}
	}
}

function fn_Menudel(shopOrderMenu, shopOrderMenuPrice, shopMenuCode, shopMenuid) { //메뉴 삭제
	if(type == shopMenuCode) {
		var price = shopOrderMenuPrice;
		var cnt = $("#shopOrderMenuQuantity" + shopMenuid).text();
		
		price = price * cnt;
			
		shopOrderMenuTotalAmount -= price;
		
		$("#shopOrderMenu" + shopMenuid).text("");
		$("#shopOrderMenuQuantity" + shopMenuid).text("");
		$("input[name=shopOrderMenuQuantity" + shopMenuid + ']').attr('value', '0');
		$("#quantity" + shopMenuid).text(cnt);
		$("#totalAmount").text(shopOrderMenuTotalAmount);
		$('input[name=totalAmount2]').val(shopOrderMenuTotalAmount);
	}
}  
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
		<div class="thumbnail_images">
		  <ul id="thumbnail">
			<c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status" begin="1" end="5">
			  <li><img onclick="changeImage(this)"
						src="../resources/upload/shop/${shop.shopUID}/${shopFileList.shopFileName}"
						width="100px" height="100px">
			  </li>
			</c:forEach>
		  </ul>
		</div>
		<div class="view-text" style="margin-left: 10px; border-top: 2px solid #C2A383;">
		  <p id="title" style="font-size: 20px">공지사항</p>
		  <p class="view-content">${shop.shopContent}</p>
		</div>
	  </div>
	</div>
	<div class="p-3 right-side" style="float:right;width: 50%;">
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
	  <div class="mt-2 pr-3 content">
		<p>${shop.shopIntro}</p>
	  </div>
	  <ul>
		<li><i class="fa-solid fa-map-location-dot"	style="color: #C2A383"></i> ${address}</li>
		<li><i class="fa-regular fa-star" style="color: #C2A383"></i> 별점 4.5 (100)</li>
		<li><i class="fa fa-phone" aria-hidden="true" style="color: #C2A383"></i> ${shop.shopTelephone}</li>
	  </ul>
	  <c:forTokens items="${shop.shopHashtag}" delims="#" var="shopHashtag">
		<span onclick="fn_search('${shopHashtag}')" style="cursor: pointer;"> 
		 <i class="fa-solid fa-hashtag" style="font-size: 18px; color: #FF7F50;">
		  <c:out value='${shopHashtag}' />
		 </i>
		</span>
	  </c:forTokens>
	  <div id="map" style="width: 100%; height: 350px; margin-top: 15px;"></div>
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
	<div class="buttons d-flex flex-row mt-2 gap-3" style="margin-left:780px;">
	  <button class="btn btn-outline-dark">
		<a href="" style="color: white;">Today 확인</a>
	  </button>
	  <!-- Button trigger modal -->
	  <button type="button" class="btn btn-primary"
			  data-bs-toggle="modal" data-bs-target="#exampleModal"
			  id="modal-btn" style="color: #ffff;">예약
	  </button>

	  <!-- Modal -->
	  <div class="modal fade" id="exampleModal" tabindex="-1"
		   aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="m">예약</h5>
					<button type="button" class="btn-close"
						    data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="shopName" style="font-size:35px;">${shop.shopName}</div> <br />
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
						<input type="text" class="datepicker"
							   placeholder="날짜를 선택해주세요" name="date" readonly>
						<div class="box">
							<ul id="datepicker-ul">
								<li id="datepicker-li">
								  <c:forEach items="${shop.shopTime}" var="shopTime" varStatus="status">
									<div class="dptime" id="shopTime${status.index}">${shopTime.shopOrderTime}</div>
								  </c:forEach>
								</li>
							</ul>
						</div><br /><br/>
						<c:if test="${shop.shopType eq 2}">
							<!-- 오마카세일때 적용 -->
							
						</c:if>
						<br />
						<br />
					</div>
					<div style="text-align:center; margin-bottom:20px;">
                               	*카운터석은 연속되게 앉을 수 없을 수도 있습니다.&nbsp;&nbsp;
                               	<input type="checkbox" id="counterSeat" class="counterSeat" style="" />
                    </div>
					<div class="menuQuantity">
						<ul class="menuQuantity">
							<table style="margin-left:20px;">
								<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
									<tr id="shopMenu${status.index}" style="font-size: 26px;">
										<td>${shopMenu.shopMenuName}</td>
										<td>${shopMenu.shopMenuPrice} 원 &nbsp;&nbsp;</td>
										<td><input type="button" value="+"
											onclick="fn_MenuAdd('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})"
											class="btn2"
											style="height: 30px; width: 30px;" /> <span id="quantity${status.index }"> </span> 
											<input type="button" value="-"
											onclick="fn_MenuSub('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})"
											class="btn2"
											style="height: 30px; width: 30px;" /> 
											<input type="button" value="삭제"
											onclick="fn_Menudel('${shopMenu.shopMenuName}', ${shopMenu.shopMenuPrice}, '${shopMenu.shopMenuCode}', ${status.index})"
											class="btn2"
											style="height: 30px; width: 60px;" /></td>
									</tr>
								</c:forEach>
							</table>
						</ul>
					</div>
					<div class="order">
						<p>주문 메뉴</p>
						<c:forEach items="${shop.shopMenu}" var="shopMenu" varStatus="status">
							<div>
								<span id="shopOrderMenu${status.index}"
									  class="shopOrderMenu"></span> 
								<span id="shopOrderMenuQuantity${status.index}"
									  class="shopOrderMenu"></span>
							</div>
						</c:forEach>
						<p style="border: 1px solid blakc;">
							총 금액 : <span id="totalAmount">0</span>
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" style="border: none;" id="pay">결제</button>
				</div>
			</div>
		</div>
	  </div>
	</div>
	
	<div class="search-option">
		<i class='bx bx-search-alt-2 first-search'></i>
		<div class="inputs">
			<input type="text" name="">
		</div>
		<i class='bx bx-share-alt share'></i>
	</div>
	
	<hr class="hr-5">
    <div class="review-container1">
     <h5 style="color: #C2A383; text-align: center;">한줄평</h5>
       <container>
		<hr class="hr-5">
       </container>
       <div class="review">
		<ul style="border-bottom: 1px solid #C2A383">
		  <li><a href="#">Review text1</a></li>
		</ul>
       </div>
    </div>
  </div>

   <form name="bbsForm" id="bbsForm" method="post">
    <input type="hidden" name="shopUID" id="shopUID"  value="${shop.shopUID}"/> 
     <input type="hidden" name="searchType"  value="${searchType}"/>
     <input type="hidden" name="searchValue" value="${searchValue}" />
     <input type="hidden" name="curPage" value="${curPage}" />
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
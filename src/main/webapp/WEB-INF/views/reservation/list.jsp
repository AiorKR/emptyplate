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
$(document).ready(function() {
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

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  
<!-- ======= reservations Section ======= -->
<section id="reservation" class="reservation">
	<div class="reservation-container container" data-aos="fade-up">
    	<div class="reservation-slider swiper" data-aos="fade-up" data-aos-delay="100">
        	<container>
            	<hr class="hr-5">
            </container>
            	<h2 style="margin-left: 30px"><strong> 오늘의 추천식당 </strong></h2>
            <container>
            	<hr class="hr-5">
            </container>
            	<div class="swiper-wrapper">
            		<c:if test="${!empty list}">
                  		<c:forEach items="${list}" var="shop" varStatus="status">
                        	<div class="swiper-slide" style="height: auto; width: 100%; background-color: rgba(240, 240, 240, 0.7);">
                        		<div class="reservation-item" style="height:350px;">
                               		<img alt="" src="../resources/upload/shop/${shop.shopFile.shopFileName}" style="height: 300px;width:300px; position: relative; left: 150px; top:25px;">
                      				<span style="position: relative; bottom:220px; left: 600px;">    
                           			<h3> ${shop.shopName} </h3>
                            		<ul>
                                 		<li>
                                    		<i class="fa-solid fa-map-location-dot"></i>	
		                                    ${shop.shopLocation1}
		                                    ${shop.shopLocation2}
		                                    ${shop.shopLocation3}
		                                    ${shop.shopAddress}
                                     	</li>
                                 		<li><i class="fa-regular fa-star"></i> 별점 4.3 (500)</li>
                           			</ul>
                            		<p class="fa-solid fa-pen" style="color:#cda45e; font-size: 19px;">
                                		${shop.shopIntro}
                            		</p><br/>
                            		  
                             		<c:forTokens items="${shop.shopHashtag}" delims = "#" var="shopHashtag">
                                    	<span onclick="fn_search('${shopHashtag}')" style="cursor: pointer; ">
                                       		<i class="fa-solid fa-hashtag"><c:out value='${shopHashtag}'/></i>
                                   		</span>
                            		</c:forTokens>
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
                            	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                	<span class="navbar-toggler-icon"></span>
                            	</button>
                            	<form>
                            
                            	<!--datepicker-->
								<div class="card">
                                	<div class="content">
                                    	<input type="text" class="datepicker" placeholder="날자를 선택해주세요" name="date" readonly>
                                 	</div>
                                 	<div class="box">
                                    	<ul id="datepicker-ul">
                                        	<li id="datepicker-li">
												<div class="dptime-disabled">런치 타임</div>
	                                            <div class="dptime">10:00</div>
	                                            <div class="dptime">11:00</div>
	                                            <div class="dptime">12:00</div>
	                                            <div class="dptime">13:00</div>
	                                            <div class="dptime">14:00</div>
	                                            <div class="dptime-disabled">디너 타임</div>
	                                            <div class="dptime">18:00</div>
	                                            <div class="dptime">19:00</div>
	                                            <div class="dptime">20:00</div>
	                                            <div class="dptime">21:00</div>
	                                            <div class="dptime">22:00</div>
                                        	</li>
                                    	</ul>
                                	</div>
								</div> 
                             	<script src="/resources/datepicker/date_picker.js"></script>
                             
                             	<!--datepicker--> 
                            	&nbsp;&nbsp;&nbsp;
                            	<div class="collapse navbar-collapse" id="navbarSupportedContent">
                                	<ul class="navbar-nav me-auto ">
                                    	<select class="select" aria-label="Default select example" style="width: 150px; height: 35px; cursor:pointer;">
	                                        <option value="0" selected style="width: 150px; height: 35px; cursor:pointer;" selected <c:if test="${searchType eq '0'}">selected</c:if>>전체</option>
	                                        <option value="1" style="width: 150px; height: 35px; cursor:pointer;"  <c:if test="${searchType eq '1'}">selected</c:if>>파인다이닝</option>
	                                        <option value="2" style="width: 150px; height: 35px; cursor:pointer;"  <c:if test="${searchType eq '2'}">selected</c:if>>오마카세</option>
                                     	</select>
                                 	</ul>
								</form>
								<div style="border:1px solid #C2A384">
                             	<input type="text" name="text" id="search" <c:if test="${searchValue ne null and searchValue ne ''}">value="${searchValue}"</c:if>>
                             	<button class="btn" type="submit" id="searchBtn">검색</button>    
                             	</div>  
                         		</div>
                     		</nav>    
                     		<tbody class="menutable"  style="height: auto; width: 100%;">
                        		<c:if test="${!empty list}">
                           			<c:forEach items="${list}" var="shop" varStatus="status">
                                		<tr onclick="fn_view('${shop.shopUID}')" style="cursor:pointer;">
                                  				<td class="w-25" colspan="4">
                                     				<img src='../resources/upload/shop/${shop.shopFile.shopFileName}' class="img-fluid img-thumbnail" style="height: 200px;width: 200px; " >
                                  				</td>
                                  				<td>
                                  					<h2><c:out value="${shop.shopName}" /></h2><br />                                    
                                    	 			<c:forTokens items="${shop.shopHashtag}" delims = "#" var="shopHashtag">
                                          				<span onclick="fn_search('${shopHashtag}')" style="cursor:pointer;">
	                                                		<i class="fa-solid fa-hashtag" style="font-size:18px; color:#FF7F50;">
	                                                      		<c:out value='${shopHashtag}'/>
	                                                		</i>
                                          				</span>
                                     				</c:forTokens><br /><br />                                   
                                     				<i class="fa-solid fa-map-location-dot" style="font-size:18px;">
				                                        <c:out value="${shop.shopLocation1}" />
				                                        <c:out value="${shop.shopLocation2}" />
				                                        <c:out value="${shop.shopLocation3}" />
                                    				</i><br /><br />                                    
				                                    <i class="fa-solid fa-pen" style="color:#cda45e; font-size:19px;">
				                                    	<c:out value="${shop.shopIntro}" />
				                                    </i>
												</td>
                           				</tr>
                          			</c:forEach>  
                     			</c:if>
                     		</tbody>
                   	</table>
                    <div class="page-wrap">
                    	<ul class="page-nation">
                        	<c:if test="${paging.prevBlockPage gt 0}">
                            	<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"> < </a></li>
                          	</c:if>
                            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                            	<c:choose>
                                	<c:when test="${i ne curpage}">
                                   		<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                                   	</c:when>
                                 	<c:otherwise>
                                   		<li class="page-item"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
                                 	</c:otherwise>
                            	</c:choose>
                          	</c:forEach>
                          	<c:if test="${paging.nextBlockPage gt 0}">
                            	<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})"> > </a></li>
                          	</c:if>
                     	</ul>
                   	</div>   
				</div>
        	</div>
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
</section>

<!-- End reservation Section -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.beans.factory.annotation.Value" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="/resources/datepicker/date_picker.css">

<%@ include file="/WEB-INF/views/include/head.jsp" %>

<!--date and time picker-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<!--date and time picker-->


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
   $("#search").on("keyup",function(key){         
		   if(key.keyCode==13) {
		      document.bbsForm.curPage.value = "1";
		      document.bbsForm.searchValue.value = $("#search").val();
		      document.bbsForm.action = "/reservation/list";
		      document.bbsForm.submit();
		   }
	   });
	   
});

</script>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  
  <!-- ======= reservations Section ======= -->
  <section id="reservation" class="reservation">
    <div class="reservation-container container" data-aos="fade-up">
      <div class="reservation-slider swiper" data-aos="fade-up" data-aos-delay="100">
        <container>
          <hr role="tournament2">
        </container>
        <h2><strong>< 오늘의 추천식당 ></strong></h2>
        <container>
          <hr role="tournament2">
        </container>
        <div></div>
        <div class="swiper-wrapper">
          <div class="swiper-slide">
            <div class="row reservation-item">
              <div class="col-lg-6">
                <img src="assets/img/파인다이닝.jpg" class="img-fluid" alt="">
              </div>
              <div class="col-lg-6 pt-4 pt-lg-0 content">
                <h3>empty plate식당</h3>
                <div class="price">
                  <p><span>₩100.0</span></p>
                </div>
                <p class="fst-italic">
                  귀한 재료와 정성의 손길로 빚어내는 아름다움 empty plate의 고유함을 지니며, 현재를 반영한 '우리 한식상'을 선보입니다. 전통과 현대를 유연히 그리고 다채롭게 표현하는 한식의 모습들을 경험하세요.
                </p>
                <ul>
                  <li><i class="fa-solid fa-map-location-dot"></i> 인천 구월동</li>
                  <li><i class="fa-regular fa-star"></i> 별점 4.5 (100)</li>
                </ul>
                <p class="int">
                  <i class="fa-brands fa-instagram"></i> #파인다이닝 #한식 #인기많은 #인천 #구월동
                </p>
              </div>
            </div>
          </div>
          <!-- End testimonial item -->
          
          <div class="swiper-slide">
            <div class="row reservation-item">
              <div class="col-lg-6">
                <img src="assets/img/오마카세.jpg" class="img-fluid" alt="">
              </div>
              <div class="col-lg-6 pt-4 pt-lg-0 content">
                <h3>오마카세 식당</h3>
                <div class="price">
                  <p><span>₩60.0</span></p>
                </div>
                <p class="fst-italic">
                  오마카세 식당은 오마카세 입문으로 좋은, 최고의 가성비 오마카세를 추구합니다. 10년 이상의 경력을 지닌 일식 셰프가 조용하고 아담한 다찌 구조의 오마카세에서 손님을 정성껏 대접합니다.
                </p>
                <ul>
                  <li><i class="fa-solid fa-map-location-dot"></i> 인천 청라</li>
                  <li><i class="fa-regular fa-star"></i> 별점 4.3 (500)</li>
                </ul>
                <p class="int">
                  <i class="fa-brands fa-instagram"></i> #오마카세 #스시 #리뷰많은 #인천 #청라
                </p>
              </div>
            </div>
          </div>
          <!-- End testimonial item -->

          <div class="swiper-slide">
            <div class="row reservation-item">
              <div class="col-lg-6">
                <img src="assets/img/카페.jpg" class="img-fluid" alt="">
              </div>
              <div class="col-lg-6 pt-4 pt-lg-0 content">
                <h3>커피바</h3>
                <div class="price">
                  <p><span>₩30.0</span></p>
                </div>
                <p class="fst-italic">
                  단순 커피를 넘어 고객이 원하는 맛과 향을 선택할 수 있는 커피 페어링 코스를 통해 다양한 커피를 느껴보세요. 이제 커피바에서 커피 페어링 코스를 경험해보시기 바랍니다.
                </p>
                <ul>
                  <li><i class="fa-solid fa-map-location-dot"></i> 인천 학익동</li>
                  <li><i class="fa-regular fa-star"></i> 별점 5.0 (80)</li>
                </ul>
                <p class="int">
                  <i class="fa-brands fa-instagram"></i> #커피 #디저트 #별점높은 #인천 #학익동
                </p>
              </div>
            </div>
          </div>
          <!-- End testimonial item -->

          <div class="swiper-slide">
            <div class="row reservation-item">
              <div class="col-lg-6">
                <img src="assets/img/카페.jpg" class="img-fluid" alt="">
              </div>
              <div class="col-lg-6 pt-4 pt-lg-0 content">
                <h3>커피바</h3>
                <div class="price">
                  <p><span>₩30.0</span></p>
                </div>
                <p class="fst-italic">
                  단순 커피를 넘어 고객이 원하는 맛과 향을 선택할 수 있는 커피 페어링 코스를 통해 다양한 커피를 느껴보세요. 이제 커피바에서 커피 페어링 코스를 경험해보시기 바랍니다.
                </p>
                <ul>
                  <li><i class="fa-solid fa-map-location-dot"></i> 인천 학익동</li>
                  <li><i class="fa-regular fa-star"></i> 별점 5.0 (80)</li>
                </ul>
                <p class="int">
                  <i class="fa-brands fa-instagram"></i> #커피 #디저트 #별점높은 #인천 #학익동
                </p>
              </div>
            </div>
          </div>
          <!-- End testimonial item -->

          <div class="swiper-slide">
            <div class="row reservation-item">
              <div class="col-lg-6">
                <img src="assets/img/카페.jpg" class="img-fluid" alt="">
              </div>
              <div class="col-lg-6 pt-4 pt-lg-0 content">
                <h3>커피바</h3>
                <div class="price">
                  <p><span>₩30.0</span></p>
                </div>
                <p class="fst-italic">
                  단순 커피를 넘어 고객이 원하는 맛과 향을 선택할 수 있는 커피 페어링 코스를 통해 다양한 커피를 느껴보세요. 이제 커피바에서 커피 페어링 코스를 경험해보시기 바랍니다.
                </p>
                <ul>
                  <li><i class="fa-solid fa-map-location-dot"></i> 인천 학익동</li>
                  <li><i class="fa-regular fa-star"></i> 별점 5.0 (80)</li>
                </ul>
                <p class="int">
                  <i class="fa-brands fa-instagram"></i> #커피 #디저트 #별점높은 #인천 #학익동
                </p>
              </div>
            </div>
          </div>
          <!-- End testimonial item -->
        </div>

        <div class="swiper-pagination"></div>

        <!--메뉴-->
        <div class="row">
          <div class="col-12">
          <table class="table table-image">
            <thead>
              <tr  style="color: #fff">
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
              </tr>
            </thead>
            <container>
              <hr role="tournament2">
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
              </div> 
              <script src="/resources/datepicker/date_picker.js"></script>
              <!--datepicker--> 
                &nbsp;&nbsp;&nbsp;
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul class="navbar-nav me-auto ">
                      <select class="select" aria-label="Default select example" style="width: 150px; height: 35px;">
                        <option value="0" selected style="width: 150px; height: 35px;" selected <c:if test="${searchType eq '0'}">selected</c:if>>전체</option>
                        <option value="1" style="width: 150px; height: 35px;"  <c:if test="${searchType eq '1'}">selected</c:if>>파인다이닝</option>
                        <option value="2" style="width: 150px; height: 35px;"  <c:if test="${searchType eq '2'}">selected</c:if>>오마카세</option>
                      </select>
                  </ul>
                </form>
              
                  
                    <input type="text" name="text" id="search" <c:if test="${searchValue ne null and searchValue ne ''}">value="${searchValue}"</c:if>>
                    <button class="btn" type="submit" id="searchBtn">검색</button>

             
                </div>
              </div>
            </nav>
            <div>
              
            </div>
            <tbody class="menutable">
            <c:if test="${!empty list}">
            <c:forEach items="${list}" var="shop" varStatus="status">
              <tr onClick="location.href='/reservation/view'">
                <th scope="row">${status.count}</th>
                <td class="w-25">
                <fmt:setBundle var="SHOP_UPLOAD_IMAGE_DIR" basename="shop.upload.image.dir"></fmt:setBundle>
                  <img src="" class="img-fluid img-thumbnail" alt="Sheep">
                </td>
                <td>
                	<c:out value="${shop.shopName}" />
                	<c:if test="${shop.shopType ne null}">
                		<c:choose>
                			<c:when test='${shop.shopType eq "1"}'>
                				<br />
                				<p>파인다이닝</p>
                			</c:when>
                			<c:when test='${shop.shopType eq "2"}'>
                				<br />
                				<p>오마카세</p>
                			</c:when>
                		</c:choose>
                	</c:if>
                </td>
                <td>
                	<c:out value="${shop.shopHashtag}" />
                </td>
                <td>
                	<c:out value="${shop.shopIntro}" />
                </td>
                <td>
                	<c:out value="${shop.shopLocation1}" />
                	<c:out value="${shop.shopLocation2}" />
                	<c:out value="${shop.shopLocation3}" />
                	<c:out value="${shop.shopAddress}" />
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
            <input type="hidden" name="searchType" value="${searchType}"/>
            <input type="hidden" name="searchValue" value="${searchValue}" />
            <input type="hidden" name="curPage" value="${curPage}" />
            </form>
    </div>

  </section>
  <!-- End reservation Section -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
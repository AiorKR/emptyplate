<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 1);

%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
			$("#btnReserve").on("click", function(){
				document.bbsForm.shopUID.value = $("#btnReserve").val();
				document.bbsForm.action = "/reservation/view";
				document.bbsForm.submit();
			   });
		});
	</script>
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start" data-aos="zoom-in" data-aos-delay="100">
      <div class="row">
        <div class="col-lg-8">
          <h1>Welcome to <span>Empty Plate</span></h1>
          <h2>For your beautiful day!</h2>

          <div class="btns">
            <a href="#recommend" class="btn-book animated fadeInUp scrollto">Recommend</a>
          </div>
        </div>
        <!--
          <div class="col-lg-4 d-flex align-items-center justify-content-center position-relative" data-aos="zoom-in" data-aos-delay="200">
            <a href="https://www.youtube.com/watch?v=u6BOC7CDUTQ" class="glightbox play-btn"></a>
          </div>
        -->
      </div>
    </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= Recommend Section ======= -->
    <section id="recommend" class="recommend">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Recommend</h2>
          <p>오늘의 추천 식당</p>
        </div>

        <div class="recommend-slider swiper" data-aos="fade-up" data-aos-delay="100">
          <div class="swiper-wrapper">
				<c:forEach var="shop" items="${recommand}" varStatus="status">
			<div class="swiper-slide">
					<div class="row recommend-item">
						<div class="col-lg-6">
							<img alt="" src="/resources/upload/shop/${shop.shopUID}/${shop.shopFile.shopFileName}" class="img-fluid" alt="">
						</div>
						<div class="col-lg-6 pt-4 pt-lg-0 content">
							<h3>${shop.shopName}</h3>
							<p class="fst-italic">${shop.shopIntro}</p>
							<ul>
								<li><i class="fa-solid fa-map-location-dot"></i> ${shop.shopLocation2} ${shop.shopLocation3}</li>
								<li><i class="fa-regular fa-star"></i> 별점 ${shop.shopStarScore} (100)</li>
							</ul>
							<p class="int">
								<i class="fa-brands fa-instagram"></i> ${shop.shopHashtag}
							</p>
							<div class="btns">
								<button type="button" id="btnReserve" class="btn-book animated fadeInUp scrollto" value="${shop.shopUID}">예약</button>
							</div>
						</div>
					</div>
			</div><!-- End testimonial item -->
				</c:forEach>

          </div>
          <div class="swiper-pagination"></div>
        </div>

      </div>
    </section><!-- End Recommend Section -->

    <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>TODAY</h2>
          <p>당일예약상품</p>
        </div>

        <div class="row">

          <div class="col-lg-4">
            <div class="box" data-aos="zoom-in" data-aos-delay="0">
              <img src="/resources/images/1.png" class="img-fluid" alt="">
              <span>스시 코우지</span>
              <h4>서울 강남구</h4>
              <h5>#스시오마카세 #콜키지 #노키즈존</h5>
              <p>도쿄 미슐랭 레스토랑 출신 셰프가 선보이는 하이엔드 오마카세</p>
              <h6>★ 4.8</h6>
            </div>
          </div>

          <div class="col-lg-4 mt-4 mt-lg-0">
            <div class="box" data-aos="zoom-in" data-aos-delay="0">
              <img src="/resources/images/2.png" class="img-fluid" alt="">
              <span>CHOI.</span>
              <h4>서울 강남구</h4>
              <h5>#이탈리안 #콜키지 #노키즈존 #레터링</h5>
              <p>최현석 셰프의 독창적인 요리를 즐길 수 있는 이탈리안 파인 다이닝</p>
              <h6>★ 4.8</h6>
            </div>
          </div>

          <div class="col-lg-4 mt-4 mt-lg-0">
            <div class="box" data-aos="zoom-in" data-aos-delay="300">
              <img src="/resources/images/3.png" class="img-fluid" alt="">
              <span>스시 카나에</span>
              <h4>서울 강남구</h4>
              <h5>#스시오마카세 #콜키지 #런치 #디너</h5>
              <p>청담동 김장환 셰프가 선보이는 숙성 스시 오마카세</p>
              <h6>★ 4.6</h6>
            </div>
          </div>
								 
      </div>
      <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="shopUID" value=""/> 
	 </form>
    </section><!-- End About Section -->
  </main><!-- End #main -->

  

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
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

            <div class="swiper-slide">
              <div class="row recommend-item">
                <div class="col-lg-6">
                  <img src="/resources/images/파인다이닝.jpg" class="img-fluid" alt="">
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
                  <div class="btns">
                    <a href="#reservation" class="btn-book animated fadeInUp scrollto">예약</a>
                  </div>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="row recommend-item">
                <div class="col-lg-6">
                  <img src="/resources/images/오마카세.jpg" class="img-fluid" alt="">
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
                  <div class="btns">
                    <a href="#reservation" class="btn-book animated fadeInUp scrollto">예약</a>
                  </div>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="row recommend-item">
                <div class="col-lg-6">
                  <img src="/resources/img/카페.jpg" class="img-fluid" alt="">
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
                  <div class="btns">
                    <a href="#reservation" class="btn-book animated fadeInUp scrollto">예약</a>
                  </div>
                </div>
              </div>
            </div><!-- End testimonial item -->

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
    </section><!-- End About Section -->
  </main><!-- End #main -->

  

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
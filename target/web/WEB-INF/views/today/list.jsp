<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  
  
  <!-- ======= Today Section ======= -->
  <section id="today" class="today">
    <div class="today-container container" data-aos="fade-up">
      <div class="today-slider swiper" data-aos="fade-up" data-aos-delay="100">
        <container>
          <hr role="tournament2">
        </container>
        <h2><strong>< 오늘 마감 ></strong></h2>
        <container>
          <hr role="tournament2">
        </container>
        <!--메뉴-->
        <div class="row">
          <div class="col-12">
          <table class="table table-image">
            
            <nav class="navbar navbar-expand-lg navbar-light bg-translucent">
              <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <form>
                &nbsp;&nbsp;&nbsp;
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul class="navbar-nav me-auto mb-2 mb-tr-0">
                      <select class="form-select" aria-label="Default select example" style="width: 150px; height: 35px;">
                        <option value="0" selected style="width: 150px; height: 35px;">전체</option>
                        <option value="1" style="width: 150px; height: 35px;">오마카세</option>
                        <option value="2" style="width: 150px; height: 35px;">파인다이닝</option>
                      </select>
                  </ul>
                </form>
              </form>
              
                  
              <input type="text" name="text">
              <button class="btn" type="submit">검색</button>

              
                </div>
              </div>
            </nav>
            <div>
              
            </div>
            <tbody class="menutable">
              <tr>
                <th scope="row">
                <td>
                    <div class="card" onClick="location.href='#'">
                        <img src="/resources/images/1.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/2.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름    </h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/3.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
              </tr>
              <tr>
                <th scope="row">
                <td>
                    <div class="card" onClick="location.href='#'">
                        <img src="/resources/images/1.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/2.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름    </h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/3.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
              </tr>
              <tr>
                <th scope="row">
                <td>
                    <div class="card" onClick="location.href='#'">
                        <img src="/resources/images/1.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/2.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름    </h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
                <td>
                    <div class="card"  onClick="location.href='#'">
                        <img src="/resources/images/3.png" class="card-img-top" alt="">
                        <div class="card-body">
                          <h5 class="card-title">Today 매장 이름</h5>
                          <div class="sec7-text-box">
                            <p class="font15 time-end1">예약시간</p>
                            <p class="font15 time-title1">Today 마감까지</p>
                            <div class="time font20">
                              <span class="hours"></span>
                              <span class="col">:</span>
                              <span class="minutes"></span>
                              <span class="col">:</span>
                              <span class="seconds"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                </td>
              </tr>
            </tbody>
          </table>   
          </div>
        </div>
      </div>

    </div>
  </section>
  <!-- End today Section -->

  <!--count down-->
  <script src="./assets/countdown/countdown.js"></script>
  <!--count down-->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
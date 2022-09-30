<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="aboutus2" class="aboutus2">
    <div class="container">
        <div class="row">
            <div class="nav nav-pills nav-justified" id="pills-tab" role="tablist">
                <li class="nav-item" >
                  <a href="/footer/aboutUs">
                  	<button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button">AboutUS</button>
                  </a>	
                </li>
                <li class="nav-item">
                  <a href="/footer/company">
                   <button class="nav-link active" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button">Company</button>
                  </a> 
                </li>
                <li class="nav-item">
                  <a href="/footer/logoHistory">
                  	<button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button">Logo History</button>
                  </a>	
                </li>                
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <div class="content">
                        <h3>Company</h3>
                        <p class="">
                          EmptyPlate는 실시간 온라인 예약 서비스로서 기다림 없는 실시간 온라인 예약 서비스를 통해 예약 편의성과 신규고객 유치까지 책임집니다!
                          <br>
                          고객은 검색을 통해 날짜, 시간, 인원 등 원하는 조건으로 검색이 가능하며 실시간 예약을 진행할 수 있습니다.
                        </p>
                      
                    </div>
                    <div class="content">
                        <h3>History</h3>
                        <p class="">
                            <div>
                                <h5>2020</h5>
                            </div>
                            <div>
                            2 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작                       
                            <br>
                            8 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작
                            <br>  
                            10 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작                       
                            <br>
                            11 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작  
                            </div>  
                        </p>
                        <p class="">
                            <div>
                                <h5>2021</h5>
                            </div>
                            <div>
                                3 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작                       
                                <br>
                                6 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작
                            </div>  
                        </p>
                        <p class="">
                            <div>
                                <h5>2022</h5>
                            </div>
                            <div>
                                1 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작                       
                                <br>
                                3 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작
                                <br>  
                                5 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작                       
                                <br>
                                7 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스시작  
                            </div>  
                        </p>
                    </div>
                </div>
            </div>    
                
        </div>
                
    </div>
        

        <div class="swiper-pagination"></div>
   
</section>
  <!-- End aboutus2 Section -->
 
    
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
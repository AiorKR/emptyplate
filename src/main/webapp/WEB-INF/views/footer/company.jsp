<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="company" class="company">
    <div class="container">
        <div class="row">
            <div class="nav nav-pills nav-justified" id="pills-tab" role="tablist">
                <li class="nav-item" >
                  <a href="/footer/aboutus">
                  	<button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button">AboutUS</button>
                  </a>	
                </li>
                <li class="nav-item">
                  <a href="/footer/company">
                   <button class="nav-link active" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button">Company</button>
                  </a> 
                </li>
                <li class="nav-item">
                  <a href="/footer/logohistory">
                  	<button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button">Logo History</button>
                  </a>	
                </li>                
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <div class="content">
                        <h3 class="title">Company</h3>
                        <hr>
                        <p class="info">
                        	EmptyPlate는 실시간 온라인 예약 서비스로서 기다림 없는 실시간 온라인 예약 서비스를 통해 예약 편의성과 신규고객 유치까지 책임집니다!
                          	<br>
                        	고객은 검색을 통해 날짜, 시간, 인원, 해시태그 등 원하는 조건으로 검색이 가능하며 실시간 예약을 진행할 수 있습니다.
                        </p>
                      
                    </div>
                    <div class="content2">
                        <h3 class="title">History</h3>
                        <hr>
                        <p>
                            <div class="year">
                                <p>2022년</p>
                            </div>
                            <div class="plan">                   
                                6월 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 계획 <br/>
                                7월 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 사이트 제작 <br/>
                                8월 &nbsp;&nbsp;&nbsp;&nbsp; EmptyPlate 서비스 시작  
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
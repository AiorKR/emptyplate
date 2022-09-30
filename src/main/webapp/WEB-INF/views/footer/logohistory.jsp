<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="aboutus3" class="aboutus3">
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
                   <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button">Company</button>
                  </a> 
                </li>
                <li class="nav-item">
                  <a href="/footer/logoHistory">
                  	<button class="nav-link active" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button">Logo History</button>
                  </a>	
                </li>                
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                    <h3>Logo History</h3>
                    <div class="current-logo">
                        <div class="thumb">
                            <img src="../resources/images/로고.png" width="200" height="200">
                        </div>
                        <div class="content-wrap">
                            <div class="image-info">
                                <span class="date">2022.10.01</span>
                                <span class="designer">Kim yee seul</span>
                            </div>    
                        </div>
                    </div>
                        
                    <ul class="logo-list">
                        <td>
                            <div class="thumb">
                                <img src="../resources/images/apple-touch-icon.png" width="120" height="120">                                    
                            </div>                                
                            <div class="content-wrap">
                                <div class="image-info">
                                    <span class="date">2022.08.07</span>
                                    <span class="designer">Kim yong chan</span>
                                </div>                                    
                            </div>
                        <td>
                        <td>
                            <div class="thumb">
                                <img src="../resources/images/favicon.png" width="120" height="120">
                            </div>
                            <div class="content-wrap">
                                <div class="image-info">
                                    <span class="date">2022.07.07</span>
                                    <span class="designer">Jung soo hyeon</span>
                                </div>    
                            </div>
                        <td>    
                    </ul>   
                </div>
            </div>   
        </div>
        

        <div class="swiper-pagination"></div>

    </div>
</section>
  <!-- End aboutus2 Section -->
 
         
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
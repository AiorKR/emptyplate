<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
<!-- ======= Top Bar ======= -->
<div id="topbar" class="d-flex align-items-center fixed-top">
	<div class="container d-flex justify-content-center justify-content-md-between">
	  <div class="contact-info d-flex align-items-center">
	</div>
	<div class="log d-none d-md-flex align-items-center">
	  <ul>
		<li><a href="/user/loginOut">LogOut</a></li>
		<li><a href="/myPage/myProfile">My Page</a></li>
	  </ul>
	</div>
  </div>
</div>
<%
	}
	else
	{
%>
<!-- ======= Top Bar ======= -->
<div id="topbar" class="d-flex align-items-center fixed-top">
	<div class="container d-flex justify-content-center justify-content-md-between">
	  <div class="contact-info d-flex align-items-center">
	</div>
	<div class="log d-none d-md-flex align-items-center">
	  <ul>
		<li><a href="/user/login">Login</a></li>
		<li><a href="/user/joinUs">Join Us</a></li>
	  </ul>
	</div>
  </div>
</div>
<%
	}
%>
<!-- ======= Header ======= -->
<header id="header" class="fixed-top d-flex align-items-cente">
  <div class="container-fluid container-xl d-flex align-items-center justify-content-lg-between">

	<a href="/index" class="logo me-auto me-lg-0"><img src="/resources/images/로고.png" width="80" height="60" alt="" class="img-fluid"></a>
	<!--<h1 class="logo me-auto me-lg-0"><a href="index.html">Empty Plate</a></h1>-->
	<!-- Uncomment below if you prefer to use an image logo -->
	<nav id="navbar" class="navbar order-last order-lg-0">
	  <ul>
		<li><a class="nav-link scrollto <c:if test="${No == 1}"> active</c:if>" href="/index">Home</a></li>
		<li><a class="nav-link scrollto <c:if test="${No == 2}"> active</c:if>" href="/reservation/list">Reservation</a></li>
		<li><a class="nav-link scrollto <c:if test="${No == 3}"> active</c:if>" href="/today/list">Today</a></li> 
		<li><a class="nav-link scrollto <c:if test="${No == 4}"> active</c:if>" href="/board/list">Community</a></li>
		<li><a class="nav-link scrollto <c:if test="${No == 5}"> active</c:if>" href="/help/index">Help</a></li>
		<li><a class="nav-link scrollto <c:if test="${No == 6}"> active</c:if>" href="/kakao/pay">pay</a></li>
	  </ul>
	  <i class="bi bi-list mobile-nav-toggle"></i>
	</nav><!-- .navbar -->
	<!--<a href="#book-a-table" class="book-a-table-btn scrollto d-none d-lg-flex">Book a table</a>-->

	<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
<nav id="navbar" class="navbar order-last order-lg-0">
	<ul>
	  <li class="dropdown"><a href="#">${cookieUserNick} 님<i class="bi bi-chevron-down"></i></a>
		<ul>
		  <li><a href="/myPage/myProfile">내 프로필</a></li>
		  <li><a href="/myPage/rList">예약내역</a></li>
		  <li><a href="/myPage/myFavorites">즐겨찾기</a></li>
		  <li><a href="#">고객센터</a></li>
		  <li><a href="/user/loginOut">로그아웃</a></li>
		</ul>
	  </li>
	<i class="bi bi-list mobile-nav-toggle"></i>
  </nav><!-- .navbar -->  
  </header><!-- End Header -->
<%
	}
	else
	{
%>
<nav id="navbar" class="navbar order-last order-lg-0">
	<ul>
	  <li class="dropdown"><a href="#">로그인<i class="bi bi-chevron-down"></i></a>
		<ul>
		  <li><a href="/user/login">로그인</a></li>
		  <li><a href="/user/joinUs">회원가입</a></li>
		  <li><a href="#">고객센터</a></li>
		</ul>
	  </li>
	<i class="bi bi-list mobile-nav-toggle"></i>
  </nav><!-- .navbar -->  
  </header><!-- End Header -->
<%
	}
%>
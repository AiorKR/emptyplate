<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 5);
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 
  <!-- ======= help Section ======= -->
  <section id="help" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start" data-aos="zoom-in" data-aos-delay="100">
      <div class="row">
        <div class="col-lg-12">
          <div id = "notice">
            <h3>공지사항</h3>
            <h4><a href ="helpList.html">공지사항 모두보기<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <ul id="soloTable">
                <a href="helpView.html">
                  <li id = "tableFirst">
                    <span id="soloTitle">제목1</span><br>
                    <span id="solocontent">내용1</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목2</span><br>
                    <span id="solocontent">내용2</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목3</span><br>
                    <span id="solocontent">내용3</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li id = "tableLast">
                    <span id="soloTitle">제목4</span><br>
                    <span id="solocontent">내용4</span>
                  </li>
                </a>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-lg-12">
          <div id = "faq">
            <h3>FAQ</h3>
            <h4><a href ="helpList.html">FAQ 모두보기<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <ul id="soloTable">
                <a href="helpView.html">
                  <li id = "tableFirst">
                    <span id="soloTitle">제목1</span><br>
                    <span id="solocontent">내용1</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목2</span><br>
                    <span id="solocontent">내용2</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목3</span><br>
                    <span id="solocontent">내용3</span>
                  </li>
                </a>
                <a href="helpView.html">
                <li id = "tableLast">
                    <span id="soloTitle">제목4</span><br>
                    <span id="solocontent">내용4</span>
                  </li>
                </a>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-lg-12">
          <div id = "personal">
            <h3>개인회원</h3>
            <h4><a href ="helpList.html">개인회원 전체 도움말<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <ul id="soloTable">
                <a href="helpView.html">
                  <li id = "tableFirst">
                    <span id="soloTitle">제목1</span><br>
                    <span id="solocontent">내용1</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목2</span><br>
                    <span id="solocontent">내용2</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목3</span><br>
                    <span id="solocontent">내용3</span>
                  </li>
                </a>
                <a href="helpView.html">
                <li id = "tableLast">
                    <span id="soloTitle">제목4</span><br>
                    <span id="solocontent">내용4</span>
                  </li>
                </a>
              </ul>
            </div>
          </div>
          <div id = "enterprise">
            <h3>기업회원</h3>
            <h4><a href ="helpList.html">기업회원 전체 도움말<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <ul id="soloTable">
                <a href="helpView.html">
                  <li id = "tableFirst">
                    <span id="soloTitle">제목1</span><br>
                    <span id="solocontent">내용1</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목2</span><br>
                    <span id="solocontent">내용2</span>
                  </li>
                </a>
                <a href="helpView.html">
                  <li>
                    <span id="soloTitle">제목3</span><br>
                    <span id="solocontent">내용3</span>
                  </li>
                </a>
                <a href="helpView.html">
                <li id = "tableLast">
                    <span id="soloTitle">제목4</span><br>
                    <span id="solocontent">내용4</span>
                  </li>
                </a>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section><!-- End help -->
 
  <main id="main">
 
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
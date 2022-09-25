<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// help 번호
	request.setAttribute("No", 5);

%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	
});
//모두보기 리스트 불러오기
function fn_helpList(bbsNo)
{
   document.helpListForm.bbsNo.value = bbsNo;
   document.helpListForm.action = "/help/helpList";
   document.helpListForm.submit();
}
//게시물 불러오기
function fn_view(bbsSeq)
{
	document.helpListForm.bbsSeq.value = bbsSeq;
	document.helpListForm.action = "/help/helpView";
	document.helpListForm.submit();
}

</script>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 
  <!-- ======= help Section ======= -->
  <section id="help" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start">
      <div class="row">
        <div class="col-lg-12">
          <div id = "notice">
            <h3>공지사항</h3>
            <h4 id ="_bbsNo" name="_bbsNo" value="1"><a class="page-link" onclick="fn_helpList(1)">공지사항 모두보기<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            	<div id="soloTableBorder">
    		        <c:if test="${!empty list1}">
    		        	<c:forEach var="board" items="${list1}" varStatus="status">
			              <ul id="soloTable">
			                <a href="javascript:void(0)" class="page-link" onclick="fn_view(${board.bbsSeq})">
			                <c:choose>
			                	<c:when test="${board.rNum eq '1'}">
			                		<c:choose>
			                			<c:when test="${listSize1 eq '1'}">
			                  				<li id = "tableFirst" style="border-bottom-left-radius: 1em; border-bottom-right-radius: 1em;">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li id = "tableFirst">
			                  			</c:otherwise>
			                  		</c:choose>
			                  	</c:when>
			                  	<c:when test="${board.rNum ne '1'}">
			                		<c:choose>
			                			<c:when test="${board.rNum eq listSize1}">
			                  				<li id = "tableLast">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li>
			                  			</c:otherwise>
		                  			</c:choose>
			                  	</c:when> 	
		                  	</c:choose>
			                    <span id="soloTitle">${board.bbsTitle}</span><br>
			                    <span id="solocontent">${board.bbsContent}</span>
			                  </li>
			                </a>
			              </ul>
			              </c:forEach>
		        	</c:if>
            </div>
          </div>
        </div>
        <div class="col-lg-12">
          <div id = "faq">
            <h3>FAQ</h3>
            <h4 id ="_bbsNo" name="_bbsNo" value="2"><a class="page-link" onclick="fn_helpList(2)">FAQ 모두보기<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <c:if test="${!empty list2}">
    		        	<c:forEach var="board" items="${list2}" varStatus="status">
			              <ul id="soloTable">
			                <a href="javascript:void(0)" class="page-link" onclick="fn_view(${board.bbsSeq})">
			                <c:choose>
			                	<c:when test="${board.rNum eq '1'}">
			                		<c:choose>
			                			<c:when test="${listSize2 eq '1'}">
			                  				<li id = "tableFirst" style="border-bottom-left-radius: 1em; border-bottom-right-radius: 1em;">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li id = "tableFirst">
			                  			</c:otherwise>
			                  		</c:choose>
			                  	</c:when>
			                  	<c:when test="${board.rNum ne '1'}">
			                		<c:choose>
			                			<c:when test="${board.rNum eq listSize2}">
			                  				<li id = "tableLast">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li>
			                  			</c:otherwise>
		                  			</c:choose>
			                  	</c:when> 	
		                  	</c:choose>
			                    <span id="soloTitle">${board.bbsTitle}</span><br>
			                    <span id="solocontent">${board.bbsContent}</span>
			                  </li>
			                </a>
			              </ul>
			              </c:forEach>
		        	</c:if>
            </div>
          </div>
        </div>
        <div class="col-lg-12">
          <div id = "personal">
            <h3>개인회원</h3>
            <h4 id ="_bbsNo" name="_bbsNo" value="3"><a class="page-link" onclick="fn_helpList(3)">개인회원 전체 도움말<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <c:if test="${!empty list3}">
    		        	<c:forEach var="board" items="${list3}" varStatus="status">
			              <ul id="soloTable">
			                <a href="javascript:void(0)" class="page-link" onclick="fn_view(${board.bbsSeq})">
			                <c:choose>
			                	<c:when test="${board.rNum eq '1'}">
			                		<c:choose>
			                			<c:when test="${listSize3 eq '1'}">
			                  				<li id = "tableFirst" style="border-bottom-left-radius: 1em; border-bottom-right-radius: 1em;">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li id = "tableFirst">
			                  			</c:otherwise>
			                  		</c:choose>
			                  	</c:when>
			                  	<c:when test="${board.rNum ne '1'}">
			                		<c:choose>
			                			<c:when test="${board.rNum eq listSize3}">
			                  				<li id = "tableLast">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li>
			                  			</c:otherwise>
		                  			</c:choose>
			                  	</c:when> 	
		                  	</c:choose>
			                    <span id="soloTitle">${board.bbsTitle}</span><br>
			                    <span id="solocontent">${board.bbsContent}</span>
			                  </li>
			                </a>
			              </ul>
			              </c:forEach>
		        	</c:if>
            </div>
          </div>
          <div id = "enterprise">
            <h3>기업회원</h3>
            <h4 id ="_bbsNo" name="_bbsNo" value="4"><a class="page-link" onclick="fn_helpList(4)">기업회원 전체 도움말<ion-icon name="arrow-forward-outline"></ion-icon></a></h4>
            <div id="soloTableBorder">
              <c:if test="${!empty list1}">
    		        	<c:forEach var="board" items="${list4}" varStatus="status">
			              <ul id="soloTable">
			                <a href="javascript:void(0)" class="page-link" onclick="fn_view(${board.bbsSeq})">
			                <c:choose>
			                	<c:when test="${board.rNum eq '1'}">
			                		<c:choose>
			                			<c:when test="${listSize4 eq '1'}">
			                  				<li id = "tableFirst" style="border-bottom-left-radius: 1em; border-bottom-right-radius: 1em;">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li id = "tableFirst">
			                  			</c:otherwise>
			                  		</c:choose>
			                  	</c:when>
			                  	<c:when test="${board.rNum ne '1'}">
			                		<c:choose>
			                			<c:when test="${board.rNum eq listSize4}">
			                  				<li id = "tableLast">
			                  			</c:when>
			                  			<c:otherwise>
			                  				<li>
			                  			</c:otherwise>
		                  			</c:choose>
			                  	</c:when> 	
		                  	</c:choose>
			                    <span id="soloTitle">${board.bbsTitle}</span><br>
			                    <span id="solocontent">${board.bbsContent}</span>
			                  </li>
			                </a>
			              </ul>
			              </c:forEach>
		        	</c:if>
            </div>
          </div>
        </div>
      </div>
		<form name="helpListForm" id="helpListForm" method="POST">
			<input type="hidden" name="bbsNo" value="" />
			<input type="hidden" name="bbsSeq" value="" />
		</form>
    </div>
  </section><!-- End help -->
 
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
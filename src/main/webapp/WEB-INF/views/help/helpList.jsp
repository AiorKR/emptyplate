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
<script type="text/javascript">
$(document).ready(function() {
    //하이보드컨트롤러로 이동
   $("#btnSearch").on("click", function() { 
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/help/helpList";
      document.bbsForm.submit();
   });
});

function fn_view(bbsSeq)
{
	document.helpListForm.bbsSeq.value = bbsSeq;
	document.helpListForm.action = "/help/helpView";
	document.helpListForm.submit();
}

function fn_list(curPage)
{
   document.helpListForm.bbsSeq.value = "";
   document.helpListForm.curPage.value = curPage;
   document.helpListForm.action = "/help/helpList";
   document.helpListForm.submit();   
}
</script>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <!-- ======= helpList Section ======= -->
  <section id="helpList" class="helpList">
    <div class="container">
      <div class = "row">
        <div class="help-name">
             <c:choose>
               <c:when test="${bbsNo eq '1'}">
                 <h3>공지사항</h3>
           	   </c:when>
           	   <c:when test="${bbsNo eq '2'}">
                 <h3>FAQ</h3>
           	   </c:when>
           	   <c:when test="${bbsNo eq '3'}">
                 <h3>개인회원</h3>
           	   </c:when>
               <c:otherwise>
                 <h3>기업회원</h3>
               </c:otherwise>
             </c:choose>
        </div>
          <div class="d-flex flex-row justify-content-between">
          <ul>
            <li><a href="#">최신글순</a></li>
            <li><a href="#">조회순</a></li>
          </ul>
          
          <div>
            <select class="select" aria-label="Default select example">
              <option value="0" selected>제목</option>
              <option value="1">내용</option>
            </select>
            <form action="" method="post">
              <input type="text" name="text"><input type="submit" value="검색">
            </form>
          </div>
        </div>
        
        <div class="board-content">
          <table>
            <tr>
              <th style="width:10%">번호</th>
              <th style="width:65%">제목</th>
              <th style="width:10%">조회수</th>
              <th style="width:15%">날짜</th>
            </tr>
            <c:if test="${!empty list}">
                <c:forEach var="board" items="${list}" varStatus="status">
                  <tr>
                    <td>${board.rNum}</td>
                    <td><a href="javascript:void(0)" onclick="fn_view(${board.bbsSeq})">${board.bbsTitle}</a></td>
                    <td>${board.bbsReadCnt}</td>
                    <td>${board.regDate}</td>
                  </tr>
                </c:forEach>
           	  </c:if>
          </table>
        </div>        
        <div class="page-wrap">
         <ul class="page-nation">
           <c:if test="${paging.prevBlockPage gt 0}">
             <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"><</a></li>
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
               <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">></a></li>
           </c:if>
         </ul>
       </div>
     </div>
      </div>
	<form name="helpListForm" id="helpListForm" method="GET">
		<input type="hidden" name="bbsSeq" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
    </div>
  </section><!-- Community Hero -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
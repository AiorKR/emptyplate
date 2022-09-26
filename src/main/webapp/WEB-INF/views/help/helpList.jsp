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
      document.helpPageForm.bbsSeq.value = "";
      document.helpPageForm.searchType.value = $("#_searchType").val();
      document.helpPageForm.searchValue.value = $("#_searchValue").val();
      document.helpPageForm.curPage.value = "1";
      document.helpPageForm.action = "/help/helpList";
      document.helpPageForm.submit();
   });
 //글쓰기
   $("#btnWrite").on("click", function() {     
      document.helpPageForm.bbsSeq.value = "";
      document.helpPageForm.action = "/help/helpWriteForm";
      document.helpPageForm.submit();
   });
 
   //검색
   $("#btnSearch").on("click", function() { 
      document.helpPageForm.bbsSeq.value = "";
      document.helpPageForm.bbsNo.value=$("#btnSearch").val();
      document.helpPageForm.searchType.value = $("#_searchType").val();
      document.helpPageForm.searchValue.value = $("#_searchValue").val();
      document.helpPageForm.curPage.value = "1";
      document.helpPageForm.action = "/help/helpList";
      document.helpPageForm.submit();
   });
   
   //최신순
   $("#btnSort1").on("click", function() { 
	      document.helpPageForm.bbsSeq.value = "";
	      document.helpPageForm.searchType.value = $("#_searchType").val();
	      document.helpPageForm.searchValue.value = $("#_searchValue").val();
	      document.helpPageForm.sortValue.value = $("#btnSort1").val();
	      document.helpPageForm.curPage.value = "1";
	      document.helpPageForm.action = "/help/helpList";
	      document.helpPageForm.submit();
   });
   
   //조회순
   $("#btnSort3").on("click", function() { 
         document.helpPageForm.bbsSeq.value = "";
         document.helpPageForm.searchType.value = $("#_searchType").val();
         document.helpPageForm.searchValue.value = $("#_searchValue").val();
         document.helpPageForm.sortValue.value = "6";
         document.helpPageForm.curPage.value = "1";
         document.helpPageForm.action = "/help/helpList";
         document.helpPageForm.submit();
      });
   
 //인덱스
   $("#btnIndex").on("click", function() {
      document.helpPageForm.action = "/help/index";
      document.helpPageForm.submit();
   });

});

function fn_view(bbsSeq)
{
	document.helpPageForm.bbsSeq.value = bbsSeq;
	document.helpPageForm.action = "/help/helpView";
	document.helpPageForm.submit();
}

function fn_list(curPage)
{
	document.helpPageForm.bbsSeq.value = "";
   	document.helpPageForm.curPage.value = curPage;
   	document.helpPageForm.action = "/help/helpList";
   	document.helpPageForm.submit();   
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
            <li><button type="button" value="4" id="btnSort1" class="btnSort">최신순</button></li>
			<li><button type="button" value="6" id="btnSort3" class="btnSort">조회순</button></li>
          </ul>
          
          <div>
            <select class="select" id="_searchType" aria-label="Default select example">
				<option value="">검색항목</option>
				<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option>
				<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>제목</option>
				<option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
			</select>
			<div class="search">
				<input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" />
				<button type="button" id="btnSearch" value="${bbsNo}">검색</button>
			</div>
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
        
			<div class="d-flex flex-row justify-content-between">
				<div class="board-list"><button type="button" id="btnIndex" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;메인</button></div>
				  
				<c:if test="${admin eq 'Y'}">
					<div class="text-center"><button id="btnWrite">글쓰기</button></div>
				</c:if>
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
			<!-- form name="helpViewForm" id="helpViewForm" method="GET">
				<input type="hidden" name="bbsSeq" value="" />
			</form -->
			<form name="helpPageForm" id="helpPageForm" method="POST">
				<input type="hidden" name="bbsSeq" value=""/>
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="sortValue" value="${sortValue}" />
				<input type="hidden" name="bbsNo" value="${bbsNo}" />
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
    	</div>
    </div>
  </section>
  <!-- Community Hero -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>
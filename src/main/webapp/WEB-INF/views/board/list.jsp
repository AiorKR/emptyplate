<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
   
   $("#btnWrite").on("click", function() {     
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.action = "/board/writeForm";
      document.bbsForm.submit();
   });
   
   $("#btnMark").on("click", function() {     
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.action = "/board/markList";
      document.bbsForm.submit();
   });

   $("#btnSearch").on("click", function() { 
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/board/list";
      document.bbsForm.submit();
   });
   $("#btnSort1").on("click", function() { 
	      document.bbsForm.bbsSeq.value = "";
	      document.bbsForm.searchType.value = $("#_searchType").val();
	      document.bbsForm.searchValue.value = $("#_searchValue").val();
	      document.bbsForm.sortValue.value = "4";
	      document.bbsForm.curPage.value = "1";
	      document.bbsForm.action = "/board/list";
	      document.bbsForm.submit();
   });
   $("#btnSort2").on("click", function() { 
         document.bbsForm.bbsSeq.value = "";
         document.bbsForm.searchType.value = $("#_searchType").val();
         document.bbsForm.searchValue.value = $("#_searchValue").val();
         document.bbsForm.sortValue.value = "5";
         document.bbsForm.curPage.value = "1";
         document.bbsForm.action = "/board/list";
         document.bbsForm.submit();
      });
   $("#btnSort3").on("click", function() { 
         document.bbsForm.bbsSeq.value = "";
         document.bbsForm.searchType.value = $("#_searchType").val();
         document.bbsForm.searchValue.value = $("#_searchValue").val();
         document.bbsForm.sortValue.value = "6";
         document.bbsForm.curPage.value = "1";
         document.bbsForm.action = "/board/list";
         document.bbsForm.submit();
      });
   
});

function fn_view(bbsSeq)
{
   document.bbsForm.bbsSeq.value = bbsSeq;
   document.bbsForm.action = "/board/view";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.bbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/board/list";
   document.bbsForm.submit();   
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="community" class="community">
   <div class="container">
     <div class = "row">
       <div class="community-slider swiper" data-aos-delay="100">
         <div class="swiper-wrapper">
           <div class="swiper-slide">
             <div class="row community-item">
               <div class="col-lg-12">
                 <table class="col-lg-12">
                  <div class="hotTitle">< 인기 많은 글 TOP4 ></div>
                   <c:if test="${!empty hotLikeList}">
                	<c:forEach var="board" items="${hotLikeList}" varStatus="status">
	                    <td><img alt="" class="img-thumbnail" src="../resources/upload/board/${board.boardFile.fileName}" onclick="fn_view(${board.bbsSeq})"></td>
	                </c:forEach>
	           	  </c:if>
                  </table>
                </div>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="row community-item">
                <div class="col-lg-12">
                 <table class="col-lg-12">
                  <div class="hotTitle">< 많이 찾는 글 TOP4 ></div>
                   <c:if test="${!empty hotReadList}">
                	<c:forEach var="board" items="${hotReadList}" varStatus="status">
	                    <td><img alt="" class="img-thumbnail" src="../resources/upload/board/${board.boardFile.fileName}" onclick="fn_view(${board.bbsSeq})"></td>
	                </c:forEach>
	           	  </c:if>
                 </table>
                </div>
              </div>
            </div>
          </div>
         <div class="swiper-pagination"></div>
       </div>
       
       <div class="d-flex flex-row justify-content-between">
         <div>
           <ul>
             <li><button type="button" value="4" id="btnSort1" onclick="location.href='/board/list?bbsNo=${search.bbsNo}&searchType=${searchType}&searchValue=${searchValue}&sortValue=4'" class="btnSort">최신순</button></li>
             <li><button type="button" value="5" id="btnSort2" onclick="location.href='/board/list?bbsNo=${search.bbsNo}&searchType=${searchType}&searchValue=${searchValue}&sortValue=5'" class="btnSort">좋아요순</button></li>
             <li><button type="button" value="6" id="btnSort3" onclick="location.href='/board/list?bbsNo=${search.bbsNo}&searchType=${searchType}&searchValue=${searchValue}&sortValue=6'" class="btnSort">조회순</button></li>
           </ul>
         </div>
         <div>
          <select class="select" id="_searchType" aria-label="Default select example">
            <option value="">검색항목</option>
            <option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option>
            <option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>제목</option>
            <option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
          </select>
   		  <div class="search">
            <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}"/>
            <button type="button" id="btnSearch">검색</button>
    	  </div>
         </div>
       </div>
       
       <div class="board-content">
         <table>
           <tr>
             <th style="width:10%">번호</th>
             <th colspan="2" style="width:10%">좋아요</th>
             <th style="width:45%">제목</th>
             <th style="width:10%">작성자</th>
             <th style="width:10%">조회수</th>
             <th style="width:15%">날짜</th>
           </tr>
                
           <c:if test="${!empty list}">
             <c:forEach var="board" items="${list}" varStatus="status">
               <tr>
                 <td>${board.rNum}</td>
                 <td><ion-icon name="heart"></ion-icon>&nbsp;</td>
                 <td class="likeNum">${board.bbsLikeCnt}</td>
                 <td><a href="javascript:void(0)" onclick="fn_view(${board.bbsSeq})">${board.bbsTitle}</a></td>
                 <td><a href="javascript:void(0)" onclick="fn_userList(${board.userUID})">${board.userNick}</a></td>
                 <td>${board.bbsReadCnt}</td>
                 <td>${board.regDate}</td>
               </tr>
             </c:forEach>
           </c:if>
         </table>
       </div>
       
       <div class="d-flex flex-row justify-content-between">
         <div class="text-center2"><button id="btnMark">내가 즐겨찾기한 글보기</button></div>
         <div class="text-center"><button id="btnWrite">글쓰기</button></div>
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
   
	<form name="bbsForm" id="bbsForm" method="post">
	 <input type="hidden" name="bbsSeq" value="" />
	 <input type="hidden" name="searchType" value="${searchType}" />
	 <input type="hidden" name="searchValue" value="${searchValue}" />
	 <input type="hidden" name="sortValue" value="${sortValue}" />
	 <input type="hidden" name="curPage" value="${curPage}" />
	 <input type="hidden" name="bbsNo" value="${bbsNo}" />
	</form>
   
   </div>
 </section>
   
 <!-- ======= Footer ======= -->
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
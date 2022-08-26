<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {

   $("#btnList").on("click", function() {
      document.bbsForm.action = "/board/list";
      document.bbsForm.submit();
   });   
/*
   $("#btnReply").on("click", function() {
      document.bbsForm.action = "/board/replyForm";
      document.bbsForm.submit();
   });
*/
   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/board/updateForm";
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function(){
      if(confirm("게시물을 삭제 하시겠습니까?") == true)
      {
         $.ajax({
            type:"POST",
            url:"/board/delete",
            data:{
               bbsSeq:<c:out value="${board.bbsSeq}" />
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
                 {
                  alert("게시물이 삭제되었습니다.");
                  location.href = "/board/list";
                 }
               else if(response.code == 400)
                 {
                  alert("파라미터 값이 올바르지 않습니다.");
                 }
               else if(response.code == 403)
                 {
                  alert("본인 글이 아니므로 삭제할 수 없습니다.");
                 }
               else if(response.code == 404)
                 {
                  alert("게시물을 찾을 수 없습니다.");
                  location.href = "/board/list";                  
                 }
               else if(response.code == -999)
                 {
                  alert("답변 게시물이 존재하여 삭제할 수 없습니다.");
                 }
               else
                 {
                  alert("게시물 삭제 중 오류가 발생하였습니다.");
                 }
            },
            error:function(xhr, status, error){
               icia.common.error(error);
            }
         });
      }
   });
});   
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="communityView" class="community">
   <div class="container">
     <div class = "row">
       <div class="board-title">
         <c:out value="${board.bbsTitle}" /><br/>
       </div>

       <div class="board-writer">
         <ion-icon name="person"></ion-icon> <a href="#"><c:out value="${board.userNick}"/></a> &nbsp;
         <ion-icon name="calendar"></ion-icon> ${board.regDate} &nbsp;
         <ion-icon name="eye"></ion-icon> ${board.bbsReadCnt}
       </div>

       <div class="board-innercontent">
         <col-lg-12>${board.bbsContent}</col-lg-12>
           <div>
           <c:if test="${boardMe eq 'Y'}">
              <div class="delete"><button type="button" id="btnDelete" class="delete">삭제</button></div>
              <div class="update"><button type="button" id="btnUpdate" class="update">수정</button></div>
           </c:if>
           </div>
           
           <div class="d-flex flex-row justify-content-center">
             <div class="like"><button type="button" id="btnLike" class="like"><ion-icon name="heart"></ion-icon>&nbsp;&nbsp;좋아요  <span class="likeCount">${board.bbsLikeCnt}</span></button></div>
             <div class="bookmark"><button type="button" id="btnBoomark" class="bookmark"><ion-icon name="star"></ion-icon>&nbsp;&nbsp;즐겨찾기</button></div>
           </div>
       </div>

       <div class="board-service">
         <div class="board-list"><button type="button" id="btnList" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;목록</button></div>
         <div class="report"><button><ion-icon name="alert-circle"></ion-icon>&nbsp;신고</button></div>
       </div>


       <div class="board-commentwrite">
         <col-lg-12><ion-icon name="chatbubbles"></ion-icon>댓글</col-lg-12>
         <div class="submit">
           <input type="text" name="text">
           <button type="submit" id="btnSearch">등록</button>
        </div>
       </div>

       <div class="comment">
         <div class="comment-write">
           <col-lg-12><ion-icon name="person"></ion-icon> ${board.userNick}</col-lg-12>
           <a href="#">신고</a>
           <a>${board.regDate}</a>
           <a href="#">댓글달기</a>
         </div>

         <div class="comment-content">
           <col-lg-12>댓글내용입니다. 댓글내용입니다.</col-lg-12>
         </div>
       </div>

       <div class="recomment">
         <div class="recomment-write">
           <col-lg-12><ion-icon name="return-down-forward" class="return"></ion-icon><ion-icon name="person" class="person"></ion-icon> ${board.userNick}</col-lg-12>
           <a href="#">신고</a>
           <a>${board.regDate}</a>
           <a href="#">댓글달기</a>
         </div>

         <div class="recomment-content">
           <col-lg-12>댓글내용입니다. 댓글내용입니다.</col-lg-12>
         </div>
       </div>

     </div>
     
    <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="bbsSeq" value="${bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
     <input type="hidden" name="bbsNo" value="${bbsNo}" />
    </form>

   </div> 
 </section>
  
  <!-- ======= Footer ======= -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
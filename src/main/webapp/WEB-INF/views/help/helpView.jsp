<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 5);

%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   //개행문자 값 저장
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
   //목록
   $("#btnList").on("click", function() {
	  document.bbsForm.bbsNo = bbsNo;
      document.bbsForm.action = "/help/helpList";
      document.bbsForm.submit();
   });   
   
   //게시물 수정
   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/board/updateForm";
      document.bbsForm.submit();
   });
   
   //게시물 삭제
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
               else
               {
                  alert("댓글이 존재하여 삭제할 수 없습니다.");
               }
            },
            error:function(xhr, status, error){
               icia.common.error(error);
            }
         });
      });

}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<section id="communityView" class="community">
		<div class="container">
			<div class = "row">
			<c:set var="bbsNo" value="${board.bbsNo}" />
				<div class="board-title">
					<c:out value="${board.bbsTitle}" /><br/>
				</div>
				<div class="board-writer">
					<ion-icon name="person"></ion-icon> ${board.userNick} &nbsp;
					<ion-icon name="calendar"></ion-icon> ${board.regDate} &nbsp;
					<ion-icon name="eye"></ion-icon><fmt:formatNumber type="number" maxFractionDigits="3" value="${board.bbsReadCnt}"/>
				</div>
				<div class="board-innercontent">
					<col-lg-12>${board.bbsContent}
					</col-lg-12>
					<div>
						<c:if test="${admin eq 'Y'}">
							<div class="delete"><button type="button" id="btnDelete" class="delete">삭제</button></div>
							<div class="update"><button type="button" id="btnUpdate" class="update">수정</button></div>
						</c:if>
					</div>
				</div>

				<div class="board-service">
				  <div class="board-list"><button type="button" id="btnList" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;목록</button></div>
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
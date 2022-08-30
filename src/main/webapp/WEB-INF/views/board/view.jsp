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
   
   $("#btnLike").on("click", function(){
	   $.ajax({
	       type:"POST",
	       url:"/board/like",
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
	             alert("좋아요를 하셨습니다.");
	             location.reload();
	            }
	          else if(response.code == 1)
	            {
	             alert("좋아요를 취소하셨습니다.");
	             location.reload();
	            }
	          else if(response.code == 400)
	          {
	           alert("로그인 후, 좋아요 버튼을 사용하실 수 있습니다.");
	          }
	          else
	            {
	             alert("좋아요 중 오류가 발생하였습니다.");
	            }
	       },
	       error:function(xhr, status, error){
	          icia.common.error(error);
	       }
	    });
   });
   
   $("#btnSearch").on("click", function() {
	      
	      $("#btnSearch").prop("disabled", true);   //글쓰기 버튼 비활성화 //버튼 여러번 누르기 방지기능(활성화시 여러번 전송되므로)
	      
	      if($.trim($("#juniorBbsContent").val()).length <= 0)
	      {
	         alert("내용을 입력하세요.");
	         $("#juniorBbsContent").val("");
	         $("#juniorBbsContent").focus();
	         
	         $("#btnSearch").prop("disabled", false);   //글쓰기 버튼 활성화
	         
	         return;
	      }
	      
	      var form = $("#commentForm")[0];
	      var formData = new FormData(form);
	      
	      $.ajax({
	         type:"POST",
	         url:"/board/commentProc",
	         data:formData,
	         processData:false,   //formData를 string으로 변환하지 않음.
	         contentType:false,   //comtent-type헤더가 multipart/form-data로 전송하기 위해
	         cache:false,
	         timeout:600000,
	         beforeSend:function(xhr)
	         {
	            xhr.setRequestHeader("AJAX", "true");
	         },
	         success:function(response)
	         {
	            if(response.code == 0)
	              {
	               alert("댓글이 등록되었습니다.");
		           location.reload();
	              }
	            else if(response.code == 400)
	              {
	               alert("파라미터 값이 올바르지 않습니다.");
	               $("#btnSearch").prop("disabled", false);   //글쓰기 버튼 활성화
	              }
	            else if(response.code == 404)
	              {
	               alert("게시물을 찾을 수 없습니다.");
	               $("#btnSearch").prop("disabled", false);   //글쓰기 버튼 활성화
	              }
	            else
	              {
	               alert("댓글 등록 중 오류가 발생.");
	               $("#btnSearch").prop("disabled", false);   //글쓰기 버튼 활성화
	              }
	         },
	         error:function(error)
	         {
	            icia.common.error(error);
	            alert("댓글 등록 중 오류가 발생하였습니다.");
	            $("#btnSearch").prop("disabled", false);   //글쓰기 버튼 활성화
	         }
	      });
	   });
   
   $("#btnAddReply").on("click", function(){
		$("#btnSearch").prop("disabled", true);   //버튼 여러번 누르기 방지기능(활성화시 여러번 전송되므로)
	   $.ajax({
	       type:"POST",
	       url:"/board/addReply",
	       data:{
	    	//$("juniorBbsContent").val() = "@" + ${juniorBoard.userNick} + " ";
	       },
	       datatype:"JSON",
	       beforeSend:function(xhr){
	          xhr.setRequestHeader("AJAX", "true");
	       },
	       success:function(response){
	          if(response.code == 0)
	            {
	             alert("댓글 등록준비!");
	             location.reload();
	            }
	          else if(response.code == 400)
	          {
	           alert("로그인 후, 댓글버튼을 사용하실 수 있습니다.");
	          }
	          else
	            {
	             alert("좋아요 중 오류가 발생하였습니다.");
	            }
	       },
	       error:function(xhr, status, error){
	          icia.common.error(error);
	       }
	    });
   });
   
   $("#btnCommentDelete").on("click", function(){
      if(confirm("댓글을 삭제 하시겠습니까?") == true)
      {
         $.ajax({
            type:"POST",
            url:"/board/commentDelete",
            datatype:"JSON",
            data:{
               bbsSeq:<c:out value="${board.bbsSeq}" />
            },
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
                 {
                  alert("댓글이 삭제되었습니다.");
 	             location.reload();
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
                  alert("댓글을 찾을 수 없습니다.");
                  location.href = "/board/list";                  
                 }
               else if(response.code == -999)
                 {
                  alert("답글이 존재하여 삭제할 수 없습니다.");
                 }
               else
                 {
                  alert("댓글 삭제 중 오류가 발생하였습니다.");
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
						<c:choose>
							<c:when test="${bbsLikeActive eq 'Y'}">
								<div class="like"><button type="button" id="btnLike" class="like"><ion-icon name="heart"></ion-icon>&nbsp;&nbsp;좋아요  <span class="likeCount">${board.bbsLikeCnt}</span></button></div>
							</c:when>
							<c:when test="${bbsLikeActive eq 'N'}">
								<div class="like"><button type="button" id="btnLike" class="like"><ion-icon name="heart-outline"></ion-icon>&nbsp;&nbsp;좋아요  <span class="likeCount">${board.bbsLikeCnt}</span></button></div>
							</c:when>
						</c:choose>
						<div class="bookmark"><button type="button" id="btnBoomark" class="bookmark"><ion-icon name="star"></ion-icon>&nbsp;&nbsp;즐겨찾기</button></div>
					</div>
				</div>


<div class="board-service">
<div class="board-list"><button type="button" id="btnList" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;목록</button></div>
<div class="report"><button><ion-icon name="alert-circle"></ion-icon>&nbsp;신고</button></div>
<c:if test="${!empty board.boardFile}">
<a href="/board/download?bbsSeq=${board.boardFile.bbsSeq}" style="float:right;">첨부이미지 다운로드</a>
</c:if>   
</div>

<c:if test="${board.bbsComment eq 'Y'}">
             
<form name="commentForm" id="commentForm" method="post" enctype="form-data">
<div class="board-commentwrite">
<col-lg-12><ion-icon name="chatbubbles"></ion-icon>댓글</col-lg-12>
<div class="submit">
<input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
<input type="text" id="juniorBbsContent" name="juniorBbsContent"  value="${juniorBoard.bbsContent}"style="ime-mode:active;" class="form-control mt-4 mb-2"/>
<button type="submit" id="btnSearch">등록</button>
</div>
</div>
</form>
  
<c:if test="${!empty list}">
<c:forEach var="juniorBoard" items="${list}" varStatus="status">
<div class="comment">
<div class="comment-write">
<col-lg-12><ion-icon name="person"></ion-icon> ${juniorBoard.userNick}</col-lg-12>

<c:if test="${boardMe eq 'Y'}">
	<button type="submit" id="btnCommentDelete" class="delete">삭제</button>
</c:if>
<a>${juniorBoard.regDate}</a>
<button type="submit" id="btnReport">신고</button>
<button type="submit" id="btnAddReply">댓글달기</button>

</div>
<div class="comment-content">
<col-lg-12>${juniorBoard.bbsContent}</col-lg-12>
</div>
</div>
</c:forEach>
</c:if>
</form>
</c:if>
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
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
               else if(response.code == -999)
                 {
                  alert("답변 댓글이 존재하여 삭제할 수 없습니다.");
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
   
   //게시물 좋아요
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
   
   //게시물 즐겨찾기
   $("#btnMark").on("click", function(){
	   $.ajax({
	       type:"POST",
	       url:"/board/mark",
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
	             alert("즐겨찾기를 하셨습니다.");
	             location.reload();
	            }
	          else if(response.code == 1)
	            {
	             alert("즐겨찾기를 취소하셨습니다.");
	             location.reload();
	            }
	          else if(response.code == 400)
	          {
	           alert("로그인 후, 즐겨찾기 버튼을 사용하실 수 있습니다.");
	          }
	          else
	            {
	             alert("즐겨찾기 중 오류가 발생하였습니다.");
	            }
	       },
	       error:function(xhr, status, error){
	          icia.common.error(error);
	       }
	    });
   });
   
   //댓글 등록
   $("#btnSearch").on("click", function() {
	      
	      $("#btnSearch").prop("disabled", true);
	      
	      if($.trim($("#bbsContent").val()).length <= 0)
	      {
	         alert("내용을 입력하세요.");
	         $("#bbsContent").val("");
	         $("#bbsContent").focus();
	         
	         $("#btnSearch").prop("disabled", false);
	         
	         return;
	      }
	      
	      var form = $("#commentForm")[0];
	      var formData = new FormData(form);
	      
	      $.ajax({
	         type:"POST",
	         url:"/board/commentProc",
	         data:formData,
	         processData:false,
	         contentType:false,
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
	               $("#btnSearch").prop("disabled", false);
	              }
	            else if(response.code == 404)
	              {
	               alert("게시물을 찾을 수 없습니다.");
	               $("#btnSearch").prop("disabled", false);
	              }
	            else
	              {
	               alert("댓글 등록 중 오류가 발생.");
	               $("#btnSearch").prop("disabled", false);
	              }
	         },
	         error:function(error)
	         {
	            icia.common.error(error);
	            alert("댓글 등록 중 오류가 발생하였습니다.");
	            $("#btnSearch").prop("disabled", false);
	         }
	      });
   });   
});

function fn_deleteComment(bbsSeqValue)
{
    if(confirm("댓글을 삭제 하시겠습니까?") == true)
    {
       $.ajax({
          type:"POST",
          url:"/board/commentDelete",
          datatype:"JSON",
          data:{
             bbsSeq:bbsSeqValue
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
                alert("답변 댓글이 존재하여 삭제할 수 없습니다.");
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
}



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
					<ion-icon name="person"></ion-icon><a href="javascript:void(0)" onclick="fn_userList(${board.userUID})">${board.userNick}</a> &nbsp;
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
						<c:choose>
							<c:when test="${bbsMarkActive eq 'Y'}">
								<div class="bookmark"><button type="button" id="btnMark" class="bookmark"><ion-icon name="star"></ion-icon>&nbsp;&nbsp;즐겨찾기</button></div>
							</c:when>
							<c:when test="${bbsMarkActive eq 'N'}">
								<div class="bookmark"><button type="button" id="btnMark" class="bookmark"><ion-icon name="star-outline"></ion-icon>&nbsp;&nbsp;즐겨찾기</button></div>
							</c:when>
						
						</c:choose>
					</div>
				</div>


				<div class="board-service">
				  <div class="board-list"><button type="button" id="btnList" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;목록</button></div>
					<div class="report"><button type="button" data-bs-toggle="modal" data-bs-target="#reportModal" id="btnReport"><ion-icon name="alert-circle"></ion-icon>&nbsp;신고</button></div>
	                  <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
	                     <div class="modal-dialog">
	                        <div class="modal-content">
	                           <div class="modal-header">
	                              <h5 class="modal-title" id="m">신고하기</h5>
	                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                           </div>
	                           <div class="modal-body">
	                              <div class="datecard">
	                                 <h3 id="view-name">
						                                 신고자 : <br>
						                                 신고게시물 : 
	                                 </h3>
	                                 <div class="content">
	                                    <ul>
	                                       <li><input type="checkbox" id="reportCheck" class="reportCheck" name="report1" value="Y">&nbsp;신고사유1</li>
	                                       <li><input type="checkbox" id="reportCheck" class="reportCheck" name="report2" value="Y">&nbsp;신고사유2</li>
	                                       <li><input type="checkbox" id="reportCheck" class="reportCheck" name="report3" value="Y">&nbsp;신고사유3</li>
	                                       <li><input type="checkbox" id="reportCheck" class="reportCheck" name="report4" value="Y">&nbsp;신고사유4</li>
	                                       <li><input type="checkbox" id="reportCheck" class="reportCheck" name="report4" value="Y">&nbsp;<input type="text" id="reportReason" name="reportReason" placeholder="기타사유를 적어주세요"></li>
	                                    </ul>
	                                 </div>
	                                 <div class="modal-footer">
	                                    <button type="button" class="btn btn-secondary">취소</button>
	                                    <button type="button" class="btn btn-primary">신고</button>
	                                 </div>
	                              </div>
	                           </div>
	                        </div>
	                     </div>
	                  </div>
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
									<input type="text" id="bbsContent" name="bbsContent" style="ime-mode:active;" class="form-control mt-4 mb-2"/>
									<button type="submit" id="btnSearch">등 록</button>
								</div>
							</div>
						
  
						<c:if test="${!empty list}">
							<c:forEach var="board" items="${list}" varStatus="status">
								<div class="comment">
									<div class="comment-write">
										<col-lg-12><ion-icon name="person"></ion-icon> ${board.userNick}</col-lg-12>
										<c:if test="${boardMe eq 'Y'}">
											<button onclick="fn_deleteComment(${board.bbsSeq})" id="btnCommentDelete" class="commentDelete">삭제</button>
										</c:if>
										<a>${board.regDate}</a>
										<button type="submit" id="btnReport">신고</button>
										<button onclick="fn_reComment(${board.bbsSeq})" id="btnReply" class="btnReply">댓글달기</button>
									</div>
									<div class="comment-content">
										<col-lg-12>${board.bbsContent}</col-lg-12>
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
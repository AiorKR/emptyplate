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
      document.bbsForm.action = "/board/list";
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
		          alert("로그인 후 좋아요 버튼을 사용하실 수 있습니다.");
		          location.href = "/user/login";
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
		         location.href = "/user/login";
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
	               alert("로그인 후 댓글을 작성해주세요.");
	               $("#btnSearch").prop("disabled", false);
			       location.href = "/user/login" ;
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
   
   //게시물 신고
   $("#reportBtn").on("click", function() {	
	      var report1 = "";
	      var report2 = "";
	      var report3 = "";
	      var report4 = "";
	      var etcReport = "";
	  
	      var reportChk = $('#report1').is(':checked');
	      if(reportChk == true)
	    	  report1 = "Y";
	      else
	    	  report1 = "N";
	      
	      reportChk = $('#report2').is(':checked');
	      if(reportChk == true)
	    	  report2 = "Y";
	      else
	    	  report2 = "N";
	      
	      reportChk = $('#report3').is(':checked');
	      if(reportChk == true)
	    	  report3 = "Y";
	      else
	    	  report3 = "N";
	      
	      reportChk = $('#report4').is(':checked');
	      if(reportChk == true)
	    	  report4 = "Y";
	      else
	    	  report4 = "N";
	      
	      reportChk = $('#etcReport').is(':checked');
	      if(reportChk == true)
	    	  etcReport = "Y";
	      else
	    	  etcReport = "N";
	      
	      $.ajax({
	         type:"POST",
	         url:"/board/reportProc",
	 		data : {
	 			bbsSeqChk: "Y",
	 			bbsSeq: $('#bbsSeq').val(),
	 			report1: report1,
	 			report2: report2,
	 			report3: report3,
	 			report4: report4,
	 			etcReport: etcReport
			},
			datatype : "JSON",
	        beforeSend:function(xhr)
	        {
	           xhr.setRequestHeader("AJAX", "true");
	        },
	        success:function(response)
	        {
	           if(response.code == 0)
	           {
	               alert("신고가 접수되었습니다.");
	               location.reload();
	           }
	           else if(response.code == 400)
	           {
	               alert("파라미터 값이 올바르지 않습니다.");
	               $("#reportBtn").prop("disabled", false);
	           }
	           else if(response.code == 404)
	           {
	               alert("신고 게시물을 찾을 수 없습니다.");
	               $("#reportBtn").prop("disabled", false);
	           }
	           else
	           {
	               alert("신고 접수 중 오류가 발생.");
	               $("#reportBtn").prop("disabled", false);
	           }
	         },
	         error:function(error)
	         {
	            icia.common.error(error);
	            alert("신고 접수 중 오류가 발생하였습니다.");
	            $("#reportBtn").prop("disabled", false);
	         }
	      });
   });
   
   //댓글 신고
   $("#reportBtn2").on("click", function() {	      
	      var report11 = "";
	      var report12 = "";
	      var report13 = "";
	      var report14 = "";
	      var etcReport2 = "";
	  
	      var reportChk = $('#report11').is(':checked');
	      if(reportChk == true)
	    	  report11 = "Y";
	      else
	    	  report11 = "N";
	      
	      reportChk = $('#report12').is(':checked');
	      if(reportChk == true)
	    	  report12 = "Y";
	      else
	    	  report12 = "N";
	      
	      reportChk = $('#report13').is(':checked');
	      if(reportChk == true)
	    	  report13 = "Y";
	      else
	    	  report13 = "N";
	      
	      reportChk = $('#report14').is(':checked');
	      if(reportChk == true)
	    	  report14 = "Y";
	      else
	    	  report14 = "N";
	      
	      reportChk = $('#etcReport2').is(':checked');
	      if(reportChk == true)
	    	  etcReport2 = "Y";
	      else
	    	  etcReport2 = "N";
	      
	      $.ajax({
	         type:"POST",
	         url:"/board/reportProc",
	 		data : {
	 			bbsSeqChk: "N",
	 			bbsSeqCom: $('#bbsSeqCom').val(),
	 			report1: report11,
	 			report2: report12,
	 			report3: report13,
	 			report4: report14,
	 			etcReport: etcReport2
			},
			datatype : "JSON",
			beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", "true");
	        },
	        success:function(response)
	        {
	           if(response.code == 0)
	           {
	               alert("신고가 접수되었습니다.");
	               location.reload();
	           }
	           else if(response.code == 400)
	           {
	               alert("파라미터 값이 올바르지 않습니다.");
	               $("#reportBtn2").prop("disabled", false);
	           }
	           else if(response.code == 404)
	           {
	               alert("신고 게시물을 찾을 수 없습니다.");
	               $("#reportBtn2").prop("disabled", false);
	           }
	           else
	           {
	               alert("신고 접수 중 오류가 발생.");
	               $("#reportBtn2").prop("disabled", false);
	           }
	         },
	         error:function(error)
	         {
	            icia.common.error(error);
	            alert("신고 접수 중 오류가 발생하였습니다.");
	            $("#reportBtn2").prop("disabled", false);
	         }
	      });
   });
});

//댓글 게시물번호
function fn_Report(bbsSeq2){
	$('#bbsSeqCom').val(bbsSeq2);
}

//댓글 삭제
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
					<ion-icon name="person"></ion-icon> ${board.userNick} &nbsp;
					<ion-icon name="calendar"></ion-icon> ${board.regDate} &nbsp;
					<ion-icon name="eye"></ion-icon><fmt:formatNumber type="number" maxFractionDigits="3" value="${board.bbsReadCnt}"/>
				</div>
				<div class="board-innercontent">
					<col-lg-12>${board.bbsContent}</col-lg-12>
					<div>
						<c:if test="${boardMe eq 'Y'}">
							<div class="delete"><button type="button" id="btnDelete" class="delete">삭제</button></div>
							<div class="update"><button type="button" id="btnUpdate" class="update">수정</button></div>
						</c:if>
					</div>
				</div>

				<div class="board-service">
				  <div class="board-list"><button type="button" id="btnList" class="board-list"><ion-icon name="reader"></ion-icon>&nbsp;목록</button></div>
	                 
				      <c:if test="${!empty board.boardFile}">
						<a href="/board/download?bbsSeq=${board.boardFile.bbsSeq}" style="float:right;">첨부이미지 다운로드</a>
					  </c:if>   
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
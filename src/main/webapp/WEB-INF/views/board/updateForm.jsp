<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {

   $("#bbsTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      
      $("#btnUpdate").prop("disabled", true);  // 수정 버튼 활성화
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bbsTitle").focus();
         return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         return;
      }
      
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
    	  type:"POST",
    	  enctype:'multipart/form-data',
    	  url:"/board/updateProc",
    	  data:formData,
    	  processData:false,
    	  contentType:false,
    	  cache:false,
    	  beforeSend:function(xhr)
    	  {
    		  xhr.setRequestHeader("AJAX", "true");
    	  },
    	  success:function(response)
    	  {
    		  if(response.code == 0)
   			  {
    			  alert("게시물이 수정되었습니다.");
    			  location.href = "/board/list";
    			  /* 왔었던 해당페이지로 이동(단점:수정 중 다른사람이 글을 써서 해당페이지에 내 글이 없을때)
    			  document.bbsForm.action = "/board/list";
    			  document.bbsForm.submit();*/
    			  
   			  }
    		  else if(response.code == 400)
			  {
    			  alert("파라미터 값이 올바르지 않습니다.");
    			  $("#btnUpdate").prop("disabled", false);
			  }
    		  else if(response.code == 403)
   			  {
    			  alert("본인 게시물이 아닙니다.");
    			  $("#btnUpdate").prop("disabled", false);
   			  }
    		  else if(response.code == 404)
   			  {
    			  alert("게시물을 찾을 수 없습니다.");
    			  location.href = "/board/list";
   			  }
    		  else
   			  {
    			  alert("게시물 수정 중 오류가 발생하였습니다.");
    			  $("#btnUpdate").prop("disabled", false);
   			  }
    	  },
    	  error:function(error)
    	  {
    		  icia.common.error(error);
    		  alert("게시물 수정 중 오류가 발생하였습니다.");
    		  $("#btnUpdate").prop("disabled", false);
    	  }
	  });
   });
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/board/list";
      document.bbsForm.submit();
   });

});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="communityUpdateForm" class="community">
  <div class="container">
   <div class = "row">
    <div class="d-flex flex-row justify-content-center">
      <div class="notice">
        <p>Community 글 작성시 유의사항</p>
          <ul>- 홍보/비방/욕설/기타 특성에 맞지 않는 등의 글은 관리자가 내용 확인 후 임의로 삭제할 수 있습니다.<br/>
              - 첫번째 등록한 이미지가 대표이미지로 자동 등록됩니다.
          </ul>
      </div>
    </div>

    <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
      <table>
        <tr>
          <td class="title">제목</td>
          <td class="title-text">
            <input type="text" id="bbsTitle" name="bbsTitle" placeholder="제목을 입력해주세요.">
            <div class="comment">댓글허용 <input type="checkbox" required/></div>
          </td>
        </tr>
        <tr>
          <td class="content">내용</td>
          <td class="content-text">

                <!--<script>
                  $(document).ready(function() {
                    $('.summernote').summernote();
                  });
                </script>-->

            <textarea class="summernote" id="bbsContent" name="bbsContent" placeholder="내용을 입력해주세요."></textarea> 
          </td>
        </tr>
      </table>
      
      <input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
        
      <div class="d-flex flex-row justify-content-center">
        <div class="update"><button type="button" id="btnUpdate" class="update" title="수정">수정</button></div>
        <div class="cancle"><button type="button" id="btnList" class="cancle" title="취소">취소</button></div>
      </div>
    </form>
   </div>
  
   <form name="bbsForm" id="bbsForm" method="post">
    <input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
    <input type="hidden" name="searchType" value="${searchType}" />
    <input type="hidden" name="searchValue" value="${searchValue}" />
    <input type="hidden" name="curPage" value="${curPage}" />
   </form>
   	
  </div>
 </section> 
</body>
</html>
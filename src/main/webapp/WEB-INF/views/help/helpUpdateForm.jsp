<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 5);

%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {

   $("#bbsTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      
      $("#btnUpdate").prop("disabled", true);
      
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
      

         $('#bbsComment').val("N");
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
         type:"POST",
         enctype:'multipart/form-data',
         url:"/help/helpUpdateProc",
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
               document.bbsForm.bbsNo = response.data;
               document.bbsForm.action = "/help/helpList";
               document.bbsForm.submit();            
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
               document.bbsForm.bbsNo = response.data;
               document.bbsForm.action = "/help/helpList";
               document.bbsForm.submit();
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
   
   //목록
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/help/helpList";
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
    <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
      <table>
        <tr>
          <td class="title">제목</td>
          <td class="title-text">
            <input type="text" id="bbsTitle" name="bbsTitle" value="${board.bbsTitle}" maxlength="30" placeholder="제목을 입력해주세요.">
          </td>
        </tr>
        
        <tr>
          <td class="content">내용</td>
          <td class="content-text">
            <textarea class="summernote" id="bbsContent" name="bbsContent" placeholder="내용을 입력해주세요.">${board.bbsContent}</textarea> 
            <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
            <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
            <script src="/resources/summernote/summernote-lite.js"></script>
            <script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
            <link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
            <script>$('.summernote').summernote({
		            	//에디터 높이
		                height: 340,
		                maxHeight: 340,
		                //에디터 한글 설정
		                lang: "ko-KR",
		                callbacks: {
		                      onInit: function (c) {
		                          c.editable.html('${board.bbsContent}');
		                      }
		                },
		                toolbar: [
		                     //글꼴 설정
		                     ['fontname', ['fontname']],
		                     //글자 크기 설정
		                     ['fontsize', ['fontsize']],
		                     //굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		                     ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		                     //글자색
		                     ['color', ['forecolor','color']],
		                     //표만들기
		                     ['table', ['table']],
		                     //글머리 기호, 번호매기기, 문단정렬
		                     ['para', ['ul', 'ol', 'paragraph']],
		                     //줄간격
		                     ['height', ['height']],
		                     //그림첨부, 링크만들기, 동영상첨부
		                     ['insert',['picture','link','video']],
		                     //코드보기, 확대해서보기, 도움말
		                     ['view', ['codeview','fullscreen', 'help']]
		                 ],
		                 //추가한 글꼴
		                 fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		                 //추가한 폰트사이즈
		                 fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		                 
		              });
            </script>
          </td>
        </tr>
        
        <tr>
          <td class="file">이미지 첨부</td>
          <td><input type="file" id="bbsFile" name="bbsFile" class="file-content" placeholder="파일을 선택하세요." required /></td>
        </tr>
        
        <c:if test="${!empty board.boardFile}">
			<tr>
			   <td class="file-check">등록파일</td>
			     <td><div class="file-check-content">[등록한 첨부파일 : ${board.boardFile.fileOrgName}]</div>
			</tr>
        </c:if>
      </table>
      
      <input type="hidden" id="bbsComment" name="bbsComment" value="" />
      <input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
    </form>
    
      <div class="d-flex flex-row justify-content-center">
        <div class="update"><button type="button" id="btnUpdate" class="update" title="수정">수정</button></div>
        <div class="cancle"><button type="button" id="btnList" class="cancle" title="취소">취소</button></div>
      </div>
   </div>
  
   <form name="bbsForm" id="bbsForm" method="post">
    <input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
    <input type="hidden" name="bbsSeq" value="${bbsNo}" />
    <input type="hidden" name="searchType" value="${searchType}" />
    <input type="hidden" name="searchValue" value="${searchValue}" />
    <input type="hidden" name="curPage" value="${curPage}" />
   </form>
  </div>
 </section> 
 
 <!-- ======= Footer ======= -->
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
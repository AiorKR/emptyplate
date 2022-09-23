<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 4);
%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
    
   $("#bbsTitle").focus();
   
   //이미지 파일 첨부 확장자, 사이즈 체크
   $("input[type='file']").on("change", function(e){
 		let formData = new FormData();
 		let fileInput = $('input[name="bbsFile"]');
 		let fileList = fileInput[0].files;
 		let fileObj = fileList[0];
 		if(!fileCheck(fileObj.name, fileObj.size)){
 			return false;
 		}
 		formData.append("bbsFile", fileObj);
 	});
	let regex = new RegExp("(.*?)\.(jpg|png|jpeg|gif)$", "i");
 	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
   
   $("#btnWrite").on("click", function() {
      
      $("#btnWrite").prop("disabled", true);
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bBbsTitle").focus();
         
         $("#btnWrite").prop("disabled", false);
         
         return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         
         $("#btnWrite").prop("disabled", false);
         
         return;
      }
      
      if($.trim($("#bbsFile").val()).length <= 0)
      {
         alert("파일을 첨부하세요.");
         $("#bbsFile").val("");
         
         $("#btnWrite").prop("disabled", false);
         
         return;
      }
      
      var comment = document.getElementById('bbsComment1');

      var resultValue = comment.checked;
      if(resultValue == true)
      {
         $('#bbsComment').val("Y");
      }
      else
      {
         $('#bbsComment').val("N");
      }
      
      var form = $("#writeForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
         type:"POST",
         enctype:'multipart/form-data',
         url:"/board/writeProc",
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
               alert("게시물이 등록되었습니다.");
               location.href = "/help/helpList";
              }
            else if(response.code == 400)
              {
               alert("파라미터 값이 올바르지 않습니다.");
               $("#btnWrite").prop("disabled", false);
              }
            else
              {
               alert("게시물 등록 중 오류가 발생.");
               $("#btnWrite").prop("disabled", false);
              }
         },
         error:function(error)
         {
            icia.common.error(error);
            alert("게시물 등록 중 오류가 발생하였습니다.");
            $("#btnWrite").prop("disabled", false);
         }
      });
   });
   
   //목록
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/board/list";
      document.bbsForm.submit();
   });
});
</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 <section id="communityWriteForm" class="community">
  <div class="container">
   <div class = "row">
    <div class="d-flex flex-row justify-content-center">
      <div class="notice">
        <p>Community 글 작성시 유의사항</p>
          <ul>- 홍보/비방/욕설/기타 특성에 맞지 않는 등의 글은 관리자가 내용 확인 후 임의로 삭제할 수 있습니다.<br/>
              - 작성 시 반드시 하나의 파일을 첨부해야 하며, 등록된 이미지는 추후 대표 이미지로 적용될 수 있습니다.<br/>
              - 회원 탈퇴하여도 게시물 내용은 삭제되지 않습니다.
          </ul>
      </div>
    </div>

    <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
      <input type="hidden" name="bbsNo" value="${bbsNo}" />
      <table>
        <tr>
          <td class="title">제목</td>
          <td class="title-text">
            <input type="text" id="bbsTitle" name="bbsTitle" maxlength="30" placeholder="제목을 입력해주세요.">
			<div class="comment">댓글허용 <input type="checkbox" id="bbsComment1" name="bbsComment1" checked="checked"/></div>
				<input type="hidden" id="bbsComment" name="bbsComment" value="" />
          </td>
        </tr>
        
        <tr>
          <td class="content">내용</td>
          <td class="content-text">
            <textarea class="summernote" id="bbsContent" name="bbsContent" placeholder="내용을 입력해주세요."></textarea> 
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
          <td><input type="file" id="bbsFile" name="bbsFile" class="file-content" placeholder="파일을 선택하세요."/></td>
        </tr>
      </table>
      
      <div class="d-flex flex-row justify-content-center">
        <div class="submit"><button type="button" id="btnWrite" class="submit" title="등록">등록</button></div>
        <div class="cancle"><button type="button" id="btnList" class="cancle" title="취소">취소</button></div>
      </div> 
    </form>
   </div>

   <form name="bbsForm" id="bbsForm" method="post">
    <input type="hidden" name="bbsNo" value="${bbsNo}" />
    <input type="hidden" name="searchType" value="" />
    <input type="hidden" name="searchValue" value="" />
    <input type="hidden" name="curPage" value="" />
   </form>
  </div>
 </section> 
 
 <!-- ======= Footer ======= -->
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
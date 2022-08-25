<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
    
   $("#bbsTitle").focus();
   
   $("#btnWrite").on("click", function() {
      
      $("#btnWrite").prop("disabled", true);   //글쓰기 버튼 비활성화 //버튼 여러번 누르기 방지기능(활성화시 여러번 전송되므로)
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bBbsTitle").focus();
         
         $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
         
         return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         
         $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
         
         return;
      }
      
      if($.trim($("#bbsFile").val()).length <= 0)
      {
         alert("파일을 첨부하세요.");
         $("#bbsFile").val("");
         
         $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
         
         return;
      }
      
      var form = $("#writeForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
         type:"POST",
         enctype:'multipart/form-data',   //파일첨부시 필요
         url:"/board/writeProc",
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
               alert("게시물이 등록되었습니다.");
               location.href = "/board/list";   // 8088/board/list호출, 검색조건 없이 첫번째 list페이지 띄우기
               /*
               document.bbsForm.action = "/board/list";   //검색조건 값 가져가기   
               document.bbsForm.submit();
               */
              }
            else if(response.code == 400)
              {
               alert("파라미터 값이 올바르지 않습니다.");
               $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
              }
            else
              {
               alert("게시물 등록 중 오류가 발생.");
               $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
              }
         },
         error:function(error)
         {
            icia.common.error(error);
            alert("게시물 등록 중 오류가 발생하였습니다.");
            $("#btnWrite").prop("disabled", false);   //글쓰기 버튼 활성화
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
 <section id="communityWriteForm" class="community">
  <div class="container">
   <div class = "row">
    <div class="d-flex flex-row justify-content-center">
      <div class="notice">
        <p>Community 글 작성시 유의사항</p>
          <ul>- 홍보/비방/욕설/기타 특성에 맞지 않는 등의 글은 관리자가 내용 확인 후 임의로 삭제할 수 있습니다.<br/>
              - 파일첨부란에 반드시 이미지를 첨부해야 하며, 등록된 이미지는 대표이미지로 적용됩니다.
          </ul>
      </div>
    </div>

    <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
      <input type="hidden" name="bbsNo" value="${bbsNo}" />
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
        <tr>
          <td class="file">파일첨부</td>
          <td><input type="file" id="bbsFile" name="bbsFile" class="file-content" placeholder="파일을 선택하세요." required /></td>
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
</body>
</html>
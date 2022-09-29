<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
	// Community 번호
	request.setAttribute("No", 2);

%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
var i  = 1
$(document).ready(function() {
	$("#shopFile").click(function (){
		$('#addfile').append('<input type="file" id="shopFile" name="shopFile'+ i + '"' + ' class="form-control mb-2" placeholder="파일을 선택하세요." required />');
		i++;
		$("#fileQuantity").val(i);
	});
	
   $("#btnWrite").on("click", function() {
	      
	      $("#btnWrite").prop("disabled", true);
	      
	      var form = $("#writeForm")[0];
	      var formData = new FormData(form);
	      
	      $.ajax({
	    	  type:"POST",
	    	  enctype:'multipart/form-data',
	    	  url:"/reservation/shopInsertProc",
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
	    			  alert("게시물이 등록 되었습니다.");
	    			  location.href = "/reservation/shopInsert";
	    		  }
	    		  else
	    		  {
	    			  alert("게시물 등록중 오류 발생.");
	    		  }
	    	  },
	    	  error:function(error)
	    	  {
	    		  icia.common.error(error);
	    		  alert("게시물 등록 중 오류가 발생하였습니다.");
	    	  }
	     	  });
		});
   $("#btnList").click(function(){
	   location.href = "/reservation/list";
   });
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container" style="position:relative; top:150px;">
   <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
      <input type="text" name="shopName" id="shopName" maxlength="20" value="" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="매장이름을 입력해주세요." />
      <input type="text" name="shopType" id="shopType" maxlength="30" value="" style="ime-mode:inactive;" class="form-control mb-2" placeholder="타입 1: 파인다이닝 2:오마카세" />
      <input type="text" name="shopHoliday" id="shopHoliday" maxlength="30" value="" style="ime-mode:inactive;" class="form-control mb-2" placeholder="휴일을 입력해주세요." />
      <input type="text" name="shopLocation1" id="shopLocation1" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="시, 도를 입력해주세요." required />
      <input type="text" name="shopLocation2" id="shopLocation2" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="군 , 구를  입력해주세요." required />
      <input type="text" name="shopLocation3" id="shopLocation3" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="동 읍 면을 입력해주세요." required />
      <input type="text" name="shopAddress" id="shopAddress" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="상세 주소 입력해주세요." required />
      <input type="text" name="shopHashtag" id="shopHashtag" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="해시태그 입력해주세요." required />
      <input type="text" name="shopTelephon" id="shopTelephon" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="전화번호 (-포함) 입력해주세요." required />
      <input type="text" name="shopIntro" id="shopIntro" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="매장 한줄 소개 입력해주세요." required />
     
      <div class="form-group">
         <textarea class="form-control" rows="10" name="shopContent" id="shopContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
      </div>
      <div id="addfile">
      <input type="file" id="shopFile" name="shopFile0" class="form-control mb-2" placeholder="파일을 선택하세요." required />
      </div>
      <div class="form-group row">
         <div class="col-sm-12">
            <button type="button" id="btnWrite" class="btn btn-primary" title="저장">저장</button>
            <button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
         </div>
      </div>
      <input type="hidden" name="fileQuantity" id="fileQuantity" value=0>
   </form>
</div>
</body>
</html>
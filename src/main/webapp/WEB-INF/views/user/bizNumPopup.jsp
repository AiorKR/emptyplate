<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script src="https://kit.fontawesome.com/842f2be68c.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnSearch").on("click", function() {
		let check = /^[0-9]+$/; 
		if($.trim($("#search").val()).length != 10)
		{
			alert("사업자 번호는 10자리의 숫자입니다.");
			$("#search").focus();
			return;
		}
		else if (!check.test($("#search").val())) 
		{
			alert('숫자만 입력 가능합니다.');
			return;
		}
		else{
			const search = $("#search").val();
			var data = {
					  "b_no": [
						    search
						  ]
						}
				
			//ajax시작
				$.ajax({
				  url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=OHdvGApJdKFVbMb%2FbKZYfP2D28h0I8yl7w%2FwD7jXeAwvflQx2xrDoJdqiJeSrpATjKIzbjFmjjV17zDysikuVA%3D%3D",  // serviceKey 값을 xxxxxx에 입력
				  type: "POST",
				  data: JSON.stringify(data), // json 을 string으로 변환하여 전송
				  dataType: "JSON",
				  contentType: "application/json",
				  accept: "application/json",
				  success: function(response) {
				      console.log(response);
				      if(response.match_cnt == "01")
				      {
				    	  alert("사용가능한 사업자번호 입니다.");
				    	  opener.document.getElementById("bizNum").value = document.getElementById("search").value;
				    	  self.close();
				      }
				      else
				      {
				    	  alert("국세청에 등록된 사업자번호가 아닙니다.");
				    	  $("#search").val("");
				      }
				  },
				  error: function(result) {
				      console.log(result.responseText); //responseText의 에러메세지 확인	
				  }
				});
			//ajax끝
		};
	})
});
</script>

<style>

</style>
</head>

<body style="background-color:white;">
<div class="container text-center">
  <div class="row">
    <div class="col" style="text-align: center;">
    <p style="font-family:Cafe24Dangdanghae; color:#d4af7a; margin-top:20px; font-size:20px;">사업자번호 상태조회</p>
    <hr style="color:black;">
      <input type="text" id="search" name="search" placeholder="-빼고 입력해주세요." maxlength="10" style="font-size:14px">
     <button type="button" id="btnSearch" style="background-color:#d4af7a; font-family:Cafe24Dangdanghae;" >사업자번호조회</button>  
    </div>
  </div>
  </div>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
<script src="https://kit.fontawesome.com/842f2be68c.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<style>

</style>
<script type="text/javascript">

$(document).ready(function() {

//let phoneAuth = true;
$("#tel_btn").on("click", function() {
	const telNum = $("#tel").val();
	$.ajax({
		type:'POST',
		url:"/user/sendSms",
		header:{"Content-Type":"application/json"},
		dateType:'json',
		data:{tel:telNum},
		success : function(response){
			if(response.code == 0){
				alert('인증 번호를 전송했습니다.')
				const code_btn = document.getElementById("code_btn")
				code_btn.disabled = false	
			} 
			else if(response.code == 100){
				alert('이미 가입된 전화번호 입니다.')
				 $("#tel").focus();
			} 
			else {
				alert('오류가 발생하였습니다.')
				$("#tel").focus();
			}
		}
	})
})	
	
	
	
});
</script>
</head>

<body>
	<form>
		<!-- <input type="text" name="rand" id="rand"> 인증번호 확인용 -->
		<div>
			<input type="tel" id="tel" name="tel"placeholder="전화번호(- 빼고 작성해주세요)" pattern="[0-9]{11}" required>
			<button type="button" id="tel_btn">인증번호 전송</button>
		</div>
		<div>
			<input type="text" name="code" id="code" placeholder="전송받은 번호" pattern="[0-9]{6}" required>
			<button type="button" id="code_btn" disabled>번호 확인</button>			
		</div>
		<input type="button" value="닫 기" onclick="self.close();" /> 
	</form>
</body>

</html>
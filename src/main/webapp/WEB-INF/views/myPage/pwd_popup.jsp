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
	
$("#tel_btn").on("click", function() {
	let check = /^[0-9]+$/; 
	if (!check.test($("#tel").val())) {
		alert('숫자만 입력 가능합니다.')
		return;
	}
	else{
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
				alert('계정정보와 일치하지 않는 번호입니다.')
				 $("#tel").focus();
			} 
			else {
				alert('오류가 발생하였습니다.')
				$("#tel").focus();
			}
		}
	})
	}
})	

$("#code_btn").on("click", function(){
	const code = $("#code").val();
	$.ajax({
		type:'POST',
		url:"/user/sendSmsOk",
		header:{"Content-Type":"application/json"},
		dateType:'json',
		data:{code:code},
		success : function(response){
			if(response.code == 0){
				alert('인증되었습니다')
				PhoneUpdate();
			} else {
				alert('인증 번호가 다릅니다.')
			}
		}
	})
})

	
});
</script>
</head>

<body>
	<form>
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
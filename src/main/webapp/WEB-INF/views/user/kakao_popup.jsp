<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
<link href="/resources/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/842f2be68c.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<style>
	.pwds{
		width: 250px;
		height: 35px;
}
	.btn_Phone{
		width:100px;
		height:36px;
	}
</style>
<script type="text/javascript">

$(document).ready(function() {
	
	$("#tel_btn").on("click", function() {
		let check = /^[0-9]+$/;
		let emptCheck = /\s/g;
		if (!check.test($("#tel").val())) {
			alert('숫자만 입력 가능합니다.')
			return;
		}
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
		    $("#userName").focus();
		    return;
		}
		if(emptCheck.test($("#userName").val())) 
	    {
		      alert("이름은 공백을 포함할 수 없습니다.");
		      $("#userName").val("");
		      $("#userName").focus();
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
					$("#code").focus();
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
				
				$.ajax({
                    type:"POST",
                    url:"/user/kakaoProc",
                    data:{
                       userName:$("#userName").val(),
                       userPhone:$("#tel").val()
                    },
                    datatype:"JSON",
                    beforeSend:function(xhr){
                       xhr.setRequestHeader("AJAX", "true");
                    },
                    success:function(response)
                    {
                      if(response.code == 0)
                      { //자동회원가입 후 자동 로그인 
                    	alert('인증되었습니다')
                    	opener.parent.updateSuccess();
      					self.close();
                      }
                      
                    },
                   error:function(xhr, status, error)
                   {
                       icia.common.error(error);
                   }
                  });
			
			} 
			else 
			{
				alert('인증 번호가 다릅니다.')
				$("#code").focus();
			}
		}
	})
})



	
});
</script>
</head>

<body style="background-color:white; margin-left:20px;">
<p style="font-family:Cafe24Dangdanghae; color:#d4af7a; margin-top:10px; font-size:30px;">전화번호 인증</p>
	<form>
		<p style="color:black;">(필수)카카오 회원은 최초 1회에 한해 정보를 수집하고 있습니다.</p>
		<div>
		<input type="text" id="userName" name="userName" class="pwds" placeholder="이름을 입력해주세요.">
		</div><br />
		<div>
			<input type="tel" id="tel" name="tel" class="pwds" placeholder="전화번호(- 빼고 작성해주세요)" pattern="[0-9]{11}" required>
			<input type="button" value="인증번호 전송" class="btn_Phone" id="tel_btn" />
		</div><br />
		<div>
			<input type="text" name="code" id="code" class="pwds" placeholder="전송받은 번호" pattern="[0-9]{6}" required>
			<input type="button" value="번호 확인" id="code_btn" class="btn_Phone" disabled />				 		
		</div><br />
		<div style="text-align: center;">
			<input type="button" value="닫 기" class="btn_Phone" onclick="self.close();" />	
		</div>
	</form>
</body>

</html>
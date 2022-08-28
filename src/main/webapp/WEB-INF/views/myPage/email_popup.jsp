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
	.userEmail{
		width: 250px;
		height: 25px;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
		$("#userEmail").focus();
		
		$("#btnUpdate").on("click", function() { 
	      	if($.trim($("#userEmail").val()).length <= 0)
	      	{
	        	$("#userEmail").focus();
	        	return;
	      	}
	      	
	      	if(!fn_validateEmail($("#userEmail").val()))
			{	
	      		alert("올바르지 않은 이메일 형식입니다."); 
	      		opener.parent.emailChk();
			 	 return;   
			}
	     	$.ajax({
			type:"POST",
			url:"/user/EmailUpdate",
			data:{
				userEmail:$("#userEmail").val()
			},
			dataType:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("이메일이 변경되었습니다.");
					opener.parent.updateSuccess();
					self.close();
				}
				else if(response.code == 400)
				{
					opener.parent.ParmError();
					self.close();
				}
				else if(response.code == 404)
				{
					opener.parent.userError();
					self.close();
				}
				else if(response.code == 500)
				{
					opener.parent.updateError();					
					self.close();
				}
				else
				{
					opener.parent.updateError();
					self.close();
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
	      });
	   });
	});
	
function fn_validateEmail(value)
	{
	   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	   
	   return emailReg.test(value);
	}
</script>
</head>

<body>
<form>
	<input type="text" id="userEmail" name="userEmail" class="userEmail" placeholder="변경하실 이메일을 입력해주세요" maxlength="20">
	<button type="button" id="btnUpdate">확인</button> 
	<input type="button" value="닫 기" onclick="self.close();" />       
</form>
</body>

</html>
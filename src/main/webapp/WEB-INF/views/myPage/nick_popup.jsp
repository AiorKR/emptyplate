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
<style>
	.userNick{
		width: 250px;
		height: 30px;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
		$("#userNick").focus();
		$("#btnUpdate").on("click", function() { 
	      	if($.trim($("#userNick").val()).length <= 0)
	      	{
	         $("#userNick").focus();
	         return;
	      	}
	     	$.ajax({
			type:"POST",
			url:"/user/NickUpdate",
			data:{
				userNick:$("#userNick").val()
			},
			dataType:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("닉네임이 변경되었습니다.");
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
</script>
</head>

<body style="background-color:white; text-align: center;">
<p style="font-family:Cafe24Dangdanghae; color:#d4af7a; margin-top:10px; font-size:20px;">닉네임 변경</p>
<form>
	<input type="text" id="userNick" name="userNick" class="userNick" placeholder="변경하실 닉네임을 입력해주세요" maxlength="12">
	<input type="button" id="btnUpdate" value="확인" style="font-family:Cafe24Dangdanghae;" /><br /><br />
	<input type="button" value="닫 기" onclick="self.close();" /> 
</form>

</body>

</html>
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
		
		$("#btnUpdate").on("click", function() { 
	  	
		var form = $("#updateForm")[0];
		var formData = new FormData(form);	
			
	    $.ajax({
	    	type:"POST",
	    	enctype:'multipart/form-data',
	    	url:"/user/picUpdate",
	    	data:formData,
	    	contentType:false,
	    	processData:false,		//formData를 String으로 변환하지 않음
	    	cache:false,
	    	timeout:600000,
	    	beforSend:function(xhr)
	    	{
	    		xhr.setRequestHeader("AJAX", "true");	
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("프로필 변경완료");
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
 <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
    <input type="file" id="userFile" name="userFile" class="form-control mb-2" placeholder="파일을 선택하세요." required />
	<button type="button" id="btnUpdate">확인</button> 
	<input type="button" value="닫 기" onclick="self.close();" />       
</form>
</body>

</html>
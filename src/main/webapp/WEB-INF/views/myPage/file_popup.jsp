<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>

<head>
<link href="/resources/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/842f2be68c.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<style>
 .userFile_sec{
		width: 250px;
		height: 25px;
		color: black;
}

 .user_file_btn{
 	font-family:Cafe24Dangdanghae;
 	font-size:20px;
 }
</style>
<script type="text/javascript">

$(document).ready(function() {
		//프로필 등록
		$("#btnInsert").on("click", function() { 
	  	
		var form = $("#insertForm")[0];
		var formData = new FormData(form);	
			
	    $.ajax({
	    	type:"POST",
	    	enctype:'multipart/form-data',
	    	url:"/user/picInsert",
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
					alert("프로필 등록완료");
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
		
		
		//프로필 변경
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
		
		
		//기본프로필 설정
		$("#delPic").on("click", function() { 
		  	
		    $.ajax({
		    	type:"GET",
		    	url:"/user/delPic",
				datatype:"JSON",
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
	

</script>
</head>

<body style="background-color:white; text-align: center;">
<p style="font-family:Cafe24Dangdanghae; color:#d4af7a; margin-top:10px; font-size:25px;">프로필 사진변경</p>
<c:if test="${user.fileName eq ''}">
	<form name="insertForm" id="insertForm" method="post" enctype="multipart/form-data">
    	<input type="file" id="userFile" name="userFile" class="userFile_sec"required />
		<input type="button" id="btnInsert" value="등 록" class="user_file_btn"/>
		<input type="button" value="닫 기" onclick="self.close();" class="user_file_btn"/> 
	</form>
</c:if>

<c:if test="${user.fileName ne ''}">
	<form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
    	<input type="file" id="userFile" name="userFile" class="userFile_sec" required />
		<input type="button" id="btnUpdate" value="확 인" class="user_file_btn" /> 
		<input type="button" value="닫 기" onclick="self.close();" class="user_file_btn"/>		       
	</form>
	<br /><br /><br />
	<input type="button" id="delPic" name="delPic" value="기본 사진으로 할래요" class="user_file_btn"/>
</c:if>
      	
 

</body>

</html>
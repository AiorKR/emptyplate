<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript">

</script>
<style>
.userFavorites{
	text-align:center;
}

.storeFavorites{
	text-align:center;
}

.favorites-profile-card-img{
	width:150px;
	height:150px;
	border-radius:50%;
}

.favorites-hr{
	color:black; 
	width:900px; 
	margin:auto;
}

</style>
</head>
<body style="background:linear-gradient(white,antiquewhite);">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<main id="main">
<section class="rlist">
<div class="rlist-title">즐겨찾기</div>         
<hr role="tournament1"><br> 
<div id="rlist" class="user-rlist">
	<div class = "rlist-card">
		<div class = "rlist-profile-img-div">
			<c:if test="${user.fileName eq ''}">
            	<img src="/resources/upload/user/userDefault.jpg" class = 'rlist-profile-card-img'>
            </c:if>
            <c:if test="${user.fileName ne ''}">
          		<img src="/resources/upload/user/${user.fileName}" class = 'rlist-profile-card-img'>
            </c:if>
			<span class = "rlist-profile-card-name">${user.userNick} 님의 즐겨찾기</span>
        </div><br />   
        	<div class="userFavorites">
				<h3>유저 즐겨찾기</h3><hr class="favorites-hr"><br />				
					<div>
						<!--프로필 1-->	
						<a href="/myPage/myProfile">
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>        
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			
            			&nbsp;&nbsp;&nbsp;
						<!--프로필 2-->
						<a>	
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			&nbsp;&nbsp;&nbsp;
						<!--프로필 3-->
						<a>
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			&nbsp;&nbsp;&nbsp;	
            			<!--프로필 4-->
            			<a>
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
					</div>
			</div><br /><br /><br />
			<div class="storeFavorites">
				<h3>매장 즐겨찾기</h3><hr class="favorites-hr"><br />
					<div>
						<!--프로필 1-->	
						<a href="/myPage/myProfile">
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>        
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			&nbsp;&nbsp;&nbsp;
						<!--프로필 2-->
						<a>	
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			&nbsp;&nbsp;&nbsp;
						<!--프로필 3-->
						<a>
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
            			&nbsp;&nbsp;&nbsp;	
            			<!--프로필 4-->
            			<a>
							<c:if test="${user.fileName eq ''}">
            					<img src="/resources/upload/user/userDefault.jpg" class = 'favorites-profile-card-img'>
           					</c:if>
            				<c:if test="${user.fileName ne ''}">
          						<img src="/resources/upload/user/${user.fileName}" class = 'favorites-profile-card-img'>
            				</c:if>
            			</a>
					</div>
		</div>
	</div>
</div>             
</section>
</main>
 
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
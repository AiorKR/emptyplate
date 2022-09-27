<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
pageContext.setAttribute("newLine", "\n");
// Community 번호
request.setAttribute("No", 2);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<!--date and time picker-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/resources/datepicker/date_picker.css">
<!--end date and time picker-->

<%@ include file="/WEB-INF/views/include/head.jsp"%>

<!--date and time picker-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<!--end date and time picker-->
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<!-- ======= reservations Section ======= -->
<section id="view" class="view">
	<div class="container">
		<div class="row">
			<div style="border-right: 2px solid #C2A383; float:left;width: 50%;">
				<div class="basic">
					<table>
						<tr>
							<th>기본정보</th>
						</tr>
						<tr>
							<td>상호명 :</td>
							<td class="title-text">
								<input type="text" id="shopTitle" name="shopTitle" value="상호" maxlength="30" placeholder="상호명을 입력해주세요.">
							</td>
						</tr>
						<tr>
							<td>매장주소</td>
							<td class="title-text">
								<input type="text" id="shopTitle" name="shopTitle" value="매장주소" maxlength="30" placeholder="상호명을 입력해주세요.">
							</td>
						</tr>
						<tr>
							<td>매장전화번호</td>
							<td class="title-text">
								<input type="text" id="shopTitle" name="shopTitle" value="매장전화번호" maxlength="30" placeholder="상호명을 입력해주세요.">
							</td>
						</tr>
						<tr>
							<td>매장형태</td>
							<td class="title-text">
								<input type="text" id="shopTitle" name="shopTitle" value="파인다이닝" maxlength="30" placeholder="상호명을 입력해주세요.">
							</td>
						</tr>
						<tr>
							<td>매장휴일</td>
							<td class="title-text">
								<input type="text" id="shopTitle" name="shopTitle" value="일요일" maxlength="30" placeholder="상호명을 입력해주세요.">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
  function changeImage(element) {
     var main_prodcut_image = document.getElementById('main_product_image');
     main_prodcut_image.src = element.src; 
  }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
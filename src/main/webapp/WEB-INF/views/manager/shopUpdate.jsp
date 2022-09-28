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
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
				var btnHashStack = 0;
				var btnTimeStack = 0;
				var btnTableStack = 0;
				var btnMenuStack = 0;
				if(btnHashStack < 6)
				{
					$("#btnHashAdd").on("click", function(){
						if(btnHashStack<6)
						{
							// table element 찾기
							const table = document.getElementById("hashTagValue");
		
							// 새 행(Row) 추가
							const newRow = table.insertRow();
		
							// 새 행(Row)에 Cell 추가
							const newCell1 = newRow.insertCell(0);
							const newCell2 = newRow.insertCell(1);
		
							// Cell에 텍스트 추가
							newCell1.innerText = "해시태그" + btnHashStack;
							newCell2.innerHTML	 = "<input type='text'>";
							
							btnHashStack++;
						}
					});
	
					$("#btnHashDelete").on("click", function(){
						// table element 찾기
						const table = document.getElementById("hashTagValue");
	
						// 행(Row) 삭제
						const newRow = table.deleteRow(-1);
						if(btnHashStack>1){
							btnHashStack--;
						}
					});
				}
				
				if(btnTimeStack < 6)
				{
					$("#btnTimeAdd").on("click", function(){
						if(btnTimeStack<6)
						{
							// table element 찾기
							const table = document.getElementById("timeValue");
		
							// 새 행(Row) 추가
							const newRow = table.insertRow();
		
							// 새 행(Row)에 Cell 추가
							const newCell1 = newRow.insertCell(0);
							const newCell2 = newRow.insertCell(1);
		
							// Cell에 텍스트 추가
							newCell1.innerText = "매장시간" + btnTimeStack;
							newCell2.innerText = 'New Fruit';
							
							btnTimeStack++;
						}
					});
	
					$("#btnTimeDelete").on("click", function(){
						// table element 찾기
						const table = document.getElementById("timeValue");
	
						// 행(Row) 삭제
						const newRow = table.deleteRow(-1);
						if(btnTimeStack>1){
							btnTimeStack--;
						}
					});
				}

				if(btnTableStack < 6)
				{
					$("#btnTableAdd").on("click", function(){
						if(btnTableStack<6)
						{
							// table element 찾기
							const table = document.getElementById("tableValue");
		
							// 새 행(Row) 추가
							const newRow = table.insertRow();
		
							// 새 행(Row)에 Cell 추가
							const newCell1 = newRow.insertCell(0);
							const newCell2 = newRow.insertCell(1);
		
							// Cell에 텍스트 추가
							newCell1.innerText = "매장 테이블" + btnTableStack;
							newCell2.innerText = 'New Fruit';
							
							btnTableStack++;
						}
					});
	
					$("#btnTableDelete").on("click", function(){
						// table element 찾기
						const table = document.getElementById("tableValue");
	
						// 행(Row) 삭제
						const newRow = table.deleteRow(-1);
						if(btnTableStack>1){
							btnTableStack--;
						}
					});
				}

				if(btnMenuStack < 6)
				{
					$("#btnMenuAdd").on("click", function(){
						if(btnMenuStack<6)
						{
							// table element 찾기
							const table = document.getElementById("menuValue");
		
							// 새 행(Row) 추가
							const newRow = table.insertRow();
		
							// 새 행(Row)에 Cell 추가
							const newCell1 = newRow.insertCell(0);
							const newCell2 = newRow.insertCell(1);
							const newCell3 = newRow.insertCell(2);
		
							// Cell에 텍스트 추가
							newCell1.innerText = "해시태그" + btnMenuStack;
							newCell2.innerText = 'New Fruit';
							newCell3.innerText = 'New Fruit';
							
							btnMenuStack++;
						}
					});
	
					$("#btnMenuDelete").on("click", function(){
						// table element 찾기
						const table = document.getElementById("menuValue");
	
						// 행(Row) 삭제
						const newRow = table.deleteRow(-1);
						if(btnMenuStack>1){
							btnMenuStack--;
						}
					});
				}
			});
</script>
</head>
<body style="color: #000000">
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<!-- ======= reservations Section ======= -->
<section id="view" class="view">
	<div class="container">
		<div class="row">
			<div style="border-right: 2px solid #C2A383; float:left;width: 50%;">
				<div class="d-flex flex-column justify-content-center">
					<div class="main_image">
					  <img src="../resources/upload/shop/${shop.shopUID}/${shop.shopFileList.get(1).shopFileName}"
						   id="main_product_image" height="400px" width="400px">
					</div>
					<br />
					<div class="thumbnail_images">
					  <ul id="thumbnail">
						<c:forEach items="${shop.shopFileList}" var="shopFileList" varStatus="status" begin="1" end="5">
						  <li><img onclick="changeImage(this)"
									src="../resources/upload/shop/${shop.shopUID}/${shopFileList.shopFileName}"
									width="100px" height="100px">&nbsp;
						  </li>
						</c:forEach>
					  </ul>
					  
					</div>
					<div class="imageModify">
						<table>
							<tr>
								<td class="file-check">등록파일</td>
								<td><div class="file-check-content"><input type="file" id="bbsFile" name="bbsFile" class="file-content" placeholder="파일을 선택하세요."/>
								<br/>[등록한 첨부파일 : ${shop.shopFile.fileOrgName}]</div></td>
							</tr>
							<tr>
								<td class="file">이미지 첨부</td>
								<td><input type="file" id="bbsFile" name="bbsFile" class="file-content" placeholder="파일을 선택하세요." required /></td>
							</tr>	
						</table>
					</div>
					<div class="introduce">
						<table>
						<tr>
	                        <th>소개정보</th>
	                     </tr>
							<tr>
								<td class="name">가게소개</td>
								<td class="intro">
									<textarea class="form-control" rows="1" name="shopIntro" id="shopIntro" style="ime-mode:inactive;" placeholder="내용을 입력해주세요" required>${shop.shopIntro}</textarea>
								</td>
							</tr>
							<tr>
								<td class="name2">공지사항</td>
								<td>
									<textarea class="form-control" rows="10" name="shopContent" id="shopContent" style="ime-mode:inactive;" placeholder="내용을 입력해주세요" required>${shop.shopContent}</textarea>
								</td>
							</tr>
						</table>
					</div>
				  </div>
				</div>

				<div class="p-3 right-side">
					<div class="d-flex justify-content-between align-items-center">
						<div class="basic">
							<table>
								<tr>
									<th>기본정보</th>
								</tr>
								<tr>
									<td class="td" style="padding-bottom:10px;">상호명</td>
									<td class="title-text" style="padding-bottom:10px;">
										<input type="text" id="shopTitle" name="shopTitle" value="${shop.shopName}" maxlength="30" placeholder="상호명을 입력해주세요.">
									</td>
								</tr>
								<tr>
									<td rowspan="2"class="td" style="padding-bottom:10px;">매장주소</td>
									<td class="title-text" style="padding-bottom:1px;">
										<input type="text" id="shopLocation1" value="${shop.shopLocation1}" placeholder="주소">
										<input type="text" id="sample6_postcode" placeholder="우편번호" hidden>
										<input type="text" id="sample6_extraAddress" placeholder="참고항목" hidden>
									</td>
								</tr>
								<tr>
									<td class="title-text" style="padding-bottom:9px;">
										<input type="text" id="shopAddress" value="${shop.shopAddress}" placeholder="상세주소">
										<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기">
									</td>
								</tr>
								<tr>
									<td class="td">매장<br/>전화번호</td>
									<td class="title-text">
										<input type="text" id="shopTitle" name="shopTitle" value="${shop.shopTelephone}" maxlength="30" placeholder="상호명을 입력해주세요.">
									</td>
								</tr>
								<tr>
									<td class="td" style="padding-bottom:10px;">매장형태</td>
									<td class="title-text" style="padding-bottom:10px;">
										<select name="shopType" class="select">
											<option value='' <c:if test="${shop.shopType ne '1' and shop.shopType ne '2'}">selected</c:if>>매장 형태</option>
											<option value='1' <c:if test="${shop.shopType eq '1'}">selected</c:if>>파인다이닝</option>
											<option value='2' <c:if test="${shop.shopType eq '2'}">selected</c:if>>오마카세</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="td">매장휴일</td>
									<td class="title-text">
										<input type="checkbox" name="day" value="sun" <c:if test="${!empty day0}">checked</c:if>> 일
										<input type="checkbox" name="day" value="mon" <c:if test="${!empty day1}">checked</c:if>> 월
										<input type="checkbox" name="day" value="tue" <c:if test="${!empty day2}">checked</c:if>> 화
										<input type="checkbox" name="day" value="wed" <c:if test="${!empty day3}">checked</c:if>> 수
										<input type="checkbox" name="day" value="thr" <c:if test="${!empty day4}">checked</c:if>> 목
										<input type="checkbox" name="day" value="fri" <c:if test="${!empty day5}">checked</c:if>> 금
										<input type="checkbox" name="day" value="sat" <c:if test="${!empty day6}">checked</c:if>> 토
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div class="additional">
					<table>
		               <tr>
		               <th>추가정보</th>
		               </tr>
		            </table>
					<div class="hashTag">
						<div class="hashTagMenu">
							<table>
								<tr>
									<td class="tdtd">해시태그</td>
									<td>
										<button type="button" id="btnHashAdd">생성</button>
									</td>
									<td>
										<button type="button" id="btnHashDelete">삭제</button>
									</td>
								</tr>
							</table>
						</div>
						<div class="hashTagValue">
							<table id="hashTagValue" style="margin-bottom:15px;">
								<tr>
									<td class="tdtd2">해시태그1</td>
									<td><input type="text" id="hashTag1" class="hastTagInput" placeholder="해시태그를 입력해주세요" style="font-size:17px;"></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="time">
						<div class="timeMenu">
							<table>
								<tr>
									<td class="tdtd">매장시간</td>
									<td>
										<button type="button" id="btnTimeAdd">생성</button>
									</td>
									<td>
										<button type="button" id="btnTimeDelete">삭제</button>
									</td>
								</tr>
							</table>
						</div>
						<div class="timeValue">
							<table id="timeValue" style="margin-bottom:15px;">
								<tr>
									<td class="tdtd2">매장시간1</td>
									<td>
										<input type="text" placeholder="매장시간을 입력해주세요" style="font-size:17px;">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="tableCap">
						<div class="tableMenu">
							<table>
								<tr>
									<td class="tdtd3">테이블 설정</td>
									<td>
										<button type="button" id="btnTableAdd">생성</button>
									</td>
									<td>
										<button type="button" id="btnTableDelete">삭제</button>
									</td>
								</tr>
							</table>
						</div>
						<div class="tableValue">
							<table id="tableValue" style="margin-bottom:15px;">
								<tr>
									<td class="tdtd3">테이블 규격</td>
									<td>
										<select name="tableType" class="select" style="font-size:17px;">
											<option value='' selected>테이블 규격</option>
											<option value='1'>1인용</option>
											<option value='2'>2인용</option>
											<option value='3'>3인용</option>
											<option value='4'>4인용</option>
											<option value='5'>5인용</option>
											<option value='6'>6인용</option>
											<option value='7'>7인용</option>
											<option value='8'>8인용</option>
										</select>
									</td>
									<td>
										<input type="text" placeholder="수량을 입력해주세요" style="font-size:17px;">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="menuSet">
						<div class="menuSet">
							<table>
								<tr>
									<td class="tdtd4">메뉴 설정</td>
									<td>
										<button type="button" id="btnMenuAdd">생성</button>
									</td>
									<td>
										<button type="button" id="btnMenuDelete">삭제</button>
									</td>
								</tr>
							</table>
						</div>
						<div class="menuValue">
							<table id="menuValue" style="margin-bottom:15px;">
								<tr>
									<td class="tdtd5">메뉴1</td>
									<td>
										<select name="menuTime" class="select" style="font-size:17px;">
											<option value='' selected>메뉴시간</option>
											<option value='1'>런치</option>
											<option value='2'>디너</option>
										</select>
									</td>
									<td>
										<input type="text" placeholder="메뉴명을 입력해주세요" style="font-size:17px;">
									</td>
									<td>
										<input type="text" placeholder="메뉴가격을 입력해주세요" style="font-size:17px;">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-center">
					<div class="update"><button type="button" id="btnUpdate" class="update" title="수정">수정</button></div>
					<div class="cancle"><button type="button" id="btnCancle" class="cancle" title="취소">취소</button></div>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("shopLocation1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("shopAddress").focus();
            }
        }).open();
    }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div id = commentSection>
			<form name="commentForm" id="commentForm" method="post" enctype="form-data">
				<div class="board-commentwrite">
					<div><ion-icon name="chatbubbles"></ion-icon>댓글</div>
					<div class="submit">
						<input type="hidden" name="bbsSeq" value="${board.bbsSeq}" />
						<input type="text" id="bbsContent" name="bbsContent" style="ime-mode:active;" class="form-control"/>
						<button type="submit" id="btnSearch">등 록</button>
					</div>
				</div>
				
				<c:set var="cookieUserUID" value="${cookieUserUID}"/>
				<c:set var="parentsBbsSeq" value="${board.bbsSeq}"/>
				<c:if test="${!empty list}">
					<c:forEach var="board" items="${list}" varStatus="status">
						<div class="comment">
							<div class="comment-write">
								<col-lg-12><ion-icon name="person"></ion-icon> ${board.userNick}</col-lg-12>
								<c:if test="${board.userUID eq cookieUserUID}">
									<button onclick="fn_deleteComment(${board.bbsSeq})" id="btnCommentDelete" class="commentDelete">삭제</button>
								</c:if>
								<a>${board.regDate}</a>
								<button type="button" data-bs-toggle="modal" data-bs-target="#reportModal2" id="btnReport${board.bbsSeq}" onclick="fn_Report(${board.bbsSeq})">신고</button>
								<button type="button" onclick="fn_reComment(${board.bbsSeq}, ${parentsBbsSeq})" id="btnReply" class="btnReply">댓글달기</button>
							</div>
							<div class="comment-content">
								<col-lg-12>${board.bbsContent}</col-lg-12>
							</div>
						</div>
					</c:forEach>	
					
					<div class="modal fade" id="reportModal2" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="m">댓글 신고하기</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form name="reportFormCom" id="reportFormCom" method="post">	
										<div class="datecard">
											<div class="content">
												<ul>
													<li><input type="checkbox" class="reportCheck" id="report11" name="report11">&nbsp;스팸 게시물 입니다.</li>
													<li><input type="checkbox" class="reportCheck" id="report12" name="report12">&nbsp;게시판 성격에 맞지 않는 글입니다.</li>
													<li><input type="checkbox" class="reportCheck" id="report13" name="report13">&nbsp;과도한 욕설이 포함된 글입니다.</li>
													<li><input type="checkbox" class="reportCheck" id="report14" name="report14">&nbsp;게시판의 분위기를 어지럽히는 글입니다.</li>
													<li><input type="checkbox" class="reportCheck" id="etcReport2" name="etcReport2">&nbsp;기타사유</li>
												</ul>
												<input type="hidden" id="bbsSeqCom" name="bbsSeqCom" value="" />
												<input type="hidden" id="bbsSeqChk" name="bbsSeqChk" value="N" />
											</div>
											<div class="modal-footer">
												<button type="button" id="reportCancle" class="reportCancle" data-bs-dismiss="modal">취소</button>
												<button type="button" id="reportBtn2" class="reportBtn2">신고</button>
											</div>
										</div>
									</form>
								</div>          
							</div>
						</div>
					</div>		                  
				</c:if>
			</form>
		</div>
	</body>
</html>
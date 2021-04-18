<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>CDD</title>
</head>
<body>
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLabel" > 일지 리스트 </h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body" style="text-align: center;">
		<div class="container">
			<c:if test="${noteListCnt != 0}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">날짜</th>
							<th scope="col">이름</th>
							<th scope="col">목욕 여부</th>
							<th scope="col">공개 여부</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notesListDTO" items="${noteList}" varStatus="status">
							<tr id="delete${status.count}">
								<td> ${status.count}</td>
								<td> ${notesListDTO.note_date} </td>
								<td> ${notesListDTO.pet_name }</td>
								<td> 
									<c:if test="${notesListDTO.note_bath == 0}">
										목욕함
									</c:if>
									<c:if test="${notesListDTO.note_bath == 1}">
										목욕안함
									</c:if>
								</td>
								<td>
									 <c:if test="${notesListDTO.note_secret == 1}">
									 	전체공개
									 </c:if> 
									 <c:if test="${notesListDTO.note_secret == 2}">
									 	팔로우만
									 </c:if> 
								</td>
								<td>
									<a data-target="#noteModifyForm" data-toggle="modal" role="button" class="btn btn-outline-primary" style="font-size: 15px; padding: 0px;" onclick="noteModifyModal(${notesListDTO.note_num})">수정</a> 	
									<button type="button" class="btn btn-outline-dark" style="font-size: 15px; margin: 0px; padding: 0px;" onclick="deleteNote(${notesListDTO.note_num},${status.count})">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<c:if test="${noteListCnt == 0}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">날짜</th>
							<th scope="col">이름</th>
							<th scope="col">공개여부</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="5">등록되어 있는 일지가 없습니다.</td>
						</tr>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	</div>
</body>

<script>
	// 스케줄 삭제
	function deleteNote(note_num, count){
		console.log("일지 삭제 해야하는곳");
	
		var ajaxJon = new Object();
		ajaxJon.note_num = note_num;	// 펫 고유번호
		
		if(confirm("일정을 삭제 하시겠습니까 ?") == true){
			$.ajax({
				url : "/cdd/myPage/deleteNote.cdd",	// 이동 URL
				type : "POST",						// 전송방식
				contentType : "application/json; charset=UF8",  
				data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
				dataType : "json",					// Controller로 보내는 데이터 타입
				success: function(deleteSuccessCnt){			// Controller에서 넘어오는 데이터 result에
					var count = JSON.parse(deleteSuccessCnt);
					if(count > 0){
						$('#delete'+ count ).empty();
					}
				}// success
			}); 
	    }//if
		
	}//deleteNote

</script>


</html>
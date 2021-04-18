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
		<h5 class="modal-title" id="exampleModalLabel" > 일정 리스트 </h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body" style="text-align: center;">
		<div class="container">
			<c:if test="${scheduleListCnt != 0}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">날짜</th>
							<th scope="col">시간</th>
							<th scope="col">이름</th>
							<th scope="col">제목</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="scheduleList" items="${scheduleList}" varStatus="status">
							<tr id="delete${status.count}">
								<td> ${status.count}</td>
								<td> ${scheduleList.sche_date} </td>
								<td> ${scheduleList.sche_time} </td>
								<td> ${scheduleList.pet_name} </td>
								<td> ${scheduleList.sche_subject} </td>
								<td>
									<a data-target="#scheModifyForm" data-toggle="modal" role="button" class="btn btn-outline-primary" style="font-size: 15px; padding: 0px;" onclick="scheModifyFormModal(${scheduleList.sche_num})">수정</a> 	
									<button id="test" type="button" class="btn btn-outline-dark" style="font-size: 15px; margin: 0px; padding: 0px;" onclick="deleteSchedule(${scheduleList.sche_num},${status.count})">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<c:if test="${scheduleListCnt == 0}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">날짜</th>
							<th scope="col">시간</th>
							<th scope="col">이름</th>
							<th scope="col">제목</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="5">등록되어 있는 일정이 없습니다.</td>
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
	function deleteSchedule(sche_num, count){
		console.log("삭제 해야하는곳");
		var ajaxJon = new Object();
		ajaxJon.sche_num = sche_num;	// 펫 고유번호
	
		
		if(confirm("일정을 삭제 하시겠습니까 ?") == true){
			$.ajax({
				url : "/cdd/myPage/deleteSchedule.cdd",	// 이동 URL
				type : "POST",						// 전송방식
				contentType : "application/json; charset=UF8",  
				data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
				dataType : "json",					// Controller로 보내는 데이터 타입
				success: function(deleteSuccessCnt){			// Controller에서 넘어오는 데이터 result에
					var count = JSON.parse(deleteSuccessCnt);
					if(count > 0){
						$('#delete'+ count ).empty();
					}//if
				}// success
			}); 
	    }//if
 
	}//deleteSchedule	

</script>


</html>
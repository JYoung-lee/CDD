<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>CDD</title>
<!--   일정 관련 Css -->
<link rel="stylesheet" href="/cdd/resource/calendar/modifycalendarCss.css"/>

</head>
<body>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel" > 일정 수정 </h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<script></script>
<!-- 1111 2222 2021 04-08 21:00 -->
<form action="/cdd/myPage/scheModifyPro.cdd" method="post">

<input id="sche_dateModifyValue" name="sche_dateModify" type="hidden"/> <!-- 날짜바뀐 값 히든으로 넘겨주기 -->
<input name="sche_num" type="hidden" value="${schedulesDTO.sche_num}"/> <!-- 스케줄 고유번호 히든으로 넘겨주기 -->
<input name="sche_date" type="hidden" value="${schedulesDTO.sche_date}" /> <!-- 날짜를 선택하지 않았을경우 -->
	<div class="modal-body">
    <div class="container">
    	 <div class="row" style="height: 400px;">
    		<div class="col-md-7">
    			<div class="my-calendar3 clearfix3">
					<div class="clicked-date3">
						<div class="cal-day3"></div>
						<div class="cal-date3"></div>
					</div>
					<div class="calendar-box3">
					<div class="ctr-box3 clearfix3">
						<button type="button" title="prev3" class="btn-cal prev3"></button>
						<span class="cal-month3" ></span>
						<span class="cal-year3"></span>
						<button type="button" title="next3" class="btn-cal next3"></button>
					</div>
					<table class="cal-table3">
						<thead>
							<tr>
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
						</thead>
						<tbody class="cal-body3"></tbody>
					</table>
					</div>
				</div>
			</div>
			<div class="col-md-5" style=" height: 400px;" >
				<div class="row" style="height: 80px; ">
					<c:if test="${pet_profile eq 'defaultimg.png' }">
						<div class="col-md-4" style="padding-left: 0px;">
							<img src="/cdd/resource/img/logo.png" width="80px" height="80px" style="border-radius: 70%; overflow: hidden;"/>						
						</div>
					</c:if>
					<c:if test="${pet_profile ne 'defaultimg.png' }">
						<div class="col-md-4" style="padding-left: 0px;">
							<img src="/cdd/save/${pet_profile}" width="80px" height="80px" style="border-radius: 70%; overflow: hidden;" />					
						</div>
					</c:if>
					<div class="col-md-8"></div>
    			</div>
    			<div class="row" style=" height: 30px;">
    				<h4><label>제목</label></h4>
    			</div>
    			<div class="row" style="height: 40px;">
    				<div class="input-group flex-nowrap">
						<input type="text" class="form-control"  name="sche_subject" style="outline: none;" value="${schedulesDTO.sche_subject}">
					</div>
    			</div>
    			<div class="row" style="height: 30px;">
    				<h4><label>내용</label></h4>
    			</div>
    			<div class="row" style="height: 80px; width: 100%; padding-right: 0px; margin-right: 0px;">
    				<div class="form-floating" style="width: 100%;">
						<textarea class="form-control" placeholder="내용작성" id="floatingTextarea2" name="sche_content" style="height: 100%; width: 100%" >${schedulesDTO.sche_content}</textarea>
					</div>
    			</div>
    			<div class="row" style="height: 30px;">
    				<h4><label>현재 날짜</label></h4>
    			</div>
    			<div class="row" style="height: 40px;">
    				<div id="sche_modifyinput" class="input-group flex-nowrap">
    					<p style="font-size: 20px;"> ${schedulesDTO.sche_date} </p>&nbsp;&nbsp;
    					<p style="font-size: 12px;">수정하시려면 날짜를 선택해주세요</p>
    				</div>
    			</div>
    			
    			<div class="row" style="bheight: 30px;">
    				<h4><label>등록 시간 </label></h4>
    			</div>
    			<div class="row" style="height: 30px;">
    				<select class="form-select" aria-label="Default select example" name="sche_time">
						<option selected>${schedulesDTO.sche_time}</option>
						<c:forEach var="i" begin="6" end="24" step="1">
							<option value="${i}:00">${i}:00</option>
						</c:forEach>
					</select>
					<p style="font-size: 12px; " >변경 시간을 선택해주세요.</p>
    			</div>
			</div>
		</div>
    </div>
</div>
<div class="modal-footer">
	<button type="submit" class="btn btn-primary">변경</button>
	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
</div>
</form>
	<!-- 일정 달력 -->
	<script src="/cdd/resource/calendar/modifyCalendar.js"></script>
</body>
</html>
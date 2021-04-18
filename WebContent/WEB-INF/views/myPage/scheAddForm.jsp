<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>CDD</title>
<!--   일정 관련 Js.Css   -->
<link rel="stylesheet" href="/cdd/resource/calendar/calendarCss.css"/>
<!-- 일정 달력 -->
<script src="/cdd/resource/calendar/calendarJs.js"></script>

<script >
//유효성 검사
function schedulesAdd(){
	var checkForm = document.checkForm;
	var pet_num = document.getElementsByName("pet_num");
	var pet_numCount = 0;
   for(var i = 0; i < pet_num.length; i++){
      if(pet_num[i].checked){
         pet_numCount++;
      }
   }
   
   if(pet_numCount == 0){
      alert("펫을 선택해 주세요!");
      return false;
   }
	if(!checkForm.sche_subject.value){
		alert("제목을 작성해 주세요!");
		return false;
	}else if(!checkForm.sche_content.value){
		alert("내용을 작성해 주세요!");
		return false;
	}else if(!checkForm.sche_date.value){
		alert("날짜를 설정해 주세요!");
		return false;
	}else if(checkForm.sche_time.value == '0'){
		alert("시간을 설정해 주세요!");
		return false;
	}
	
}//schedulesAdd
</script>

</head>
<body>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel" > 일정 추가 </h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>

<form action="/cdd/myPage/scheAddPro.cdd" method="post" name="checkForm" onsubmit="return schedulesAdd()">
<input id="sche_dateValue" name="sche_date" type="hidden"/><!-- 날짜 값 히든으로 넘겨주기 -->
	<div class="modal-body">
    <div class="container">
    	<div class="row" style="height: 400px;">
    		<div class="col-md-7">
    			<div class="my-calendar clearfix">
					<div class="clicked-date">
						<div class="cal-day"></div>
						<div class="cal-date"></div>
					</div>
					<div class="calendar-box">
					<div class="ctr-box clearfix">
						<button type="button" title="prev" class="btn-cal prev"></button>
						<span class="cal-month" ></span>
						<span class="cal-year"></span>
						<button type="button" title="next" class="btn-cal next"></button>
					</div>
					<table class="cal-table">
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
					<tbody class="cal-body"></tbody>
					</table>
					</div>
				</div>
    		</div>
    		<div class="col-md-5" style=" height: 400px;" >
				<c:if test="${count > 0}">
					<div class="row">
						<div class="col-md-12">
							<div class="btn-group-toggle" data-toggle="buttons">
								<div class="row">
									<c:forEach var="pet_infoDTO" items="${petInfoList}">
										<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'}">
											<div class="col-md-3" >
												<label class="btn btn-outline-primary">
													<input type="radio" autocomplete="off" name="pet_num" value="${pet_infoDTO.pet_number}">
													<img src="../resource/img/${pet_infoDTO.pet_profile}" height="40px" width="40px" style="border-radius: 70%; overflow: hidden;"/>
												</label>
											</div>
										</c:if>
										<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
											<div class="col-md-3">
												<label class="btn btn-outline-primary">
													<input type="radio" autocomplete="off" name="pet_num" value="${pet_infoDTO.pet_number}">
													<img src="/cdd/save/${pet_infoDTO.pet_profile}" height="40px" width="40px" style="border-radius: 70%; overflow: hidden;" />
												</label>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div> <!-- 이미지 -->	
				</c:if>   				
				<c:if test="${count == 0}">
					<h4>등록된 사진이 없습니다.</h4>
				</c:if>   				
    			<div class="row" style=" height: 30px;">
    				<h4><label>제목</label></h4>
    			</div>
    			<div class="row" style="height: 40px;">
    				<div class="input-group flex-nowrap">
					  <input type="text" class="form-control"  name="sche_subject" style="outline: none;">
					</div>
    			</div>
    			<div class="row" style="height: 30px;">
    				<h4><label>내용</label></h4>
    			</div>
    			<div class="row" style="height: 80px; width: 100%; padding-right: 0px; margin-right: 0px;">
    				<div class="form-floating" style="width: 100%;">
						<textarea class="form-control" placeholder="내용작성" id="floatingTextarea2" name="sche_content" style="height: 100%; width: 100%"></textarea>
					</div>
    			</div>
    			<div class="row" style="height: 30px;">
    				<h4><label>날짜</label></h4><label></label>
    			</div>
    			<div class="row" style="height: 40px;">
    				<div id="sche_addinput" class="input-group flex-nowrap">
    					<p style="font-size: 12px; margin-bottom: 0px; ">달력을 선택해주세요~</p>
    				</div>
    			</div>
    			<div class="row" style="bheight: 30px;">
    				<h4><label style="margin-bottom: 0px;">시간</label></h4>
    			</div>
    			<div class="row" style="height: 30px;">
    				<select class="form-select" aria-label="Default select example" name="sche_time">
						<option value="0" selected>시간을 선택하세요</option>
						<c:forEach var="i" begin="6" end="24" step="1">
							<option value="${i}:00">${i}:00</option>
						</c:forEach>
					</select>
    			</div>
    		</div>
    	</div>
    </div>    
</div>
<div class="modal-footer">
	<button type="submit" class="btn btn-primary">저장</button>
	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
</div>
</form>





</body>
</html>
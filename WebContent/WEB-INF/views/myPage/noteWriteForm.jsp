<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
<script>
	$(function(){
       $('.input-group.date').datepicker({
           calendarWeeks: false,	/* 왼쪽에 일년에 몇주차인지 설정 여부 */
           todayHighlight: true,	/* true면 날짜를 강조 표시 */
           autoclose: true,			/* 날짜 선택시 날짜창 즉시 닫을지 여부 */
           format: "yyyy/mm/dd",	/* 출력 방식 */ 
           language: "en"			/* 달력언어 설정 */
       	});
   	});
</script>
<script >
//유효성 검사
function noteAdd(){
	var checkForm = document.checkForm;
	var pet_num = document.getElementsByName("pet_num");
	var checkKo = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;  // 한글 유효성
	var checkEng = /[a-zA-Z]/;		   // 영어 유효성 검사
	var note_bath = document.getElementsByName("note_bath");
	var note_emotion = document.getElementsByName("note_emotion");
	
	
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

	if(!checkForm.note_date.value){
		alert("날짜를 선택해주세요!");
		return false;
	}else if(!checkForm.note_weight.value){
		alert("몸무게를 작성해주세요!");
		return false;
	}else if(!checkForm.note_dry.value){
		alert("건식을 작성해주세요!");
		return false;
	}else if(!checkForm.note_wet.value){
		alert("습식을 해주세요!");
		return false;
	}else if(!checkForm.note_water.value){
		alert("하루 먹는 물의 양을 작성해주세요!");
		return false;
	}else if(!checkForm.note_stroll1.value){
		alert("산책시간 오전을 작성해주세요!");
		return false;
	}else if(!checkForm.note_stroll2.value){
		alert("산책시간 오후를 작성해주세요!");
		return false;
	}else if(!checkForm.note_stroll3.value){
		alert("산책시간 저녁을 작성해주세요!");
		return false;
	}else if(!checkForm.note_other.value){
		alert("일기를 짧게나마 작성해주세요!");
		return false;
	}
	var count = 0;
	for(var i = 0; i < note_emotion.length; i++){
		if(note_emotion[i].checked){
			count ++;
		}
	}
	
	if(count > 0){
		return true;
	}else{
		alert("오늘의 기분을 선택해 주세요!");
		return false;
	}
	
	var bathcheckCount = 0;
	if(note_bath[0].checked){
		bathcheckCount++;
	}else if(note_bath[1].checked){
		bathcheckCount++;
	}
	if(bathcheckCount == 0){
		alert("목욕 사항을 선택해 주세요!");
		return false;
 	}	
	
	
	
	
	
	
	
	if(checkKo.test(checkForm.note_weight.value) || checkKo.test(checkForm.note_dry.value) || checkKo.test(checkForm.note_wet.value) || checkKo.test(checkForm.note_water.value)){
		alert("식사량은 숫자로입력해주세요 입력해주세요!");
		return false;
	}else if(checkEng.test(checkForm.note_weight.value) || checkEng.test(checkForm.note_dry.value) || checkEng.test(checkForm.note_wet.value) || checkEng.test(checkForm.note_water.value)){
		alert("식사량은 숫자로입력해주세요 입력해주세요!");
		return false;
	}//else
		
	if(checkKo.test(checkForm.note_stroll1.value) || checkKo.test(checkForm.note_stroll2.value) || checkKo.test(checkForm.note_stroll3.value)){
		alert("산책시간은 숫자로입력해주세요 입력해주세요!");
		return false;
	}else if(checkEng.test(checkForm.note_stroll1.value) || checkEng.test(checkForm.note_stroll2.value) || checkEng.test(checkForm.note_stroll3.value)){
		alert("산책시간은 숫자로입력해주세요 입력해주세요!");
		return false;
	}//else
		

	


		

	
}//schedulesAdd
</script>
<!-- 달력인코딩 -->
<script src="/cdd/resource/calendar/encodingKo.js"></script> 
<body>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel" style="font-size: 30px"> Pet 일지 등록 </h5>
   	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
     	<span aria-hidden="true">&times;</span>
   	</button>
</div>
<c:if test="${count > 0}">
	<form action="/cdd/myPage/noteWritePro.cdd" method="post" name="checkForm" onsubmit="return noteAdd()">
		<div class="modal-body" style="height: 600px; overflow: auto;">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="btn-group-toggle" data-toggle="buttons">
							<div class="row">
								<c:forEach var="pet_infoDTO" items="${petInfoList}">
									<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'}">
										<div class="col-md-2" style="padding: 0px;">
											<label class="btn btn-outline-primary">
												<input type="radio" autocomplete="off" name="pet_num" value="${pet_infoDTO.pet_number}">
												<img src="../resource/img/${pet_infoDTO.pet_profile}" height="40px" width="40px" style="border-radius: 70%; overflow: hidden;"/>
											</label>
										</div>
									</c:if>
										<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
											<div class="col-md-2" style="padding: 0px;">
												<label class="btn btn-outline-primary">
													<input type="radio" autocomplete="off" name="pet_num" value="${pet_infoDTO.pet_number}">
													<img src="/cdd/save/${pet_infoDTO.pet_profile}" height="40px" width="40px" style="border-radius: 70%; overflow: hidden;"/>
												</label>
											</div>
										</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div> <!-- 이미지 -->	
				<div class="row" style="padding-top: 10px;">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label>날짜선택</label></h5>
						<div class="input-group date"> <!-- 달력 출력 -->
		        			<input type="text" class="form-control" name="note_date"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		   				</div> 
					</div>
				</div> <!-- 날짜 -->
				<div class="row" style="padding-top: 20px;">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label> # 오늘의 식사량 </label></h5>
						<div class="row">
							<div class="col-md-3" style="padding-right: 0px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">몸무게</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_weight">
								  <div class="input-group-append">
								    <span class="input-group-text">kg</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">건식</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_dry">
								  <div class="input-group-append">
								    <span class="input-group-text">g</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">습식</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control"  name="note_wet">
								  <div class="input-group-append">
								    <span class="input-group-text">g</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">음수</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_water">
								  <div class="input-group-append">
								    <span class="input-group-text">ml</span>
								  </div>
								</div>
							 </div>
						</div>				
					</div>
				</div>	<!-- 신체사항 -->
				<div class="row" style="height: 230px; margin-top: 5px;">
					<div class="col-md-6">
						<h5 class="initialism" style="margin-bottom: 0px;"><label># 이상 증상</label></h5>						
						<div class="row">
							<div class="col-md-12" >
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="note_disorder1">
									<label class="form-check-label">
									    구토
									</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input class="form-check-input" type="checkbox" name="note_disorder2">
									<label class="form-check-label">
									    설사
									</label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
							<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px;">기타</label></h5>
								<textarea class="form-control col-sm-100%" rows="6" name="note_disorder3" style="margin-top: 0px; margin-bottom: 0px; height: 148px;"></textarea>
							</div>
						</div>		
					</div>
					<div class="col-md-6" style="height: 230px;">
						<div class="row">
							<div class="col-md-12" style="height: 230px;">
								<h5 class="initialism" style="margin-bottom: 0px;"><label># 산책 시간</label></h5>
								<div class="row">
									<div class="col-md-12" >
										<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">아침</label></p>							 	
										<div class="input-group mb-3">
										  <input type="text" class="form-control" name="note_stroll1" >
										  <div class="input-group-append">
										    <span class="input-group-text">분</span>
										  </div>
										</div>
									</div>						
								</div>					
								<div class="row">
									<div class="col-md-12" style="bottom: 10px">
										<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">점심</label></p>							 	
										<div class="input-group mb-3">
										  <input type="text" class="form-control" name="note_stroll2" >
										  <div class="input-group-append">
										    <span class="input-group-text">분</span>
										  </div>
										</div>
									</div>						
								</div>					
								<div class="row">
									<div class="col-md-12" style="bottom: 20px">
										<p style="font-size: 14px; margin-bottom: 0px;" ><label style="margin-bottom: 0px;">저녁</label></p>							 	
										<div class="input-group mb-3">
										  <input type="text" class="form-control" name="note_stroll3" >
										  <div class="input-group-append">
										    <span class="input-group-text">분</span>
										  </div>
										</div>
									</div>						
								</div>					
							</div>							
						</div>
					</div>
				</div> <!-- 산책 -->
				<div class="row" style="margin-top: 10px;">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12" style="text-align: center;">
								<h5 class="initialism" style="margin-bottom: 0px;"><label># 오늘의 기분</label></h5>
								<div class="btn-group-toggle" data-toggle="buttons">
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; ">
										<input type="radio" autocomplete="off" name="note_emotion" value="1">
										<img src="/cdd/resource/img/heart-eyes.svg" /> 신남 
									</label>
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; margin-left: 5px;">
										<input type="radio" autocomplete="off" name="note_emotion" value="2">
										<img src="/cdd/resource/img/angry.svg" /> 화남
									</label>
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; margin-left: 5px;">
										<input type="radio" autocomplete="off" name="note_emotion" value="3">
										<img src="/cdd/resource/img/expressionless.svg" /> 우울
									</label>
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; margin-left: 5px;">
										<input type="radio" autocomplete="off" name="note_emotion" value="4">
										<img src="/cdd/resource/img/frown.svg" /> 슬픔
									</label>
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; margin-left: 5px;">
										<input type="radio" autocomplete="off" name="note_emotion" value="5">
										<img src="/cdd/resource/img/dizzy.svg" /> 아픔
									</label>
									<label class="btn btn-outline-primary btn-sm" style="font-size: 8px; margin-left: 5px;">
										<input type="radio" autocomplete="off" name="note_emotion" value="6">
										<img src="/cdd/resource/img/smile.svg" /> 보통
									</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-top: 10px; margin-bottom: 0px;"># 오늘의 일기</label></h5>
						<textarea class="form-control col-sm-100%" rows="6" name="note_other" style="margin-top: 0px; margin-bottom: 0px; height: 148px;"></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-12">
								<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px; margin-top: 10px;"># 청결</label></h5>
								<div class="btn-group-toggle" data-toggle="buttons">
									<label class="btn btn-outline-primary btn-sm">
										<input type="radio" autocomplete="off" style="background: white; color: black;" name="note_bath" value="0"> 목욕함
									</label>
									<label class="btn btn-outline-primary btn-sm">
										<input type="radio" autocomplete="off" style="background: black; color: white;" name="note_bath" value="1"> 목욕안함
									</label>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-12" style="text-align: right;">
								<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px; margin-top: 10px;"># 공개 범위</label></h5>
								<select name="note_secret" class="selectpicker">
									<option value="1">전체공개</option>
									<option value="2">팔로우</option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- modal-body -->
		<div class="modal-footer">
		   	<button type= "submit" class="btn btn-primary"> 등록 </button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal"> 취소 </button>
		</div>	
	</form>					    	
</c:if>
<c:if test="${count == 0}">
	<div class="modal-body" style="height: 100px; ">
		<div class="row" style="text-align: center;">
			<div class="col-md-12">
				<h5 > 등록된 펫이 없습니다 ! 등록 먼저 해주세요.</h5>
			</div>
		</div>
	</div>
	<div class="modal-footer">
	   	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	</div>	
</c:if>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
<div class="modal-header">
	<p class="modal-title" id="exampleModalLabel" style="font-size: 20px"> Pet 일지 변경 </p>
   	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
     	<span aria-hidden="true">&times;</span>
   	</button>
</div>
	<form action="noteModifyPro.cdd" method="post">
	<input type="hidden" name="pet_num" value="${notesDTO.pet_num}"/>
	<input type="hidden" name="note_num" value="${notesDTO.note_num}" />
		<div class="modal-body">
			<div class="container">
				<div class="row">
					<c:if test="${pet_profile eq 'defaultimg.png' }">
						<div class="col-md-6">
							<img src="/cdd/resource/img/logo.png" width="80px" height="80px" style="border-radius: 70%; overflow: hidden;"/>						
						</div>
					</c:if>
					<c:if test="${pet_profile ne 'defaultimg.png' }">
						<div class="col-md-6">
							<img src="/cdd/save/${pet_profile}" width="80px" height="80px" style="border-radius: 70%; overflow: hidden;" />					
						</div>
					</c:if>
					<div class="col-md-3"></div>
					<div class="col-md-3">
						<div class="row"  style="text-align: right;">
							<label style="margin-bottom: 0px; "> # 그날의 기분</label>
							<c:if test="${notesDTO.note_emotion == 1}">
								<img src="/cdd/resource/img/heart-eyes.svg"  width="20px" height="20px"/> 신남 
							</c:if>				
							<c:if test="${notesDTO.note_emotion == 2}">
								<img src="/cdd/resource/img/angry.svg"  width="20px" height="20px"/> 화남 
							</c:if>				
							<c:if test="${notesDTO.note_emotion == 3}">
								<img src="/cdd/resource/img/expressionless.svg"  width="20px" height="20px"/> 우울 
							</c:if>				
							<c:if test="${notesDTO.note_emotion == 4}">
								<img src="/cdd/resource/img/frown.svg"  width="20px" height="20px"/> 슬픔 
							</c:if>				
							<c:if test="${notesDTO.note_emotion == 5}">
								<img src="/cdd/resource/img/dizzy.svg"  width="20px" height="20px"/> 아픔 
							</c:if>				
							<c:if test="${notesDTO.note_emotion == 6}">
								<img src="/cdd/resource/img/smile.svg"  width="20px" height="20px"/> 보통 
							</c:if>				
						</div>
						<div class="row">
						</div>					
					 </div>
				</div> <!-- 이미지 -->	
				<div class="row" style="padding-top: 10px;">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label>날짜</label></h5>
						<p style="font-size: 20px;">${notesDTO.note_date}</p>
					</div>
				</div> <!-- 날짜 -->
				<div class="row">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label> # 오늘의 식사량</label></h5>
						<div class="row">
							<div class="col-md-3" style="padding-right: 0px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">몸무게</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_weight" value="${notesDTO.note_weight}">
								  <div class="input-group-append">
								    <span class="input-group-text">kg</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">건식</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_dry" value="${notesDTO.note_dry}">
								  <div class="input-group-append">
								    <span class="input-group-text">g</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">습식</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control"  name="note_wet" value="${notesDTO.note_wet}">
								  <div class="input-group-append">
								    <span class="input-group-text">g</span>
								  </div>
								</div>
							 </div>
							<div class="col-md-3" style="padding-right: 0px; padding-left: 5px;">
							<p style="font-size: 14px; margin-bottom: 0px;"><label style="margin-bottom: 0px;">음수</label></p>							 	
								<div class="input-group mb-3">
								  <input type="text" class="form-control" name="note_water" value="${notesDTO.note_water}">
								  <div class="input-group-append">
								    <span class="input-group-text">ml</span>
								  </div>
								</div>
							 </div>
						</div>				
					</div>
				</div>	<!-- 신체사항 -->
				<div class="row" style="height: 230px;">
					<div class="col-md-6">
						<h5 class="initialism" style="margin-bottom: 0px;"><label># 이상 증상</label></h5>						
						<div class="row">
							<div class="col-md-12" >
								<div class="form-check">
									<c:if test="${ notesDTO.note_disorder1 eq 'on'}">
										<input class="form-check-input" type="checkbox" name="note_disorder1" checked="checked">
										<label class="form-check-label">
									    구토
										</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									<c:if test="${ notesDTO.note_disorder1 ne 'on'}">
										<input class="form-check-input" type="checkbox" name="note_disorder1">
										<label class="form-check-label">
									    구토
										</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									<c:if test="${ notesDTO.note_disorder2 eq 'on'}">
										<input class="form-check-input" type="checkbox" name="note_disorder2" checked="checked">
										<label class="form-check-label">
										    설사
										</label>
									</c:if>
									<c:if test="${ notesDTO.note_disorder2 ne 'on'}">
										<input class="form-check-input" type="checkbox" name="note_disorder2">
										<label class="form-check-label">
										    설사
										</label>
									</c:if>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
							<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px;">기타</label></h5>
								<textarea class="form-control col-sm-100%" rows="6" name="note_disorder3" style="margin-top: 0px; margin-bottom: 0px; height: 148px;">${notesDTO.note_disorder3}</textarea>
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
										  <input type="text" class="form-control" name="note_stroll1" value="${notesDTO.note_stroll1}">
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
										  <input type="text" class="form-control" name="note_stroll2" value="${notesDTO.note_stroll2}">
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
										  <input type="text" class="form-control" name="note_stroll3"  value="${notesDTO.note_stroll3}">
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
				<div class="row">
					<div class="col-md-12">
						<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-top: 10px; margin-bottom: 0px;"># 오늘의 일기</label></h5>
						<textarea class="form-control col-sm-100%" rows="6" name="note_other" style="margin-top: 0px; margin-bottom: 0px; height: 148px;">${notesDTO.note_other}</textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-12">
								<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px; margin-top: 10px;"># 청결</label></h5>
								<div class="btn-group-toggle" data-toggle="buttons">
									<c:if test="${notesDTO.note_bath == 0}">
										<label class="btn btn-outline-primary btn-sm">
											<input type="radio" autocomplete="off" name="note_bath" value="0" checked="checked"> 목욕함
										</label>
										<label class="btn btn-outline-primary btn-sm">
											<input type="radio" autocomplete="off" name="note_bath" value="1"> 목욕안함
										</label>
									</c:if>
									<c:if test="${notesDTO.note_bath == 1}">
										<label class="btn btn-outline-primary btn-sm">
											<input type="radio" autocomplete="off" name="note_bath" value="0"> 목욕함
										</label>
										<label class="btn btn-outline-primary btn-sm">
											<input type="radio" autocomplete="off" name="note_bath" value="1" checked="checked"> 목욕안함
										</label>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-12">
								<h5 class="initialism" style="margin-bottom: 0px;"><label style="margin-bottom: 0px; margin-top: 10px;"># 공개 범위</label></h5>
								<select name="note_secret" class="selectpicker">
									<c:if test="${notesDTO.note_secret == 1 }">
										<option value="1" selected="selected">전체공개</option>
										<option value="2">팔로우</option>
									</c:if>
									<c:if test="${notesDTO.note_secret == 2 }">
										<option value="1">전체공개</option>
										<option value="2" selected="selected">팔로우</option>
									</c:if>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div> <!-- container -->
		</div><!-- modal-body -->
		<div class="modal-footer">
		   	<button type= "submit" class="btn btn-primary"> 변경 </button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal"> 취소 </button>
		</div>	
	</form>					    	


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>
<script src="/cdd/resource/petInfo.js"></script>
<script src="/cdd/resource/petInfoModify.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
<script>
	$(function(){
       $('.input-group.date').datepicker({
           calendarWeeks: false,	/* 왼쪽에 일년에 몇주차인지 설정 여부 */
           todayHighlight: true,	/* true면 날짜를 강조 표시 */
           autoclose: true,			/* 날짜 선택시 날짜창 즉시 닫을지 여부 */
           format: "yyyy/mm/dd",	/* 출력 방식 */ 
           language: "kr"			/* 달력언어 설정 */
       	});
   	});
</script>

</head>
<body>
<div class="modal-header" style="background-color: yellow;">
		<h5 class="modal-title" id="exampleModalLabel" > Pet 수정 </h5>
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body">
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div class="container" >
						<div class="row border border-warning" style="width: 465px; height: 130px;" >
							<div id="changeImg" class="col-md-3" style="width: 150px; height: 100%; ">
								<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
									<img src="/cdd/save/${pet_infoDTO.pet_profile}" width="100%" height="100%" style="border-radius: 70%; overflow: hidden;">
								</c:if>
								<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'}">
									<img src="../resource/img/${pet_infoDTO.pet_profile}" width="100%" height="100%" style="border-radius: 70%; overflow: hidden;">
								</c:if>
							</div> 
							<div class="col-md-9" style="width: 315px; height: 100%; padding-right: 0;">
								<form id="imgForm" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="pet_numberValue" value="${pet_number}"/>
									<div class="row" style="width: 100%; height: 30px; ">
										<div class="col-md-8" style="padding-left: 0; margin-right: 0;">
											<input type="file" name="pet_profileImg" onclick="addImg();">
										</div>
										<div id="EditBtn" class="col-md-4" style="height: 100%; padding-left: 40px">
										
										</div>
									</div>
								</form>
								<div class="row" style="width: 365px; height: 100px; padding-left: 0; margin-right: 0;">
									<table class="table" style="padding-right: 0;">
								  		<thead class="thead-light">
										    <tr>
												<th scope="col">이름</th>
											    <th scope="col">성별</th>
											    <th scope="col">종류</th>
											    <th scope="col">품종</th>
											</tr>
									  	</thead>
									 	<tbody>
									    	<tr>
											   	<th scope="row">${pet_infoDTO.pet_name}</th>
											   	<c:if test="${pet_infoDTO.pet_gender eq 'male'}">
											   		<td>남</td>
											   	</c:if>
											   	<c:if test="${pet_infoDTO.pet_gender eq 'famale'}">
											   		<td>여</td>
											   	</c:if>
											   	<c:if test="${pet_infoDTO.kind_other == 1}">
												   	<td>${pet_kindName}</td>
											   	</c:if>
											   	<c:if test="${!(pet_infoDTO.kind_other == 1)}">
												   	<td>${pet_infoDTO.kind_other}</td>
											   	</c:if>
											   	<td>${pet_typeName}</td>
									   		</tr>
									  	</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>생일</label>
						</div>
						<div class="row" style=" height: 40px;">
							<div class="col-md-8" style="padding-left: 0px">
								<c:if test="${pet_infoDTO.pet_birth eq '0000.00.00'}">
									<div class="input-group date">
			   							<input type="text" id="pet_birthFix" class="form-control" name="pet_birth" placeholder="등록을 원하시면 날짜를 지정해주세요."><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
								<c:if test="${!(pet_infoDTO.pet_birth eq '0000.00.00')}">
									<div class="input-group date">
			   							<input type="text" id="pet_birthFix" class="form-control" name="pet_birth" value=${ pet_infoDTO.pet_birth }><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<div class="col-md-2" style="padding-left: 0px;">
								<label>모름</label>
								<input type="checkbox" name="pet_birthCheck" >
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>중성화 여부</label>
						</div>
						<div class="row" style="height: 40px;">
							<div class="btn-group-toggle" data-toggle="buttons">
								<c:if test="${pet_infoDTO.pet_tt == 0}">
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_OkBtn" name="pet_tt" value="0" checked="checked"> 했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_NoBtn" name="pet_tt" value="1"> 안했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_Btn" name="pet_tt" value="2"> 모름
									</label>
								</c:if>
								<c:if test="${pet_infoDTO.pet_tt == 1}">
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_OkBtn" name="pet_tt" value="0"> 했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_NoBtn" name="pet_tt" value="1"  checked="checked"> 안했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_Btn" name="pet_tt" value="2"> 모름
									</label>
								</c:if>
								<c:if test="${pet_infoDTO.pet_tt == 2}">
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_OkBtn" name="pet_tt" value="0" > 했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_NoBtn" name="pet_tt" value="1"> 안했음
									</label>
									<label class="btn btn-secondary">
										<input type="radio" autocomplete="off" id="tt_Btn" name="pet_tt" value="2" checked="checked"> 모름
									</label>
								</c:if>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>중성화 시기</label>
						</div>
						<div class="row" style="height: 40px;">
							<div class="col-md-8" style="padding-left: 0px">
								<c:if test="${pet_infoDTO.pet_ttday eq '0000.00.00'}">
									<div class="input-group date">
			   							<input type="text" class="form-control" id="pet_ttdayFix" name="pet_ttday" placeholder="등록을 원하시면 날짜를 지정해주세요."><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
								<c:if test="${!(pet_infoDTO.pet_ttday eq '0000.00.00')}">
									<div class="input-group date">
			   							<input type="text" class="form-control" id="pet_ttdayFix" name="pet_ttday" value="${pet_infoDTO.pet_ttday}"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<div class="col-md-2" style="padding-left: 0px;">
								<label>모름</label>
								<input type="checkbox" name="pet_ttdayCheck">
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>입양 날</label>
						</div>
						<div class="row" style="height: 40px;">
							<div class="col-md-8" style="padding-left: 0px">
								<c:if test="${pet_infoDTO.pet_meet eq '0000.00.00'}">
									<div class="input-group date">
		   								<input type="text" class="form-control" id="pet_meetFix" name="pet_meet" placeholder="등록을 원하시면 날짜를 지정해주세요."><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
								<c:if test="${!(pet_infoDTO.pet_meet eq '0000.00.00')}">
									<div class="input-group date">
		   								<input type="text" class="form-control" id="pet_meetFix" name="pet_meet" value="${pet_infoDTO.pet_meet}"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</c:if>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<div class="col-md-2" style="padding-left: 0px;">
								<label>모름</label> 
								<input type="checkbox" name="pet_meetCheck">
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<div class="col-md-9 col-md-offset-9"></div>
							<div class="col-md-3">
								<a class="btn btn-primary" href="#carouselExampleIndicators" role="button" data-slide="next" onclick="infoModify(${pet_number});"> 
									다음
								</a>
							 </div>
						</div>
						<div class="row" style="height: 30px;">
						</div>
					</div>
				</div>
				<div class="carousel-item">	<!-- 2Page -->
					<div class="container">
						<div class="row" style="height: 40px;">
							<h4><label>질환 기록</label></h4>
						</div>
						<c:if test="${sickCount > 0}">
							<div class="row">
								<table class="table">
									<thead class="thead-light">
									    <tr>
											<th scope="col">질병상태</th>
											<th scope="col">질환명</th>
										    <th scope="col">진료 병원</th>
										    <th scope="col">진료 날짜</th>
									    </tr>
									</thead>
									<tbody>
									<c:forEach var="pet_sickDTOList" items="${pet_sickDTOList}">										  
									    <tr>
									    	<c:if test="${ pet_sickDTOList.sick_status == 0 }">
											   	<td>보유중</td>
									    	</c:if>
									    	<c:if test="${pet_sickDTOList.sick_status == 1 }">
											   	<td>완치</td>
									    	</c:if>
										   	<th>${pet_sickDTOList.pet_sickname}</th>
										   	<td>${pet_sickDTOList.pet_hospital}</td>
										   	<td>${pet_sickDTOList.pet_sickday}</td>
									    </tr>
									</c:forEach>
								  </tbody>
								</table>
							</div>
						</c:if>
						<c:if test="${sickCount == 0}">
							<div class="row" style="height: 40px;">
								<label>질환 기록이 없습니다. 등록해주세요.</label>
							</div>
						</c:if>
						<div id="sickBtnDelete" class="row" style="padding-bottom: 20px;">
							 <button class="btn btn-primary" type="button" onclick="sick_Add();">추가</button>
						</div>
						 <div id="sickModify" >
						 	
						</div>
						<div class="row" style="height: 40px;">
							<h4><label>접종 기록</label></h4>
						</div>
						<c:if test="${jjCount > 0}">
							<div class="row">
								<table class="table">
									<thead class="thead-light">
									  	<tr>
											<th scope="col">접종명</th>
										    <th scope="col">접종 병원</th>
										    <th scope="col">접종 날짜</th>
									    </tr>
									</thead>
									<tbody>
									<c:forEach var="pet_jjDTOList" items="${pet_jjDTOList}">
									  	<tr>
										    <th scope="row">${pet_jjDTOList.pet_jjname}</th>
										    <td>${pet_jjDTOList.pet_jjhospital}</td>
										    <td>${pet_jjDTOList.pet_jjday}</td>
									    </tr>
									</c:forEach>
								  </tbody>
								</table>
							</div>
						</c:if>
						<c:if test="${jjCount == 0}">
							<div class="row" style="height: 40px;">
								<label>접종 기록이 없습니다. 등록해주세요.</label>
							</div>
						</c:if>
						<div id="jjBtnDelete" class="row" style="padding-bottom: 20px;">
							<button class="btn btn-primary" type="button" onclick="jj_Add();">추가</button>			
						</div>
						<div id="jjModify">
						
						</div>
						<div class="row" style="height: 40px;">
							<h4><label>수술 기록</label></h4>
						</div>
						<c:if test="${surgCount > 0}">
							<div class="row">
								<table class="table">
									<thead class="thead-light">
									  	<tr>
											<th scope="col">수술명</th>
										    <th scope="col">수술 병원</th>
										    <th scope="col">수술 날짜</th>
									    </tr>
									</thead>
									<tbody>
										<c:forEach var="pet_surgDTOList" items="${pet_surgDTOList}">
										  	<tr>
											    <th scope="row">${pet_surgDTOList.pet_surgname}</th>
											    <td>${pet_surgDTOList.pet_surghospi}</td>
											    <td>${pet_surgDTOList.pet_surgday}</td>
										    </tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:if>
						<c:if test="${surgCount == 0}">
							<div class="row" style="height: 40px;">
								<label>수술 기록이 없습니다. 등록해주세요.</label>
							</div>
						</c:if>
						<div id="surgBtnDelete" class="row" style="padding-bottom: 40px;">
							<button class="btn btn-primary" type="button" onclick="surg_Add();">추가</button>
						</div>
						<div id="surgModify" style="padding-bottom: 40px;">
							
						</div>
						<div class="row" style="height: 40px;">
							<div class="col-md-3">
								<a href="#carouselExampleIndicators" role="button" data-slide="prev"> 
									<button class="btn btn-primary" type="button" >이전</button>	
								</a>
							</div>
							<div class="col-md-6"></div>
							<div class="col-md-3">
								<a href="#carouselExampleIndicators" role="button"> 
									<button class="btn btn-primary" type="button" data-dismiss="modal" onclick="petSickModify(${pet_number})"> 완료 </button>	
								</a>
							</div>
						</div>
						<div class="row" style="height: 30px">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>


<script>
/* 슬라이드 정지 */
$('.carousel').carousel({
  interval: 0
});

function sick_Add(){
	$("#sickBtnDelete").empty();
	
	var html = "";
	html += '<div class="row" style="height: 40px;">';
	html += '<div class="btn-group" data-toggle="buttons">';
	html += '<label class="btn btn-secondary">';
	html += '<input type="radio" autocomplete="off" name="sick_status" value="0"> 보유중';
	html += '</label>';
	html += '<label class="btn btn-secondary">';
	html += '<input type="radio" autocomplete="off" name="sick_status" value="1"> 완치됨';
	html += '</label>';
	html += '</div>';
	html += '</div>';
	
	html += '<div class="row" style="height: 30px;">';
	html += '<label>병명</label>';
	html += '</div>';
	html += '<div class="row" style="height: 30px;">';
	html += '<input type="text" name="pet_sickname"/>';
	html += '</div>';
	
	html += '<div class="row" style="height: 30px;">';
	html += '<label>판정 날짜 </label>';
	html += '</div>';
	html += '<div class="row" style="height: 40px;">';
	html += '<div class="col-md-6" style="padding-left: 0px">';
	html += '<input type="text" name="pet_sickday" placeholder="ex) 2021/01/01">';
	html += '</div>';
	html += '</div>';
		
	html += '<div class="row" style="height: 30px;">';
	html += '<label>진료 병원</label>';
	html += '</div>';
	html += '<div class="row" style="height: 30px;  padding-bottom: 50px; ">';
	html += '<input type="text" name="pet_hospital"/>';
	html += '</div>';
	
	$("#sickModify").append(html);
	
	
	
}; //sick_Add();

function jj_Add(){
	$("#jjBtnDelete").empty();
	
	var html = '';
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>접종명</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<input type="text" name="pet_jjname"/>';
	html +=	'</div>';
	
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>접종 날짜</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 40px;">';
	html +=	'<div class="col-md-6" style="padding-left: 0px">';
	html +=	'<input type="text" name="pet_jjday" placeholder="ex) 2021/01/01">';
	html +=	'</div>';
	html +=	'</div>';
	
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>접종 병원</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 30px; padding-bottom: 50px;">';
	html +=	'<input type="text" name="pet_jjhospital"/>';
	html +=	'</div>';
	html +=	'</div>';
	html +=	'</div>';

	$("#jjModify").append(html);
	
};//jj_Add();
function surg_Add(){
	$("#surgBtnDelete").empty();
	
	var html ='';
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>수술명</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<input type="text" name="pet_surgname"/>';
	html +=	'</div>';
	
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>수술 날짜</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 40px;">';
	html +=	'<div class="col-md-6" style="padding-left: 0px">';
	html +=	'<input type="text" name="pet_surgday" placeholder="ex) 2021/01/01">';
	html +=	'</div>';
	html +=	'</div>';
	
	html +=	'<div class="row" style="height: 30px;">';
	html +=	'<label>수술 병원</label>';
	html +=	'</div>';
	html +=	'<div class="row" style="height: 30px; padding-bottom: 30px;">';
	html +=	'<input type="text" name="pet_surghospi"/>';
	html +=	'</div>';
	html +=	'</div>';
	html +=	'</div>';
		
	$("#surgModify").append(html);
	
};//surg_Add();



</script>
</html>
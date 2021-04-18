<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>

<!-- 달력 사용 CDN -->
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
$('.carousel').carousel({
	   interval: 100000000
});
</script>
<script src="/cdd/resource/petInfo.js"></script>

</head>
<body>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel" > Pet 등록 </h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>

<div class="modal-body">
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<form action="/cdd/myPage/petInfoPro.cdd" method="post" enctype="multipart/form-data">
				<div class="carousel-item active">
					<div class="container">
						<div class="row" >
							<label>성별</label>
						</div>
						<div class="row">
							<div class="btn-group-toggle" data-toggle="buttons">
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" name="pet_gender" value="male"> 남
								</label>
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" name="pet_gender" value="famale"> 여
								</label>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>생일</label>
						</div>
						<div class="row" style=" height: 40px;">
							<div class="col-md-6" style="padding-left: 0px">
								<div class="input-group date">
		   							<input type="text" id="pet_birthFix" class="form-control" name="pet_birth" ><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
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
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" id="tt_OkBtn" name="pet_tt" value="0"> 했음
								</label>
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" id="tt_NoBtn" name="pet_tt" value="1"> 안했음
								</label>
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" id="tt_Btn" name="pet_tt" value="2"> 모름
								</label>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>중성화 시기</label>
						</div>
						<div class="row" style="height: 40px;">
							<div class="col-md-6" style="padding-left: 0px">
								<div class="input-group date">
		   							<input type="text" class="form-control" id="pet_ttdayFix" name="pet_ttday"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
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
							<div class="col-md-6" style="padding-left: 0px">
								<div class="input-group date">
	   								<input type="text" class="form-control" id="pet_meetFix" name="pet_meet"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
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
								<a href="#carouselExampleIndicators" role="button" data-slide="next"> 
									<button class="btn btn-primary" type="button" >다음</button>	
								</a>
							 </div>
						</div>
						<div class="row" style="height: 30px;">
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div class="container">
						<div class="row" style="height: 30px;">
							<label> 반려동물 </label>
						</div>
						<div class="row" style="height: 40px;">
							<div class="btn-group-toggle" data-toggle="buttons">
								<c:forEach var="pettype" items="${pettype}" >
									<label class="btn btn-outline-primary">
										<input class="typebtn" type="radio" autocomplete="off" name="type_num" value="${pettype.type_num}" /> ${pettype.type_name}
									</label>
								</c:forEach>
							</div>
						</div>
						<div class="row" style="height: 30px;">
							<label> 품종 </label>
						</div>
						<div id="petkind" class="row" style="height: 100px;">
							
						</div>
						<div class="row" style="height: 40px;" >
							<button name="type_num" class="btn btn-primary" type="button" data-toggle="collapse" data-target="#other" aria-expanded="false" aria-controls="collapseExample" style="background: gray;">
								기타
							</button>
							<div style="font-size: 12px; vertical-align: bottom;" >품종이 없으시면 기타를 눌러주세요</div>
						</div>	
						<div class="row" style="height: 30px;">
							<div class="collapse" id="other">
					 			<div class="well">
					 				<input type="text" name="kind_other" />
					 			</div>
					 		</div>
						</div>
						<div class="row" style="height: 30px;">
							<label>나의 펫 사진 등록</label>							
						</div>
						<div class="row" style="height: 30px;">
							<input type="file" name="pet_profileImg">
						</div>
						<div class="row" style="height: 30px;">
							<label> 동물 이름 </label>							
						</div>
						<div class="row" style="height: 30px;">
							<input type="text" name="pet_name"/>
						</div>
							<div class="row" style="height: 30px;">
						</div>
						<div class="row" style="height: 30px;">
							<div class="col-md-3"> 
								<a href="#carouselExampleIndicators" role="button" data-slide="prev"> 
									<button class="btn btn-primary" type="button" >이전</button>	
								</a>
							</div>
							<div class="col-md-6"></div>
							<div class="col-md-3"> 
								<a href="#carouselExampleIndicators" role="button" data-slide="next"> 
									<button class="btn btn-primary" type="button" >다음</button>	
								</a>
							</div>
						</div>
					</div>
					<div class="row" style="height: 30px;">
					</div>
				</div>
				<div class="carousel-item">
					<div class="container">
						<div class="row" style="height: 40px;">
							<div class="btn-group-toggle" data-toggle="buttons">
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" name="sick_status" value="0"> 보유중
								</label>
								<label class="btn btn-outline-primary">
									<input type="radio" autocomplete="off" name="sick_status" value="1"> 완치됨
								</label>
							</div>
						</div>
						<div class="row" style="height: 40px;">
							<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#pet_sick" aria-expanded="false" aria-controls="collapseExample" style="background: gray;">
								  보유질환
							</button>
						</div>
						<div class="collapse" id="pet_sick">
							<div class="well">
								<div class="row" style="height: 30px;">
									<label>병명</label>
								</div>
								<div class="row" style="height: 30px;">
									<input type="text" name="pet_sickname"/>
								</div>
								<div class="row" style="height: 30px;">
									<label>판정 날짜 </label>
								</div>
								<div class="row" style="height: 40px;">
									<div class="col-md-6" style="padding-left: 0px">
										<div class="input-group date">
											<input type="text" class="form-control" name="pet_sickday"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
									</div>
								</div>
								<div class="row" style="height: 30px;">
									<label>진료 병원</label>
								</div>
								<div class="row" style="height: 30px;  padding-bottom: 50px; ">
									<input type="text" name="pet_hospital"/>
								</div>
							</div>
						</div>
						<div class="row" style="height: 40px;">
							<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#pet_jj" aria-expanded="false" aria-controls="collapseExample" style="background: gray;">
								접종기록
							</button>
						</div>
						<div class="collapse" id="pet_jj">
							<div class="well">
								<div class="row" style="height: 30px;">
									<label>접종명</label>
								</div>
								<div class="row" style="height: 30px;">
									<input type="text" name="pet_jjname"/>
								</div>
								<div class="row" style="height: 30px;">
									<label>접종 날짜</label>
								</div>
								<div class="row" style="height: 40px;">
									<div class="col-md-6" style="padding-left: 0px">
										<div class="input-group date">
  											<input type="text" class="form-control" name="pet_jjday"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
									</div>
								</div>
								<div class="row" style="height: 30px;">
									<label>접종 병원</label>
								</div>
								<div class="row" style="height: 30px; padding-bottom: 50px;">
									<input type="text" name="pet_jjhospital"/>
								</div>
							</div>
						</div>
						<div class="row" style="height: 40px; padding-bottom: 40px">
							<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#pet_surg" aria-expanded="false" aria-controls="collapseExample" style="background: gray;">
								 수술기록
							</button>
						</div>
						<div class="collapse" id="pet_surg">
				 			<div class="well">
								<div class="row" style="height: 30px;">
									<label>수술명</label>
								</div>
								<div class="row" style="height: 30px;">
									<input type="text" name="pet_surgname"/>
								</div>
								<div class="row" style="height: 30px;">
									<label>수술 날짜</label>
								</div>
								<div class="row" style="height: 40px;">
									<div class="col-md-6" style="padding-left: 0px">
										<div class="input-group date">
  											<input type="text" class="form-control" name="pet_surgday"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
									</div>
								</div>
								<div class="row" style="height: 30px;">
									<label>수술 병원</label>
								</div>
								<div class="row" style="height: 30px;">
									<input type="text" name="pet_surghospi"/>
								</div>
							</div>
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
									<button class="btn btn-primary" type="submit"> 저장</button>	
								</a>
							</div>
						</div>
						<div class="row" style="height: 30px">
						</div>
					</div>
				</div>
			</form>	
		</div>
	</div>
</div>


</body>
</html>
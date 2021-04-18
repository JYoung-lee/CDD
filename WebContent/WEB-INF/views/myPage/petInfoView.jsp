<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>
</head>
<body>
<div class="modal-header" >
		<h5 class="modal-title" id="exampleModalLabel" > ${pet_infoDTO.pet_name} 의 정보 </h5>
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body" >
		<div class="container" >
			<div class="row border border-warning" style="width: 465px; height: 100px;" >
				<div class="col-md-3" style="width: 100px; height: 100%; ">
					<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
						<img src="/cdd/save/${pet_infoDTO.pet_profile}" width="100%" height="100%">
					</c:if>
					<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'}">
						<img src="../resource/img/${pet_infoDTO.pet_profile}" width="100%" height="100%">
					</c:if>
				</div>
				<div class="col-md-9" style="width: 365px; height: 100%; padding-left: 0; padding-right: 0;">
					<table class="table" style="text-align: center;">
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
			<div class="row" style="text-align: center;">
				<table class="table">
			  		<thead class="thead-light">
					    <tr>
							<th scope="col">생일</th>
						    <th scope="col">중성화</th>
						    <th scope="col">입양날</th>
						</tr>
				  	</thead>
				 	<tbody>
				    	<tr>
				    		<c:if test="${pet_infoDTO.pet_birth eq '0000.00.00'}">
					   			<td> - </td>
					   		</c:if>
				    		<c:if test="${!(pet_infoDTO.pet_birth eq '0000.00.00')}">
					   			<td>${pet_infoDTO.pet_birth}</td>
					   		</c:if>
					   		<c:if test="${pet_infoDTO.pet_tt == 0}">
					   			<td>${pet_infoDTO.pet_ttday}</td>
					   		</c:if>
					   		<c:if test="${pet_infoDTO.pet_tt == 1 || pet_infoDTO.pet_tt == 2}">
					   			<td> - </td>
					   		</c:if>
					   		<c:if test="${pet_infoDTO.pet_meet eq '0000.00.00'}">
					   			<td> - </td>
					   		</c:if>
					   		<c:if test="${!(pet_infoDTO.pet_meet eq '0000.00.00')}">
							   	<td>${pet_infoDTO.pet_meet}</td>
					   		</c:if>
				   		</tr>
				  	</tbody>
				</table>
			</div>
			<div class="row" style="height: 40px;">
				<h4><label>질환 기록</label></h4>
			</div>
				<div class="row">
					<table class="table" style="text-align: center;">
						<c:if test="${sickCount == 1}">
					  		<thead class="thead-light">
							    <tr>
									<th scope="col">질환상태</th>
								    <th scope="col">질환명</th>
								    <th scope="col">진료 병원</th>
								    <th scope="col">진료 날짜</th>
								</tr>
						  	</thead>
						 	<tbody>
						 		<c:if test="${sickCount > 0}">
						    		<c:forEach var="pet_sickDTOList" items="${pet_sickDTOList}">
								    	<tr>
								    		<c:if test="${pet_sickDTOList.sick_status == 0}">
									    		<td>보유중</td>
								    		</c:if>
								    		<c:if test="${pet_sickDTOList.sick_status == 1}">
									    		<td>완치됨</td>
								    		</c:if>
								    		<td>${pet_sickDTOList.pet_sickname}</td>
								    		<td>${pet_sickDTOList.pet_hospital}</td>
											<td>${pet_sickDTOList.pet_sickday}</td>
								   		</tr>
						    		</c:forEach>
						    	</c:if>	
						  	</tbody>
						</c:if>
						<c:if test="${sickCount == 0}">
							<tr>
								<td colspan="3">등록 되어 있지 않습니다.</td>
							</tr>
						</c:if>
					</table>
				</div>
			<div class="row" style="height: 40px;" >
				<h4><label>접종 기록</label></h4>
			</div>
				<div class="row">
					<table class="table" style="text-align: center;">
				  		<thead class="thead-light">
						    <tr>
							    <th scope="col">접종 명</th>
							    <th scope="col">접종 병원</th>
							    <th scope="col">접종 날짜</th>
							</tr>
					  	</thead>
					 	<tbody>
							<c:if test="${jjCount > 0}">
						 		<c:forEach var="pet_jjDTOList" items="${pet_jjDTOList}">
						    	<tr>
						    		<td>${pet_jjDTOList.pet_jjname}</td>
						    		<td>${pet_jjDTOList.pet_jjhospital}</td>
									<td>${pet_jjDTOList.pet_jjday}</td>
						   		</tr>
						 		</c:forEach>
							</c:if>
					  	</tbody>
						<c:if test="${jjCount == 0}">
							<tr>
								<td colspan="3">등록 되어 있지 않습니다.</td>
							</tr>
						</c:if>
					</table>
				</div>
			<div class="row" style="height: 40px;">
				<h4><label>수술 기록</label></h4>
			</div>
			<div class="row">
				<table class="table" style="text-align: center;">
			  		<thead class="thead-light">
					    <tr>
						    <th scope="col">수술 명</th>
						    <th scope="col">수술 병원</th>
						    <th scope="col">수술 날짜</th>
						</tr>
				  	</thead>
				 	<tbody>
						<c:if test="${surgCount > 0}">
					 		<c:forEach var="pet_surgDTOList" items="${pet_surgDTOList}">
						    	<tr>
						    		<td>${pet_surgDTOList.pet_surgname}</td>
						    		<td>${pet_surgDTOList.pet_surghospi}</td>
									<td>${pet_surgDTOList.pet_surgday}</td>
						   		</tr>
					 		</c:forEach>
						</c:if>
				  	</tbody>
					<c:if test="${surgCount == 0}">
						<tr>
							<td colspan="3">등록 되어 있지 않습니다.</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
		<div class="modal-footer">
        	<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
    	</div>
	</div>						
</body>
</html>
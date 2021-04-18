<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body class="all">
<div class="cddHeader"> 
</div>
<br/><br/><br/><br/>
<div class="container" >
	<div class="row">
		<div class="col-md-2 col-md-offset-2">
		</div>
		<div class="col-md-4" style="background-color: white;">
			<div class="row">
				<div class="col">
					<h3 style="font-weight: bolder;"> 종류 </h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="row petTypeBtn">
						<div class="col" id="petType${list.type_num}" style="padding-bottom: 5px;">
							<div class="btn btn-group-toggle" data-toggle="buttons">
								<c:forEach var="list" items="${petTypes}" varStatus="status">
									<label class="btn btn-light" style="width: 100px;">
								    	<input type="radio" id="petType" onclick="printKind(${list.type_num})"> ${list.type_name}
								  	</label>
								  	<a role="button" onclick="removeType(${list.type_num})"><i class="fas fa-minus-circle"></i></a><br/>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col" >
				<br/><br/>
					<input type="text" class="form-control" id="typeAdd" style="display: inline; width: 200px;">
					<a role="button" onclick="addType()"><i class="fas fa-plus-circle"></i></a>
				</div>
			</div>
		</div>
		<div class="col-md-1 col-dm-offset-1" style="background-color: white;"></div>
		<div class="col-md-3" style="background-color: white;">
			<div class="row">
				<div class="col" >
					<h3 style="font-weight: bolder;"> 품종 </h3>
				</div>
			</div>
			<div class="row">
				<div class="col petKindBtn" style="max-height: 500px; overflow: auto;">
				<h5 style="color: gray;">종류를 선택해주세요</h5>
				</div>
			</div>
			<div class="row">
				<div class="col inputKind">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script>
		function addType(){
			var typeAdd = $("#typeAdd").val();
			if(typeAdd == ""){
				alert("종류를 입력하세요!!");
				return false;
			}else{
				var ajaxJson = new Object;
				ajaxJson.typeAdd = typeAdd;
				var sendData = JSON.stringify(ajaxJson);
				$.ajax({
					url : "/cdd/admin/ajaxAddType.cdd",
					contentType : 'application/json;charset=UTF-8',
					method : "POST",
					data : sendData,
					success: function(){
						location.reload();
					}
				});
			}
		}
		
		function removeType(typeNum){
				var ajaxJson = new Object;
				ajaxJson.typeNum = typeNum;
				var sendData = JSON.stringify(ajaxJson);
				$.ajax({
					url : "/cdd/admin/ajaxRemoveType.cdd",
					contentType : 'application/json;charset=UTF-8',
					method : "POST",
					data : sendData,
					success : function(){
						location.reload();
					}
				});
		}
		
		function printKind(typeNum){
			var ajaxJson = new Object;
			ajaxJson.typeNum = typeNum;
			var sendData = JSON.stringify(ajaxJson);
			$.ajax({
				url : "/cdd/admin/ajaxPrintKind.cdd",
				contentType: 'application/json;charset=UTF-8',
				method : "POST",
				data : sendData,
				success : function(res){
					var kindList = JSON.parse(res);
					appendKind(kindList, typeNum);
				}
			});
		}
		function appendKind(kindList, typeNum){
			var html = "";
			if(kindList.length == 0){
				html += "<h5 style='color: gray;'>등록된 품종이 없습니다</h5>";
				/* html += "<br/><br/><input type='text' class='form-control' id='kindAdd' style='display: inline; width: 200px;'/>";
				html += "<a role='button' onclick='addKind("+typeNum+")''><i class='fas fa-plus-circle'></i></a>"; */
			}else{
				var type_num = kindList[0].type_num;
				for(var i=0; i<kindList.length; i++){
					html += "<div class='row'>";
					html += "<div class='col' id='petKind"+kindList[i].kind_num+"' style='padding-bottom: 5px;'>";
					html += "<div class='btn-group-toggle' data-toggle='buttons'>";
					html += "<label class='btn btn-secondary' style='width: 200px;'>";
					html += "<input type='radio' disabled='disabled'>"+kindList[i].kind_name;
					html += "</label>";
					html += "<a role='button' onclick='removeKind("+kindList[i].kind_num+", "+kindList[i].type_num+")'><i class='fas fa-minus-circle'></i></a> <br/>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
				}
			}
			$(".petKindBtn").empty();
			$(".petKindBtn").append(html);
			
			html2="";
			html2 += "<br/><br/><input type='text' class='form-control' id='kindAdd' style='display: inline; width: 200px;'>";
			html2 += "<a role='button' onclick='addKind("+typeNum+")''><i class='fas fa-plus-circle'></i></a>";
				
				
			$(".inputKind").empty();
			$(".inputKind").append(html2);
		}
		
		function addKind(typeNum){
			var inputKind = $("#kindAdd").val();
			var ajaxJson = new Object;
			ajaxJson.inputKind = inputKind;
			ajaxJson.typeNum = typeNum;
			var sendData = JSON.stringify(ajaxJson);
			$.ajax({
				url : "/cdd/admin/ajaxAddKind.cdd",
				contentType : 'application/json;charset=UTF-8',
				method : "POST",
				data : sendData,
				success : function(){
					printKind(typeNum);
				}
			});
		}
		
		function removeKind(kindNum, typeNum){
			var ajaxJson = new Object;
			ajaxJson.kindNum = kindNum;
			var sendData = JSON.stringify(ajaxJson);
			$.ajax({
				url : "/cdd/admin/ajaxRemoveKind.cdd",
				contentType : 'application/json;charset=UTF-8',
				method : "POST",
				data : sendData,
				success : function(){
					printKind(typeNum);
				}
			});
		}
</script>
</html>
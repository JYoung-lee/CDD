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
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd?category=dm");
	});
</script>
</head>
<body class="all">
<div class="cddHeader"> 
</div>
<br/><br/><br/><br/>
<div class="container" style="width: 1000px;">
	<div class="row">
		<div class="col-md-1 col-md-offset-1"></div>
		<div class="col-md-2" style="border-left: 2px solid lightgray; border-top: 2px solid lightgray; border-bottom: 2px solid lightgray;
		background-color: white; height:50px; padding-top: 5px; width: 40;" align="right">
			<h4 style="margin:0px; display: inline; color: gray;">${user.user_id }</h4>
			<input type="hidden" id="memId" value="${user.user_id }"/>
		</div>
		<div class="col-md-1" style="border-top: 2px solid lightgray; border-right: 2px solid lightgray; border-bottom: 2px solid lightgray;
		background-color: white; padding:0px;" align="right">
			<div class="dropdown" style="float: right;">
			  <a class="btn btn-secondary" type="button" id="dropdownMenuButton" data-toggle="dropdown" 
			  	aria-haspopup="true" aria-expanded="false" style="background-color: white; border:none;">
			    <img src="/cdd/resource/img/write.png" width="20px" style="margin-top: 10px;">
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="width:150px; height:auto; max-height:300px; overflow: auto;">
			  	<c:if test="${followList == '[]' }">
			  		<h5 style="font-weight: bolder; color: gray;" align="center">친구가 없습니다 ㅠ_ㅠ</h5>
			  	</c:if>
			  	<c:forEach var="user" items="${followList }">
			  	<div style="display: inline-block;"><img style="border-radius: 70%; width: 30px; height: 30px;" src="/cdd/save/${user.user_profile}"/></div>
				    <div style="display: inline-block;"><a class="dropdown-item followUser" data-toggle="modal" 
				    	data-target="#sendDmFormView" role="button" onclick="sendValue(this)">${user.user_to}</a></div>
			  	</c:forEach>
			  </div>
			</div>
		</div>
		<div class="col-md-7" style="border-top: 2px solid lightgray; border-right: 2px solid lightgray; border-bottom: 2px solid lightgray;
			background-color: white; padding-top:7px;">
			<div class="row">
				<div class="col" >
					<h3 style="display:inline; color: gray;" id="chatUserId"></h3>
				</div>
				<div class="col" id="deleteDiv"  align="right">
					
				</div>
			</div>
		</div>
		<div class="col-md-1 col-md-offset-1"></div>
	</div>
	<div class="row">
		<div class="col-md-1 col-md-offset-1"></div>
		<div class="col-md-3" style="border-left: 2px solid lightgray; border-right: 2px solid lightgray; border-bottom: 2px solid lightgray; 
		height: 550px; overflow: auto; background-color: white; padding: 0px;">
			<div class=" btn-group-toggle" data-toggle="buttons" >
				<c:forEach var="map" items="${chatUserAndStatus }">
				  <label class="btn btn-outline-secondary active" style="width:100%;">
				    <input type="radio" name="options" class="dmList" value="${map.key}" > ${map.key}
				    <c:if test="${map.value > 0 }">
				    	<img src="/cdd/resource/img/redcircle.png" width="10px" />
				    </c:if>
				  </label>
				  <br/>
				</c:forEach>
			</div>
		</div>
		<!-- Dm List -->
		<div class="col-md-7" id="dmsgs" style="height: 550px; background-color: white;
			border-right: 2px solid lightgray; border-bottom: 2px solid lightgray;">
			
		</div>
		<div class="col-md-1 col-md-offset-1"></div>
	</div>
	</div>
	<div id="sendDmFormView" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="z-index: 1000;  width: 500px;">
			<div class="modal-content" style="height: 150px;" >
				<div class="modal-header">
			        <h5 class="modal-title">To.&nbsp;&nbsp;</h5><h5 class="modal-title" id="chatIdFromFollow"></h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
				</div>
				<div class="modal-body">
					<input type='text' class='form-control' id='sendContentFromForm' 
						style='width:80%; height:30px; display:inline; margin-right: 10px;'/>
					<button type='button' class='btn btn-outline-secondary' style='font-size: 10pt; height:30px;' id='sendDmBtn'>보내기</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		// dm수신자 아이디를 모달로 보내기
		function sendValue(toId){
			var chatId = $(toId).text();
			$("#chatIdFromFollow").text(chatId);
		}
		
		$(document).ready(function(){
			
			// dmList 가져오기 
			function getDmList(chatId, memId){
				var ajaxJson = new Object;
				ajaxJson.memId = memId;
				ajaxJson.chatId = chatId;
				var sendData = JSON.stringify(ajaxJson);
				$.ajax({
					url : "/cdd/ajaxGetDmList.cdd",
					contentType: 'application/json;charset=UTF-8',
					method : "POST",
					data : sendData,
					success: function(data){
						var dmList = JSON.parse(data);
						appendDmList(dmList, chatId);
					}
				});
			}
			
			// DM 삽입
			function insertDm(chatId, memId, sendContent){
				if(sendContent == "" || chatId == ""){
					alert("입력해라!!");
				}else{
					var ajaxJson = new Object;
					ajaxJson.memId = memId;
					ajaxJson.chatId = chatId;
					ajaxJson.sendContent = sendContent;
					var sendData = JSON.stringify(ajaxJson);
					$.ajax({
						url : "/cdd/ajaxSendDm.cdd",
						contentType: 'application/json;charset=UTF-8',
						method : "POST",
						data : sendData,
						success: function(){
							getDmList(chatId, memId);
						}
					});
				}
			}
			
			// DM 삽입 (새로운 대화 시작)
			function justInsertDm(chatId, memId, sendContent){
				if(sendContent == "" || chatId == ""){
					alert("입력해라!!");
				}else{
					var ajaxJson = new Object;
					ajaxJson.memId = memId;
					ajaxJson.chatId = chatId;
					ajaxJson.sendContent = sendContent;
					var sendData = JSON.stringify(ajaxJson);
					$.ajax({
						url : "/cdd/ajaxSendDm.cdd",
						contentType: 'application/json;charset=UTF-8',
						method : "POST",
						data : sendData,
						success: function(){
							location.reload();
						}
					});
				}
			}
			
			// 새 DM 보낼 때 이벤트
			$("#sendDmBtn").click(function(){
				var chatId = $("#chatIdFromFollow").text();
				var memId = $("#memId").val();
				var sendContent = $("#sendContentFromForm").val();
				justInsertDm(chatId, memId, sendContent);
			})
			
			// 대화 이력이 있는 사람을 클릭했을 때 이벤트 
			$(".dmList").click(function(){
				var chatId = $(this).attr('value');
				//var chatId = $(".dmList").val();
				var memId = $("#memId").val();
				getDmList(chatId, memId);
			});

			// DM 삭제
			function deleteDm(chatId, memId){
				var ajaxJson = new Object;
				ajaxJson.chatId = chatId;
				ajaxJson.memId = memId;
				var sendData = JSON.stringify(ajaxJson);
				$.ajax({
					url: "/cdd/ajaxDeleteDM.cdd",
					contentType: 'application/json;charset=UTF-8',
					method: "POST",
					data: sendData,
					success: function(){
						location.reload();
					}
				});
			}
			
			// dmList 화면에 출력
			function appendDmList(dmList, chatId){
				var html = "";
				html+= "<div class='row'>";
				html+= "<div class='col' id='msgList' style='height: 480px; overflow: auto;";
				html+= "padding-top: 10px; padding-bottom: 10px;'>";
				html+= "<br/>";
				for(var i=0; i<dmList.length; i++){
					if(dmList[i].sender == dmList[i].userId){
						html+= "<div style='text-align: right;'>";
						html+= "<a style='background-color : lightgray; border-radius: 10px; padding:10px;' align='right'>"+dmList[i].content+"</a><br/><br/>";
						html+= "</div>";
					}
					if(dmList[i].receiver == dmList[i].userId){
						html+= "<div style='text-align: left;'>";
						html+= "<a style='border: 2px solid lightgray; border-radius: 10px; padding:10px;' align='right'>"+dmList[i].content+"</a><br/><br/>";
						html+= "</div>";
					}
				}
				html+= "</div>";
				html+= "</div>";
				html+= "<div class='row'>";
				html+= "<div class='col' style='height:70px; padding-top:10px;'>";
				html+= "<input type='text' class='form-control' id='sendContent' style='width:85%; display:inline; margin-right: 10px;'/>";
				html+= "<button type='button' class='btn btn-outline-secondary' style='font-size: 10pt;' id='sendDmBtn'>보내기</button>";
				html+= "</div>";
				html+= "</div>";
				html+="<input type='hidden' value='"+chatId+"' id='chatId' />";
				
				$("#dmsgs").empty();
				$("#dmsgs").append(html);
				$("#msgList").scrollTop($("#msgList")[0].scrollHeight);
				
				var html2 = "<a role='button' id='deleteDm'><img src='/cdd/resource/img/delete.png' width='20px'/></a>";
				$("#chatUserId").text(chatId);
				$("#deleteDiv").empty();
				$("#deleteDiv").append(html2);
				
				// 삭제 버튼 클릭 이벤트
				$("#deleteDm").click(function(){
					if(!confirm("진짜로?")){
						return false;
					}{
						//var chatId = $(this).attr('value');
						var chatId = $("#chatId").val();
						var memId = $("#memId").val();
						console.log(chatId+" "+memId);
						deleteDm(chatId, memId);
						
					}
				});
				
				// 보내기 버튼 클릭 이벤트
				$("#sendDmBtn").click(function(){
					var chatId = $("#chatId").val();
					var sendContent = $("#sendContent").val();
					var memId = $("#memId").val();
					insertDm(chatId, memId, sendContent);
				});
			}
		});
	</script>
</body>
</html>
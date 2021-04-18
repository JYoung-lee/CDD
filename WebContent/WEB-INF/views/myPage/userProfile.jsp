<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!--   일정 css   -->
<link rel="stylesheet" href="/cdd/resource/calendar/userCalendarCss.css" />
<!-- 달력 사용 CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
		var pageNum = 1;
		var profileId = $('#profileId').val();
		$("#feedWrite").click(function() {
			$(".feed_Write").load("/cdd/feeds/feedWriteForm.cdd");
		})
		$(window).scroll(function() {
	      	
	     	if($(document).height() <= ($(window).height() + $(window).scrollTop())) {
	     		
	     		pageNum++;
	     		feedAppend(pageNum,profileId);
			}
	     });
	});
</script>
</head>
<body>
	<input type="hidden" id="profileId" value="${profileId}" />
	<c:if test="${profileIdInfo.userInfo.blocked == 1 }">
		<script>
		alert("정지된 계정입니다.");
		history.go(-1);
	</script>
	</c:if>
	<div class="cddHeader"></div>
	<br />
	<br />
	<br />
	<br />
	<!-- 나중에 색 지우기 -->
	<div class="container" style="width: 900px;">
		<div class="row">
			<div class="col-md-3" style="height: 200px;">
				<img src="/cdd/save/${profileIdInfo.userInfo.user_profile}" style="width: 170px; height: 170px; border-radius: 70%; overflow: hidden;" />
			</div>
			<div class="col-md-7">
				<div class="row">
					<div class="col" style="height: 50px;">
						<c:if test="${sessionScope.memId eq profileIdInfo.userInfo.user_id}">
							<p style="display: inline; font-size: 20pt;">${profileIdInfo.userInfo.user_id}</p>&nbsp;&nbsp;&nbsp;
						<a data-toggle="modal" data-target="#modifyProfileModal" role="button" onclick="modifyProfileModalView()"> <img src="/cdd/resource/img/editProfile.png" width="90px" />
							</a>
						</c:if>
						<c:if test="${sessionScope.memId ne profileIdInfo.userInfo.user_id}">
							<p style="display: inline; font-size: 20pt;">${profileIdInfo.userInfo.user_id}</p>&nbsp;&nbsp;&nbsp;
						<a role="button" data-toggle="modal" data-target="#sendDmForm" onclick="sendValue('${profileIdInfo.userInfo.user_id}')"> 메세지 보내기 </a>&nbsp;&nbsp;&nbsp;
						<c:if test="${profileIdInfo.flwCh == 1}">
								<div style="display: inline-block" id="follow">
									<a role="button" onclick="followProcess('${sessionScope.memId}', '${profileIdInfo.userInfo.user_id}', ${profileIdInfo.flwCh})"> <i style="font-size: 20px; margin-left: 10px; color: #3178EA;" class="fas fa-user-check"></i>
									</a>
								</div>
							</c:if>
							<c:if test="${profileIdInfo.flwCh == 0}">
								<div style="display: inline-block" id="follow">
									<a role="button" onclick="followProcess('${sessionScope.memId}', '${profileIdInfo.userInfo.user_id}', ${profileIdInfo.flwCh})"> <i style="font-size: 20px; margin-left: 10px; color: black;" class="fas fa-user-plus"></i>
									</a>
								</div>
							</c:if>
						</c:if>
					</div>
				</div>
				<div class="row">
					<div class="col" style="height: 50px; padding-top: 7px;">
						<p style="display: inline;">
							<a role="button" href="#myFeed"style="font-size: 12pt; color:black;">게시물 <span style="font-weight: bolder;">${profileIdInfo.feedCnt}</span></a>
						</p>
						&nbsp;&nbsp;&nbsp; <a role="button" style="font-size: 12pt;" data-toggle="modal" data-target="#followView" onclick="followView('${profileIdInfo.userInfo.user_id}')"> 팔로우 <span style="font-weight: bolder;">${profileIdInfo.flwCnt}</span>
						</a>&nbsp;&nbsp;&nbsp; <a role="button" style="font-size: 12pt;" data-toggle="modal" data-target="#followerView" onclick="followerView('${profileIdInfo.userInfo.user_id}')"> 팔로워 <span style="font-weight: bolder;">${profileIdInfo.flwerCnt}</span>
						</a>&nbsp;&nbsp;&nbsp;
					</div>
				</div>
				<div class="row">
					<div class="col" style="height: 100px;">
						<p style="font-size: 12pt; font-weight: bolder;">${profileIdInfo.userInfo.user_name}</p>
						<h6>${profileIdInfo.userInfo.user_bio }</h6>
					</div>
				</div>
			</div>
			<div class="col-md-2 col-md-offset-2"></div>
			<!--  offset 양옆 길이 줄이기 -->
		</div>
		<div class="row" style="padding-bottom: 40px">
			<div class="col-md-1">
				<c:if test="${sessionScope.memId eq profileIdInfo.userInfo.user_id}">
					<a data-target="#petInfoFormModal" data-toggle="modal" role="button"><img class="meterial-icons" src="/cdd/resource/img/floatingBtn.png" style="width: 50px; height: 50px;" onclick="petInfoFormModal()"> </a>
				</c:if>
			</div>
			<div class="col-md-7" style="height: 50px;">
				<div class="row">
					<c:if test="${ count > 0 }">
						<c:forEach var="pet_infoDTO" items="${petInfoList}">
							<div class="col-md-2" style="text-align: center;">
								<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'}">
									<a role="button" class="pet_nameInfo" onclick="pet_Name('${pet_infoDTO.pet_name}',${pet_infoDTO.pet_number})"> <img src="../resource/img/${pet_infoDTO.pet_profile}" width="50px" height="50px" style="border-radius: 70%; overflow: hidden;">
									</a>
								</c:if>
								<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
									<a role="button" class="pet_nameInfo " onclick="pet_Name('${pet_infoDTO.pet_name}',${pet_infoDTO.pet_number})"> <img src="/cdd/save/${pet_infoDTO.pet_profile}" width="50px" height="50px" style="border-radius: 70%; overflow: hidden;">
									</a>
								</c:if>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="row">
					<c:if test="${ count > 0 }">
						<c:forEach var="pet_infoDTO" items="${petInfoList}">
							<div class="col-md-2">
								<c:if test="${pet_infoDTO.pet_profile eq 'defaultimg.png'} ">
									<p style="font-size: 12px; color: blue; text-align: center;">${pet_infoDTO.pet_name}</p>
								</c:if>
								<c:if test="${!(pet_infoDTO.pet_profile eq 'defaultimg.png')}">
									<p style="font-size: 12px; color: blue; text-align: center;">${pet_infoDTO.pet_name}</p>
								</c:if>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
		<!-- 펫 정보 보기 수정 영역 -->
		<c:if test="${count > 0}">
			<div class="row" style="padding-bottom: 20px;">
				<div class="col-md-4 col-md-offset-4"></div>
				<div class="col-md-4" style="text-align: center;">
					<a id="petViewbtn" data-target="#petViewModal" data-toggle="modal" role="button" onclick="petViewModal('${profileId}')"> </a>
				</div>
				<div class="col-md-4 col-md-offset-4"></div>
			</div>
		</c:if>
		<!-- 달력 / 일지영역 -->
		<div class="row" style="height: 520px; border: 2px solid black;">
			<div class="col-md-6" style="border-right: 2px;">
				<div class="row" style="height: 410px;">
					<div class="my-calendar2 clearfix2">
						<div class="clicked-date2">
							<div class="cal-day2"></div>
							<div class="cal-date2"></div>
						</div>
						<div class="calendar-box2">
							<div class="ctr-box2 clearfix2">
								<button type="button" title="prev2" class="btn-cal prev2"></button>
								<span class="cal-month2"></span> <span class="cal-year2"></span>
								<button type="button" title="next2" class="btn-cal next2"></button>
							</div>
							<table class="cal-table2">
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
								<tbody class="cal-body2"></tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="row" style="height: 90px;">
					<div class="col-md-9" style="height: 110px;">
						<div class="col-md-12">
							<div class="row" id="scheduleContent" style="overflow: auto; height: 100px;"></div>
						</div>
					</div>
					<div class="col-md-3" style="padding-left: 0px; padding-right: 0px;">
						<div class="row" style="height: 55px; padding: 0px; margin: 0px;">
							<c:if test="${sessionScope.memId eq profileIdInfo.userInfo.user_id}">
								<div class="col-md-12" style="padding-right: 0px; padding-left: 40px;">
									<a data-target="#scheduleListForm" data-toggle="modal" role="button" class="btn btn-outline-primary" style="font-size: 15px; padding: 0px;" onclick="scheduleListFormModal()">일정 관리</a>
								</div>
							</c:if>
						</div>
						<div class="row" style="height: 55px;"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6" style="height: 500px; overflow: auto;">
				<div class="row" style="height: 40px;">
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-12" style="margin-top: 10px;">
								<i class="far fa-list-alt">일지</i>&nbsp; <i class="fas fa-warehouse">일정</i>
							</div>
						</div>
					</div>

					<div class="col-md-5"></div>
					<div class="col-md-3" style="padding-right: 0px; text-align: right; padding-right: 3px;">
						<c:if test="${sessionScope.memId eq profileIdInfo.userInfo.user_id}">
							<a data-target="#noteList" data-toggle="modal" role="button" class="btn btn-outline-primary" style="font-size: 15px; padding: 0px;" onclick="noteListModal()">일지 관리</a>
						</c:if>
					</div>
				</div>
				<div class="border border-5" style="padding: 10px;">
					<div class="row" style="height: 460px; text-align: center;">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-7" style="padding-left: 0px;">
									<h5 id="today_date"></h5>
								</div>
								<div id="today_emotion" class="col-md-5">
									<label style="margin-bottom: 0px;"> # 그날의 기분</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="height: 130px;">
									<label style="margin-bottom: 0px;"> # 나의 펫</label>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">몸무게</th>
												<th scope="col">건식</th>
												<th scope="col">습식</th>
												<th scope="col">음수</th>
											</tr>
										</thead>
										<tbody>
											<tr id="today_eat">
												<td>-</td>
												<td>-</td>
												<td>-</td>
												<td>-</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="height: 130px;">
									<label style="margin-bottom: 0px;"> # 그날의 증상</label>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">구토</th>
												<th scope="col">설사</th>
												<th scope="col">기타 증상</th>
											</tr>
										</thead>
										<tbody>
											<tr id="today_sick">
												<td>-</td>
												<td>-</td>
												<td>-</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="height: 130px; padding-bottom: 5px;">
									<label style="margin-bottom: 0px;"> # 그날의 운동량 </label>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">아침</th>
												<th scope="col">점심</th>
												<th scope="col">저녁</th>
												<th scope="col">목욕</th>
											</tr>
										</thead>
										<tbody>
											<tr id="today_Exercise">
												<td>-</td>
												<td>-</td>
												<td>-</td>
												<td>-</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row" style="border: 1px solid black;">
								<div class="col-md-12">
									<label style="margin-bottom: 0px;"> # 다이어리 </label>
									<p id="today_diary">-</p>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<br />
		<hr>
		<!-- 게시글 이미지 작업내역 -->
		<div id="myFeed">
			<fmt:parseNumber var="rowCount" value="${(9 / 3) + (9 % 3 eq 0 ? 0 : 1)}" integerOnly="true" />

			<c:set var="pageNum" value="1" />
			<c:forEach begin="1" end="${rowCount}">
				<c:set var="startRow" value="${((pageNum - 1) * 3 + 1) -1}" />
				<c:set var="endRow" value="${(startRow + 3) -1}" />
				<div class="row" style="margin-top: 50px;">
					<c:forEach begin="${startRow}" end="${endRow}" var="list" items="${myAllfeed}" varStatus="status">
						<div class="col-md-4">
							<a onclick="contentView(${list.feed_num})" id="replyView" type="button" data-toggle="modal" data-target="#feedContent"> <img style="width: 290px; height: 290px;" src="/cdd/save/${list.photo_dir}" class="img-fluid" />
							</a>
						</div>
					</c:forEach>
				</div>
				<c:set var="pageNum" value="${pageNum + 1}" />
			</c:forEach>
		</div>

	</div>
	<div id="feedContent" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content feed_content"></div>
		</div>
	</div>
	<!-- 컨테이너 안에 작업 -->

	<!-- floating button -->
	<div class="btn-group dropup" style="position: fixed; bottom: 50px; right: 200px;">
		<a class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="/cdd/resource/img/floatingBtn.png" width="40px" />
		</a>
		<div class="dropdown-menu">
			<a class="dropdown-item" id="feedWrite" type="button" data-toggle="modal" data-target="#feedWriteView">피드작성</a> 
			<a class="dropdown-item" data-target="#noteWriteFormModal" data-toggle="modal" role="button" onclick="noteWriteFormModal()">일지작성</a> 
			<a class="dropdown-item" data-target="#floatingScheAddForm" data-toggle="modal" role="button" onclick="floatingscheAddFormModal()">일정추가</a>
			<!-- Dropdown menu links -->
		</div>
	</div>

	<!-- 작성 일지 작성폼  -->
	<div id="noteWriteFormModal" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-mg">
			<div class="modal-content noteWriteForm" style="width: 600px;"></div>
		</div>
	</div>
	<script>
		function noteWriteFormModal(){
			$(".noteWriteForm").load("/cdd/myPage/noteWriteForm.cdd"); /* 어디서 불렀는지 view 파라미터로 넘겨주기 */
		}
		function contentView(feed_num) {
			$(".feed_content").load('/cdd/feeds/feedContent2.cdd?feed_num=' + feed_num);
		}
	</script>

	<!-- 펫 일지 List-->
	<div id="noteList" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content noteList"></div>
		</div>
	</div>
	<script>
		function noteListModal(){
			$(".noteList").load("/cdd/myPage/noteList.cdd"); /* 어디서 불렀는지 view 파라미터로 넘겨주기 */
		}
	</script>

	<!-- 펫 일지 수정 폼 -->
	<div id="noteModifyForm" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" style="width: 450px; z-index: 10000;">
			<div class="modal-content noteModifyForm"></div>
		</div>
	</div>
	<script>
		function noteModifyModal(note_num){
			console.log("일지 수정폼");
			$(".noteModifyForm").load("/cdd/myPage/noteModifyForm.cdd",{'note_num': note_num}); /* 어디서 불렀는지 view 파라미터로 넘겨주기 */
		}
	</script>






	<!-- 펫 작성폼 -->
	<div id="petInfoFormModal" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-mg">
			<div class="modal-content petInfoForm"></div>
		</div>
	</div>
	<script>
		function petInfoFormModal(){
			$(".petInfoForm").load("/cdd/myPage/petInfoForm.cdd");
		}
	</script>
	<!-- 펫 정보 폼 -->
	<div id="petViewModal" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-mg">
			<div class="modal-content petViewbtn"></div>
		</div>
	</div>
	<script>
		var pet_numberData = ''; 
		// 펫 그림 누르면 이름 출력 ( pet 이름과 고유번호 받기 )
		function pet_Name(pet_name , pet_number){
			pet_numberData = pet_number;
			$("#petViewbtn").empty();
			$("#petViewbtn").append('<h4 style="color: blue;"> [ '+ pet_name +' ] Pet정보 </h4>');
		}
		
		function petViewModal(profileId){
			console.log(" petViewModal pro : " + profileId);										
			$(".petViewbtn").load("/cdd/myPage/petInfoView.cdd",{ 'pet_number' : pet_numberData, 'profileId': profileId}); //로드에서 Contoroller로 데이터 넘기는 방법
		}
	</script>

	<%-- 플로팅 버튼 일정 추가--%>
	<div id="floatingScheAddForm" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content floatingScheAddForm"></div>
		</div>
	</div>
	<script>
		function floatingscheAddFormModal(){
			$(".floatingScheAddForm").load("/cdd/myPage/scheAddForm.cdd"); //로드에서 Contoroller로 데이터 넘기는 방법
		}
	</script>
	
	<!-- Modal Feed write-->
	<div id="feedWriteView" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content feed_Write"></div>
		</div>
	</div>

	<%-- 일정 수정 모달  --%>
	<div id="scheModifyForm" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" style="z-index: 10000;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content scheModifyForm"></div>
		</div>
	</div>
	<script>
		function scheModifyFormModal(sche_num){
			$(".scheModifyForm").load("/cdd/myPage/scheModifyForm.cdd",{'sche_num':sche_num}); /* 로드에서 Contoroller로 데이터 넘기는 방법 */ 
		}
	</script>

	<!-- 스케쥴 수정에서 보여줄 리스트 모달 -->
	<div id="scheduleListForm" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content scheduleListForm"></div>
		</div>
	</div>
	<script>
		function scheduleListFormModal(){
			$(".scheduleListForm").load("/cdd/myPage/scheduleListForm.cdd");
		}
	</script>

	<!-- 사용자 정보 수정 : 사용자 비밀번호 확인 -->
	<div id="modifyProfileModal" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content modifyProfile"></div>
		</div>
		<script>
			function modifyProfileModalView(){
				$(".modifyProfile").load("/cdd/user/userPwCh.cdd");
			}
		</script>
	</div>
	<div class="modal fade" id="followerView" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="width: 300px;">
			<div class="modal-content followerView"></div>
		</div>
		<script>
		function followerView(userId){
			console.log(userId);
			$(".followerView").load("/cdd/myPage/myPageFollowerList.cdd", { 'userId' : userId});
		}
	  </script>
	</div>
	<div class="modal fade" id="followView" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="width: 300px;">
			<div class="modal-content followView"></div>
		</div>
		<script>
		function followView(userId){
			console.log(userId);
			$(".followView").load("/cdd/myPage/myPageFollowList.cdd", { 'userId' : userId});
		}
	  </script>
	</div>
	<div id="sendDmForm" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" style="z-index: 1000; width: 500px;">
			<div class="modal-content" style="height: 150px;">
				<div class="modal-header">
					<h5 class="modal-title">To.&nbsp;&nbsp;</h5>
					<h5 class="modal-title" id="chatIdFromFollow"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="/cdd/myPage/sendDm.cdd" method="post" name="dmForm" onsubmit="return sendDmCh()">
						<input type="hidden" value="" id="receiver" name="receiver" /> <input type="hidden" value="${sessionScope.memId }" name="sender"> <input type="text" class="form-control" id="sendContentFromForm" name="content" style='width: 80%; height: 30px; display: inline; margin-right: 10px;' />
						<button type="submit" class='btn btn-outline-secondary' style='font-size: 10pt; height: 30px;'>보내기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		function sendValue(toId){
			$("#chatIdFromFollow").text(toId);
			$("#receiver").val(toId);
		}
		function sendDmCh(){
			var dmContent = document.dmForm.content.value;
			if(dmContent == ""){
				alert("메세지를 입력해주세요");
				return false;
			}
		}
		function feedAppend(pageNum,profileId) {
			var ajaxJson = new Object();
			ajaxJson.pageNum = pageNum;
			ajaxJson.profileId = profileId;
			var jsonString = JSON.stringify(ajaxJson);
			
			$.ajax({
			    url : '/cdd/myPage/appendMyFeeds.cdd',
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			    	var json = JSON.parse(data);
			    	console.log(json);
			    	var myAllfeed = json.myAllfeed;
			    	var myFeedCount = json.myFeedCount;
			    	var html = "";
			    	
			    	var rowCount = Math.floor(9 / 3) + (9 % 3 == 0 ? 0 : 1);
			    	
			    	var startIndex = 1;
			    	for(var i = 0; i < rowCount; i++) {
			    		if(myAllfeed.length == 0) {
			    			break;
			    		}
			    		var startRow = ((startIndex - 1) * 3 +1) -1;
			    		var endRow = (startRow + 3) -1;
			    		if(endRow >= myAllfeed.length-1) {
			    			endRow = myAllfeed.length -1;
			    		}
			    		if(startRow > myAllfeed.length) {
			    			break;
			    		}
			    		html += "<div class=\"row\" style=\"margin-top: 50px;\">";
			    		
			    		
			    		
			    		
			    		for(var j = startRow; j <= endRow; j ++) {
			    			html += "<div class=\"col-md-4\">";
			    			html += "<a onclick=\"contentView("+myAllfeed[j].feed_num +")\" id=\"replyView\" type=\"button\" data-toggle=\"modal\" data-target=\"#feedContent\"> <img style=\"width: 290px; height: 290px;\" src=\"/cdd/save/"+myAllfeed[j].photo_dir +"\"class=\"img-fluid\" />";
			    			html += "</a>";
			    			html += "</div>";
			    		}
			    		html += "</div>";
			    		
			    		startIndex++;
			    	}
			    		
			    		
						
			    	$('#myFeed').append(html);
			    	
			    }
			});
		}
		function heartProcess(feed_num, user_id, likeCh, user_to, index2) {
			if(index2 == null) {
				index2 = 0;
			}
			var ajaxJson = new Object();
			ajaxJson.feed_num = feed_num;
			ajaxJson.user_id = user_id;
			ajaxJson.likeCh = likeCh;
			ajaxJson.user_to = user_to;
			ajaxJson.index2 = index2;
			
			var jsonString = JSON.stringify(ajaxJson);
			
			$.ajax({
			    url : '/cdd/feeds/heartProcess.cdd',
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			        
			    	var json = JSON.parse(data);
			        console.log(json);
					
			        $("#main_heart" + index2).empty();
			        $("#content_heart").empty();
			        
			        if(json.likeCh == 1) {
			        	var html = '<div id="heart" style="display: inline-block; background-color: white;"><a role="button" onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\', '+json.index2+');"><i style="color: red; font-size: 30px;"class="fas fa-heart"></i></a></div>';
			        }else if(json.likeCh == 0) {
			        	var html = '<div id="heart" style="display: inline-block;"><a role="button" onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\', '+json.index2+');"><i style="font-size: 30px;" class="far fa-heart"></i></a></div>';
			        }
			        
			        $('#main_heart' + index2).append(html);
			        $("#content_heart").append(html);
					
			       }

			}) 
			
		}
		function bookmarkProcess(feed_num, user_id, bookCh, index2) {
			if(index2 == null) {
				index2 = 0;
			}
			
			var ajaxJson = new Object();
			ajaxJson.feed_num = feed_num;
			ajaxJson.user_id = user_id;
			ajaxJson.bookCh = bookCh;
			ajaxJson.index2 = index2;
			
			var jsonString = JSON.stringify(ajaxJson);
			
			console.log(jsonString);
			
			$.ajax({
			    url : '/cdd/feeds/bookmarkProcess.cdd',
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			        
			    	var json = JSON.parse(data);
			    	console.log(json);
			    	
			    	$("#main_bookmark" + index2).empty();
			    	$("#content_bookmark").empty();
			    	
			    	if(json.bookCh == 0) {
			        	var html = '<div id="bookmark" style="display: inline-block; float: right"><a role="button" onclick="bookmarkProcess('+ json.feed_num + ',\''+ json.user_id +'\', '+ json.bookCh +','+index2+')"><i style="font-size: 30px;" class="far fa-bookmark"></i></a></div>';
			        }else if(json.bookCh == 1) {
			        	var html = '<div id="bookmark" style="display: inline-block; float: right"><a role="button" onclick="bookmarkProcess('+ json.feed_num + ',\''+ json.user_id +'\', '+ json.bookCh +', '+index2+')"<i style="color: black; font-size: 30px;"class="fas fa-bookmark"></i></a></div>';
			        }
			        	
			    	 $('#main_bookmark' + index2).append(html);
			    	 $('#content_bookmark').append(html);
			    }
			}) 
		}
		
		function followProcess(user_from, user_to, followCh) {
			var ajaxJson = new Object();
			ajaxJson.user_from = user_from;
			ajaxJson.user_to = user_to;
			ajaxJson.followCh = followCh;
			
			var jsonString = JSON.stringify(ajaxJson);
			
			console.log(jsonString);
			$.ajax({
			    url : '/cdd/feeds/followProcess.cdd',
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			        
			    	var json = JSON.parse(data);
			    	console.log(json);
			    	$("#follow").empty();
			       	
			    	 if(json.followCh == 0) {
				        	var html = '<div style="display: inline-block" id="follow"><a role="button" onclick="followProcess(\''+json.user_from+'\', \''+json.user_to+'\', '+json.followCh+')"><i style="font-size: 20px; margin-left: 10px; color: black;" class="fas fa-user-plus"></i></a></div>';
				        	
				        }else if(json.followCh == 1) {
				        	
				        	
					        	var html = '<div style="display: inline-block" id="follow"><a role="button" onclick="followProcess(\''+json.user_from+'\', \''+json.user_to+'\', '+json.followCh+')"><i style="font-size: 20px; margin-left: 10px; color: #3178EA;" class="fas fa-user-check"></i></a></div>';
				        }
				        	
				        		
				        	
				        	
			        	
			    	 $('#follow').append(html);
					
			       }
			       


			}) 
		}
	</script>


	
	<!-- 달력 스크립트 -->
	<script src="/cdd/resource/calendar/userCalendar.js"></script>

</body>
</html>






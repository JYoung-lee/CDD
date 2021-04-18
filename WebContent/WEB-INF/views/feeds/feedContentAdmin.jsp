<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
</head>
<body>


	<div class="modal-header">
		<h5 class="modal-title">Modal title</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body" style="height: 600px; positon: fixed;">

		<div class="container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-8 ml-auto">
						<div id="ch6-1-carousel" class="carousel slide" data-ride="carousel" data-touch="false">
							<ol class="carousel-indicators">
								<c:set var="name" value="0" />
								<c:forEach var="photo" begin="0" items="${photos}" varStatus="status">

									<c:if test="${name == 0}">
										<li data-target="#ch6-1-carousel" data-slide-to="${name}" class="active"></li>
									</c:if>
									<c:if test="${name > 0}">
										<li data-target="#ch6-1-carousel" data-slide-to="${name}"></li>
									</c:if>
									<c:set var="name" value="${name + 1 }" />
								</c:forEach>



							</ol>
							<div class="carousel-inner">
								<c:set var="name" value="0" />
								<c:forEach var="photo" begin="0" items="${photos}" varStatus="status">
									<c:if test="${name == 0}">
										<div class="carousel-item active">
											<img src="/cdd/save/${photo.photo_dir}" class="d-block w-100" style="width: 100%; height: 570px; object-fit: cover;" alt="...">
										</div>
									</c:if>
									<c:if test="${name > 0}">
										<div class="carousel-item">
											<img src="/cdd/save/${photo.photo_dir}" class="d-block w-100" style="width: 100%; height: 570px; object-fit: cover;" alt="...">
										</div>
									</c:if>
									<c:set var="name" value="${name + 1 }" />
								</c:forEach>

							</div>
							<a class="carousel-control-prev" href="#ch6-1-carousel" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#ch6-1-carousel" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>
					</div>

					<div class="col-md-4 ml-auto">
						<img src="/cdd/resource/img/defaultimg.png" style="width: 30px; height: 30px;" /> <strong>${feed.user_id}</strong>
						<hr>
						<div style="overflow: auto; height: 350px;">
							${feed.feed_content}
							<hr>
							<div id="reply_body">
								<c:set var="test10" value="0" />
								<c:forEach var="reply" items="${replies}" varStatus="status">

									<c:if test="${reply.reply_level == 0}">
										<img src="/cdd/resource/img/${reply.user_profile}" style="width: 30px; height: 30px;" />
										<strong>${reply.user_id}</strong>
											${reply.reply_content}
										<div id="depth${test10}"></div>
										<hr>
									</c:if>
									<c:if test="${reply.reply_level == 1}">
										<img src="/cdd/resource/img/${reply.user_profile}" style="width: 30px; height: 30px; margin-left: 30px;" />
										<strong>${reply.user_id}</strong>
										<p style="color: #929E9E; display: inline-block">${reply.reply_id}</p>
											${reply.reply_content}
										<div id="depth${test10}"></div>
										<hr>
									</c:if>
									<c:set var="test10" value="${test10 + 1}" />
								</c:forEach>
							</div>
						</div>

						


											
										
											
										






					</div>
				</div>
			</div>
			
			
			<script type="text/javascript">
				function reply_depth(feed_num, user_id, reply_num, current, reply_id, reply_level) {

					console.log(reply_id);
					var html = '<input id="reply1" type="text" style="width: 80%;" placeholder="댓글입력"/>';
					html += '<button type="button" class="btn btn-primary" onclick="test(' + feed_num + ',\'' + user_id + '\',' + reply_num + ',\'' + reply_id + '\',' + reply_level + ',' + current + ');">등록</button>';
					if ($('#depth' + current).is(':empty')) {

						$('#depth' + current).append(html);
					} else {
						$('#depth' + current).empty();
					}
				}

				function test(feed_num, user_id, reply_num, reply_id, reply_level, current) {

					if (reply_level == 0) {
						var reply = $("#reply").val();
						var ajaxJson = new Object();
						ajaxJson.reply_content = reply;
						ajaxJson.user_id = user_id;
						ajaxJson.feed_num = feed_num;
						ajaxJson.reply_ref = reply_num;
						ajaxJson.reply_id = reply_id;
						ajaxJson.reply_level = reply_level;

						var jsonString = JSON.stringify(ajaxJson);

					} else {
						var reply = $("#reply1").val();
						var ajaxJson = new Object();
						ajaxJson.reply_content = reply;
						ajaxJson.user_id = user_id;
						ajaxJson.feed_num = feed_num;
						ajaxJson.reply_ref = reply_num;
						ajaxJson.reply_id = reply_id;
						ajaxJson.reply_level = reply_level;

						var jsonString = JSON.stringify(ajaxJson);

					}
					console.log(jsonString);

					$.ajax({
						url : '/cdd/feeds/feed_reply_level0.cdd',
						contentType : 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
						method : 'POST', // 전달방식이 controller와 일치해야함
						data : jsonString, // 전달하는 데이터
						success : function(data) {
							var json = JSON.parse(data);
							console.log(json);
							var html = "";
							$("#reply_body").empty();
							$("#reply").val("");
							for (var i = 0; i < json.length; i++) {
								if (Number(json[i].reply_level) == 0) {
									html += '<img src=\"/cdd/resource/img/' + json[i].user_profile 
							+ '\" style=\"width: 30px; height: 30px;\" />';
									html += ' <strong>' + json[i].user_id + '</strong>';
									html += ' ' + json[i].reply_content;
									html += '<a href="#"><p style="float: right; font-size: 10px;">댓글신고</p></a>';
									html += '<a href="#"><p onclick="reply_depth(' + json[i].feed_num + ', \'' + user_id + '\',' + json[i].reply_ref + ',' + i + ', \'' + json[i].user_id + '\', 1)" style="float: right; font-size: 10px;">답글달기</p></a>';
									html += '<div id=\"depth'+i+'\"></div>';
									html += '<hr>';
								}
								if (Number(json[i].reply_level) == 1) {
									html += '<img src=\"/cdd/resource/img/' + json[i].user_profile 
							+ '\" style=\"width: 30px; height: 30px; margin-left: 30px;\" />';
									html += ' <strong>' + json[i].user_id + '</strong>';
									html += '<p style="color: #929E9E; display: inline-block">' + json[i].reply_id + '</p>'
									html += ' ' + json[i].reply_content;
									html += '<a href="#"><p style="float: right; font-size: 10px;">댓글신고</p></a>';
									html += '<a href="#"><p onclick="reply_depth(' + json[i].feed_num + ', \'' + user_id + '\',' + json[i].reply_ref + ',' + i + ', \'' + json[i].user_id + '\', 1)" style="float: right; font-size: 10px;">답글달기</p></a>';
									html += '<div id=\"depth'+i+'\"></div>';
									html += '<hr>';
								}
							}

							$('#reply_body').append(html);

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
						contentType : 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
						method : 'POST', // 전달방식이 controller와 일치해야함
						data : jsonString, // 전달하는 데이터
						success : function(data) {

							var json = JSON.parse(data);
							console.log(json);
							$("#follow").empty();

							if (json.followCh == 0) {
								var html = '<div style="display: inline-block" id="follow"><button type="button" class="btn btn-primary btn-sm" onclick="followProcess(\'' + json.user_from + '\', \'' + json.user_to + '\', ' + json.followCh + ')">팔로우</button></div>';

							} else if (json.followCh == 1) {
								var html = '<div style="display: inline-block" id="follow"><button type="button" class="btn btn-secondary btn-sm" onclick="followProcess(\'' + json.user_from + '\', \'' + json.user_to + '\', ' + json.followCh + ')">팔로잉</button></div>';

							}

							$('#follow').append(html);

						}

					})
				}

				function popup() {
					var url = "/cdd/feeds/reportPage.cdd";
					var name = "popup test";
					var option = "width = 500, height = 500, top = 300, left = 700, location = no";
					window.open(url, name, option);
				}
				
				
			</script>






















		</div>


	</div>

























</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<script>
	$(document).ready(function() {
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body class="all">
	<c:if test="${search == '' }">
		<script>
			alert("아이 아무것도 없잖아!");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${search != '' }">
		<script>
			$(document).ready(function() {
				$("#tagsResultView").show();
				$("#feedsResultView").hide();
				$("#userResultView").hide();

				$("#searchTags").click(function() {
					$("#tagsResultView").show();
					$("#feedsResultView").hide();
					$("#userResultView").hide();
				});
				$("#searchFeeds").click(function() {
					$("#tagsResultView").hide();
					$("#feedsResultView").show();
					$("#userResultView").hide();
				});
				$("#searchUser").click(function() {
					$("#tagsResultView").hide();
					$("#feedsResultView").hide();
					$("#userResultView").show();
				});
			});
		</script>
		<div class="cddHeader"></div>
		<br />
		<br />
		<br />
		<br />
		<br />
		<div class="container" align="center">

			<div class="btn-group btn-group-toggle" data-toggle="buttons" style="background-color: #f4f4f4;">
				<label class="btn btn-outline-secondary active" style="width: 80px;"> <input type="radio" name="options" id="searchTags" checked> #
				</label> <label class="btn btn-outline-secondary" style="width: 80px;"> <input type="radio" name="options" id="searchFeeds"> 피드
				</label> <label class="btn btn-outline-secondary" style="width: 80px;"> <input type="radio" name="options" id="searchUser"> 사용자
				</label>
			</div>

			<br /> <br /> <br />
			<!-- search result -->
			<div style="width: 80%;">

				<fmt:parseNumber var="rowCount" value="${(searchTagCount / 3) + (searchTagCount % 3 eq 0 ? 0 : 1)}" integerOnly="true" />

				<h3>${search}검색결과</h3>
				<br /> <br />
				<div id="tagsResultView">
					<div>
						<c:if test="${searchTags == '[]' }">
							<div class="col" align="center">
								<h5 style="color: gray;">해시태그 검색 결과가 없습니다.</h5>
							</div>
						</c:if>
						<c:if test="${searchTags != '[]' }">
							<fmt:parseNumber var="rowCount" value="${(searchTagCount / 3) + (searchTagCount % 3 eq 0 ? 0 : 1)}" integerOnly="true" />

							<c:set var="pageNum" value="1" />
							<c:forEach begin="1" end="${rowCount}">

								<c:set var="startRow" value="${((pageNum - 1) * 3 + 1) -1}" />
								<c:set var="endRow" value="${(startRow + 3) -1}" />
								<div class="row" style="margin-top: 50px;">
									<c:forEach begin="${startRow}" end="${endRow}" var="list" items="${searchTags}" varStatus="status">
										<div class="col-md-4">
											<a onclick="contentView(${list.feed_num})" id="replyView" type="button" data-toggle="modal" data-target="#feedContent">
													<img style="width: 290px; height: 290px;" src="/cdd/save/${list.photo_dir}" class="img-fluid" />
													
											</a>
										</div>
									</c:forEach>
								</div>


								<c:set var="pageNum" value="${pageNum + 1}" />
							</c:forEach>

							<div id="feedContent" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
									<div class="modal-content feed_content"></div>
								</div>
							</div>
						</c:if>
					</div>


				</div>
				<div id="feedsResultView">
					<c:if test="${searchFeeds == '[]' }">
						<div class="col" align="center">
							<h5 style="color: gray;">피드 검색 결과가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${searchFeeds != '[]' }">
						<c:forEach var="list" items="${searchFeeds }">
							<div class="col-md-3" style="height: 200px;">
								<img src="/cdd/save/${list.photo_dir }" style="width: 100%; height: 95%;" />
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div id="userResultView">
				<c:if test="${searchUsers == '[]' }">
					<div class="row">
						<div class="col" align="center">
							<h5 style="color: gray;">사용자 검색 결과가 없습니다.</h5>
						</div>
					</div>
				</c:if>
				<c:if test="${searchUsers != '[]' }">
					<c:forEach var="list" items="${searchUsers }">
						<div class="row">
							<div class="col-md-3 col-md-offset-3"></div>
							<div class="col-md-1" style="height: 60px;">
								<img src="/cdd/save/${list.user_profile }" style="width: 50px; height: 50px; border-radius: 70%; overflow: hidden;" />
							</div>
							<div class="col-md-2" align="left">
								<h6 style="display: inline;">
									<a role="button" onclick="userProfileView('${list.user_id }')">${list.user_id }</a>
								</h6>
								<br />
								<h6 style="display: inline; font-weight: boler; color: gray;">${list.user_name }</h6>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</c:if>
</body>
<script>
	function userProfileView(userId) {
		location.href = "/cdd/myPage/userProfile.cdd?profileId=" + userId;
	}
	function contentView(feed_num) {
		$(".feed_content").load('/cdd/feeds/feedContent2.cdd?feed_num=' + feed_num);
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
</script>
</html>
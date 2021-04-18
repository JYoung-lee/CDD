<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		<h5 class="modal-title">Feed</h5>
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

					<div style="text-align: left;" class="col-md-4 ml-auto">
						<img src="/cdd/save/${feed.user_profile}" style="border-radius: 70%; width: 30px; height: 30px;" /> <a style="font-weight: bold; color: black;" href="/cdd/myPage/userProfile.cdd?profileId=${feed.user_id }">${feed.user_id}</a>
						<c:if test="${user_id != feed.user_id}">
							<c:if test="${followCh == 0}">
								<div style="display: inline-block" id="follow">
									<a role="button" onclick="followProcess('${user_id}', '${feed.user_id}', ${followCh})"> <i style="font-size: 20px; margin-left: 10px; color: black;" class="fas fa-user-plus"></i>
									</a>
								</div>
							</c:if>
							<c:if test="${followCh == 1}">
								<div style="display: inline-block" id="follow">
									<a role="button" onclick="followProcess('${user_id}', '${feed.user_id}', ${followCh})"> <i style="font-size: 20px; margin-left: 10px; color: #3178EA;" class="fas fa-user-check"></i>
									</a>
								</div>
							</c:if>
						</c:if>
						<a role="button" onclick="popup()"><i style="float: right; font-size:30px; color: black;" class="fas fa-exclamation-circle"></i></a>

						<hr>
						<div style="overflow: auto; height: 350px;">

							${feed.feed_content}
							<br/>
							<c:set var="hash_split" value="${fn:split(feed.feed_hash, '#') }"/>
							<c:forEach var="hash" items="${hash_split}" varStatus="status">
								<a href="/cdd/searchResult.cdd?search=${hash}">#${hash}</a>
							</c:forEach>
							
							<hr>
							<div id="reply_body">
								<c:set var="test10" value="0" />
								<c:forEach var="reply" items="${replies}" varStatus="status">

									<c:if test="${reply.reply_level == 0}">
										<img src="/cdd/save/${reply.user_profile}" style="border-radius: 70%; width: 30px; height: 30px;" />
										<a style="font-weight: bold; color: black;" href="/cdd/myPage/userProfile.cdd?profileId=${reply.user_id }">${reply.user_id}</a>
											${reply.reply_content}<br/>
											<a role="button" onclick="popup()"><span style="float: right; font-size: 10px">댓글신고</span></a>
										<a role="button" onclick="reply_depth(${feed.feed_num},'${user_id}', ${reply.reply_num}, ${test10}, '${reply.user_id}', 1);"><span style="float: right; font-size: 10px; margin-right: 10px;">답글달기</span></a>
										<div id="depth${test10}"></div>


										<hr>



									</c:if>
									<c:if test="${reply.reply_level == 1}">
										
										<img src="/cdd/save/${reply.user_profile}" style="margin-left: 30px; border-radius: 70%; width: 30px; height: 30px; margin-left: 30px;" />
										<a style="font-weight: bold; color: black;" href="/cdd/myPage/userProfile.cdd?profileId=${reply.user_id }">${reply.user_id}</a>
										<p style="color: #929E9E; display: inline-block">${reply.reply_id}</p>
											${reply.reply_content}<br/>
											<a role="button" onclick="popup()"><span style="float: right; font-size: 10px">댓글신고</span></a>
										<a role="button" onclick="reply_depth(${feed.feed_num},'${user_id}', ${reply.reply_num}, ${test10}, '${reply.user_id}', 1);"><span style="float: right; font-size: 10px; margin-right: 10px;">답글달기</span></a>
										<div id="depth${test10}"></div>
										<hr>
									</c:if>
									<c:set var="test10" value="${test10 + 1}" />
								</c:forEach>
							</div>
						</div>
						<c:if test="${likeCh == 0}">
							<div id="content_heart" style="display: inline-block;">
								<a role="button" onclick="heartProcess(${feed.feed_num},'${user_id}',${likeCh},'${feed.user_id}',${index2});"> <i style="font-size: 30px;" class="far fa-heart"></i>
								</a>
							</div>
						</c:if>
						<c:if test="${likeCh == 1}">
							<div id="content_heart" style="display: inline-block;">
								<a role="button" onclick="heartProcess(${feed.feed_num}, '${user_id}',${likeCh},'${feed.user_id}',${index2})"> <i style="color: red; font-size: 30px;" class="fas fa-heart"></i>
								</a>
							</div>
						</c:if>
						<c:if test="${bookCh == 0}">
							<div id="content_bookmark" style="display: inline-block; float: right">
								<a role="button" onclick="bookmarkProcess(${feed.feed_num}, '${user_id}', ${bookCh}, ${index2})"> <i style="font-size: 30px;" class="far fa-bookmark"></i>
								</a>
							</div>
						</c:if>
						<c:if test="${bookCh == 1}">
							<div id="content_bookmark" style="display: inline-block; float: right">
								<a role="button" onclick="bookmarkProcess(${feed.feed_num}, '${user_id}', ${bookCh}, ${index2})" style="outline: 0; border: 0;"> <i style="font-size: 30px;" class="fas fa-bookmark"></i>
								</a>
							</div>
						</c:if>
						<br /> <br /> ${countLikes}명이 좋아합니다.
						<hr>
						<input style="width: 80%;" type="text" id="reply" placeholder="댓글 달기..." />
						<a role="button" onclick="test(${feed.feed_num},'${user_id}',0,null, 0,null);"><i style="float: right; font-size: 30px;" class="far fa-comment-dots"></i></a>
					</div>
				</div>
			</div>


			<script type="text/javascript">
	
	
	function reply_depth(feed_num, user_id, reply_num, current, reply_id, reply_level) {
		
		console.log(reply_id);
		var html = '<input id="reply1" type="text" style="width: 70%;" placeholder="댓글입력"/>';
		html += '<a role="button" onclick="test('+feed_num +',\'' +user_id +'\','+ reply_num + ',\''+ reply_id +'\','+reply_level+','+current+');"><i style="font-size: 30px;" class="far fa-comment-dots"></i></a>';
			if($('#depth' + current).is(':empty')) {
				
				$('#depth' + current).append(html);
			}else{
				$('#depth' + current).empty();
			}
	}
	
	function test(feed_num, user_id,reply_num,reply_id,reply_level, current) {
			
		if(reply_level == 0) {
			var reply = $("#reply").val();
			var ajaxJson = new Object();
			ajaxJson.reply_content = reply;
			ajaxJson.user_id = user_id;
			ajaxJson.feed_num = feed_num;
			ajaxJson.reply_ref = reply_num;
			ajaxJson.reply_id = reply_id;
			ajaxJson.reply_level = reply_level;
			
			
			var jsonString = JSON.stringify(ajaxJson);
		
			
			
			
			
		}else {
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
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			        var json = JSON.parse(data);
			        console.log(json);
			       	var html = "";
			        $("#reply_body").empty();
					$("#reply").val("");
					for(var i =0; i < json.length;i++) {
						if(Number(json[i].reply_level) == 0) {
							html += '<img src=\"/cdd/save/' + json[i].user_profile 
							+ '\" style=\"border-radius: 70%; width: 30px; height: 30px;\" />';
							html += "<a style=\"font-weight: bold; color: black;\" href=\"/cdd/myPage/userProfile.cdd?profileId="+json[i].user_id+ "\">"+json[i].user_id+"</a>";
							html += ' ' + json[i].reply_content;
							html += "<br/>";
							html += '<a role="button" onclick="popup()"><span style="float: right; font-size: 10px;">댓글신고</span></a>';
							html += '<a role="button"><span onclick="reply_depth('+ json[i].feed_num+', \'' +user_id+ '\','+json[i].reply_ref+',' + i+', \''+json[i].user_id+'\', 1)" style="float: right; font-size: 10px;">답글달기</span></a>';
							html += '<div id=\"depth'+i+'\"></div>';
							html += '<hr>';
						}
						if(Number(json[i].reply_level) == 1) {
							html += '<img src=\"/cdd/save/' + json[i].user_profile 
							+ '\" style=\"border-radius: 70%; width: 30px; height: 30px; margin-left: 30px;\" />';
							html += "<a style=\"font-weight: bold; color: black;\" href=\"/cdd/myPage/userProfile.cdd?profileId="+json[i].user_id+ "\">"+json[i].user_id+"</a>";
							html += '<span style="color: #929E9E; display: inline-block">'+ json[i].reply_id+'</span>'
							html += ' ' + json[i].reply_content;
							html += "<br/>";
							html += '<a role="button" onclick="popup()"><span style="float: right; font-size: 10px;">댓글신고</span></a>';
							html += '<a role="button"><span onclick="reply_depth('+ json[i].feed_num+', \'' +user_id+ '\','+json[i].reply_ref+',' + i+', \''+json[i].user_id+'\', 1)" style="float: right; font-size: 10px;">답글달기</span></a>';
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
	
	function popup(){
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<!-- 달력 사용 CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- 달력인코딩 -->
<script src="/cdd/resource/calendar/encodingKo.js"></script>
<!-- UserProfile JavaScript -->
<script src="/cdd/resource/userProfile.js"></script>
</head>
<script>
	$(document).ready(function() {
		
		var pageNum = 1;
		var user_id = $('#user_id').val();
		
		$("#badook").hide();
		$(".cddHeader").load("/cdd/header.cdd?category=main");
		$("#feedWrite").click(function() {
			$(".feed_Write").load("/cdd/feeds/feedWriteForm.cdd");
		})
		$(".noteWriteForm").load("/cdd/myPage/noteWriteForm.cdd");
      $(".scheAddForm").load("/cdd/myPage/scheAddForm.cdd");
       
     $(window).scroll(function() {
      	
     	if($(document).height() <= ($(window).height() + $(window).scrollTop())) {
     		
     		pageNum++;
     		feedAppend(pageNum,user_id);
		}
     });
		
	});
	function showList() {
		$("#list").show();
		$("#badook").hide();

	}
	function showBadook() {
		$("#list").hide();
		$("#badook").show();
	}
</script>
<body>
	<input id="user_id" type="hidden" value="${user_id}" />
	<div class="cddHeader"></div>
	<br />
	<br />
	<br />
	<br />
	<br />




	<div class="container" style="padding-left: 13%; position: relative;">

		<br /> <br />
		<!-- main content -->
		<div id="list">
			<c:set var="index2" value="0" />
			<c:forEach var="feed" items="${follwofeedList}" varStatus="status">
				<div class="card" style="width: 615px;">
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><img src="/cdd/save/${feed.user_profile}" style="border-radius: 70%; float: left; width: 30px; height: 30px;" /> <a style="font-weight: bold; margin-left: 10px; color: black;" href="/cdd/myPage/userProfile.cdd?profileId=${feed.user_id}"> ${feed.user_id} </a> <i style="float: right; font-size: 30px;" class="fas fa-ellipsis-h"></i></li>
						<li class="list-group-item" style="height: 615px;">

							<div id="carouselExampleIndicators${index2}" class="carousel slide" data-ride="carousel" data-touch="false">
								<ol class="carousel-indicators">

									<c:set var="photo" value="photoList${status.index}" />
									<c:set var="indexNumber" value="0" />
									<c:forEach var="photos" items="${requestScope[photo]}">
										<c:if test="${indexNumber == 0}">
											<li data-target="#carouselExampleIndicators${index2}" data-slide-to="${indexNumber}" class="active"></li>
										</c:if>
										<c:if test="${indexNumber > 0}">
											<li data-target="#carouselExampleIndicators${index2}" data-slide-to="${indexNumber}"></li>
										</c:if>

										<c:set var="indexNumber" value="${indexNumber +1 }" />
									</c:forEach>
								</ol>
								<div class="carousel-inner">

									<c:set var="photo" value="photoList${status.index}" />
									<c:set var="indexNumber" value="0" />
									<c:forEach var="photos" items="${requestScope[photo]}">
										<c:if test="${indexNumber == 0}">
											<div class="carousel-item active">
												<img src="/cdd/save/${photos.photo_dir}" style="width: 615px; height: 600px; object-fit: cover;" class="d-block w-100" alt="...">
											</div>
										</c:if>
										<c:if test="${indexNumber > 0}">
											<div class="carousel-item">
												<img src="/cdd/save/${photos.photo_dir}" style="width: 615px; height: 600px; object-fit: cover;" class="d-block w-100" alt="...">
											</div>
										</c:if>
										<c:set var="indexNumber" value="${indexNumber +1 }" />
									</c:forEach>
								</div>
								<a class="carousel-control-prev" href="#carouselExampleIndicators${index2}" role="button" data-slide="prev" data-target="#carouselExampleIndicators${index2}"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
								</a> <a class="carousel-control-next" href="#carouselExampleIndicators${index2}" role="button" data-slide="next" data-target="#carouselExampleIndicators${index2}"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
								</a>
							</div>
						</li>
						<li class="list-group-item"><c:if test="${feed.likeCh == 0}">
								<div id="main_heart${index2}" style="float: left; display: inline-block; background-color: #ffffff;">
									<a role="button" title="좋아요" onclick="heartProcess(${feed.feed_num},'${user_id}',${feed.likeCh},'${feed.user_id}', ${index2}, ${likeCount})"><i style="font-size: 30px;" class="far fa-heart"></i> </a>
								</div>
							</c:if> <c:if test="${feed.likeCh == 1}">
								<div id="main_heart${index2}" style="display: inline-block; float: left;">
									<a role="button" title="좋아요 취소"onclick="heartProcess(${feed.feed_num}, '${user_id}',${feed.likeCh},'${feed.user_id}', ${index2},${likeCount})"> <i style="color: red; font-size: 30px;" class="fas fa-heart"></i>
									</a>
								</div>

							</c:if> <!-- Button trigger modal --> <a role="button" title="댓글보기" onclick="contentView(${feed.feed_num}, ${index2})" id="replyView" type="button" data-toggle="modal" data-target="#feedContent"> <i style="font-size: 30px; margin-left: 10px;" class="far fa-comment"></i>
						</a> <a role="button" onclick="popup()"> <i style="font-size: 30px; margin-left: 5px;" class="far fa-share-square"></i>
						</a> <c:if test="${feed.bookCh == 0}">
								<div id="main_bookmark${index2}" style="display: inline-block; float: right">
									<a role="button" title="북마크" onclick="bookmarkProcess(${feed.feed_num}, '${user_id}', ${feed.bookCh}, ${index2})"> <i style="font-size: 30px;" class="far fa-bookmark"></i>
									</a>
								</div>
							</c:if> <c:if test="${feed.bookCh == 1}">
								<div id="main_bookmark${index2}" style="display: inline-block; float: right">
									<a role="button" title="북마크취소" onclick="bookmarkProcess(${feed.feed_num}, '${user_id}', ${feed.bookCh}, ${index2})"> <i style="font-size: 30px;" class="fas fa-bookmark"></i>
									</a>
								</div>
							</c:if> <br /> <br />
							<div id="likeCount${index2}">${feed.likeCount}명이좋아합니다.</div>
							<c:set var="substring" value="${feed.feed_content}" />
							<div id="moreView${index2}">
								<strong>${feed.user_id}</strong> ${fn:substring(substring,0,10)}....<a onclick="moreView('${feed.feed_content}', ${index2}, '${feed.user_id}', '${feed.feed_hash}')" style="color: #696969; cursor: pointer;">더 보기</a>
							</div></li>
					</ul>
				</div>
				<br />
				<br />
				<br />
				<br />
				<c:set var="index2" value="${index2 + 1 }" />
			</c:forEach>
		</div>
	</div>
	<!-- floating button -->
	<div class="btn-group dropup" style="position: fixed; bottom: 50px; right: 300px;">
		<a class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="/cdd/resource/img/floatingBtn.png" width="40px" />
		</a>
		<div class="dropdown-menu">
			<a class="dropdown-item" id="feedWrite" type="button" data-toggle="modal" data-target="#feedWriteView">피드작성</a> 
			<a class="dropdown-item" data-target="#staticBackdrop" data-toggle="modal" role="button">일지작성</a> 
			<a class="dropdown-item" id="scheAddForm" data-target="#staticBackdrop4" data-toggle="modal" role="button">일정추가</a>
		</div>
	</div>
	<!-- Button trigger modal -->

	<!-- Modal Feed write-->
	<div id="feedWriteView" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content feed_Write"></div>
		</div>
	</div>

	<!-- Modal feed content-->
	<div id="feedContent" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content feed_content"></div>
		</div>
	</div>

	<!-- 작성 noteWriteform  -->
	<div id="staticBackdrop" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-mg">
			<div class="modal-content noteWriteForm" style="width: 600px;"></div>
		</div>
	</div>

	<!-- 일정 추가 -->
	<div id="staticBackdrop4" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content scheAddForm"></div>
		</div>
	</div>

	<script type="text/javascript">
	function noteWriteFormModal(){
		$(".noteWriteForm").load("/cdd/myPage/noteWriteForm.cdd"); /* 어디서 불렀는지 view 파라미터로 넘겨주기 */
	}
	function heartProcess(feed_num, user_id, likeCh, user_to, index2,likeCount) {
		var ajaxJson = new Object();
		ajaxJson.feed_num = feed_num;
		ajaxJson.user_id = user_id;
		ajaxJson.likeCh = likeCh;
		ajaxJson.user_to = user_to;
		ajaxJson.index2 = index2;
		ajaxJson.likeCount = likeCount;
		
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
		        $("#likeCount" + index2).empty();
		        
		        if(json.likeCh == 1) {
		        	var html = '<div id="heart" style="display: inline-block; background-color: white;"><a role="button" onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\', '+json.index2+');"><i style="color: red; font-size: 30px;"class="fas fa-heart"></i></a></div>';
		        }else if(json.likeCh == 0) {
		        	var html = '<div id="heart" style="display: inline-block;"><a role="button" onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\', '+json.index2+');"><i style="font-size: 30px;" class="far fa-heart"></i></a></div>';
		        }
		        
		        $('#main_heart' + index2).append(html);
		        $("#content_heart").append(html);
		       	$("#likeCount"+ index2).append(json.likeCount+"명이 좋아합니다.");
				
		       }

		}) 
		
	}
	function bookmarkProcess(feed_num, user_id, bookCh, index2) {
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
	function moreView(feed_content, index2, user_id, feed_hash) {
		
		$('#moreView' + index2).empty();
		var html = '<strong >'+user_id+'</strong>';
		html += "&nbsp;";
		html += feed_content;
		html += "<br/>";
		var hash_split = feed_hash.split("#");
		for(var i =0; i < hash_split.length;i++) {
			
			if(i == 0) {
				
			}else {
			html += "<a href=\"/cdd/searchResult.cdd?search="+hash_split[i]+"\">";	
			html += "#" + hash_split[i];
			html += "</a>";
			}
		}
		
		$('#moreView' + index2).append(html);
	}
	
	function contentView(feed_num, index2) {
		$(".feed_content").load('/cdd/feeds/feedContent.cdd?feed_num=' + feed_num + '&index2=' + index2);
	}
	var index2 = 10;
	function feedAppend(pageNum,user_id) {
		var ajaxJson = new Object();
		ajaxJson.pageNum = pageNum;
		var jsonString = JSON.stringify(ajaxJson);
		
		$.ajax({
		    url : '/cdd/appendFeeds.cdd',
		    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
		    method : 'POST', // 전달방식이 controller와 일치해야함
		    data : jsonString, // 전달하는 데이터
		    success: function(data){
		        
		    	var json = JSON.parse(data);
		    	console.log(json);
		    	var html = "";
		    	for(var i = 0; i < json.follwofeedList.length; i++) { // 피드
		    		html += '<div class="card" style="width: 615px;">';
		    		html += '<ul class="list-group list-group-flush">';
		    		html += '<li class="list-group-item">';
		    		html += '<img src="/cdd/save/'+ json.follwofeedList[i].user_profile+'" style="float: left; width: 30px; height: 30px;" />'; 
		    		html += "<a style=\"font-weight: bold; margin-left: 10px; color: black;\"href=\"/cdd/myPage/userProfile.cdd?profileId="+json.follwofeedList[i].user_id+"\">"+json.follwofeedList[i].user_id+"</a>";
		    		
					html += '<li class="list-group-item" style="height: 615px;">';
					html += '<div id="carouselExampleIndicators'+ index2 +'" class="carousel slide" data-ride="carousel" data-touch="false"> <ol class="carousel-indicators">';
		    		var feedNumPhoto = json.follwofeedList[i].feed_num;
		    		for(var j = 0; j < json[feedNumPhoto].length; j++) { // 사진
		    			if(j == 0) {
		    				html += '<li data-target="#carouselExampleIndicators'+ index2 +'" data-slide-to="'+j+'" class="active"></li>';
		    			}else if(j > 0) {
		    				html += '<li data-target="#carouselExampleIndicators'+ index2 +'" data-slide-to="'+j+'"></li>';
		    			}
						
		    		} // 사진 포문 끝
		    		html += '</ol><div class="carousel-inner">';
		    		
		    		for(var j = 0; j < json[feedNumPhoto].length; j++) { // 사진
		    			if(j == 0) {
		    				html += '<div class="carousel-item active"> <img src="/cdd/save/'+ json[feedNumPhoto][j].photo_dir +'" style="width: 615px; height: 600px; object-fit: cover;" class="d-block w-100" alt="..."> </div>';
		    				
		    			}else {
		    				html += '<div class="carousel-item"> <img src="/cdd/save/'+ json[feedNumPhoto][j].photo_dir +'" style="width: 615px; height: 600px; object-fit: cover;" class="d-block w-100" alt="..."> </div>';
		    			}
		    		} // 사진 포문 끝
		    		
		    		html += '</div> <a class="carousel-control-prev" ';
		    		html += 'href="#carouselExampleIndicators'+index2+'" role="button" ';
		    		html += 'data-slide="prev"';
		    		html += 'data-target="#carouselExampleIndicators'+index2+'"> <span ';
		    		html += 'class="carousel-control-prev-icon" aria-hidden="true"></span> <span ';
		    		html += 'class="sr-only">Previous</span> ';
		    		html += '</a>';
		    		html += '<a class="carousel-control-next" ';
		    		html += 'href="#carouselExampleIndicators'+ index2 +'" role="button" ';
		    		html += 'data-slide="next" ';
		    		html += 'data-target="#carouselExampleIndicators'+index2+'"> <span ';
		    		html += 'class="carousel-control-next-icon" aria-hidden="true"></span> <span ';
		    		html += 'class="sr-only">Next</span></a> ';
					html += '</div></li>';
					html += '<li class="list-group-item">';
					
					if(json.follwofeedList[i].likeCh == 0) {
			        	html += '<div id="main_heart'+index2+'" style="display: inline-block;"><a role="button" onclick="heartProcess('+json.follwofeedList[i].feed_num+',\'' +user_id+'\',' + json.follwofeedList[i].likeCh +',\''+json.follwofeedList[i].user_to+'\', '+index2+');"><i style="font-size: 30px;" class="far fa-heart"></i><a></div>';
			        }else if(json.follwofeedList[i].likeCh == 1) {
			        	html += '<div id="main_heart'+index2+'" style="display: inline-block;"><a role="button" onclick="heartProcess('+json.follwofeedList[i].feed_num+',\'' +user_id+'\',' + json.follwofeedList[i].likeCh +',\''+json.follwofeedList[i].user_to+'\', '+index2+');"><i style="font-size: 30px; color:red;"class="fas fa-heart"></i></a></div>';
			        }
					html += '<a role="button" onclick="contentView('+ json.follwofeedList[i].feed_num +', '+index2+')"';
					html += ' id="replyView" type="button" ';
					html += 'data-toggle="modal" data-target="#feedContent">';
					html += '<i style="font-size: 30px; margin-left: 10px;" class="far fa-comment"></i>';
					html += '</a>';
					html += '<a role="button">';
					html += '<i style="font-size: 30px; margin-left: 10px;" class="far fa-share-square"></i>';
					html += '</a>';
					
					if(json.follwofeedList[i].bookCh == 0) {
			        	html += '<div id="main_bookmark'+index2+'" style="display: inline-block; float: right"><a role="button" onclick="bookmarkProcess('+ json.follwofeedList[i].feed_num + ',\''+ json.follwofeedList[i].user_id +'\', '+ json.follwofeedList[i].bookCh +','+index2+')"><i style="font-size: 30px;" class="far fa-bookmark"></i></a></div>';
			        }else if(json.follwofeedList[i].bookCh == 1) {
			        	html += '<div id="main_bookmark'+index2+'" style="display: inline-block; float: right"><a role="button" onclick="bookmarkProcess('+ json.follwofeedList[i].feed_num + ',\''+ json.follwofeedList[i].user_id +'\', '+ json.follwofeedList[i].bookCh +', '+index2+')"><i style="font-size: 30px;" class="fas fa-bookmark"></i></a></div>';
			        }
					
					html += '<br /> <br /> '+ json.follwofeedList[i].likeCount+'명이 좋아합니다.<br />';
					
					var feed_content = json.follwofeedList[i].feed_content.substring(0,10);
					html += '<div id="moreView'+index2+'">';
					html += '<strong>'+json.follwofeedList[i].user_id +'</strong>';
					html += feed_content + '....';
					html += '<a onclick="moreView(\''+json.follwofeedList[i].feed_content +'\','+ index2 +',\''+json.follwofeedList[i].user_id+'\', \'' +json.follwofeedList[i].feed_hash+'\')" style="color: #696969; cursor: pointer;">더 보기</a>';
					html += '</div>';	
					html += '</li>';
					html += '</ul></div><br /><br /><br /><br />';
		    		index2++;
		    		
		    	}
		    	$('#list').append(html);
		    	
		    }
		});
	}
	
	function popup(){
        var url = "/cdd/feeds/reportPage.cdd";
        var name = "popup test";
        var option = "width = 500, height = 500, top = 300, left = 700, location = no";
        window.open(url, name, option);
    }
	</script>
</body>
</html>
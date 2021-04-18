<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- 달력인코딩 -->
<script src="/cdd/resource/calendar/encodingKo.js"></script>
<!-- UserProfile JavaScript -->
<script src="/cdd/resource/userProfile.js"></script>
</head>
<script>
	$(document).ready(function(){
		var pageNum = 1;
		
		$(".cddHeader").load("/cdd/header.cdd?category=allfeed");
		$("#feedWrite").click(function() {
			$(".feed_Write").load("/cdd/feeds/feedWriteForm.cdd");
		})
		$(".noteWriteForm").load("/cdd/myPage/noteWriteForm.cdd");
      $(".scheAddForm").load("/cdd/myPage/scheAddForm.cdd");
		$(window).scroll(function() {
	     	if($(document).height() <= ($(window).height() + $(window).scrollTop())) {
	     		pageNum++;
	     		feedAppend(pageNum);
			}
	     });
		
	});
	
</script>
<body>
	<div class="cddHeader"></div>
	<br />
	<br />
	<br />
	<div class="container" align="center">


		<br /> <br />
		<div id="allFeedView" style="width: 80%; height: 800px;">
			<fmt:parseNumber var="rowCount" value="${(15 / 3) + (15 % 3 eq 0 ? 0 : 1)}" integerOnly="true" />
			
			<c:set var="pageNum" value="1" />
			<c:forEach begin="1" end="${rowCount}">
				<c:set var="startRow" value="${((pageNum - 1) * 3 + 1) -1}" />
				<c:set var="endRow" value="${(startRow + 3) -1}" />
				<div class="row" style="margin-top: 50px;">
					<c:forEach begin="${startRow}" end="${endRow}" var="list" items="${mainAllFeed}" varStatus="status">
						<div class="col-md-4">
							<a onclick="contentView(${list.feed_num})" id="replyView" type="button" data-toggle="modal" data-target="#feedContent"> <img style="width: 290px; height: 290px;" src="/cdd/save/${list.photo_dir}" class="img-fluid" />
							</a>
						</div>
					</c:forEach>
				</div>
				<c:set var="pageNum" value="${pageNum + 1}" />
			</c:forEach>
		</div>
			<div id="feedContent" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
					<div class="modal-content feed_content"></div>
				</div>
			</div>










		<!-- floating button -->
		<div class="btn-group dropup" style="position: fixed; bottom: 50px; right: 300px;">
			<a class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="/cdd/resource/img/floatingBtn.png" width="40px" />
			</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" id="feedWrite" type="button" data-toggle="modal" data-target="#feedWriteView">피드작성</a> <a class="dropdown-item" id="noteWriteForm" data-target="#staticBackdrop" data-toggle="modal" role="button">일지작성</a> <a class="dropdown-item" id="scheAddForm" data-target="#staticBackdrop4" data-toggle="modal" role="button">일정추가</a>
			</div>
		</div>


		<!-- 작성 noteWriteform  -->
		<div id="staticBackdrop" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content noteWriteForm"></div>
			</div>
		</div>

		<!-- 일정 추가 -->
		<div id="staticBackdrop4" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content scheAddForm"></div>
			</div>
		</div>

		<!-- Modal Feed write-->
		<div id="feedWriteView" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content feed_Write"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
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
		function feedAppend(pageNum) {
			var ajaxJson = new Object();
			ajaxJson.pageNum = pageNum;
			var jsonString = JSON.stringify(ajaxJson);
			
			$.ajax({
			    url : '/cdd/appendAllFeeds.cdd',
			    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
			    method : 'POST', // 전달방식이 controller와 일치해야함
			    data : jsonString, // 전달하는 데이터
			    success: function(data){
			    	var json = JSON.parse(data);
			    	console.log(json);
			    	var mainAllfeed = json.mainAllFeed;
			    	var allCount = json.allCount;
			    	var html = "";
			    	
			    	var rowCount = Math.floor(15 / 3) + (15 % 3 == 0 ? 0 : 1);
			    	
			    	var startIndex = 1;
			    	for(var i = 0; i < rowCount; i++) {
			    		html += "<div class=\"row\" style=\"margin-top: 50px;\">";
			    		var startRow = ((startIndex - 1) * 3 +1) -1;
			    		var endRow = (startRow + 3) -1;
			    		if(endRow >= mainAllfeed.length-1) {
			    			endRow = mainAllfeed.length -1;
			    		}
			    		if(startRow > mainAllfeed.length) {
			    			break;
			    		}
			    		
			    		
			    		
			    		
			    		
			    		for(var j = startRow; j <= endRow; j ++) {
			    			html += "<div class=\"col-md-4\">";
			    			html += "<a onclick=\"contentView("+mainAllfeed[j].feed_num +")\" id=\"replyView\" type=\"button\" data-toggle=\"modal\" data-target=\"#feedContent\"> <img style=\"width: 290px; height: 290px;\" src=\"/cdd/save/"+mainAllfeed[j].photo_dir +"\"class=\"img-fluid\" />";
			    			html += "</a>";
			    			html += "</div>";
			    		}
			    		html += "</div>";
			    		
			    		startIndex++;
			    	}
			    		
			    		
						
			    	$('#allFeedView').append(html);
			    	
			    }
			});
		}
	</script>
</body>
</html>
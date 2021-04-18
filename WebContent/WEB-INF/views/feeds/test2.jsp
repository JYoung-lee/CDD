<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/cdd/resources/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resources/js/bootstrap.bundle.js"></script>
<script src="/cdd/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/cdd/resources/css/bootstrap.css">

<body>


	<!-- Button trigger modal -->
	<button id="hiyo" type="button" class="btn btn-primary"
		data-toggle="modal" data-target="#staticBackdrop">Launch
		static backdrop modal</button>



	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content"></div>
		</div>
	</div>
	
	
	<script type="text/javascript">
	$("#hiyo").click(function() {
		$(".modal-content").load("/cdd/feeds/feedContent.cdd?feed_num=1");
	})
	
	function reply_depth(feed_num, user_id, reply_num, current, reply_id, reply_level) {
		
		console.log(reply_id);
		var html = '<input id="reply1" type="text" style="width: 80%;" placeholder="댓글입력"/>';
		html += '<button type="button" class="btn btn-primary" onclick="test('+feed_num +',\'' +user_id +'\','+ reply_num + ',\''+ reply_id +'\','+reply_level+','+current+');">등록</button>';
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
							html += '<img src=\"/cdd/resources/img/' + json[i].user_profile 
							+ '\" style=\"width: 30px; height: 30px;\" />';
							html += ' <strong>' + json[i].user_id + '</strong>';
							html += ' ' + json[i].reply_content;
							html += '<a href="#"><p style="float: right; font-size: 10px;">댓글신고</p></a>';
							html += '<a href="#"><p onclick="reply_depth('+ json[i].feed_num+', \'' +user_id+ '\','+json[i].reply_ref+',' + i+', \''+json[i].user_id+'\', 1)" style="float: right; font-size: 10px;">답글달기</p></a>';
							html += '<div id=\"depth'+i+'\"></div>';
							html += '<hr>';
						}
						if(Number(json[i].reply_level) == 1) {
							html += '<img src=\"/cdd/resources/img/' + json[i].user_profile 
							+ '\" style=\"width: 30px; height: 30px; margin-left: 30px;\" />';
							html += ' <strong>' + json[i].user_id + '</strong>';
							html += '<p style="color: #929E9E; display: inline-block">'+ json[i].reply_id+'</p>'
							html += ' ' + json[i].reply_content;
							html += '<a href="#"><p style="float: right; font-size: 10px;">댓글신고</p></a>';
							html += '<a href="#"><p onclick="reply_depth('+ json[i].feed_num+', \'' +user_id+ '\','+json[i].reply_ref+',' + i+', \''+json[i].user_id+'\', 1)" style="float: right; font-size: 10px;">답글달기</p></a>';
							html += '<div id=\"depth'+i+'\"></div>';
							html += '<hr>';
						}
					}
						
					$('#reply_body').append(html);	
					
			       }
			       


			}) 
			
			
		
		}
	
	function heartProcess(feed_num, user_id, likeCh, user_to) {
		var ajaxJson = new Object();
		ajaxJson.feed_num = feed_num;
		ajaxJson.user_id = user_id;
		ajaxJson.likeCh = likeCh;
		ajaxJson.user_to = user_to;
		
		var jsonString = JSON.stringify(ajaxJson);
		
		$.ajax({
		    url : '/cdd/feeds/heartProcess.cdd',
		    contentType: 'application/json; charset=UTF-8', // 보내는 데이터 json 일때 필수 옵션
		    method : 'POST', // 전달방식이 controller와 일치해야함
		    data : jsonString, // 전달하는 데이터
		    success: function(data){
		        
		    	var json = JSON.parse(data);
		        console.log(json);
				
		        $("#heart").empty();
		        
		        
		        if(json.likeCh == 1) {
		        	var html = '<div id="heart" style="display: inline-block;"><button onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\');" style="outline: 0; border: 0;"><img style="width: 30px; height: 30px;"src="/cdd/resources/img/heart-red.png" /></button></div>';
		        }else if(json.likeCh == 0) {
		        	var html = '<div id="heart" style="display: inline-block;"><button onclick="heartProcess('+json.feed_num+',\'' +json.user_id+'\',' + json.likeCh +',\''+json.user_to+'\');" style="outline: 0; border: 0;"><img style="width: 30px; height: 30px;"src="/cdd/resources/img/heart-black.png" /></button></div>';
		        }
		        
		        $('#heart').append(html);
		        
				
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
			        	var html = '<div style="display: inline-block" id="follow"><button type="button" class="btn btn-primary btn-sm" onclick="followProcess(\''+json.user_from+'\', \''+json.user_to+'\', '+json.followCh+')">팔로우</button></div>';
			        	
			        }else if(json.followCh == 1) {
			        	var html = '<div style="display: inline-block" id="follow"><button type="button" class="btn btn-secondary btn-sm" onclick="followProcess(\''+json.user_from+'\', \''+json.user_to+'\', '+json.followCh+')">팔로잉</button></div>';
			        	
			        }
		        	
		    	 $('#follow').append(html);
				
		       }
		       


		}) 
	}
	
	function bookmarkProcess(feed_num, user_id, bookCh) {
		var ajaxJson = new Object();
		ajaxJson.feed_num = feed_num;
		ajaxJson.user_id = user_id;
		ajaxJson.bookCh = bookCh;
		
		console.log(bookCh);
		
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
		    	
		    	$("#bookmark").empty();
		    	
		    	if(json.bookCh == 0) {
		        	var html = '<div id="bookmark" style="display: inline-block; float: right"><button onclick="bookmarkProcess('+ json.feed_num + ',\''+ json.user_id +'\', '+ json.bookCh +')" style="outline: 0; border: 0;"><img style="width: 30px; height: 30px;"src="/cdd/resources/img/bookmark-white.png" /></button></div>';
		        }else if(json.bookCh == 1) {
		        	var html = '<div id="bookmark" style="display: inline-block; float: right"><button onclick="bookmarkProcess('+ json.feed_num + ',\''+ json.user_id +'\', '+ json.bookCh +')" style="outline: 0; border: 0;"><img style="width: 30px; height: 30px;"src="/cdd/resources/img/bookmark-black.png" /></button></div>';
		        }
		        	
		    	 $('#bookmark').append(html);
		    }
		}) 
	}
		       	
		    	 
		       


		
		
		
		
	</script>




</body>
</html>


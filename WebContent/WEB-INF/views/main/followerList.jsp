<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDD</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
</head>
<body>
	<div id="testModal">
	<div class="modal-header" style="height: 50px;">
       <h6 class="modal-title">새로운 메세지</h6>
       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <span aria-hidden="true">&times;</span>
       </button>
     </div>
     <div class="modal-body">
     <form action="#">
		<ul class="list-group list-group-flush">
			<li>gd${followList }gd</li>
			<c:if test="${followList == null}">
				<li class="list-group-item">
					친구가 없습니다 ㅠㅠ
				</li>
			</c:if>
			<c:forEach var="follows" items="${followList }">
			  <li class="list-group-item">${follows }<input type="radio" name="userId" value="${follows }" style="float: right;"/></li>
			</c:forEach>
		</ul>
       <!-- <button type="submit" class="btn btn-primary" style="float: right;">보내기</button> -->
       <button type="button" class="btn btn-primary" style="float: right;" id="sendDmBtn" >보내기</button>
     </form>
     </div>
     </div>
     <script>
     	/* ${document}.ready(function(){
     		$("#sendDmBtn").click(function(){
     			$(".modal-content").load("")
     		})
     	}); */
     	$(document).ready(function(){
	     	
     	})
     </script>
</body>
</html>
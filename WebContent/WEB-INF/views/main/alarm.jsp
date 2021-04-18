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
</head>
<body>

<div class="modal-header" style="height: 50px;">
	<img src="/cdd/resource/img/bell.png" width="25px"/>&nbsp;&nbsp;&nbsp;
	<h5 class="modal-title">알림</h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<div class="modal-body" style="overflow: auto; max-height: 200px;">
	<c:if test="${alarms == '[]' }">
		<h2 align="center" style="color: lightgray;">알림이 없습니다</h2>
	</c:if>
	<c:if test="${alarms != '[]' }">
		<c:forEach var="alarm" items="${alarms}">
			<img src="/cdd/save/${alarm.user_profile}" style="border-radius: 70%; width: 30px; height: 30px; border-radius: 70%; overflow: hidden;"/>
			
				<a style="margin-left: 10px;" href="/cdd/myPage/userProfile.cdd?profileId=${alarm.alarmFromId}">${alarm.alarmFromId }</a> 
				<c:if test="${alarm.feed_num != 0 }">
					<a>${alarm.alarm_content}</a>
				</c:if>
				<c:if test="${alarm.feed_num == 0 }">
					${alarm.alarm_content}
				</c:if>
				<hr>
			
		</c:forEach>
	</c:if>
</div>
</body>
</html>
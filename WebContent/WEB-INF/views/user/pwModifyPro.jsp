<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${res == 0 }">
	<script>
		alert("이전 비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${res != 0 }">
	<script>
		alert("비밀번호가 변경되었습니다.");
	</script>
	<c:redirect url="/mainAllFeed.cdd"/>
</c:if>
</body>
</html>
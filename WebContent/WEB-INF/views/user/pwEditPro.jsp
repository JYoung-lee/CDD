<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwEditPro</title>
</head>
<body>
<c:if test="${result == 1 }">
	<script>
		alert("비밀번호가 입력되지 않았습니다.");
		window.location="/cdd/user/loginForm.cdd";
	</script>
</c:if>
<c:if test="${result == 2 }">
	<script>
		alert("비밀번호 확인창이 입력되지 않았습니다.");
		window.location="/cdd/user/loginForm.cdd";
	</script>
</c:if>
<c:if test="${result == 3 }">
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		window.location="/cdd/user/loginForm.cdd";
	</script>
</c:if>
<c:if test="${result == 4 }">
	<script>
		alert("비밀번호가 변경 되었습니다.");
		window.location="/cdd/user/loginForm.cdd";
	</script>
</c:if>
</body>
</html>
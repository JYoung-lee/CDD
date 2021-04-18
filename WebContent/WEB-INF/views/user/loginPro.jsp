<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login Pro</title>
</head>
<body>
<c:if test="${result == 0 }">
	<script>
		alert("아이디 또는 비밀번호를 확인해주세요.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 1 }">
	<c:redirect url="/main.cdd" />
</c:if>
<c:if test="${result == 2 }">
	<script>
		alert("해당 계정은 정지 상태입니다. 관리자에게 문의해주세요.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>
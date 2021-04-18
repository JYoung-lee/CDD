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
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
		setTimeout(function(){
			history.go(-1);
		},6000);
	});
	
</script>
</head>
<body class="all">
<div class="cddHeader">
</div>
<br />
<br />
<br />
<div class="container" align="center">
	<img src="/cdd/resource/img/errorman.png" style="width: 100%;"/><br/><br/>
	<h1 style="font-weight: bolder;">심상치 않은 오류는 너굴맨이 처리할테니 안심하라구!!</h1>
</div>
</body>
</html>
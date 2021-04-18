<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>setting</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body class="all">
<div class="cddHeader"> 
</div>
<br/><br/><br/><br/>
<div class="row">
	<div class="col-md-3" ></div>
	<div class="col-md-2" align="left" style="font-size: 30px;">
		<a class="dropdown-item"  role="button" href="/cdd/admin/memberList.cdd"><i class="fas fa-address-book"></i> &nbsp;회원 목록</a>
		<a class="dropdown-item"  role="button" href="/cdd/admin/typeKindAdd.cdd" ><i class="fas fa-cog"></i> &nbsp;사이트 설정</a>
		<a class="dropdown-item"  role="button" href="/cdd/admin/reportList.cdd" ><i class="far fa-flag"></i> &nbsp;신고 접수</a>
	</div>
	<div class="col-md-2" ></div>
</div>


</body>
</html>
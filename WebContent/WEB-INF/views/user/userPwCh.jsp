<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userPwChPro</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
	<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
	<script src="/cdd/resource/js/bootstrap.js"></script>
</head>
<body class="text-center">
	<div class="card align-middle" >
		<div class="card-body" align="center">
			<div class="container">
				<h6 style="color: #808080; " align="center">비밀번호를 입력하세요.
					<button type="button" class="close" aria-label="Close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
				</h6>
				<form action="/cdd/user/userPwChPro.cdd" method="post">
					<input type="password" name="user_pw" style="width: 150px">
					<input type="submit" class="btn btn-primary" value="확인">
				</form>
			</div>
		</div>
	</div>
</body>
</html>

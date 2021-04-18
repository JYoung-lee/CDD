<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.js"></script>

</head>
<body>
	<div class="card align-middle">
		<div class="card-title">
			<br/>
			<div class="col-md-11">
				<button type="button" class="close" aria-label="Close" data-dismiss="modal" onclick="window.location.reload()">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br/><br/>
			<img src="/cdd/resource/img/logoFont.png" width="200px" />
		</div>
		<div class="card-body" align="center">
			<div class="container">
				<form action="/cdd/user/pwEditPro.cdd" method="post" >
					<input type="hidden" name="user_id" value="${user_id}">
				  <div class="form-group"> 새로운 비밀번호
				  	  <input type="password" class="form-control" name="user_pw"  placeholder="새 비밀번호" style="width: 200px;">
				  </div>
				  <div class="form-group"> 재입력
				  	  <input type="password" class="form-control" name="pwCh" placeholder="재입력" style="width: 200px;">
				  </div>
				  <div>
					  <button type="submit" class="btn btn-primary">비밀번호 변경</button>
				  </div>
				</form>
			</div>
		</div>						
	</div>
</body>
</html>
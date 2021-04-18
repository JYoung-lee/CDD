<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.js"></script>
<body>
<div class="modal-header">
	<h5 class="modal-title">비밀번호 변경</h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<div class="modal-body">
	<form action="user/pwModifyPro.cdd" method="post">
		<input type="hidden" value="${sessId }" name="userId"/>
	  <div class="form-group">
	    <input type="text" class="form-control" name="exPw" placeholder="현재 비밀번호" style="width: 200px;">
	  </div>
	  <div class="form-group">
	    <input type="password" class="form-control" name="newPw" placeholder="새 비밀번호" style="width: 200px;">
	  </div>
	  <div class="form-group">
	    <input type="password" class="form-control" name="newPwCh" placeholder="새 비밀번호 확인" style="width: 200px;">
	  </div>
	  <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	  <button type="submit" class="btn btn-primary">변경</button>
	</form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캣댕댕</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.js"></script>
<script>
		$("#btn").click(function(){
			$.ajax({
				type : "post",
				url : "/cdd/user/findIdPro.cdd",
				data : {email : $("#user_email").val()},
				success : function(result){
					console.log(result);
					$("#reId").val(result);
					$("#reId1").val(result);
				}
			});
		});
	</script>
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
				<div align="center">
				<ul class="nav nav-tabs" >
					<li class="nav-item">
						<a class="nav-link active" data-toggle="tab" href="#findId">아이디 찾기</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#findPw">비밀번호 찾기</a>
					</li>
				</ul>
				<br/>
				</div>
				<div class="tab-content" >
					<div class="tab-pane fade show active" id="findId">
						<form action="" method="post">
						  <div class="form-group" style="color: #808080; "> 이메일
						    <input type="email" class="form-control" name="email" id="user_email" placeholder="이메일" style="width: 200px;">
						  </div>
						  <div class="form-group" style="color: #808080; "> 아이디
							<input type="text" id="reId" placeholder="아이디" disabled="disabled" class="form-control" style="width: 200px;"/>
						  </div>
						  <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
						  <button type="button" id="btn" class="btn btn-primary"  >찾기</button>
						</form>
					</div>
					<div class="tab-pane fade" id="findPw">
						<form action="" method="post">
						  <div class="form-group" style="color: #808080; "> 아이디
						    <input type="text" placeholder="아이디" id="reId1" class="form-control" name="id" style="width: 200px;">
						  </div>
						  <div class="form-group" style="color: #808080; "> 이메일
						    <input type="email" class="form-control" placeholder="이메일" id="pw_email" name="email" style="width: 200px;">
						  </div>
						  <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
						  <button type="button" id="pwEdit" class="btn btn-primary" data-toggle="modal" data-target="#editModal">비밀번호 변경</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="editModal" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
			</div> 
		</div> 
	</div>
	<script>
		$("#pwEdit").click(function(){
			$.ajax({
				type : "post",
				url : "/cdd/user/findPwPro.cdd",
				data : {id : $("#reId1").val(), email : $("#pw_email").val()},
				success : function(uri){
					if(uri == "user/pwEdit"){
						$(".modal-content").load("/cdd/user/pwEdit.cdd?user_id="+$('#reId1').val());
					}
					if(uri == "user/findIdPw"){
						$(".modal-content").load("/cdd/user/findIdPw.cdd");
					}
					console.log(uri);
				}
			});
		});
	</script>
</body>
</html>
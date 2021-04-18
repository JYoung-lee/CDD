<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
	<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
	<script src="/cdd/resource/js/bootstrap.js"></script>
	<script>
		$(document).ready(function(){
			if($("#idch").val() != null){
				$("#idch").change(function(){
					var idval = $("#idch").val();
					$.ajax({
						type : "post",
						url : "/cdd/user/ajaxIdEmailAvail.cdd",
						data : {id : idval},
						success : function(result){
							if(result == "Available"){
								$("#idChRes").val("사용가능한 아이디입니다.").css("color", "gray");
							}
							if(result == "Not Available"){
								$("#idChRes").val("이미 사용중인 아이디입니다.").css("color", "red");
							}
							console.log(result);
						}
					});
				});
			} if($("#email").val() != null){
				$("#email").change(function(){
					var emailval = $("#email").val();
					$.ajax({
						type : "post",
						url : "/cdd/user/ajaxIdEmailAvail.cdd",
						data : {email : emailval},
						success : function(result){
							if(result == "Available"){
								$("#emailChRes").val("사용가능한 이메일입니다.").css("color", "gray");
							}
							if(result == "Not Available"){
								$("#emailChRes").val("이미 사용중인 아이디입니다.").css("color", "red");
							}
							console.log(result);
						}
					});
				});
			}
		});
	</script>
<c:if test="${sessionScope.memId != null }">
	<script>
		alert("로그인 상태입니다.");
		window.location="/cdd/user/main.cdd";
	</script>
</c:if>
<c:if test="${sessionScope.memId == null }">
<body>
	<form action="/cdd/user/signupPro.cdd" method="post">
		<%-- 이미지 default 값 --%>
		<input type="hidden" name="user_profile" value="defaultimg.png" />
		
	<div align="center" style="padding: 20px;">
		<div class="form-group">
			<img src="/cdd/resource/img/logoFont.png" width="200px"/><br/><br/>
			<h6 style="color: #808080; ">다른 보호자의 사진과 동영상을 보려면 가입하세요.</h6>
		</div>
	  <div class="form-group" style="color: #808080; "> 아이디 <!-- 아이디 -->
	    <input type="text" class="form-control" name="user_id" id="idch" placeholder="아이디" style="width: 250px;" maxlength="20">
	  </div>
	  <div class="form-group" style="color: #808080; "> 아이디 중복확인 <!-- 아이디 사용여부 -->
	    <input type="text" class="form-control" id="idChRes" disabled="disabled" placeholder="아이디 확인" style="width: 250px;">
	  </div>
	  <div class="form-group" style="color: #808080; "> 비밀번호 <!-- 비밀번호 -->
	    <input type="password" class="form-control" name="user_pw" placeholder="비밀번호" style="width: 250px;" maxlength="20">
	  </div>
	  <div class="form-group" style="color: #808080; "> 비밀번호 재입력 <!-- 비밀번호 확인 -->
	    <input type="password" class="form-control" name="pwCh" placeholder="비밀번호 재입력" style="width: 250px;" maxlength="20">
	  </div>
	  <div class="form-group" style="color: #808080; "> 이메일 <!-- 이메일 -->
	    <input type="email" class="form-control" name="user_email" id="email" placeholder="이메일" style="width: 250px;" maxlength="50">
	  </div>
	  <div class="form-group" style="color: #808080; "> 이메일 중복확인<!-- 이메일 확인 -->
	    <input type="email" class="form-control" id="emailChRes" disabled="disabled" placeholder="이메일 중복확인" style="width: 250px;">
	  </div>
	  <div class="form-group" style="color: #808080; "> 이름 <!-- 이름 -->
	    <input type="text" class="form-control" name="user_name" placeholder="이름" style="width: 250px;" maxlength="20">
	  </div>
	  <div class="form-group" style="color: #808080; "> 전화번호 <!-- 전화번호 -->
	    <input type="text" class="form-control" name="user_tel" placeholder="전화번호 (- 제외)" style="width: 250px;" maxlength="20">
	  </div>
	  <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
	  <button type="submit" class="btn btn-primary">sign up</button>
	</div>
	</form>
</body>
</c:if>
</html>
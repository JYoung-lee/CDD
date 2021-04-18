<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userEdit</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<script type="text/javascript" >
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#selectImg').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
              }
            $("#basicImg").remove();
            console.log(show);
        }
</script>
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body>
<div class="cddHeader"> 
</div>
<br/><br/><br/><br/>
<div align="center">
	<div style="width: 200px; height: 200px; border-radius:70%; overflow:hidden;" >
		<div id="basicImg">
			<div >
				<c:if test="${member.user_profile.equals(defaultimg.png) }">
					<img src="/cdd/resource/img/defaultimg.png" class="img-thumbnail" style="width: 200px; height: 200px; border-radius:70%; overflow:hidden;">
				</c:if>
				<c:if test="${!member.user_profile.equals(defaultimg.png) }">
					<img src="/cdd/save/${member.user_profile }" class="img-thumbnail" style="width: 200px; height: 200px; border-radius:70%; overflow:hidden;">
				</c:if>
			</div>
		</div>
		<div >
			<img id="selectImg" src="" class="img-thumbnail" name="select" style="width: 200px; height: 200px; border-radius:70%; overflow:hidden;" />
		</div>
	</div>
	<form action="/cdd/user/userEditPro.cdd" enctype="multipart/form-data" method="post">
		<div class="mb-3">
			<label for="formFile" class="form-label" />
  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			<input  type="file" id="formFile" name="img" onchange="readURL(this);">
		</div>
		<div class="form-group"> <!-- 아이디 -->
			<div class="col-md-3" align="left">
				<label for="inputId" class="col-md-12 control-label" >ID</label>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" id="inputId" value="${member.user_id }" disabled="disabled">
			</div>
		</div>
		<div class="form-group"> <!-- 이름 -->
			<div class="col-md-3" align="left">
				<label for="inputName" class="col-md-12 control-label">이름</label>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control"  id="inputName" name="user_name" value="${member.user_name }" maxlength="20">
			</div>
		</div>
		<div class="form-group"> <!-- 전화번호 -->
			<div class="col-md-3" align="left">
				<label for="inputTel" class="col-md-12 control-label">전화번호</label>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" id="inputTel" name="user_tel" value="${member.user_tel }" maxlength="20">
			</div>
		</div>
		<div class="form-group"> <!-- 이메일 -->
			<div class="col-md-3" align="left">
				<label for="inputEmail" class="col-md-12 control-label">이메일</label>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" id="inputEmail" name="user_email" value="${member.user_email }" maxlength="50">
			</div>
		</div>
		<div class="form-group"> <!-- 소개 -->
			<div class="col-md-3" align="left">
				<label for="inputBio" class="col-md-12 control-label">소개</label>
			</div>
			<div class="col-md-3">
				<textarea class="form-control" id="inputBio" rows="3" cols="" name="user_bio" maxlength="2000">${member.user_bio }</textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="col-md-3" align="right">
				<input type="button" class="btn btn-default" onclick="window.location='/cdd/user/main.cdd'" value="Back">/
				<button type="submit" class="btn btn-default">Modify</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>
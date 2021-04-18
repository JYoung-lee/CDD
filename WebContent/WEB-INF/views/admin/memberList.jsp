<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- 제명 -->
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
	});
	function memberBlocked(blockedId){
		var user_id = blockedId.user_id.value;
		var blocked = blockedId.blocked.value;
		var confirmBlocked = confirm('정지 하겠습니까?');
		if(confirmBlocked){
			$.ajax({
				type : "post",
				data : {user_id : user_id, blocked : blocked},
				url : "/cdd/admin/ajaxBlockedPro.cdd",
				success : function(result){
					console.log(result);
				}
			});
			alert('정지 되었습니다.');
			location.reload();
		}
	}	
</script>
<!-- 제명해제 -->
<script>
	function memberUnBlocked(unBlockedId){
		var user_id = unBlockedId.user_id.value;
		var blocked = unBlockedId.blocked.value;
		var confirmBlocked = confirm('정지 해제 하겠습니까?');
		if(confirmBlocked){
			$.ajax({
				type : "post",
				data : {user_id : user_id, blocked : blocked},
				url : "/cdd/admin/ajaxBlockedPro.cdd",
				success : function(result){
					console.log(result);
				}
			});
			alert('정지 해제 되었습니다.');
			location.reload();
		}
	}	
</script>
</head>

<!-- 유효성 검사 -->
<c:if test="${sessionId ne 'admin' }">
	<script>
		alert("관리자만 사용 가능합니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${sessionId eq 'admin' }">
	<body class="all">
		<div class="cddHeader"> 
		</div>
		<br/><br/><br/><br/>
		<div class="row">
			<div class="col-md-2" ></div>
			<h3><i class="fas fa-address-book"></i>&nbsp;회원 목록</h3>
		</div>
		<!-- 회원 정보 목록보여주기 -->
	<div class="row">
		<div class="col-md-8 offset-md-2" style="height:580px; overflow:auto" >
			<table class="table table-hover" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: auto; margin-right: auto; text-align: center;">
			  <thead class="thead-light">
			    <tr>
			      <th scope="col"><i class="fas fa-sort-numeric-down"></i></th>
			      <th scope="col"><i class="fas fa-id-card"></i></th>
			      <th scope="col"><i class="fas fa-mobile-alt"></i></th>
			      <th scope="col"><i class="fas fa-envelope"></i></th>
			      <th scope="col"><i class="fas fa-handshake"></i></th>
			      <th scope="col"><i class="fas fa-exclamation"></i></th>
			    </tr>
			  </thead>
			  <tbody >
				<c:if test="${count ne 0 }">
	  				<c:forEach var="member" items="${memberList }" varStatus="status" >
				    	<tr>
					      <th scope="row">${status.count }</th>
					      <td>${member.user_id }</td>
					      <td>${member.user_tel }</td>
					      <td>${member.user_email }</td>
					      <td>
					      	
					       	<c:if test="${member.blocked eq '0' }"> 
						  		<form action="/cdd/admin/memberBlocked.cdd" method="post" name="blockedId">
						  			<input type="hidden" name="user_id" value="${member.user_id }">
						  			<input type="hidden" name="blocked" value="1">
						  			<!-- <input type="submit" value="제명"> -->
						  			<button class="btn btn-default" type="button" onclick="memberBlocked(this.form)"><i class="far fa-user"></i></button> <!-- 제명버튼 -->
						  		</form>
						  	</c:if>
						  	<!-- 제명인 상태 -->
						  	<c:if test="${member.blocked eq '1' }">
						  		<form action="/cdd/admin/memberBlocked.cdd" method="post" name="unBlockedId">
						  			<input type="hidden" name="user_id" id="user_id" value="${member.user_id }">
						  			<input type="hidden" name="blocked" id="blocked" value="0">
						  			<!-- <input type="submit" value="해제"> -->
						  			<button class="btn btn-default" type="button" onclick="memberUnBlocked(this.form)" style="color: red"><i class="fas fa-user-slash"></i></button> <!-- 제명해제 -->
						  		</form>
						  	</c:if>
						  </td>
					      <td><a href="/cdd/admin/memberReportList.cdd?id=${member.user_id }"><i class="fas fa-list-ul"></i></a></td>
					    </tr>
					</c:forEach>
				</c:if>
				<c:if test="${count eq 0 }">
					<div align="center">
						<br/>
						신고 내역없음			
					</div>
				</c:if>
			  </tbody>
			</table>			
		</div>
	</div>
		
	</body>
</c:if>
</html>
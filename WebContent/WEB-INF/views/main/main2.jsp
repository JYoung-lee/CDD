<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test main</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="all">
<div style="background-color: white; height: 60px;" class="fixed-top">
   <div class="container">
      <jsp:include page="/WEB-INF/views/header/header.jsp"/>
   </div>
</div>
<br/><br/><br/><br/>
<div class="row">
	<div class="col-md-8" ></div>
	<div class="col-md-2" align="center">
		<a class="dropdown-item" id="userPwCh" data-toggle="modal" data-target="#myModal3" role="button" ><i class="fas fa-address-book" ></i> &nbsp;userEdit(임시)</a>
	</div>
	<div class="col-md-2" ></div>
</div>
<div id="myModal3" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" >
	<div class="modal-dialog modal-dialog-centered" >
		<div class="modal-content">
		</div>
	</div>
</div>
	<script>
		$("#userPwCh").click(function(){
			$(".modal-content").load("/cdd/user/userPwCh.cdd");
		});
	</script>
</body>
</html>
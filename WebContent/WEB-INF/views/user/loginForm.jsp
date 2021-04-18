<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>캣댕댕</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 
	<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
	<script src="/cdd/resource/js/bootstrap.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/sign-in/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <!-- Bootstrap core CSS -->
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }
      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <!-- Custom styles for this template -->
    <link href="/cdd/resource/signin.css" rel="stylesheet">
</head>
<body class="text-center">
	<div style="width: 1200px; height: 700px; background-color: white; margin: 0 auto;">
		<div style="width: 600px; height: 400px; background-color: white; margin: 150px 20px 0px 100px; float: left;">
			<div style="width: 600px; height: 400px;">
			    <ul class="bxslider" >
			        <li><a href="#"><img src="/cdd/resource/img/slide1.png" alt="" style="width: 600px; height: 400px;"></a></li>
			        <li><a href="#"><img src="/cdd/resource/img/slide2.png" alt="" style="width: 600px; height: 400px;"></a></li>
			        <li><a href="#"><img src="/cdd/resource/img/slide4.png" alt="" style="width: 600px; height: 400px;"></a></li>
			        <li><a href="#"><img src="/cdd/resource/img/slide3.png" alt="" style="width: 600px; height: 400px;"></a></li>
			        <li><a href="#"><img src="/cdd/resource/img/slide5.png" alt="" style="width: 600px; height: 400px;"></a></li>
			    </ul>
			</div>
		</div>
		<div style="width: 400px; height: 350px; background-color: white; margin: 180px 0px 0px 20px; float: left;">
			<form class="form-signin" action="/cdd/user/loginPro.cdd" method="post">
				<img class="mb-4" src="/cdd/resource/img/logo.png" width="72" height="72">
				<h1 class="h3 mb-3 font-weight-normal">로그인</h1>
				<label for="id" class="sr-only">ID</label>
				<input type="text" id="id" name="user_id" class="form-control" placeholder="ID" required autofocus>
				<label for="pw" class="sr-only">Password</label>
				<input type="password" id="pw" name="user_pw" class="form-control" placeholder="Password" required>
				<a id="findIdPw" data-toggle="modal" data-target="#staticBackdrop" role="button">
					<i class="meterial-icons">id/pw</i>
				</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a id="signup" data-toggle="modal" data-target="#staticBackdrop" role="button">
					<i class="meterial-icons">회원가입</i>
				</a>
				<!-- <a class="mt-5 mb-3 text-muted" href="/cdd/user/signupForm.cdd" style="text-align: left;">회원가입</a> -->
				<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
			</form>
		</div>
	</div>
	<div id="staticBackdrop" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
			</div> 
		</div> 
	</div>
	<script>
		$("#findIdPw").click(function(){
			$(".modal-content").load("/cdd/user/findIdPw.cdd");
		});
		
		$("#signup").click(function(){
			$(".modal-content").load("/cdd/user/signupForm.cdd");
		});
		$(document).ready(function () {
		    $('.bxslider').bxSlider({
		        auto: true, // 자동으로 애니메이션 시작
		        speed: 500,  // 애니메이션 속도
		        pause: 2500,  // 애니메이션 유지 시간 (1000은 1초)
		        mode: 'horizontal', // 슬라이드 모드 ('fade', 'horizontal', 'vertical' 이 있음)
		        pager: true, // 페이지 표시 보여짐
		        captions: true, // 이미지 위에 텍스트를 넣을 수 있음
		        controls: false
		    });
		});
	</script>
	</body>
</html>

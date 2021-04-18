<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캣댕댕</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="shortcut icon" href="/resource/img/logo.png">
<style type="text/css">
	input#search { background-image: url("/resource/img/search.png"); background-repeat: no-repeat; width: 40px; border: 0; }
</style>
</head>
<body>
<div class="fixed-top" style="background-color: white;" align="center">
<div style="width:900px;">
   <nav class="navbar navbar-expand-lg navbar-dark" >
        <a class="navbar-brand" href="/cdd/main.cdd"><img src="/cdd/resource/img/logoFont.png" width="150px" ></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
          <form class="form-inline my-2 my-lg-0" action="/cdd/searchResult.cdd" name="inputForm" method="post">
            <input class="form-control mr-sm-2" type="text" id="searchWord" name="search" placeholder="Search" aria-label="Search" value="${search }">
            <input type="image" src="/cdd/resource/img/search.png" width="25px"/>
          </form>
        <div class="collapse navbar-collapse flex-grow-0 ml-auto mr-1" align="left" id="navbarSupportedContent">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="/cdd/main.cdd" title="메인">
              	<c:if test="${category eq 'main'}">
              		<img src="/cdd/resource/img/blackhome.png" width="25px"/>
              	</c:if>
              	<c:if test="${category ne 'main'}">
              		<img src="/cdd/resource/img/home.png" width="25px"/>
              	</c:if>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/cdd/mainAllFeed.cdd" onclick="ajaxCh('allfeed')" title="전체피드">
              	<c:if test="${category eq 'allfeed'}">
              		<img src="/cdd/resource/img/allbalck.png" width="25px"/>
              	</c:if>
              	<c:if test="${category ne 'allfeed'}">
              		<img src="/cdd/resource/img/explore.png" width="25px"/>
              	</c:if>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/cdd/dm.cdd" title="DM">
              	<c:if test="${category eq 'dm'}">
              		<img src="/cdd/resource/img/dmblack.png" width="25px"/>
              	</c:if>
              	<c:if test="${category ne 'dm'}">
              		<img src="/cdd/resource/img/dm.png" width="25px"/>
              	</c:if>
              
              	
              	<c:if test="${dmRes > 0 }">
                	<img src="/cdd/resource/img/redcircle.png" width="7px"/>
                </c:if> 
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="alarm" role="button" data-toggle="modal" data-target="#alarmModalView">
                <img src="/cdd/resource/img/bell.png" width="25px" />
                <c:if test="${alarmRes > 0 }">
                	<img src="/cdd/resource/img/redcircle.png" id="newAlarm" width="7px"/>
                </c:if>
              </a>
            </li>
            <li class="nav-item dropdown" >
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <img src="/cdd/save/${userDto.user_profile }" style="border-radius: 70%; width: 30px; height: 30px;"/>
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="font-size: 10pt;">
                <a class="dropdown-item" href="/cdd/myPage/userProfile.cdd?profileId=${user_id}" >
                	<i class="far fa-user-circle" style="width: 30px;"></i>내 프로필
                </a>
                <a class="dropdown-item" href="/cdd/myPage/collection.cdd">
                	<i class="far fa-bookmark" style="width: 30px;"></i>저장됨
                </a>
                <c:if test="${sessionScope.memId eq 'admin'}">
	                <a class="dropdown-item" href="/cdd/admin/setting.cdd">
	                	<i class="fas fa-cog" style="width: 30px;"></i>설정
	                </a>
                </c:if>
                <div>
                </div>
                <a class="dropdown-item" id="pwModify" data-toggle="modal" data-target="#pwEditModalView" role="button">
                	<i class="fas fa-key" style="width: 30px;"></i>비밀번호 변경
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="/cdd/user/logout.cdd">
                	<i class="fas fa-sign-out-alt" style="width: 30px;"></i>로그아웃
                </a>
              </div>
            </li>
          </ul>
        </div>
   </nav>
</div>
<hr>
</div>

	<div id="alarmModalView" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" >
			<div class="modal-content alarmModal">
			</div>
		</div>
	</div>
   <div id="pwEditModalView" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" >
			<div class="modal-content pwEdit" style="width: 300px;" align="center">
			</div>
		</div>
	</div>
	
	<script>
	$(document).ready(function(){
		$("#pwModify").click(function(){
			$(".pwEdit").load("/cdd/user/pwModifyForm.cdd");
		});
		$("#alarm").click(function(){
			$(".alarmModal").load("/cdd/alarm.cdd");
			$("#newAlarm").remove();
		});
	})
	
	</script>
</body>
</html>
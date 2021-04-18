<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal-header" align="center">
        <h5 class="modal-title" id="exampleModalLabel" align="center">팔로우 목록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="max-height: 300px; overflow: auto;">
      <c:if test="${followList == '[]' }">
      	친구가 없어요 ㅠㅠ
      </c:if>
      <c:if test="${followList != '[]' }">
	      <c:forEach var="flist" items="${followList }">
	      	<img style="border-radius: 70%; width: 30px; height: 30px;" src="/cdd/save/${flist.user_profile}"/>
	      	<a style="font-weight: bold; margin-left: 10px;" role="button" onclick="viewProfile('${flist.user_to}')">${flist.user_to}</a><br/><br/>
	      </c:forEach>
      </c:if>
      <script>
      	function viewProfile(userId){
      		location.href="/cdd/myPage/userProfile.cdd?profileId="+userId;
      	}
      </script>
      </div>
</body>
</html>
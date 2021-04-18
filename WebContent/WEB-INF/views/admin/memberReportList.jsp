<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberReportList</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script>
	$(document).ready(function(){
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body class="all">
	<div class="cddHeader"> 
	</div>
	<br/><br/><br/><br/>
	<div class="row">
		<div class="col-md-2" ></div>
		<h3><i class="fas fa-user-check"></i>&nbsp;${repotedID } 신고목록</h3>
	</div>
	<!-- 제목란 -->
	<div class="row">
		<div class="col-md-8 offset-md-2" style="height:50px; overflow:auto">
			<table class="table table-hover" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: auto; margin-right: auto; text-align: center;">
			  <thead class="thead-light">
			    <tr>
			      <th scope="col"><i class="fas fa-sort-numeric-down"></i></th>
			      <th scope="col"><i class="fas fa-boxes"></i></th>
			      <th scope="col"><i class="far fa-angry"></i></th>
			      <th scope="col"><i class="fas fa-file-alt"></i></th>
			    </tr>
			  </thead>
			  <tbody>
				  	<c:forEach var="reports" items="${memberReportList}" varStatus="status">
				    	<tr>
					      <th scope="row">${status.count }</th>
					      <td>${reports.reportCate }</td>
					      <td>${reports.reporterId }</td>
					      <td>${reports.reportContent }</td>
					    </tr>
					</c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-8 offset-md-2" style="height:600px; overflow:auto" >
			<table class="table table-hover" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: auto; margin-right: auto; text-align: center;">
			  <tbody>
				<c:if test="${count ne 0 }">
				  	<c:forEach var="reports" items="${memberReportList}" varStatus="status">
				    	<tr>
					      <th scope="row">${status.count }</th>
					      <td>${reports.reportCate }</td>
					      <td>${reports.reporterId }</td>
					      <td>${reports.reportContent }</td>
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
</html>
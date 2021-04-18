<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">
<script src="/cdd/resource/js/bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script>
	$(document).ready(function() {
		$(".cddHeader").load("/cdd/header.cdd");
	});
</script>
</head>
<body class="all">

	<div class="cddHeader"></div>
	<br />
	<br />
	<br />
	<br />
	<div class="container">
		<input type="hidden" id="report_type" value="${report_type}" />
		<h4 align="center">신고 접수 목록</h4>
		<a href="/cdd/admin/reportList.cdd?report_type=reportAll">전체신고보기</a> <br />
		<div class="test" style="height: 500px; overflow: auto;">

			<table class="table table-hover">
				<thead class="thead-light">
					<tr align="center">
						<th style="position: sticky; top: 0px;" scope="col" width="120px"><div class="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">신고유형</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<a href="/cdd/admin/reportList.cdd?report_type=yok" class="dropdown-item">욕설</a> <a class="dropdown-item" href="/cdd/admin/reportList.cdd?report_type=adult">음란물</a>
								</div>
							</div></th>
						<th style="position: sticky; top: 0px;" scope="col" width="120px"><div class="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">카테고리</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<a href="/cdd/admin/reportList.cdd?report_type=feed" class="dropdown-item" href="#">피드</a> <a href="/cdd/admin/reportList.cdd?report_type=reply" class="dropdown-item">댓글</a>
								</div>
							</div></th>
						<th style="position: sticky; top: 0px;" scope="col" width="120px">신고자</th>
						<th style="position: sticky; top: 0px;" scope="col" width="120px">피신고자</th>
						<th style="position: sticky; top: 0px;" scope="col" width="350px">신고내용</th>
						<th style="position: sticky; top: 0px;" scope="col" width="300px">신고일자</th>
						<th style="position: sticky; top: 0px;" scope="col" width="150px">페이지이동</th>
						<th style="position: sticky; top: 0px;" scope="col" width="150px">목록삭제</th>
					</tr>
				</thead>
				<tbody class="reportLoadView">
					<c:if test="${reportList == '[]' }">
						<tr align="center">
							<td colspan="6" style="font-size: 20pt; font-weight: bold; color: gray;">접수된 유형의 신고가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${reportList != '[]' }">
						<c:forEach var="list" items="${reportList }" varStatus="status">
							<tr id="trIndex${status.count}">
								<td align="center">${list.report_type}</td>
								<td align="center">${list.report_cate}</td>
								<td align="center">${list.reporterId}</td>
								<td align="center">${list.repotedId}</td>
								<td align="center">${list.report_content}</td>
								<td align="center">
									<fmt:formatDate var="dateFmt" pattern="yyyy-MM-dd hh:mm" value="${list.report_reg}"/>
									<c:out value="${dateFmt}"/>
								</td>
								<td align="center">
									<a onclick="contentView(${list.feed_num})" id="replyView" type="button" data-toggle="modal" data-target="#feedContent">
										<span style="font-size: 1.5em;"><i class="fas fa-arrow-circle-right"></i></span>
									</a>
								</td>
								<td align="center">
									<a onclick="deleteReport(${status.count}, ${list.report_num})" type="button"> 
										<span style="font-size: 1.5em;"><i class="fas fa-times-circle"></i></span>
									</a>
								</td>



							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			
			
			<div id="feedContent" class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog modal-dialog-centered modal-xl">
					<div class="modal-content feed_content"></div>
				</div>
			</div>
			
			<script>
			
			
			
				$(document).ready(function() {
					var startNum = 1;
					var endNum = 10;
					var report_type = $("#report_type").val();
					var trIndex = 11;
					
					
					
					$(".test").scroll(function() {
						var scrollTop = $(this).scrollTop();
						var innerHeight = $(this).innerHeight();
						var scrollHeight = $(this).prop('scrollHeight');
						if (scrollTop + innerHeight >= scrollHeight - 0.5) {
							startNum = Number(startNum);
							endNum = Number(endNum);
							startNum += 10;
							endNum += 10;
							startNum = String(startNum);
							endNum = String(endNum);
							var ajaxJson = new Object;
							ajaxJson.startNum = startNum;
							ajaxJson.endNum = endNum;
							ajaxJson.report_type = report_type;
							var sendData = JSON.stringify(ajaxJson);
							$.ajax({
								url : "/cdd/admin/ajaxLoadReports.cdd",
								contentType : 'application/json;charset=UTF-8',
								method : "POST",
								data : sendData,
								success : function(res) {
									var reportList = JSON.parse(res);
									console.log(reportList);
									startNum = Number(startNum);
									appendList(reportList, startNum,trIndex);
									trIndex += 10;
								}
							});
						}
					});

					function appendList(reportList, startNum,trIndex) {
						var html = "";
						
						for (var i = 0; i < reportList.length; i++) {
							var dateFmt = moment(reportList[i].report_reg).format('YYYY-MM-DD hh:mm');
							html += "<tr id=\"trIndex" +trIndex+i+1+ "\">";
							html += "<td align=\"center\">" + reportList[i].report_type + "</td>";
							html += "<td align=\"center\">" + reportList[i].report_cate + "</td>";
							html += "<td align=\"center\">" + reportList[i].reporterId + "</td>";
							html += "<td align=\"center\">" + reportList[i].repotedId + "</td>";
							html += "<td align=\"center\">" + reportList[i].report_content + "</td>";
							html += "<td align=\"center\">" + dateFmt + "</td>";
							html += "<td align=\"center\"> <a onclick=\"contentView("+ reportList[i].feed_num+")\" id=\"replyView\" type=\"button\" data-toggle=\"modal\" data-target=\"#feedContent\">";
							html += "<span style=\"font-size: 1.5em;\"><i class=\"fas fa-arrow-circle-right\"></i></span></a>";
							html += "<td align=\"center\">";
							html += "<a onclick=\"deleteReport("+trIndex+i+1+", "+ reportList[i].report_num +")\" type=\"button\">";
							html += "<span style=\"font-size: 1.5em;\"><i class=\"fas fa-times-circle\"></i></span></a></td>";
								
								
							
							
							html += "</tr>";
							
						}
						$(".reportLoadView").append(html);
					}
					

				});
				
				
				function deleteReport(trIndex,report_num) {
					
					var res = confirm("신고목록에서 삭제하시겠습니까?");
					console.log(res);
					if(res) {
						var ajaxJson = new Object();
						ajaxJson.report_num = report_num;
						
						var sendData = JSON.stringify(ajaxJson);
						$.ajax({
							url : "/cdd/admin/ajaxDeleteReport.cdd",
							contentType : 'application/json;charset=UTF-8',
							method : "POST",
							data : sendData
							
								
						});
							$('#trIndex' + trIndex).empty();
								
							
					}
						
					
					 
					
				}
				function contentView(feed_num) {
					$(".feed_content").load('/cdd/feeds/feedContent2.cdd?feed_num=' + feed_num);
				}
			</script>
		</div>
		<br/><br/><br/>
		<button onclick="location.href='/cdd/admin/setting.cdd'" type="button" class="btn btn-primary">이전페이지</button>
	</div>


	
	
</body>
</html>
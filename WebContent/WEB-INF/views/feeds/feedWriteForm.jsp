<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>피드 작성 페이지</title>
<script type="text/javascript" src="/cdd/resource/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/cdd/resource/js/ bootstrap.bundle.min.js"></script>
<script src="/cdd/resource/js/bootstrap.bundle.js"></script>
<script src="/cdd/resource/js/bootstrap.js"></script>
<script src="/cdd/resource/js/jquery.dd.min.js"></script>
<link rel="stylesheet" href="/cdd/resource/css/bootstrap.css">


</head>

<body>
	<div style="text-align: left;">
	<form name="fileForm" action="/cdd/feeds/feedWritePro.cdd" method="post"
		enctype="multipart/form-data">
		<input name="user_id" type="hidden" value="${user_id}" />
		<input name="feed_reportCh" type="hidden" value="0" />
		
		<div class="modal-header">
			<h5 class="modal-title text-center" id="staticBackdropLabel">피드
				작성</h5>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body"
			style="margin-left: 50px; margin-right: 50px;">


			<!-- 나중에 디비에서 이미지 불러올꺼 -->
			<img src="/cdd/resource/img/defaultimg.png"
				style="width: 30px; height: 30px;" /> ${user_id}
			<!-- Example split danger button -->
			<div style="float: right;">
				<select name="feed_emotion">
					<option value="1">신남</option>
					<option value="2">화남</option>
					<option value="3">우울</option>
					<option value="4">슬픔</option>
				</select>
			</div>

			<hr>
			<input type="file" name="photo_dir" id="uploadFile"
				multiple="multiple" accept="image/*" onchange="fileCheck(this);">
			<table>

				<tr>
					<td>
						<div id="preview"></div>
					</td>
				</tr>
			</table>





			<hr>
			<textarea id="feed_content" name="feed_content" placeholder="내용을 입력하세요"
				style="width: 100%; resize: none; height: 200px;"></textarea>
				<textarea name="feed_hash" placeholder="#해쉬태그" style="width: 100%;"></textarea>
			<div class="btn-group btn-group-toggle" data-toggle="buttons">
				<label class="btn btn-primary active"> <input type="radio"
					name="feed_secret" id="option1" value="0" checked> 전체공개
				</label> <label class="btn btn-primary"> <input type="radio"
					name="feed_secret" value="1" id="option2"> 팔로워만공개
				</label>
			</div>
		</div>
		<div class="modal-footer">
			<button id="savebutton" type="submit" class="btn btn-primary">피드작성</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		</div>
	</form>
	</div>

	<script type="text/javascript">
		$(document)
				.ready(
						function(e) {
							$("input[type='file']").change(
									function(e) {
										$('#preview').empty();

										var files = e.target.files;
										var arr = Array.prototype.slice
												.call(files);

										if (files.length > 10) {
											alert("10장 이상 업로드 불가");
											$("input[type='file']").val("");
											return false;
										}

										//업로드 가능 파일인지 체크
										for (var i = 0; i < files.length; i++) {

											if (!checkExtension(files[i].name,
													files[i].size)) {
												return false;
											}
										}
										preview(arr);
									});//file change

							function checkExtension(fileName, fileSize) {
								var regex = new RegExp(
										"(.*?)\.(exe|sh|zip|alz)$");
								var maxSize = 20971520; //20MB

								if (fileSize >= maxSize) {
									alert('파일 사이즈 초과');
									$("input[type='file']").val(""); //파일 초기화
									return false;
								}

								if (regex.test(fileName)) {
									alert('업로드 불가능한 파일이 있습니다.');
									$("input[type='file']").val(""); //파일 초기화
									return false;
								}

								return true;
							}

							function preview(arr) {
								arr
										.forEach(function(f) {
											//파일명이 길면 파일명...으로 처리
											var fileName = f.name;
											if (fileName.length > 10) {
												fileName = fileName.substring(
														0, 7)
														+ "...";
											}
											//div에 이미지 추가
											var str = '<div style="display: inline-flex; padding: 10px;">';
											//이미지 파일 미리보기
											if (f.type.match('image.*')) {
												var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
												reader.onload = function(e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
													//str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
													str += '<img src="'+e.target.result+'" title="'+f.name+'" width=100 height=100 />';
													str += '</div>';
													$(str).appendTo('#preview');
												}
												reader.readAsDataURL(f);
											} else {
												str += '<img src="/resource/img/fileImg.png" title="'+f.name+'" width=100 height=100 />';
												$(str).appendTo('#preview');
											}
										});//arr.forEach
							}
						});

		function fileCheck(el) {

			if (!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)) {

				alert('이미지 파일만 업로드 가능합니다.');

				el.value = '';

				el.focus();

			}

		}
		$(document).ready(function() { var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함. 
		// Editor Setting 
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : oEditors, // 전역변수 명과 동일해야 함. 
			elPlaceHolder : "feed_content", // 에디터가 그려질 textarea ID 값과 동일 해야 함. 
			sSkinURI : "/cdd/resource/se2/SmartEditor2Skin.html", // Editor HTML 
			fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X 
			htParams : { // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : true, 
			} 
		}); 
	
	// 전송버튼 클릭이벤트 
	$("#savebutton").click(function(){ 
		//if(confirm("저장하시겠습니까?")) { // id가 smarteditor인 textarea에 에디터에서 대입 
			oEditors.getById["feed_content"].exec("UPDATE_CONTENTS_FIELD", []); 
		
		// 이부분에 에디터 validation 검증 
		if(validation()) { 
			$("#frm").submit(); 
		} 
		//} 
		}) 
	}); 
	// 필수값 Check 
	function validation(){
		var contents = $.trim(oEditors[0].getContents()); 
		if(contents === '<p>&bnsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
			alert("내용을 입력하세요.!!!"); oEditors.getById['feed_content'].exec('FOCUS'); 
			return false; 
		} 
		
		return true; 
}
	</script>
</body>
</html>































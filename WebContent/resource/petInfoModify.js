// pet_info Ajax 수정 등록
function infoModify(pet_number){
	var ajaxJon = new Object(); // JSON 객체 만들어주고
	
	// input 태그 받기
	var pet_birthValue = document.getElementsByName("pet_birth"); 	// 데이터 받아주기
	var pet_ttValue = document.getElementsByName("pet_tt"); 		// 데이터 받아주기
	var pet_ttdayValue = document.getElementsByName("pet_ttday"); 	// 데이터 받아주기
	var pet_meetValue = document.getElementsByName("pet_meet"); 	// 데이터 받아주기
	ajaxJon.pet_number = pet_number // 해당 펫 넘버
	
	// 생일, 중성화 날짜, 입양날 적지않았을경우 데이터 넣어쥐기
	if(pet_birthValue[0].value == ""){ 
		ajaxJon.pet_birth = "0000.00.00";
	}else{
		ajaxJon.pet_birth = pet_birthValue[0].value;
	};
	
	if(pet_ttdayValue[0].value == ""){
		ajaxJon.pet_ttday = "0000.00.00";
	}else{
		ajaxJon.pet_ttday = pet_ttdayValue[0].value;
	};
	
	if(pet_meetValue[0].value == ""){
		ajaxJon.pet_meet = "0000.00.00";
	}else{
		ajaxJon.pet_meet = pet_meetValue[0].value;
	};
	
	// Radio value Json형태로 데이터 넣어주기
	for(var i = 0; i < pet_ttValue.length; i++){
		if(pet_ttValue[i].checked){
			ajaxJon.pet_tt = pet_ttValue[i].value;
		};//if
	};//for
	
	$.ajax({
		url : "/cdd/myPage/pet_InfoModify.cdd",	// 이동 URL
		type : "POST",						// 전송방식
		contentType : "application/json; charset=UF8",  
		data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
		dataType : "json",					// Controller로 보내는 데이터 타입
	});
};
// 이미지 추가 버튼
function addImg(){
	var html = "";
	$("#EditBtn").empty();
	html += '<a id="uploadImg" class="btn btn-primary btn-sm" role="button" onclick="petModifyImg();">';
	html += '변경';
	html += '</a>';
	$("#EditBtn").append(html);
};

function petModifyImg(){
	console.log("들어왔어요!~!!!!!!");
	var pet_number = document.getElementsByName("pet_numberValue"); 
	
	var upload = $('#imgForm')[0];
	var data = new FormData(upload);
	$('#uploadImg').prop('disabled', true);
	
	$.ajax({
        enctype: 'multipart/form-data',
        url: "/cdd/myPage/pet_UploadImg.cdd",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        cache: false, 
        timeout: 600000, 
        success : function(result){
        	console.log("확인");
        	var newImg = JSON.parse(result);
        	$("#changeImg").empty();
        	var html = '<img src="/cdd/save/' + newImg + ' " width="100%" height="100%">';
        	$("#changeImg").append(html);
        }//suceess
		       	
	}); // ajax
	
};


//#################### 추가 누른상태에서 다 작성하지않으면 안되게 만들어주기
// 펫 질환, 접종, 수술 내역 추가 수정       
function petSickModify(pet_number){
	console.log("petSickModify 스크립트 입성");
	var ajaxJon2 = new Object();
	ajaxJon2.pet_number = pet_number; // 해당 펫 넘버
	
	// 질환 추가
	var sick_statusValue = document.getElementsByName("sick_status");
	// Radio value Json형태로 데이터 넣어주기
	if(sick_statusValue[i] == undefined){
		ajaxJon2.sick_status = 3;
	}
	for(var i = 0; i < sick_statusValue.length; i++){
		if(sick_statusValue[i] != undefined){
			for(var i = 0; i < sick_statusValue.length; i++){
				if(sick_statusValue[i].checked){
					ajaxJon2.sick_status = sick_statusValue[i].value;
				};
			};//for
		}
	}
	var pet_sicknameValue = document.getElementsByName("pet_sickname");
	var pet_sickdayValue = document.getElementsByName("pet_sickday");
	var pet_hospitalValue = document.getElementsByName("pet_hospital");
	
	if(pet_sicknameValue[0] != undefined){
		ajaxJon2.pet_sickname = pet_sicknameValue[0].value;
	}else {
		ajaxJon2.pet_sickname = "N";
	}//else
	
	if(pet_sickdayValue[0] != undefined){
		ajaxJon2.pet_sickday = pet_sickdayValue[0].value;
	}else {
		ajaxJon2.pet_sickday = "N";
	}//else
	
	if(pet_hospitalValue[0] != undefined){
		ajaxJon2.pet_hospital = pet_hospitalValue[0].value;
	}else {
		ajaxJon2.pet_hospital = "N";
	}//else
	
	//접종 추가
	var pet_jjnameValue = document.getElementsByName("pet_jjname");
	var pet_jjdayValue = document.getElementsByName("pet_jjday");
	var pet_jjhospitalValue = document.getElementsByName("pet_jjhospital");
	
	if(pet_jjnameValue[0] != undefined){
		ajaxJon2.pet_jjname = pet_jjnameValue[0].value;
	}else {
		ajaxJon2.pet_jjname = "N";
	}//else
	
	if(pet_jjdayValue[0] != undefined){
		ajaxJon2.pet_jjday = pet_jjdayValue[0].value;
	}else {
		ajaxJon2.pet_jjday = "N";
	}//else
	
	if(pet_jjhospitalValue[0] != undefined){
		ajaxJon2.pet_jjhospital = pet_jjhospitalValue[0].value;
	}else {
		ajaxJon2.pet_jjhospital = "N";
	}//else

	// 수술 추가
	var pet_surgnameValue = document.getElementsByName("pet_surgname");
	var pet_surgdayValue = document.getElementsByName("pet_surgday");
	var pet_surghospiValue = document.getElementsByName("pet_surghospi");
	
	if(pet_surgnameValue[0] != undefined){
		ajaxJon2.pet_surgname = pet_surgnameValue[0].value;
	}else {
		ajaxJon2.pet_surgname = "N";
	}//else
	
	if(pet_surgdayValue[0] != undefined){
		ajaxJon2.pet_surgday = pet_jjdayValue[0].value;
	}else {
		ajaxJon2.pet_surgday = "N";
	}//else
	
	if(pet_surghospiValue[0] != undefined){
		ajaxJon2.pet_surghospi = pet_surghospiValue[0].value;
	}else {
		ajaxJon2.pet_surghospi = "N";
	}//else
	$.ajax({
		url : "/cdd/myPage/pet_SickModify.cdd",	// 이동 URL
		type : "POST",						// 전송방식
		contentType : "application/json; charset=UF8",  
		data: JSON.stringify(ajaxJon2),		// Controller로 보내는 데이터
		dataType : "json",					// Controller로 보내는 데이터 타입
	});
	
};




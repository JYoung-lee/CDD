$(document).ready(function(){
	$(".typebtn").click(function(event){
		
		var data = 0;
		$.each($(this).serializeArray(), function(index, o){  
			data = o.value;  //value값 넣어주기 데이터에
		});
		
		var ajaxJon = new Object(); // JSON 객체 만들어주고
		ajaxJon.type_num = data;	// 데이터 받아주기
		
		$.ajax({
			url : "/cdd/myPage/pet_kind.cdd",	// 이동 URL
			type : "POST",						// 전송방식
			contentType : "application/json; charset=UF8",  
			data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
			dataType : "json",					// Controller로 보내는 데이터 타입
			success: function(petkinds){			// Controller에서 넘어오는 데이터 result에
												// 담기
			var petkind = JSON.parse(petkinds); // JSON 으로 넘어온 변수를 자바 스크립트 객체로 변환
			
			$("#petkind").empty();				// 이전에 있던 HTML 코드 삭제
			var html = ""; // 자바스크립트 Html
			html += '<div class="btn-group-toggle" data-toggle="buttons">';
			for(var i = 0; i < petkind.length; i++){
				html += '<label class="btn btn-outline-primary">';
				html += '<input type="radio" autocomplete="off" name="kind_num" value="'+petkind[i].kind_num+'">' + petkind[i].kind_name;
				html += '</label>';
			}
			html += '</div>';
			$("#petkind").append(html);
		
			}// success
		}); // $.ajax
	}); // click
	
	 //생일 모름 체크 여부 
	$('input[name=pet_birthCheck]:checkbox').click(function(){
		if($('input[name=pet_birthCheck]:checkbox').is(':checked')){
			$('#pet_birthFix').attr("value", "0000.00.00");
			$('#pet_birthFix').attr("disabled", "disabled");
		} else{
			$('#pet_birthFix').removeAttr("value", "0000.00.00");
			$('#pet_birthFix').removeAttr("disabled", "disabled");
		}
		
	});
	
	// 중성화 여부 안했음
	$('input[id="tt_NoBtn"]:radio').click(function(){
		if($('input[id="tt_NoBtn"]:radio').is(':checked')){
			$('input[name="pet_ttdayCheck"]:checkbox').attr("checked", "checked");
			$('#pet_ttdayFix').attr("value", "0000.00.00");
			$('#pet_ttdayFix').attr("disabled", "disabled");
		}
	});
	
	// 중성화 여부 모름 
	$('input[id="tt_Btn"]:radio').click(function(){
		if($('input[id="tt_Btn"]:radio').is(':checked')){
			$('input[name="pet_ttdayCheck"]:checkbox').attr("checked", "checked");
			$('#pet_ttdayFix').attr("value", "0000.00.00");
			$('#pet_ttdayFix').attr("disabled", "disabled");
		}
	});
	
	
	
	
	
	// 중성화 했음 처리 ( 안했음 잘못눌렀을 경우 중성화 checked 다시 빈 상태로 만들기
	$('input[id="tt_OkBtn"]:radio').click(function(){
		if($('input[id="tt_OkBtn"]:radio').is(':checked')){
			$( 'input[name="pet_ttdayCheck"]:checkbox').removeAttr( "checked");
			$('#pet_ttdayFix').removeAttr("value", "0000.00.00");
			$('#pet_ttdayFix').removeAttr("disabled", "disabled");
		}
	});
	
	// 중성화 모름 체크 여부
	$('input[name=pet_ttdayCheck]:checkbox').click(function(){
		if($('input[name=pet_ttdayCheck]:checkbox').is(':checked')){
			$('#pet_ttdayFix').attr("value", "0000.00.00");
			$('#pet_ttdayFix').attr("disabled", "disabled");
		} else{
			$('#pet_ttdayFix').removeAttr("value", "0000.00.00");
			$('#pet_ttdayFix').removeAttr("disabled", "disabled");
		}
	});  
	
	//입양날 모름 체크여부 
	$('input[name="pet_meetCheck"]:checkbox').click(function(){
		if($('input[name=pet_meetCheck]:checkbox').is(':checked')){
			$('#pet_meetFix').attr("value", "0000.00.00");
			$('#pet_meetFix').attr("disabled", "disabled");
		} else{
			$('#pet_meetFix').removeAttr("value", "0000.00.00");
			$('#pet_meetFix').removeAttr("disabled", "disabled");
		}
	}); 
	
});//document






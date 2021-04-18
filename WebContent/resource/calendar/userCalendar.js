// ================================
// START YOUR APP HERE
// ================================
var init2 = {
  monList2: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  dayList2: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
  today2: new Date(),
  monForChange2: new Date().getMonth(),
  activeDate2: new Date(),
  getFirstDay2: (yy, mm) => new Date(yy, mm, 1),
  getLastDay2: (yy, mm) => new Date(yy, mm + 1, 0),
  nextMonth2: function () { // 다음달 설정
    let d2 = new Date();
    d2.setDate(1);
    d2.setMonth(++this.monForChange2);
    this.activeDate2 = d2;
    return d2;
  },
  prevMonth2: function () { // 이전달 설정
    let d2 = new Date();
    d2.setDate(1);
    d2.setMonth(--this.monForChange2);
    this.activeDate2 = d2;
    return d2;
  },
  addZero2: (num) => (num < 10) ? '0' + num : num,
  activeDTag2: null,
  getIndex2: function (node) {
    let index1 = 0;
    while (node = node.previousElementSibling) {
      index1++;
    }
    return index1;
  }
};

var $calBody2 = document.querySelector('.cal-body2'); // 바디 영역
var $btnNext2 = document.querySelector('.btn-cal.next2'); // 다음달
var $btnPrev2 = document.querySelector('.btn-cal.prev2'); // 이전달

/**
 * @param {date} fullDate
 */
var getParameters = function (paramName) { 
	// 리턴값을 위한 변수 선언 
	var returnValue; 
	// 현재 URL 가져오기 
	var url = location.href; 
	// get 파라미터 값을 가져올 수 있는 ? 를 기점으로 slice 한 후 split 으로 나눔 
	var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
	// 나누어진 값의 비교를 통해 paramName 으로 요청된 데이터의 값만 return 
	for (var i = 0; i < parameters.length; i++) {
		var varName = parameters[i].split('=')[0]; 
	if (varName.toUpperCase() == paramName.toUpperCase()) { 
		returnValue = parameters[i].split('=')[1]; 
		return decodeURIComponent(returnValue);
		} 
	} 
};
var profileId = getParameters('profileId');


function loadYYMM2 (fullDate) { // 로딩시 달력 띄워주기
	console.log("유저프로필 로딩시 달력찍기 ");
	var ajaxJon = new Object();
	ajaxJon.profileId = profileId;
	  
	
	$.ajax({
  		url : "/cdd/myPage/userProfileNoteScheduleList.cdd",	// 이동 URL
		type : "POST",						// 전송방식
		contentType : "application/json; charset=UF8",  
		data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
		dataType : "json",					// Controller로 보내는 데이터 타입
		success: function(res){			// Controller에서 넘어오는 데이터 result에
		console.log(" 달력찍기 들어옴 ")
			var map = JSON.parse(res);
			let notesCount = map.notesCount;
			let userNoteList = map.userNoteList;
			
			let scheduleCount = map.scheduleCount;
			let userScheduleList = map.userScheduleList;
	
				
			let yy2 = fullDate.getFullYear();	
			let mm2 = fullDate.getMonth();
			let firstDay2 = init2.getFirstDay2(yy2, mm2);
			let lastDay2 = init2.getLastDay2(yy2, mm2);
			let markToday2;  // 해당일 마크 찍어주기
			  
			if (mm2 === init2.today2.getMonth() && yy2 === init2.today2.getFullYear()) {
				markToday2 = init2.today2.getDate();
			}
			  
			document.querySelector('.cal-month2').textContent = init2.monList2[mm2]; //해당월
			document.querySelector('.cal-year2').textContent = yy2; // 해당 년도

			console.log(notesCount);
			console.log(userNoteList);
			console.log(scheduleCount);
			console.log(userScheduleList);
  
			let trtd2 = '';
			let startCount2;
			let countDay2 = 0;
			for (let i = 0; i < 6; i++) {
				trtd2 += '<tr>';
				for (let j = 0; j < 7; j++) {
					if (i === 0 && !startCount2 && j === firstDay2.getDay()) {
						startCount2 = 1;
					}
					if (!startCount2) {
						trtd2 += '<td>'
					} else {
						let fullDate = yy2 + '/' + init2.addZero2(mm2 + 1) + '/' + init2.addZero2(countDay2 + 1);
						trtd2 += '<td class="day2';
						trtd2 += (markToday2 && markToday2 === countDay2 + 1) ? ' today2" ' : '"';
						trtd2 += ` data-date="${countDay2 + 1}" data-fdate="${fullDate}" value="${fullDate}">`; // 전부 붙여주기
						
						// 이벤트 마크 찍기
						if(notesCount > 0){
							for(var k = 0; k < userNoteList.length; k++){
								if(userNoteList[k].note_date == fullDate){
									trtd2 += '<i class="far fa-list-alt"></i>';
								}//if
							}//for
						}//if
						if(scheduleCount > 0){
							for(var l = 0; l < userScheduleList.length; l++){
								if(userScheduleList[0].sche_date == fullDate){
									trtd2 += '<i class="fas fa-warehouse"></i>';
								}//if
							}//for
						}//if
        
					}//else
					trtd2 += (startCount2) ? ++countDay2 : '';
					if (countDay2 === lastDay2.getDate()) { 
						startCount2 = 0; 
					}//if
					trtd2 += '</td>';
				}//for
				trtd2 += '</tr>';
			}//for
			$calBody2.innerHTML = trtd2;
		}//success
	});//ajax
  
}//loadYYMM2

loadYYMM2(init2.today2);


$btnNext2.addEventListener('click', () => loadYYMM2(init2.nextMonth2()));
$btnPrev2.addEventListener('click', () => loadYYMM2(init2.prevMonth2()));

/*
function test(e) {
	console.log(e)
}

 (e) => {
	 console.log(e)
 }

$calBody.addEventListener('click', );
*/


$calBody2.addEventListener('click', (e) => { // 클래스 추가되면서 색깔 생김
	console.log("유저프로필 클릭이벤트 ");

  if (e.target.classList.contains('day2')) {
    if (init2.activeDTag2) {
      init2.activeDTag2.classList.remove('day-active2');
    }
    let day2 = Number(e.target.textContent);
    
    e.target.classList.add('day-active2');
    init2.activeDTag2 = e.target;
    init2.activeDate2.setDate(day2);
    
    if(pet_numberData == ""){
    	alert("펫을 선택해주세요~");
    	 init2.activeDTag2.classList.remove('day-active2');	// 타겟 취소
    }else{
	    // 일정 가져오는 처리
	    var ajaxJon = new Object();
	    var dayData = e.target.getAttribute("value"); //클릭시 클릭 한게 타겟이되어 그 속성중 value 값 가져오기
	    
	    ajaxJon.clickday = dayData;		// 날짜
	    ajaxJon.pet_num = pet_numberData;	// 펫넘버
	    
	    //펫 넘버, 날짜
	    $.ajax({
	    	url : "/cdd/myPage/getScheduleNote.cdd",	// 이동 URL
			type : "POST",						// 전송방식
			contentType : "application/json; charset=UF8",  
			data: JSON.stringify(ajaxJon),		// Controller로 보내는 데이터
			dataType : "json",					// Controller로 보내는 데이터 타입
			success: function(res){			// Controller에서 넘어오는 데이터 result에
			console.log(" 성공 ")
				
			var map = JSON.parse(res); // 넘어온 데이터 파싱.
			
			console.log(map);
			// 스케줄 뿌려주기
			if(map.scheduleList.length == 0){
				$('#scheduleContent').empty();
				$('#modifyBtn').empty();
			    var html = '<p style="padding: 20px; font-size: 15px;"> 해당 날짜 스케줄이 없습니다 </p>';
			    $('#scheduleContent').append(html);
			}else{
				console.log("데이터 있어요~");

				$('#scheduleContent').empty();
				var html='';
				for(var i= 0; i < map.scheduleList.length; i++){
					html+='날짜 : ' + map.scheduleList[i].sche_date + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
					html+='시간 : ' + map.scheduleList[i].sche_time + '시<br/>';
					html+='제목 : ' + map.scheduleList[i].sche_subject + '<br/>';
					html+='내용 : ' + map.scheduleList[i].sche_content + '<br/>';
				}
				$('#scheduleContent').append(html);
			
			}//else	
			// 일지 뿌려주기	
			if(map.petNoteCount > 0){
				console.log("들어왔어요 ");
				$('#today_date').empty();		// # 날짜
				$('#today_emotion').empty();	// # 이모티콘 삭제
				$('#today_eat').empty();		// # 나의펫 영역
				$('#today_sick').empty();		// # 그날의 증상
				$('#today_Exercise').empty();	// # 그날의 운동량
				$('#today_diary').empty();		// # 그날의 일기
				
				var toDay = map.notesDTO.note_date +' 의 일지'; // 날짜
				$('#today_date').append(toDay);

				var today_emotion = '<label style="margin-bottom: 0px;"> # 그날의 기분</label><br />';
				if(map.notesDTO.note_emotion == 1){
					today_emotion += '<img src="/cdd/resource/img/heart-eyes.svg"  width="20px" height="20px"/> 신남';
				}else if(map.notesDTO.note_emotion == 2){
					today_emotion += '<img src="/cdd/resource/img/angry.svg"  width="20px" height="20px"/> 화남'
				}else if(map.notesDTO.note_emotion == 3){
					today_emotion += '<img src="/cdd/resource/img/expressionless.svg"  width="20px" height="20px"/> 우울';
				}else if(map.notesDTO.note_emotion == 4){
					today_emotion += '<img src="/cdd/resource/img/frown.svg"  width="20px" height="20px"/> 슬픔';
				}else if(map.notesDTO.note_emotion == 5){
					today_emotion += '<img src="/cdd/resource/img/dizzy.svg"  width="20px" height="20px"/> 아픔';
				}else if(map.notesDTO.note_emotion == 6){
					today_emotion += '<img src="/cdd/resource/img/smile.svg"  width="20px" height="20px"/> 보통';
				}
				$('#today_emotion').append(today_emotion);
				
				// # 나의펫 영역
				var today_eat = ''; 
				today_eat += '<td>'+ map.notesDTO.note_weight +'</td>' ;
				today_eat += '<td>'+ map.notesDTO.note_dry +'</td>' ;
				today_eat += '<td>'+ map.notesDTO.note_wet +'</td>' ;
				today_eat += '<td>'+ map.notesDTO.note_water +'</td>' ;
				$('#today_eat').append(today_eat);	
				
				// # 그날의 증상
				var today_sick = '';
				if(map.notesDTO.note_disorder1 == 'on'){
					today_sick += '<td> 했음 </td>';
				}else{
					today_sick += '<td> 안했음 </td>';
				}
				if(map.notesDTO.note_disorder2 == 'on'){
					today_sick += '<td> 했음 </td>';
				}else{
					today_sick += '<td> 안했음 </td>';
				}
				today_sick += '<td>'+ map.notesDTO.note_disorder3 +'</td>';
				$('#today_sick').append(today_sick);			
				
				
				// # 그날의 운동량
				var today_Exercise = '';
				if(map.notesDTO.note_stroll1 == null){
					today_Exercise += '<td> 0분 </td>';
				}else{
					today_Exercise += '<td>' + map.notesDTO.note_stroll1 + ' 분 </td>';
				}//else
				
				if(map.notesDTO.note_stroll2 == null){
					today_Exercise += '<td> 0분 </td>';
				}else{
					today_Exercise += '<td>' + map.notesDTO.note_stroll2 + ' 분 </td>';
				}//else
				
				if(map.notesDTO.note_stroll3 == null){
					today_Exercise += '<td> 0분 </td>';
				}else{
					today_Exercise += '<td>' + map.notesDTO.note_stroll3 + ' 분 </td>';
				}//else
				
				if(map.notesDTO.note_bath == 0){
					today_Exercise += '<td>상쾌</td>';
				}else {
					today_Exercise += '<td>불쾌</td>';
				}//else
				
				$('#today_Exercise').append(today_Exercise);				
				
				var today_diary = map.notesDTO.note_other;
				$('#today_diary').append(today_diary);					// 다이어리
				
			}else{
				console.log("여기여기");
				$('#today_date').empty();		// # 날짜
				$('#today_emotion').empty();	// # 이모티콘 삭제
				$('#today_eat').empty();		// # 나의펫 영역
				$('#today_sick').empty();		// # 그날의 증상
				$('#today_Exercise').empty();	// # 그날의 운동량
				$('#today_diary').empty();		// # 그날의 일기
				
				var today_emotion = '<label style="margin-bottom: 0px;"> # 그날의 기분</label>';
				$('#today_emotion').append(today_emotion);		// # 이모티콘 영역
				
				var today_eat = '<td colspan="4"> 등록된 일지 정보가 없습니다.  </td>'
				$('#today_eat').append(today_eat);		// # 나의펫 영역
				
				var today_sick = '<td colspan="3"> 등록된 일지 정보가 없습니다.</td>'
				$('#today_sick').append(today_sick);		// # 그날의 증상
				
				var today_Exercise = '<td colspan="4"> 등록된 일지 정보가 없습니다. </td>'
				$('#today_Exercise').append(today_Exercise);	// # 그날의 운동량
				
				var today_diary = '등록된 일지 정보가 없습니다.';
				$('#today_diary').append(today_diary);		// # 그날의 일기
				
				
		
						
				
			}//else
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			}// success
	    })//ajax
    }//else
  }//if
  
}); 							








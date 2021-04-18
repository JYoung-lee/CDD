// ================================
// START YOUR APP HERE
// ================================
var init3 = {
  monList3: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  dayList3: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
  today3: new Date(),
  monForChange3: new Date().getMonth(),
  activeDate3: new Date(),
  getFirstDay3: (yy, mm) => new Date(yy, mm, 1),
  getLastDay3: (yy, mm) => new Date(yy, mm + 1, 0),
  nextMonth3: function () { // 다음달 설정
    let d3 = new Date();
    d3.setDate(1);
    d3.setMonth(++this.monForChange3);
    this.activeDate3 = d3;
    return d3;
  },
  prevMonth3: function () { // 이전달 설정
    let d3 = new Date();
    d3.setDate(1);
    d3.setMonth(--this.monForChange3);
    this.activeDate3 = d3;
    return d3;
  },
  addZero3: (num) => (num < 10) ? '0' + num : num,
  activeDTag3: null,
  getIndex3: function (node) {
    let index1 = 0;
    while (node = node.previousElementSibling) {
      index1++;
    }
    return index1;
  }
};

var $calBody3 = document.querySelector('.cal-body3'); // 바디 영역
var $btnNext3 = document.querySelector('.btn-cal.next3'); // 다음달
var $btnPrev3 = document.querySelector('.btn-cal.prev3'); // 이전달

/**
 * @param {date} fullDate
 */
function loadYYMM3 (fullDate) { // 로딩시 달력 띄워주기
	console.log("수정 페이지 3 ");
  let yy3 = fullDate.getFullYear();	
  let mm3 = fullDate.getMonth();
  let firstDay3 = init3.getFirstDay3(yy3, mm3);
  let lastDay3 = init3.getLastDay3(yy3, mm3);
  let markToday3;  // 해당일 마크 찍어주기
  
  if (mm3 === init3.today3.getMonth() && yy3 === init3.today3.getFullYear()) {
    markToday3 = init3.today3.getDate();
  }
  
  document.querySelector('.cal-month3').textContent = init3.monList3[mm3]; //해당월
  document.querySelector('.cal-year3').textContent = yy3; // 해당 년도

  let trtd3 = '';
  let startCount3;
  let countDay3 = 0;
  for (let i = 0; i < 6; i++) {
    trtd3 += '<tr>';
    for (let j = 0; j < 7; j++) {
      if (i === 0 && !startCount3 && j === firstDay3.getDay()) {
        startCount3 = 1;
      }
      if (!startCount3) {
        trtd3 += '<td>'
      } else {
        let fullDate = yy3 + '/' + init3.addZero3(mm3 + 1) + '/' + init3.addZero3(countDay3 + 1);
        trtd3 += '<td class="day3';
        trtd3 += (markToday3 && markToday3 === countDay3 + 1) ? ' today3" ' : '"';
        trtd3 += ` data-date="${countDay3 + 1}" data-fdate="${fullDate}" value="${fullDate}">`; // 전부 붙여주기
      }
      trtd3 += (startCount3) ? ++countDay3 : '';
      if (countDay3 === lastDay3.getDate()) { 
        startCount3 = 0; 
      }
      trtd3 += '</td>';
    }
    trtd3 += '</tr>';
  }
  $calBody3.innerHTML = trtd3;
}

loadYYMM3(init3.today3);


$btnNext3.addEventListener('click', () => loadYYMM3(init3.nextMonth3()));
$btnPrev3.addEventListener('click', () => loadYYMM3(init3.prevMonth3()));


$calBody3.addEventListener('click', (e) => { // 클래스 추가되면서 색깔 생김
	console.log("수정 클릭이벤트 ");
  if(e.target.classList.contains('day3')) {
		if(init3.activeDTag3) {
			init3.activeDTag3.classList.remove('day-active3');
		}
		let day3 = Number(e.target.textContent);
		
		e.target.classList.add('day-active3');
		init3.activeDTag3 = e.target;
		init3.activeDate3.setDate(day3);
		
		var dataDay = e.target.getAttribute("value"); //클릭시 클릭 한게 타겟이되어 그 속성중 value 값 가져오기
		console.log("dataDay : " + dataDay); //팁 td 스크립트에 의해 동적으로 생성되는것들은
		
		$('#sche_modifyinput').empty();
		var html = '<h5>' + dataDay + '</h5>';
		$('#sche_modifyinput').append(html);
		
		$('#sche_dateModifyValue').val(dataDay); //input태그 value값 넣는방법
  }//if
  
}); 							








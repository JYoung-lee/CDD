var init = {
  monList: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  dayList: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
  today: new Date(),
  monForChange: new Date().getMonth(),
  activeDate: new Date(),
  getFirstDay: (yy, mm) => new Date(yy, mm, 1),
  getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
  nextMonth: function () { // 다음달 설정
    let d = new Date();
    d.setDate(1);
    d.setMonth(++this.monForChange);
    this.activeDate = d;
    return d;
  },
  prevMonth: function () { // 이전달 설정
    let d = new Date();
    d.setDate(1);
    d.setMonth(--this.monForChange);
    this.activeDate = d;
    return d;
  },
  addZero: (num) => (num < 10) ? '0' + num : num,
  activeDTag: null,
  getIndex: function (node) {
    let index = 0;
    while (node = node.previousElementSibling) {
      index++;
    }
    return index;
  }
};

var $calBody = document.querySelector('.cal-body'); // 바디 영역
var $btnNext = document.querySelector('.btn-cal.next'); // 다음달
var $btnPrev = document.querySelector('.btn-cal.prev'); // 이전달

/**
 * @param {date} fullDate
 */
function loadYYMM (fullDate) { // 로딩시 달력 띄워주기
  console.log(" 로딩시 들어옴 ");
  let yy = fullDate.getFullYear();	
  let mm = fullDate.getMonth();
  let firstDay = init.getFirstDay(yy, mm);
  let lastDay = init.getLastDay(yy, mm);
  let markToday;  // 해당일 마크 찍어주기
  
  if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
    markToday = init.today.getDate();
  }
  document.querySelector('.cal-month').textContent = init.monList[mm]; //해당월
  document.querySelector('.cal-year').textContent = yy; // 해당 년도

  let trtd = '';
  let startCount;
  let countDay = 0;
  for (let i = 0; i < 6; i++) {
    trtd += '<tr>';
    for (let j = 0; j < 7; j++) {
      if (i === 0 && !startCount && j === firstDay.getDay()) {
        startCount = 1;
      }
      if (!startCount) {
        trtd += '<td>'
      } else {
        let fullDate = yy + '/' + init.addZero(mm + 1) + '/' + init.addZero(countDay + 1);
        trtd += '<td class="day';
        trtd += (markToday && markToday === countDay + 1) ? ' today" ' : '"';
        trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}" value="${fullDate}">`; // 전부 붙여주기
      }
      trtd += (startCount) ? ++countDay : '';
      if (countDay === lastDay.getDate()) { 
        startCount = 0; 
      }
      trtd += '</td>';
    }
    trtd += '</tr>';
  }
  $calBody.innerHTML = trtd;
}


loadYYMM(init.today);


$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));

/*
function test(e) {
	console.log(e)
}

 (e) => {
	 console.log(e)
 }

$calBody.addEventListener('click', );
*/
$calBody.addEventListener('click', (e) => { // 클래스 추가되면서 색깔 생김
	console.log(" 들어옴 ");
	if (e.target.classList.contains('day')) {
	    if (init.activeDTag) {
	      init.activeDTag.classList.remove('day-active');
	    }
	    let day = Number(e.target.textContent);
    
	    e.target.classList.add('day-active');
	    init.activeDTag = e.target;
	    init.activeDate.setDate(day);
	    var dataDay = e.target.getAttribute("value"); //클릭시 클릭 한게 타겟이되어 그 속성중 value 값 가져오기
	    console.log("dataDay : " + dataDay); //팁 td 스크립트에 의해 동적으로 생성되는것들은
	    
	    $('#sche_addinput').empty();
	    var html = '<h5>' + dataDay + '</h5>';
	    $('#sche_addinput').append(html);
	    
	    $('#sche_dateValue').val(dataDay); //input태그 value값 넣는방법
	}
  
});
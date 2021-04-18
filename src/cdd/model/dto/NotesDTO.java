package cdd.model.dto;

public class NotesDTO {
	private Integer note_num;		// 일지 고유번호
	private String user_id;			// 작성자 고유 ID
	private Integer pet_num;		// 펫 고유번호
	private Integer note_emotion;	// 그날의 기분
	private String note_weight;		// 몸무게
	private String note_dry;		// 건식 식사량
	private String note_wet;		// 습식 식사량
	private String note_water;		// 음수량
	private String note_disorder1;	// 구토 여부
	private String note_disorder2;	// 설사 여부
	private String note_disorder3;	// 기타 이상증상
	private Integer note_stroll1;	// 오전 산책 시간
	private Integer note_stroll2;	// 오후 산책 시간
	private Integer note_stroll3;	// 저녁 산책 시간
	private Integer note_bath;		// 목욕 여부
	private Integer note_secret;	// 일지 공개 여부
	private String note_date;		// 일지 작성 날짜
	private String note_other;		// 일지 기타 사항 
	
	public Integer getNote_num() {
		return note_num;
	}
	public void setNote_num(Integer note_num) {
		this.note_num = note_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getPet_num() {
		return pet_num;
	}
	public void setPet_num(Integer pet_num) {
		this.pet_num = pet_num;
	}
	public Integer getNote_emotion() {
		return note_emotion;
	}
	public void setNote_emotion(Integer note_emotion) {
		this.note_emotion = note_emotion;
	}
	public String getNote_weight() {
		return note_weight;
	}
	public void setNote_weight(String note_weight) {
		this.note_weight = note_weight;
	}
	public String getNote_dry() {
		return note_dry;
	}
	public void setNote_dry(String note_dry) {
		this.note_dry = note_dry;
	}
	public String getNote_wet() {
		return note_wet;
	}
	public void setNote_wet(String note_wet) {
		this.note_wet = note_wet;
	}
	public String getNote_water() {
		return note_water;
	}
	public void setNote_water(String note_water) {
		this.note_water = note_water;
	}
	public String getNote_disorder1() {
		return note_disorder1;
	}
	public void setNote_disorder1(String note_disorder1) {
		this.note_disorder1 = note_disorder1;
	}
	public String getNote_disorder2() {
		return note_disorder2;
	}
	public void setNote_disorder2(String note_disorder2) {
		this.note_disorder2 = note_disorder2;
	}
	public String getNote_disorder3() {
		return note_disorder3;
	}
	public void setNote_disorder3(String note_disorder3) {
		this.note_disorder3 = note_disorder3;
	}
	public Integer getNote_stroll1() {
		return note_stroll1;
	}
	public void setNote_stroll1(Integer note_stroll1) {
		this.note_stroll1 = note_stroll1;
	}
	public Integer getNote_stroll2() {
		return note_stroll2;
	}
	public void setNote_stroll2(Integer note_stroll2) {
		this.note_stroll2 = note_stroll2;
	}
	public Integer getNote_stroll3() {
		return note_stroll3;
	}
	public void setNote_stroll3(Integer note_stroll3) {
		this.note_stroll3 = note_stroll3;
	}
	public Integer getNote_bath() {
		return note_bath;
	}
	public void setNote_bath(Integer note_bath) {
		this.note_bath = note_bath;
	}
	public Integer getNote_secret() {
		return note_secret;
	}
	public void setNote_secret(Integer note_secret) {
		this.note_secret = note_secret;
	}
	public String getNote_date() {
		return note_date;
	}
	public void setNote_date(String note_date) {
		this.note_date = note_date;
	}
	public String getNote_other() {
		return note_other;
	}
	public void setNote_other(String note_other) {
		this.note_other = note_other;
	}
	
}//NotesDTO

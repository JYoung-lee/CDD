package cdd.model.dto;

public class NotesListDTO {
	private Integer note_num; 		// 일지 고유넘버
	private Integer pet_num;		// 펫 고유넘버
	private String pet_name;		// 펫 이름
	private Integer note_bath;		// 펫 목욕 여부
	private Integer note_secret;	// 공개여부
	private String note_date;		// 날짜.
	
	
	public Integer getNote_num() {
		return note_num;
	}
	public void setNote_num(Integer note_num) {
		this.note_num = note_num;
	}
	public Integer getPet_num() {
		return pet_num;
	}
	public void setPet_num(Integer pet_num) {
		this.pet_num = pet_num;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
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
	
}

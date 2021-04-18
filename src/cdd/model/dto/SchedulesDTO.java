package cdd.model.dto;

public class SchedulesDTO {
	private Integer sche_num;		// 스케줄 고유 넘버
	private String user_id; 		// 유저 아이디
	private Integer pet_num;		// 펫 고유번호
	private String sche_date;		// 스케줄 날짜
	private String sche_subject;	// 스케줄 제목
	private String sche_content;	// 스케줄 내용
	private String sche_time;		// 스케줄 시간
	
	public Integer getSche_num() {
		return sche_num;
	}
	public void setSche_num(Integer sche_num) {
		this.sche_num = sche_num;
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
	public String getSche_date() {
		return sche_date;
	}
	public void setSche_date(String sche_date) {
		this.sche_date = sche_date;
	}
	public String getSche_subject() {
		return sche_subject;
	}
	public void setSche_subject(String sche_subject) {
		this.sche_subject = sche_subject;
	}
	public String getSche_content() {
		return sche_content;
	}
	public void setSche_content(String sche_content) {
		this.sche_content = sche_content;
	}
	public String getSche_time() {
		return sche_time;
	}
	public void setSche_time(String sche_time) {
		this.sche_time = sche_time;
	}
	
}//SchedulesDTO

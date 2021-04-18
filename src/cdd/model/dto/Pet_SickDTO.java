package cdd.model.dto;

import java.sql.Timestamp;

public class Pet_SickDTO {
	private Integer pet_number;		// 펫 고유번호 
	private String user_id;			// 사용자 ID
	private Integer sick_status;	// 질환 상태
	private String pet_sickname;	// 질환명
	private String pet_sickday;		// 질환판정날짜
	private String pet_hospital;	// 질환판정병원
	private Timestamp sick_reg;		// 등록시간
	
	public Integer getPet_number() {
		return pet_number;
	}
	public void setPet_number(Integer pet_number) {
		this.pet_number = pet_number;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getSick_status() {
		return sick_status;
	}
	public void setSick_status(Integer sick_status) {
		this.sick_status = sick_status;
	}
	public String getPet_sickname() {
		return pet_sickname;
	}
	public void setPet_sickname(String pet_sickname) {
		this.pet_sickname = pet_sickname;
	}
	public String getPet_sickday() {
		return pet_sickday;
	}
	public void setPet_sickday(String pet_sickday) {
		this.pet_sickday = pet_sickday;
	}
	public String getPet_hospital() {
		return pet_hospital;
	}
	public void setPet_hospital(String pet_hospital) {
		this.pet_hospital = pet_hospital;
	}
	public Timestamp getSick_reg() {
		return sick_reg;
	}
	public void setSick_reg(Timestamp sick_reg) {
		this.sick_reg = sick_reg;
	}
	
}//Pet_SickDTO

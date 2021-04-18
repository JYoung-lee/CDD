package cdd.model.dto;

import java.sql.Timestamp;

public class Pet_JJDTO {
	private Integer pet_number;		// 펫 고유번호
	private String user_id;			// 사용자 ID
	private String pet_jjname;		// 접종명
	private String pet_jjday;		// 접종 날짜
	private String pet_jjhospital; 	// 접종 병원
	private Timestamp jj_reg;		// 등록 시간
	
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
	public String getPet_jjname() {
		return pet_jjname;
	}
	public void setPet_jjname(String pet_jjname) {
		this.pet_jjname = pet_jjname;
	}
	public String getPet_jjday() {
		return pet_jjday;
	}
	public void setPet_jjday(String pet_jjday) {
		this.pet_jjday = pet_jjday;
	}
	public String getPet_jjhospital() {
		return pet_jjhospital;
	}
	public void setPet_jjhospital(String pet_jjhospital) {
		this.pet_jjhospital = pet_jjhospital;
	}
	public Timestamp getJj_reg() {
		return jj_reg;
	}
	public void setJj_reg(Timestamp jj_reg) {
		this.jj_reg = jj_reg;
	}
	
	
	
}//Pet_JJDTO

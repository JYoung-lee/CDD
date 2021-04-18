package cdd.model.dto;

public class Pet_SurgDTO {
	
	private Integer pet_number;		// 펫 고유번호
	private String user_id;			// 사용자 ID
	private String pet_surgname;	// 수술명
	private String pet_surgday;		// 수술날짜
	private String pet_surghospi;	// 수술병원
	private String surg_reg;		// 등록 시간
	
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
	public String getPet_surgname() {
		return pet_surgname;
	}
	public void setPet_surgname(String pet_surgname) {
		this.pet_surgname = pet_surgname;
	}
	public String getPet_surgday() {
		return pet_surgday;
	}
	public void setPet_surgday(String pet_surgday) {
		this.pet_surgday = pet_surgday;
	}
	public String getPet_surghospi() {
		return pet_surghospi;
	}
	public void setPet_surghospi(String pet_surghospi) {
		this.pet_surghospi = pet_surghospi;
	}
	public String getSurg_reg() {
		return surg_reg;
	}
	public void setSurg_reg(String surg_reg) {
		this.surg_reg = surg_reg;
	}
	
	
}//Pet_SurgDTO

package cdd.model.dto;

public class Pet_InfoDTO {
	private Integer pet_number; // 펫고유넘버
	private String user_id;		// 사용자 ID
	private Integer type_num;	// 펫 종류
	private Integer kind_num;	// 펫 품종
	private String kind_other;	
	private String pet_profile;	// 펫 프로필 사진
	private String pet_name;	// 펫 이름
	private String pet_gender;	// 펫 성별
	private String pet_birth;	// 펫 생일
	private Integer pet_tt;		// 펫 중성화
	private String pet_ttday;	// 펫 중성화 날짜
	private String pet_meet;	// 입양 날짜
	
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
	public Integer getType_num() {
		return type_num;
	}
	public void setType_num(Integer type_num) {
		this.type_num = type_num;
	}
	public Integer getKind_num() {
		return kind_num;
	}
	public void setKind_num(Integer kind_num) {
		this.kind_num = kind_num;
	}
	public String getKind_other() {
		return kind_other;
	}
	public void setKind_other(String kind_other) {
		this.kind_other = kind_other;
	}
	public String getPet_profile() {
		return pet_profile;
	}
	public void setPet_profile(String pet_profile) {
		this.pet_profile = pet_profile;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public String getPet_gender() {
		return pet_gender;
	}
	public void setPet_gender(String pet_gender) {
		this.pet_gender = pet_gender;
	}
	public String getPet_birth() {
		return pet_birth;
	}
	public void setPet_birth(String pet_birth) {
		this.pet_birth = pet_birth;
	}
	public Integer getPet_tt() {
		return pet_tt;
	}
	public void setPet_tt(Integer pet_tt) {
		this.pet_tt = pet_tt;
	}
	public String getPet_ttday() {
		return pet_ttday;
	}
	public void setPet_ttday(String pet_ttday) {
		this.pet_ttday = pet_ttday;
	}
	public String getPet_meet() {
		return pet_meet;
	}
	public void setPet_meet(String pet_meet) {
		this.pet_meet = pet_meet;
	}
	
	
	
}// Pet_InfoDTO

package cdd.model.dto;

import java.sql.Timestamp;

public class UserDTO {
	
	private String user_id; // 아이디 20자
	private String user_pw; // 패스워드 20자
	private String user_name; // 이름 20자
	private String user_tel; // 전화 20자
	private String user_email; // 이메일 50자
	private String user_profile; // 프로필 사진 1000자
	private String user_bio; // 소개 2000자
	private Integer blocked; // 개정 정지여부 기본: 0, 정지:1
	private Timestamp reg; // 가입 시간
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_profile() {
		return user_profile;
	}
	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}
	public String getUser_bio() {
		return user_bio;
	}
	public void setUser_bio(String user_bio) {
		this.user_bio = user_bio;
	}
	public Integer getBlocked() {
		return blocked;
	}
	public void setBlocked(Integer blocked) {
		this.blocked = blocked;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	

}

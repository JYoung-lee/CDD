package cdd.model.dto;

import java.sql.Timestamp;

public class AlarmsDTO {
	private Integer feed_num;
	private String user_id;
	private String alarm_content;
	private Integer alarm_status;
	private String alarmFromId;
	private String user_profile;
	private Timestamp alarm_reg;
	
	public String getUser_profile() {
		return user_profile;
	}
	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}
	public Integer getFeed_num() {
		return feed_num;
	}
	public void setFeed_num(Integer alarm_num) {
		this.feed_num = alarm_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
	}
	public Integer getAlarm_status() {
		return alarm_status;
	}
	public void setAlarm_status(Integer alarm_status) {
		this.alarm_status = alarm_status;
	}
	public String getAlarmFromId() {
		return alarmFromId;
	}
	public void setAlarmFromId(String alarmFromId) {
		this.alarmFromId = alarmFromId;
	}
	
	public Timestamp getAlarm_reg() {
		return alarm_reg;
	}
	public void setAlarm_reg(Timestamp alarm_reg) {
		this.alarm_reg = alarm_reg;
	}
}

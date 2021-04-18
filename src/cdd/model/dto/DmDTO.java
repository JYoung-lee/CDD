package cdd.model.dto;

import java.sql.Timestamp;

public class DmDTO {
	private Integer dm_num;
	private String userId;
	private String sender;
	private String receiver;
	private String content;
	private Integer status;
	private Timestamp dm_reg;
	public Integer getDm_num() {
		return dm_num;
	}
	public void setDm_num(Integer dm_num) {
		this.dm_num = dm_num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Timestamp getDm_reg() {
		return dm_reg;
	}
	public void setDm_reg(Timestamp dm_reg) {
		this.dm_reg = dm_reg;
	}
}

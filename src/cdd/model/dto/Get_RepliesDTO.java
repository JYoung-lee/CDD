package cdd.model.dto;

import java.sql.Timestamp;

public class Get_RepliesDTO {
	private String user_profile;
	public String getUser_profile() {
		return user_profile;
	}
	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}
	private Integer reply_num;
	private Integer feed_num;
	private String user_id;
	private String reply_content;
	private Integer reply_ref;
	private Integer reply_level;
	private String reply_id;
	private Timestamp reply_reg;
	private Integer reportch;
	public Integer getReply_num() {
		return reply_num;
	}
	public void setReply_num(Integer reply_num) {
		this.reply_num = reply_num;
	}
	public Integer getFeed_num() {
		return feed_num;
	}
	public void setFeed_num(Integer feed_num) {
		this.feed_num = feed_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Integer getReply_ref() {
		return reply_ref;
	}
	public void setReply_ref(Integer reply_ref) {
		this.reply_ref = reply_ref;
	}
	public Integer getReply_level() {
		return reply_level;
	}
	public void setReply_level(Integer reply_level) {
		this.reply_level = reply_level;
	}
	public String getReply_id() {
		return reply_id;
	}
	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}
	public Timestamp getReply_reg() {
		return reply_reg;
	}
	public void setReply_reg(Timestamp reply_reg) {
		this.reply_reg = reply_reg;
	}
	public Integer getReportch() {
		return reportch;
	}
	public void setReportch(Integer reportch) {
		this.reportch = reportch;
	}
}

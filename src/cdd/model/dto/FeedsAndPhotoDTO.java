package cdd.model.dto;

import java.sql.Timestamp;

public class FeedsAndPhotoDTO {
	private Integer feed_num;
	private String user_id;
	private String feed_content;
	private Integer feed_emotion;
	private Integer feed_secret;
	private Timestamp feed_reg;
	private String feed_hash;
	private String photo_dir;
	
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
	public String getFeed_content() {
		return feed_content;
	}
	public void setFeed_content(String feed_content) {
		this.feed_content = feed_content;
	}
	public Integer getFeed_emotion() {
		return feed_emotion;
	}
	public void setFeed_emotion(Integer feed_emotion) {
		this.feed_emotion = feed_emotion;
	}
	public Integer getFeed_secret() {
		return feed_secret;
	}
	public void setFeed_secret(Integer feed_secret) {
		this.feed_secret = feed_secret;
	}
	public Timestamp getFeed_reg() {
		return feed_reg;
	}
	public void setFeed_reg(Timestamp feed_reg) {
		this.feed_reg = feed_reg;
	}
	public String getFeed_hash() {
		return feed_hash;
	}
	public void setFeed_hash(String feed_hash) {
		this.feed_hash = feed_hash;
	}
	public String getPhoto_dir() {
		return photo_dir;
	}
	public void setPhoto_dir(String photo_dir) {
		this.photo_dir = photo_dir;
	}
}

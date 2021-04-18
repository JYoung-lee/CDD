package cdd.model.dto;

import java.sql.Timestamp;

public class ReportsDTO {
	private Integer report_num;
	private String reporterId;
	private String repotedId;
	private String report_type;
	private String report_cate;
	private String report_content;
	private Integer feed_num;
	private Integer reportState;
	private Timestamp report_reg;
	public Integer getReport_num() {
		return report_num;
	}
	public void setReport_num(Integer report_num) {
		this.report_num = report_num;
	}
	public String getReporterId() {
		return reporterId;
	}
	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}
	public String getRepotedId() {
		return repotedId;
	}
	public void setRepotedId(String repotedId) {
		this.repotedId = repotedId;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public String getReport_cate() {
		return report_cate;
	}
	public void setReport_cate(String report_cate) {
		this.report_cate = report_cate;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public Integer getFeed_num() {
		return feed_num;
	}
	public void setFeed_num(Integer feed_num) {
		this.feed_num = feed_num;
	}
	public Integer getReportState() {
		return reportState;
	}
	public void setReportState(Integer reportState) {
		this.reportState = reportState;
	}
	public Timestamp getReport_reg() {
		return report_reg;
	}
	public void setReport_reg(Timestamp report_reg) {
		this.report_reg = report_reg;
	}
	
	
	
	
}

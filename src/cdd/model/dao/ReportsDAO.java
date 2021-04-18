package cdd.model.dao;

import java.util.List;

public interface ReportsDAO {
	// 회원 목록가져오기
	public List getMemberList() throws Exception;
	
	// 회원 blocked
	public void updateBlocked(String id, String blocked) throws Exception;
	
	// 회원 1명에 대한 신고 목록 가져오기
	public List getMemberReportList(String id) throws Exception;

	// 회원 1명 신고 갯수 가져오기
	public int getReportCount(String id) throws Exception;
	
	// 전체 신고내역 조회
	public List getReportAllList(String startNum, String endNum) throws Exception;
	
	// 리포트 삭제
	public void deleteReport(Integer reportNum) throws Exception;
	
	
	
	// [4.7 훈영추가] 게시물/ 댓글 신고 입력
	public void reportInsert() throws Exception;
	
	// [4.7 훈영추가] 카테고리 신고목록 가져오기
	public List getReportCateList(String startNum, String endNum, String report_cate) throws Exception;
	
	public List getReportTypeList(String startNum, String endNum, String report_cate) throws Exception;
}

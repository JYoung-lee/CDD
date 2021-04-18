package cdd.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportsDAOImpl implements ReportsDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// 회원 목록가져오기 가져오기
	@Override
	public List getMemberList() throws Exception{
		
		List memberList = sqlSession.selectList("reports.memberList" ,null);
		return memberList;
	}
	
	// 회원 blocked
	@Override
	public void updateBlocked(String user_id, String blocked) throws Exception {
		Map map = new HashMap();
		map.put("id", user_id);
		map.put("blocked", blocked);
		sqlSession.update("reports.updateBlocked", map);
	}

	@Override
	public List getMemberReportList(String id) throws Exception {
		
		List memberReportList = sqlSession.selectList("reports.memberReportList", id);
		
		return memberReportList;
	}

	@Override
	public int getReportCount(String id) throws Exception {
		
		int count = sqlSession.selectOne("reports.getReportsCount", id);
		
		return count;
	}
	
	//전체 신고내역 조회
	@Override
	public List getReportAllList(String startNum, String endNum) throws Exception {
		Map args = new HashMap();
		args.put("startNum", startNum);
		args.put("endNum", endNum);
		List reportList = sqlSession.selectList("reports.getReportAllList", args);
		return reportList;
	}
	
	// 리폿삭제
	@Override
	public void deleteReport(Integer report_num) throws Exception {
		sqlSession.delete("reports.deleteReport",report_num);
	}
	
	
	
	// 4.7 훈영 추가 신고입력
	@Override
	public void reportInsert() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	// 4.8 훈영 추가 피드신고목록 가져오기
	@Override
	public List getReportCateList(String startNum, String endNum, String report_cate) throws Exception {
		Map args = new HashMap();
		args.put("startNum", startNum);
		args.put("endNum", endNum);
		args.put("report_cate", report_cate);
		List reportList = sqlSession.selectList("reports.getReportCateList", args);
		return reportList;
	}
	// 4.8 훈영 추가 타입신고목록 가져오기
	@Override
	public List getReportTypeList(String startNum, String endNum, String report_cate) throws Exception {
		Map args = new HashMap();
		args.put("startNum", startNum);
		args.put("endNum", endNum);
		args.put("report_cate", report_cate);
		List reportList = sqlSession.selectList("reports.getReportTypeList", args);
		return reportList;
	}
}

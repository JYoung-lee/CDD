package cdd.service.bean;

import java.util.List;

public interface AdminService {
	// 회원 목록 가져오기
	public List getMemberList() throws Exception;
	
	// 회원 blocked
	public void updateBlocked(String id, String blocked) throws Exception;
	
	// 회원 1명에 대한 신고 목록 가져오기
	public List getMemberReportList(String id) throws Exception;

	// 회원 1명 신고 갯수 가져오기
	public int reportsCount(String id) throws Exception;
	
	// 전체 신고 내역 조회 [선준]
	public List getReportList(String startNum, String endNum, String report_type) throws Exception;
	
	// 신고목록 삭제 [훈영 4.8 수정]
	public void deleteReport(Integer reportNum) throws Exception;
	
	// 펫 종류 가져오기
	public List getPetTypes() throws Exception;
	
	// 펫 종류 추가하기
	public void addPetType(String petType) throws Exception;
	
	// 펫 종류 삭제하기
	public void removeType(Integer typeNum) throws Exception;
	
	// 펫 품종 가져오기
	public List getKindList(Integer typeNum) throws Exception;
	
	// 펫 품종 추가하기
	public void addPetKind(String kindName, Integer typeNum) throws Exception;
	
	// 펫 품종 삭제하기
	public void removeKind(Integer kindNum) throws Exception;
}

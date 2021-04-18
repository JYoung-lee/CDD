package cdd.service.bean;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cdd.model.dao.PetDAO;
import cdd.model.dao.ReportsDAO;
import cdd.model.dto.ReportsDTO;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private ReportsDAO reportsDAO = null;
	@Autowired
	private PetDAO petDAO = null;
	
	// 회원 목록 불러오기, 신고 내역가져오기
	@Override
	public List getMemberList() throws Exception {
		
		List memberList = reportsDAO.getMemberList();
		
		return memberList;
	}
	
	// 회원 blocked
	@Override
	public void updateBlocked(String user_id, String blocked) throws Exception {
		reportsDAO.updateBlocked(user_id, blocked);
	}

	@Override
	public List getMemberReportList(String id) throws Exception {
		
		List memberReportList =  reportsDAO.getMemberReportList(id);
		
		return memberReportList;
	}

	@Override
	public int reportsCount(String id) throws Exception{
		
		int count = reportsDAO.getReportCount(id);
		
		return count;
	}
	
	//  신고 내역 조회 [선준]
	@Override
	public List getReportList(String startNum, String endNum, String report_type) throws Exception {
		List reportList = null;
		if(startNum == null) {
			startNum = "1";
		}
		if(endNum == null) {
			endNum = "10";
		}
		if(report_type.equals("reportAll")) {
			reportList = reportsDAO.getReportAllList(startNum, endNum);
		}else if(report_type.equals("feed")) {
			String report_cate = "피드";
			reportList = reportsDAO.getReportCateList(startNum, endNum, report_cate);
		}else if(report_type.equals("reply")) {
			String report_cate = "댓글";
			reportList = reportsDAO.getReportCateList(startNum, endNum, report_cate);
		}else if(report_type.equals("yok")) {
			String report_cate = "욕설";
			reportList = reportsDAO.getReportTypeList(startNum, endNum, report_cate);
		}else if(report_type.equals("adult")) {
			String report_cate = "음란물";
			reportList = reportsDAO.getReportTypeList(startNum, endNum, report_cate);
		}
		
		return reportList;
	}
	
	// 신고 삭제
	@Override
	public void deleteReport(Integer reportNum) throws Exception {
		reportsDAO.deleteReport(reportNum);
	}
	
	// 펫 종류 가져오기
	@Override
	public List getPetTypes() throws Exception {
		List petTypes = petDAO.getPetTypes();
		return petTypes;
	}
	
	// 펫 종류 추가하기
	@Override
	public void addPetType(String petType) throws Exception {
		petDAO.insertPetType(petType);
	}
	
	// 펫 종류 삭제하기
	@Override
	public void removeType(Integer typeNum) throws Exception {
		petDAO.deletePetType(typeNum);
	}
	
	// 펫 품종 가져오기
	@Override
	public List getKindList(Integer typeNum) throws Exception {
		List kindList = petDAO.getKindList(typeNum);
		return kindList;
	}
	
	// 펫 품종 추가하기
	@Override
	public void addPetKind(String kindName, Integer typeNum) throws Exception {
		petDAO.insertPetKind(kindName, typeNum);
	}
	
	// 펫 품종 삭제하기
	@Override
	public void removeKind(Integer kindNum) throws Exception {
		petDAO.deletePetKind(kindNum);
	}
}

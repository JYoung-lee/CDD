package cdd.controller.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import cdd.service.bean.AdminService;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	private AdminService adminService = null;
	
	@RequestMapping("setting.cdd")
	public String setting() {
		return "admin/setting";
	}
	
	// 신고목록 불러오기 4.7 훈영 수정
	@RequestMapping("reportList.cdd")
	public String reportList(Model model, String startNum, String endNum, String report_type) throws Exception{
		
		if(report_type == null) {
			report_type = "reportAll";
		}
			
			
		List reportList = adminService.getReportList(startNum, endNum, report_type);
		model.addAttribute("reportList", reportList);
		model.addAttribute("report_type", report_type);
		return "admin/reportList";
	}
	
	@RequestMapping("typeKindAdd.cdd")
	public String typeKindAdd(Model model) throws Exception{
		List petTypes = adminService.getPetTypes();
		model.addAttribute("petTypes", petTypes);
		return "admin/typeKindAdd";
	}
	
	// 회원 목록 불러오기
	@RequestMapping("memberList.cdd")
	public String memberList(Model model, HttpSession session) throws Exception {
		String sessionId = (String) session.getAttribute("memId");
		List memberList = adminService.getMemberList();
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("sessionId", sessionId);
		return "admin/memberList";
	}
	
	// 유저 제명 ajax
	@RequestMapping("ajaxBlockedPro.cdd")
	public ResponseEntity<String> ajaxBlockedPro(String user_id, String blocked) throws Exception {
		String result = "ok";
		adminService.updateBlocked(user_id, blocked);
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("content-type", "text/html;charset=utf-8");
		return new ResponseEntity<String>(result, responseHeaders, HttpStatus.OK);
	}
	
	// ajax : 추가로 reportList 불러오기
	@ResponseBody
	@RequestMapping(value="ajaxLoadReports.cdd", method=RequestMethod.POST)
	public String ajaxLoadReports(@RequestBody Map<Object, Object> map) throws Exception {
		String startNum = (String)map.get("startNum");
		String endNum = (String)map.get("endNum");
		String report_type = map.get("report_type").toString();
		List reportList = adminService.getReportList(startNum, endNum, report_type);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(reportList);
		return json;
	}
	
	// 회원 1명 신고 목록
	@RequestMapping("memberReportList.cdd")
	public String memberReportList(String id, Model model) throws Exception {
		
		List memberReportList = adminService.getMemberReportList(id);
		int count = adminService.reportsCount(id);
		
		model.addAttribute("memberReportList", memberReportList);
		model.addAttribute("repotedID", id);
		model.addAttribute("count", count);
		return "admin/memberReportList";
	}
		
	// ajax : report 상태 업데이트 하기
	
	@RequestMapping(value="ajaxDeleteReport.cdd", method=RequestMethod.POST)
	public void ajaxDeleteReport(@RequestBody Map<Object, Object> map) throws Exception {
		Integer reportNum = (Integer)map.get("report_num");
		adminService.deleteReport(reportNum);
		
		
	}
	
	// ajax : 펫 종류 추가
	@ResponseBody
	@RequestMapping(value="ajaxAddType.cdd", method=RequestMethod.POST)
	public void ajaxAddType(@RequestBody Map<Object, Object> map) throws Exception{
		String petType = (String)map.get("typeAdd");
		adminService.addPetType(petType);
	}
	
	// ajax : 펫 종류 삭제
	@ResponseBody
	@RequestMapping(value="ajaxRemoveType.cdd", method=RequestMethod.POST)
	public void ajaxRemoveType(@RequestBody Map<Object, Integer> map) throws Exception{
		Integer typeNum = (Integer)map.get("typeNum");
		adminService.removeType(typeNum);
	}
	
	// ajax : 펫 품종 출력
	@ResponseBody
	@RequestMapping(value="ajaxPrintKind.cdd", method=RequestMethod.POST)
	public String ajaxPrintKind(@RequestBody Map<Object, Object> map) throws Exception{
		Integer typeNum = (Integer)map.get("typeNum");
		List kindList = adminService.getKindList(typeNum);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(kindList);
		return json;
	}
	
	// ajax : 펫 품종 추가
	@ResponseBody
	@RequestMapping(value="ajaxAddKind.cdd", method=RequestMethod.POST)
	public void ajaxAddKind(@RequestBody Map<Object, Object> map) throws Exception{
		String kindName = (String)map.get("inputKind");
		Integer typeNum = (Integer)map.get("typeNum");
		adminService.addPetKind(kindName, typeNum);
	}
	
	// ajax : 펫 품종 삭제
	@ResponseBody
	@RequestMapping(value="ajaxRemoveKind.cdd", method=RequestMethod.POST)
	public void ajaxRemoveKind(@RequestBody Map<Object, Object> map) throws Exception{
		Integer kindNum = (Integer)map.get("kindNum");
		adminService.removeKind(kindNum);
	}
}

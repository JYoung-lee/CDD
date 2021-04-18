package cdd.controller.bean;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

import cdd.model.dto.NotesDTO;
import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.Pet_JJDTO;
import cdd.model.dto.Pet_SickDTO;
import cdd.model.dto.Pet_SurgDTO;
import cdd.model.dto.SchedulesDTO;
import cdd.service.bean.MainService;
import cdd.service.bean.MyPageService;
import cdd.service.bean.PetService;

@Controller
@RequestMapping("/myPage/")
public class MyPageController {

	@Autowired
	private PetService petService = null;		// 펫 관련 서비스 
	@Autowired
	private MyPageService myPageService = null;
	@Autowired
	private MainService mainService = null;

	// User 프로필 페이지 (수정 : 선준)
	@RequestMapping("userProfile.cdd")
	public String userProfile(Model model, String profileId) throws Exception {
		System.out.println("여기냐?");
		Integer pageNum = 1;
		Map petInfo = petService.getPetInfoList(profileId);
		Map profileIdInfo = myPageService.getProfileIdInfo(profileId);
		Map feedResult = myPageService.getMyAllFeed(profileId, pageNum);
		// 펫 정보등록되었는지 뿌려주기
		model.addAttribute("petInfoList", petInfo.get("petInfoList"));
		model.addAttribute("count", petInfo.get("count"));
		model.addAttribute("profileIdInfo", profileIdInfo);
		model.addAttribute("profileId", profileId);
		// 피드관련
		model.addAttribute("myAllfeed", feedResult.get("myAllfeed"));
		model.addAttribute("myFeedCount", feedResult.get("myFeedCount"));
		return "myPage/userProfile";
	}//userProfile
	
	@RequestMapping("myPageFollowerList.cdd")
	public String myPageFollowerList(String userId, Model model) throws Exception{
		List followerList = myPageService.getFollowerList(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("followerList", followerList);
		return "myPage/myPageFollowerList";
	}
	
	@RequestMapping("myPageFollowList.cdd")
	public String myPageFollowList(String userId, Model model) throws Exception{
		List followList = myPageService.getfollowList(userId);
		model.addAttribute("followList", followList);
		return "myPage/myPageFollowList";
	}
	
	@RequestMapping("collection.cdd")
	public String collection(HttpSession session, Model model) throws Exception{
		String memId = (String)session.getAttribute("memId");
		List collectionList = myPageService.getCollectionList(memId);
		model.addAttribute("collections", collectionList);
		return "myPage/collection";
	}
	
	@RequestMapping("sendDm.cdd")
	public String sendDm(String sender, String receiver, String content) throws Exception{
		Map dmAttr = new HashMap();
		dmAttr.put("memId", sender);
		dmAttr.put("chatId", receiver);
		dmAttr.put("sendContent", content);
		mainService.insertDm(dmAttr);
		
		return "redirect:/dm.cdd";
	}
	
	
	
	// ================================ 펫 =========================================================

	// 펫정보 가입 폼 페이지
	@RequestMapping("petInfoForm.cdd")
	public String petInfoForm(Integer type_num ,Model model) throws Exception{
		System.out.println("petInfoForm 입성");
		//펫 종류와 펫 품종뿌려주기
		Map pettypes = petService.getPetType();
	
		model.addAttribute("pettype", pettypes.get("pettype"));
		
		return "/myPage/petInfoForm";
	}//petInfoTest
	
	// 펫정보 가입 처리 
	@RequestMapping("petInfoPro.cdd")	// Pet_SickDTO pet_SickDTO, Pet_JJDTO pet_JJDTO, Pet_SurgDTO pet_SurgDTO
	public String petInfoPro(Pet_InfoDTO pet_InfoDTO, MultipartHttpServletRequest request, Pet_SickDTO pet_SickDTO, Pet_JJDTO pet_JJDTO, Pet_SurgDTO pet_SurgDTO) throws Exception{
		// 펫 정보 저장(보유질환, 접종기록, 수술기록)
		petService.insertPetInfo(pet_InfoDTO, request, pet_SickDTO, pet_JJDTO, pet_SurgDTO);
		
		// userProfile 페이지로 변경
		return "redirect:/myPage/userProfile.cdd";
	}//petInfoPro
	
	// 펫 정보 보기 <본인> -> Modify , <이용자> -> View 페이지
	@RequestMapping("petInfoView.cdd")
	public String petViewForm(HttpServletRequest Requset, String profileId, Integer pet_number, Model model) throws Exception {		
		System.out.println("petInfoView 입성");
		Map<String, Object> pet_allInfo = new HashMap<String, Object>();
		// 펫 고유번호에 해당하는 정보 가져오기
		pet_allInfo = petService.getPetOneInfo(profileId, pet_number);
		String view = (String)pet_allInfo.get("view");
		model.addAttribute("pet_infoDTO", pet_allInfo.get("pet_infoDTO"));
		model.addAttribute("pet_sickDTOList", pet_allInfo.get("pet_sickDTOList"));
		model.addAttribute("pet_jjDTOList", pet_allInfo.get("pet_jjDTOList"));
		model.addAttribute("pet_surgDTOList", pet_allInfo.get("pet_surgDTOList"));
		model.addAttribute("pet_typeName", pet_allInfo.get("pet_typeName"));
		model.addAttribute("pet_kindName", pet_allInfo.get("pet_kindName"));
		
		model.addAttribute("sickCount", pet_allInfo.get("sickCount"));
		model.addAttribute("jjCount", pet_allInfo.get("jjCount"));
		model.addAttribute("surgCount", pet_allInfo.get("surgCount"));
		
		model.addAttribute("pet_number", pet_number);
		return view;
	}//petViewForm
	
	// 펫 이미지 업로드하기 (이미지 변경) ajax
	@ResponseBody
	@RequestMapping("pet_UploadImg.cdd")
	public String petUploadImg(MultipartHttpServletRequest request) throws Exception {
		System.out.println("업로드 이미지 입성");
		String result = petService.petUploadImg(request);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(result);
		
		return json;
	}//petUploadImg
	
	//펫 InfoModify Ajax 
	@RequestMapping("pet_InfoModify.cdd")
	public void petInfoModify(@RequestBody Map<Object, Object> data) throws Exception {
		petService.petModifyInfo(data);
		
	}//infoModify

	//펫 질환, 접종, 수술 추가사항 등록하기 Ajax
	@RequestMapping("pet_SickModify.cdd")
	public void petSickModify(@RequestBody Map<Object, Object> data) throws Exception {
		petService.petSickModify(data);
		
	}//petSickModify
	
	//펫 품종 변경 Ajax 
	@ResponseBody
	@RequestMapping("pet_kind.cdd")
	public String getPet_kind(@RequestBody Map<Object, Object> data) throws Exception{
		Integer type_num = Integer.parseInt(data.get("type_num").toString()); //문자열 변환 -> 정수로 변환
		ObjectMapper mapper = new ObjectMapper(); //JSon변환
		List<Object> petkinds = petService.getPetKind(type_num); //리스트로 받아온 데이텅 JSON 으로 넘겨주기
		String json = mapper.writeValueAsString(petkinds);
		
		return json;
	}//getPet_kind
	
	
	// ======================================== 추가 ====================================================
	
	// UserProfile ajax 해당날짜에 일지 or 일정 있는지
	@ResponseBody
	@RequestMapping("userProfileNoteScheduleList.cdd")
	public String userProfileNoteScheduleList(@RequestBody Map<Object, Object> data) throws Exception {
		Map map = myPageService.userProfileNoteScheduleList(data);
		
		ObjectMapper mapper = new ObjectMapper(); //JSon변환
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	// 펫의 해당하는 일정 가져오기 ajax [ 준용 ]
	@ResponseBody
	@RequestMapping("getScheduleNote.cdd")
	public String getScheduleNote(@RequestBody Map<Object, Object> data) throws Exception {
		Map<Object, Object> map = myPageService.getNoteScheduleList(data);
		
		//데이터 리턴
		ObjectMapper mapper = new ObjectMapper(); //JSon변환
		String json = mapper.writeValueAsString(map); //ajax success 시 보낼 데이터
		
		return json;
	}//getSchedule
	
	// ======================================== 일지 ====================================================
	// 일지 Form 페이지             #### 펫 정보 긁어와서 있는지 없는지 확인해야한다 ( 해당펫의 넘버가 필요하다 )
	@RequestMapping("noteWriteForm.cdd")
	public String noteWriteForm(Model model, String profileId) throws Exception{
		Map petInfo = petService.getPetInfoList(profileId);
		
		model.addAttribute("petInfoList", petInfo.get("petInfoList"));
		model.addAttribute("count", petInfo.get("count"));
		return "/myPage/noteWriteForm";
	}//noteWriteForm
	
	// 일지 처리
	@RequestMapping("noteWritePro.cdd")
	public String noteWritePro(NotesDTO notesDTO, Model model) throws Exception {
		myPageService.insertNote(notesDTO);
		
		return "redirect:/myPage/userProfile.cdd";
	}//noteWritePro
	
	// 일지 List 가져오기
	@RequestMapping("noteList.cdd")
	public String noteList(Model model) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map = myPageService.getNoteList();
		
		model.addAttribute("noteListCnt", map.get("noteListCnt"));
		model.addAttribute("noteList", map.get("noteList"));
		
		return "/myPage/noteList";
	}//noteList
	
	// 해당 일지 수정폼 
	@RequestMapping("noteModifyForm.cdd")
	public String noteModifyForm(Integer note_num, Model model) throws Exception {
		
		Map<Object,Object> map = myPageService.getPetOneNote(note_num);
		model.addAttribute("notesDTO", map.get("notesDTO"));
		model.addAttribute("pet_profile", map.get("pet_profile"));
		return "/myPage/noteModifyForm";
	}//noteModifyForm
	
	// 해당 일지 수정처리
	@RequestMapping("noteModifyPro.cdd")
	public String noteModifyPro(NotesDTO notesDTO, Integer note_emotionValue) throws Exception {
		myPageService.noteModify(notesDTO, note_emotionValue);
		
		return "redirect:/myPage/userProfile.cdd";
	}//noteModifyForm
	
	// 해당 일지 삭제 하기
	@ResponseBody
	@RequestMapping("deleteNote.cdd")
	public String noteDelete(@RequestBody Map<Object, Object> data) throws Exception {
		int deleteSuccessCnt = myPageService.deleteNote(data);
		
		ObjectMapper mapper = new ObjectMapper(); //JSon변환
		String json = mapper.writeValueAsString(deleteSuccessCnt);
		
		return json;
	}// noteDelete

	
	// ======================================== 일정 ====================================================
	
	// 일정 Form 페이지 [ 준용 ]
	@RequestMapping("scheAddForm.cdd")
	public String scheAddForm(Model model ,String profileId) throws Exception{
		Map petInfo = petService.getPetInfoList(profileId);
		
		model.addAttribute("petInfoList", petInfo.get("petInfoList"));
		model.addAttribute("count", petInfo.get("count"));
		return "/myPage/scheAddForm";
	}//scheAddForm
	
	// 일정 저장 [ 준용 ]
	@RequestMapping("scheAddPro.cdd")
	public String scheAddPro(SchedulesDTO schedulesDTO , Model model) throws Exception{
		myPageService.insertSchedule(schedulesDTO);
		
		return "redirect:/myPage/userProfile.cdd";
	}//scheAddPro
	
	
	// 해당유저 펫의 일정 리스트 [ 준용 ]
	@RequestMapping("scheduleListForm.cdd")
	public String scheduleListForm(Model model) throws Exception{
		Map<Object, Object> map = new HashMap<Object, Object>();
		map = myPageService.scheduleList();
		model.addAttribute("scheduleListCnt", map.get("scheduleListCnt"));
		model.addAttribute("scheduleList", map.get("scheduleList"));
		
		return "/myPage/scheduleListForm";
	}//scheduleListForm
	
	// 펫 수정 폼 [ 준용 ]
	@RequestMapping("scheModifyForm.cdd")
	public String scheModifyForm(Integer sche_num, Model model) throws Exception {
		System.out.println("sche_num : " + sche_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map = myPageService.petOneSchedule(sche_num);
		
		model.addAttribute("schedulesDTO", map.get("schedulesDTO"));
		model.addAttribute("pet_profile", map.get("pet_profile"));
		
		return "/myPage/scheModifyForm";
	}// scheModifyForm
	
	// 펫 수정 처리 [ 준용 ] 
	@RequestMapping("scheModifyPro.cdd")
	public String scheModifyPro(SchedulesDTO schedulesDTO,String sche_dateModify) throws Exception {
		if(sche_dateModify != "") {
			schedulesDTO.setSche_date(sche_dateModify);
		}
		myPageService.scheduleModify(schedulesDTO);
		
		return "redirect:/myPage/userProfile.cdd"; 
	}//scheModifyPro
	
	// 펫 삭제 [ 준용 ]
	@ResponseBody
	@RequestMapping("deleteSchedule.cdd")
	public String deleteSchedule(@RequestBody Map<Object, Object> data) throws Exception{
		int deleteSuccessCnt = myPageService.deleteSchedule(data);
		ObjectMapper mapper = new ObjectMapper(); //JSon변환
		String json = mapper.writeValueAsString(deleteSuccessCnt);
		
		return json;
	}//deleteSchedule
	
	// 마이페이지 스크롤내려오면 피드추가
	@ResponseBody
	@RequestMapping(value = "appendMyFeeds.cdd", method = RequestMethod.POST)
	public String appendMyFeeds(@RequestBody Map<Object, Object> map, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("여기안와??");
		String user_id = map.get("profileId").toString();
		int pageNum = Integer.parseInt(map.get("pageNum").toString());
		ObjectMapper mapper = new ObjectMapper();
		Map jsonMap = myPageService.getMyAllFeed(user_id, pageNum);
		String json = mapper.writeValueAsString(jsonMap);
		
		return json; 
	}
	
	
	// ============================================================================================
	
	
	
	
}//MyPageController

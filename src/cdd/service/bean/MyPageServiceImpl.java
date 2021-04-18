package cdd.service.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cdd.model.dao.MyPageDAO;
import cdd.model.dao.PetDAO;
import cdd.model.dto.NotesDTO;
import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.ScheduleListDTO;
import cdd.model.dto.SchedulesDTO;
import cdd.model.dao.CollectionDAO;
import cdd.model.dao.FeedsDAO;
import cdd.model.dao.FollowsDAO;
import cdd.model.dao.UserDAO;
import cdd.model.dto.UserDTO;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired
	private MyPageDAO myPageDAO = null;
	@Autowired
	private CollectionDAO collectionDAO = null;
	@Autowired
	private FeedsDAO feedsDAO = null;
	@Autowired 
	private UserDAO userDAO = null;
	@Autowired
	private FollowsDAO followsDAO = null;
	@Autowired
	private PetDAO petDAO = null;
	
	// 저장된 북마크 가져오기 [선준]
	@Override
	public List getCollectionList(String memId) throws Exception {
		List collections = collectionDAO.getCollectionFeedNum(memId);
		List collectionList = feedsDAO.getCollectionList(collections);
		
		return collectionList;
	}
	
	// 프로필 id, 유저 이름, 소개글, 게시물, 팔로워, 팔로워 수 가져오기 [선준]
	@Override
	public Map getProfileIdInfo(String profileId) throws Exception {
		Map profileidInfo = new HashMap();
		Integer feedCnt = 0;
		Integer flwCnt = 0;
		Integer flwerCnt = 0;
		if(profileId == null) {
			profileId = getSessionId();
			UserDTO userInfo = userDAO.getMember(profileId);
			feedCnt = feedsDAO.getFeedCnt(profileId);
			flwCnt = followsDAO.getFlwCnt(profileId);
			flwerCnt = followsDAO.getFlwerCnt(profileId);
			
			profileidInfo.put("userInfo", userInfo);
			profileidInfo.put("feedCnt", feedCnt);
			profileidInfo.put("flwCnt", flwCnt);
			profileidInfo.put("flwerCnt", flwerCnt);
		}else {
			UserDTO userInfo = userDAO.getMember(profileId);
			feedCnt = feedsDAO.getFeedCnt(profileId);
			flwCnt = followsDAO.getFlwCnt(profileId);
			flwerCnt = followsDAO.getFlwerCnt(profileId);
			Integer flwCh = followsDAO.followCheck(profileId, getSessionId());
			
			profileidInfo.put("userInfo", userInfo);
			profileidInfo.put("feedCnt", feedCnt);
			profileidInfo.put("flwCnt", flwCnt);
			profileidInfo.put("flwerCnt", flwerCnt);
			profileidInfo.put("flwCh", flwCh);
		}
		return profileidInfo;
	}
	
	// 팔로워 리스트 가져오기
	@Override
	public List getFollowerList(String userId) throws Exception {
		List followerList = followsDAO.getFollowerList(userId);
		return followerList;
	}
	
	// 팔로우 리스트 가져오기
	@Override
	public List getfollowList(String userId) throws Exception {
		List followList = followsDAO.getFollowList(userId);
		return followList;
	}

	
	
	
	
	
	
	
	
	
	//============================================================= 추가 ============================================
	
	// 유저의 펫 일정 일지 모두 가져오기 [ 준용 ]  UserProfile페이지 달력 클릭시 사용 ajax
	@Override
	public Map<Object, Object> getNoteScheduleList(Map<Object, Object> data) throws Exception {
		System.out.println("Service : 입성" );
		
		
		// 일정 가져오기 List
		String clickDay = (String)data.get("clickday");						// 넘어온 날짜
		System.out.println(clickDay);
		Integer pet_num = Integer.parseInt(data.get("pet_num").toString());		// 펫 넘버
		List<SchedulesDTO> scheduleList = new ArrayList<SchedulesDTO>();						
		Map<Object, Object> map = new HashMap<Object, Object>();
		NotesDTO notesDTO = null;
		
		// 펫의 해당하는 일정이 있는지 확인
		int scheduleCnt = myPageDAO.petScheduleCount(pet_num);	// 펫 일정 카운트
		if(scheduleCnt > 0) {
			scheduleList = myPageDAO.getScheduleList(clickDay, pet_num);
		}//if
		
		// 펫의 해당하는 일지가 있는지 확인 카운트
		int petNoteCount = myPageDAO.getPetNoteCount(pet_num, clickDay);
		// 펫 해당 날짜 일지 가져오기
		if(petNoteCount > 0) {
			notesDTO = myPageDAO.getPetNote(pet_num, clickDay);
		}//if
		
		map.put("scheduleCnt", scheduleCnt);	// 스케줄 카운트
		map.put("scheduleList", scheduleList);	// 스케줄 리스트
		map.put("petNoteCount", petNoteCount);  // 일지 카운트
		map.put("notesDTO", notesDTO);
		
		return map;
	}//getScheduleList
	
	
	// UserProfile ajax 해당날짜에 일지 or 일정 있는지
	@Override
	public Map<Object, Object> userProfileNoteScheduleList(Map<Object,Object> data) throws Exception {
		System.out.println("userProfile 일지,일정 찍기 들어옴");
		Map<Object, Object> map = new HashMap<Object, Object>();
		String user_id = (String)data.get("profileId");
		System.out.println("profileId : " + user_id);
		List<Object> userNoteList = null;
		List<Object> userScheduleList = null;
		
		int notesCount = -1;
		int scheduleCount = -1;
		if(user_id == null) {
			notesCount = myPageDAO.userProfileNoteCount(getSessionId());
			if(notesCount > 0) {
				userNoteList = myPageDAO.userProfileNoteList(getSessionId());
			}//if
			
			scheduleCount = myPageDAO.userProfileSchedulesCount(getSessionId());
			if(scheduleCount > 0) {
				userScheduleList = myPageDAO.userProfileSchedulesList(getSessionId());
			}//if
			
		}else {
			notesCount = myPageDAO.userProfileNoteCount(user_id);
			if(notesCount > 0) {
				userNoteList = myPageDAO.userProfileNoteList(user_id);
			}//if
			
			scheduleCount = myPageDAO.userProfileSchedulesCount(user_id);
			if(scheduleCount > 0) {
				userScheduleList = myPageDAO.userProfileSchedulesList(user_id);
			}//if
		}//else
		
		map.put("notesCount", notesCount);
		map.put("scheduleCount", scheduleCount);
		map.put("userNoteList", userNoteList);	
		map.put("userScheduleList", userScheduleList);	
		
		return map;
	}//userProfileNoteScheduleList
	
	
	
	
	
	//============================================================= 일지 관련 ============================================
	
	//일지 등록 [ 준용 ]
	@Override
	public void insertNote(NotesDTO notesDTO) throws Exception {
		System.out.println("service 입성");
		notesDTO.setUser_id(getSessionId());	// 세션아이디
		if(notesDTO.getNote_bath() == null) {
			notesDTO.setNote_bath(1);
		}
		myPageDAO.insertNote(notesDTO); 
	}// insertNote
	
	// 유저 일지 모두 가져오기 [ 준용 ] 
	@Override
	public Map<Object, Object> getNoteList() throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		int noteListCnt = myPageDAO.getNoteListCnt(getSessionId());
		if(noteListCnt > 0) {
			List<Object> noteList = myPageDAO.getNoteList(getSessionId());
			map.put("noteList", noteList);
			
		}
		map.put("noteListCnt", noteListCnt);
		
		return map;
	}//getNoteList
	
	// 펫 일지 수정(1개) 정보 가져오기 [ 준용 ]
	@Override
	public Map<Object, Object> getPetOneNote(Integer note_num) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		NotesDTO notesDTO = myPageDAO.getPetOneNote(note_num);
		// 해당 펫 이미지 가져오기
		Pet_InfoDTO pet_infoDTO = new Pet_InfoDTO();
		pet_infoDTO.setUser_id(getSessionId());
		pet_infoDTO.setPet_number(notesDTO.getPet_num());
		String pet_profile = petDAO.getPetImg(pet_infoDTO);
		
		map.put("notesDTO", notesDTO);
		map.put("pet_profile", pet_profile);
		
		return map;
	}//getPetOneNote
	
	// 펫 일지 수정 [ 준용 ]
	@Override
	public void noteModify(NotesDTO notesDTO, Integer note_emotionValue) throws Exception {
		myPageDAO.noteModify(notesDTO);
	}//noteModify
	
	// 펫 일지 삭제	[ 준용 ]
	@Override
	public int deleteNote(Map<Object, Object> data) throws Exception {
		System.out.println("myPageService 일지 삭제 입성 " + Integer.parseInt(data.get("note_num").toString()));
		int deleteSuccessCnt = myPageDAO.deleteNote(Integer.parseInt(data.get("note_num").toString()));
		return deleteSuccessCnt;
	}//deleteNote
	
	//============================================================= 일정 관련 ============================================
	
	// 일정 등록 [ 준용 ]
	@Override
	public void insertSchedule(SchedulesDTO schedulesDTO) throws Exception {
		schedulesDTO.setUser_id(getSessionId());
		myPageDAO.insertSchedule(schedulesDTO);
	}//insertSchedule
	
	// 유저 펫 일정 리스트 가져오기 [ 준용 ]
	@Override
	public Map<Object, Object> scheduleList() throws Exception {
		String user_id = getSessionId();
		List<ScheduleListDTO> scheduleList = new ArrayList<ScheduleListDTO>();
		Map<Object, Object> map = new HashMap<Object, Object>();
		int scheduleListCnt = myPageDAO.scheduleListCnt(user_id);
		
		// 카운트가 있다면
		if(scheduleListCnt > 0) {
			scheduleList = myPageDAO.scheduleList(user_id);
		}//if
		
		map.put("scheduleListCnt", scheduleListCnt);
		map.put("scheduleList", scheduleList);
		
		return map;
	}//scheduleList
	
	// 펫 일정 수정(1개) 정보 가져오기 [ 준용 ]
	@Override
	public Map<String, Object> petOneSchedule(Integer sche_num) throws Exception {
		System.out.println(" petOne 입성 ");
		Map<String, Object> map = new HashMap<String, Object>();
		SchedulesDTO schedulesDTO = myPageDAO.petOneSchedule(sche_num);
		
		// 해당 펫 이미지 가져오기
		Pet_InfoDTO pet_infoDTO = new Pet_InfoDTO();
		pet_infoDTO.setUser_id(getSessionId());
		pet_infoDTO.setPet_number(schedulesDTO.getPet_num());
		String pet_profile = petDAO.getPetImg(pet_infoDTO);
		
		map.put("schedulesDTO", schedulesDTO);
		map.put("pet_profile", pet_profile);
		
		return map;
	}
	
	// 펫 일정 수정 [ 준용 ]
	@Override
	public void scheduleModify(SchedulesDTO schedulesDTO) throws Exception {
		myPageDAO.scheduleModify(schedulesDTO);
	}//scheduleModify
	
	// 펫 일정 삭제	[ 준용 ]
	@Override
	public int deleteSchedule(Map<Object, Object> data) throws Exception {
		Integer sche_num = Integer.parseInt(data.get("sche_num").toString());
		
		int deleteSuccessCnt = myPageDAO.deleteSchedule(sche_num);	// 펫 고유 번호, 날짜, 시간데이터 넘기고 삭제
		
		return deleteSuccessCnt;
	}//deleteSchedule
	
	// 세션 가져오기
	
	//세션
	public String getSessionId() {
		HttpSession session = (((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest()).getSession();
		
		return (String)session.getAttribute("memId");
	}//getSessionId
	
	@Override
	public Map getMyAllFeed(String user_id, Integer pageNum) throws Exception {
		String my_Id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		
		
		Map result = new HashMap();
		
		int feedView = 9;
		int startRow = (pageNum - 1) * feedView + 1;
		int endRow = startRow + feedView - 1;
		int myCh = 0;
		/// 여기 아래  nullpoint
		if(user_id == null) {
			user_id = my_Id;
		}
		if(!user_id.equals(my_Id)) {
			myCh = 1;
		}
		
		
		List myAllfeed = feedsDAO.getMyAllFeed(user_id, startRow, endRow, myCh);
		Integer myFeedCount = feedsDAO.getMyFeedCount(user_id, myCh);
		result.put("myAllfeed", myAllfeed);
		result.put("myFeedCount" , myFeedCount);
		
		return result;
	}
	
	
}//MyPageServiceImpl

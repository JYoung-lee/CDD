package cdd.service.bean;

import java.util.List;
import java.util.Map;

import cdd.model.dto.NotesDTO;
import cdd.model.dto.SchedulesDTO;

public interface MyPageService {
	
	// 저장된 북마크 가져오기 [선준]
	public List getCollectionList(String memId) throws Exception;
	
	// 프로필 id, 게시물, 팔로워, 팔로워 수, 유저 이름, 소개글 가져오기 [선준]
	public Map getProfileIdInfo(String profileId) throws Exception;
	
	// 팔로워 리스트 가져오기
	public List getFollowerList(String userId) throws Exception;
	
	// 팔로우 리스트 가져오기
	public List getfollowList(String userId) throws Exception;
	
	
	//=============================================================  추가  ============================================
	// 펫의 해당 하는 일정,일지  가져오기  ajax[ 준용 ]
	public Map<Object, Object> getNoteScheduleList(Map<Object, Object> data) throws Exception;
	
	// UserProfile ajax 해당날짜에 일지 or 일정 있는지
	public Map<Object, Object> userProfileNoteScheduleList(Map<Object,Object> data) throws Exception;
	
	
	//============================================================= 일지 관련 ============================================
	
	// 일지 등록 [ 준용 ]
	public void insertNote(NotesDTO notedto) throws Exception;
	
	// 유저 일지 모두 가져오기 [ 준용 ] 
	public Map<Object, Object> getNoteList() throws Exception;
	
	// 펫 일지 수정(1개) 정보 가져오기 [ 준용 ]
	public Map<Object, Object> getPetOneNote(Integer note_num) throws Exception;
	
	// 펫 일지 수정 [ 준용 ]
	public void noteModify(NotesDTO notesDTO, Integer note_emotionValue) throws Exception;
	
	
	// 펫 일지 삭제	[ 준용 ]
	public int deleteNote(Map<Object,Object> data) throws Exception;
	
	
	//============================================================= 일정 관련 ============================================
	
	// 일정 등록 [ 준용 ]
	public void insertSchedule(SchedulesDTO schedulesDTO) throws Exception;
	
	// 유저 펫 일정 리스트 가져오기 [ 준용 ]
	public Map<Object, Object> scheduleList() throws Exception;
	
	// 펫 일정 수정 정보 가져오기 [ 준용 ]
	public Map<String, Object> petOneSchedule(Integer sche_num) throws Exception;
	
	// 펫 일정 수정
	public void scheduleModify(SchedulesDTO schedulesDTO) throws Exception;
	
	// 펫 일정 삭제
	public int deleteSchedule(Map<Object, Object> data) throws Exception;
	public Map getMyAllFeed(String user_id,Integer pageNum) throws Exception;
	
}//MyPageService

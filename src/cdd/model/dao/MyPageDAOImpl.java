package cdd.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cdd.model.dto.NotesDTO;
import cdd.model.dto.ScheduleListDTO;
import cdd.model.dto.SchedulesDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO{
	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	//============================================================= 추가 ============================================
	
	// UserProfile 사용 해당 유저의 일지 전부 카운트
	@Override
	public int userProfileNoteCount(String user_id) throws SQLException {
		int notesCount = sqlSession.selectOne("myPage.userProfileNoteCount", user_id);
		return notesCount;
	}//userProfileNoteCount
	
	// UserProfile 사용 해당 유저의 일지 전부 가져오기
	@Override
	public List<Object> userProfileNoteList(String user_id) throws SQLException {
		List<Object> userNoteList = sqlSession.selectList("myPage.userProfileNoteList", user_id);
		return userNoteList;
	}//userProfileNoteList
	
	// UserProfile 사용 해당 유저의 일정 전부 카운트
	@Override
	public int userProfileSchedulesCount(String user_id) throws SQLException {
		int scheduleCount = sqlSession.selectOne("myPage.userProfileSchedulesCount", user_id);
		return scheduleCount;
	}//userProfileSchedulesCount
	
	// UserProfile 사용 해당 유저의 일정 전부 가져오기
	@Override
	public List<Object> userProfileSchedulesList(String user_id) throws SQLException {
		List<Object> userScheduleList = sqlSession.selectList("myPage.userProfileSchedulesList", user_id);
		return userScheduleList;
	}//userProfileSchedulesList
	
	
	//============================================================= 일지 관련 ============================================
	
	//일지 등록 [ 준용 ]
	@Override
	public void insertNote(NotesDTO notesdto) throws SQLException {
			sqlSession.insert("myPage.insertNote", notesdto); 
	}//insertNote
	
	// 펫 일지 카운트  [ 준용 ]
	@Override
	public int getPetNoteCount(Integer pet_num, String clickDay) throws SQLException {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("pet_num", pet_num);
		map.put("clickDay", clickDay);
		
		int petNoteCount = sqlSession.selectOne("myPage.getPetNoteCount", map);
		return petNoteCount;
	}//getPetNoteCount
	
	// 펫 해당 날짜 일지 가져오기 [ 준용 ]
	@Override
	public NotesDTO getPetNote(Integer pet_num, String clickDay) throws SQLException {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("pet_num", pet_num);
		map.put("clickDay", clickDay);
		
		NotesDTO notesDTO = sqlSession.selectOne("myPage.getPetNote", map);
		return notesDTO;
	}//getPetNoteCount
	
	
	
	// 유저 일지 총 카운트
	@Override
	public int getNoteListCnt(String user_id) throws SQLException {
			int noteListCnt = sqlSession.selectOne("myPage.getNoteListCnt", user_id);
		return noteListCnt;
	}//getNoteListCnt
	
	// 유저 일지 모두 가져오기 [ 준용 ] 
	@Override
	public List<Object> getNoteList(String user_id) throws SQLException {
			List<Object> noteList = sqlSession.selectList("myPage.getNoteList", user_id);
		return noteList;
	}//getNoteList
	
	// 펫 일지 수정(1개) 정보 가져오기 [ 준용 ]
	@Override
	public NotesDTO getPetOneNote(Integer note_num) throws Exception {
		NotesDTO notesDTO = sqlSession.selectOne("getPetOneNote", note_num);
		
		return notesDTO;
	}//getPetOneNote
	
	// 펫 일지 수정 [ 준용 ]
	@Override
	public void noteModify(NotesDTO notesDTO) throws SQLException {
		sqlSession.update("myPage.noteModify", notesDTO);
	}//noteModify
	
	// 펫 일지 삭제	[ 준용 ]
	@Override
	public int deleteNote(Integer note_num) throws SQLException {
		int deleteSuccessCnt = sqlSession.delete("myPage.deleteNote", note_num);
		return deleteSuccessCnt;
	}//deleteNote
	
	//============================================================= 일정 관련 ============================================
	
	// 일정 등록 [ 준용 ]
	@Override
	public int insertSchedule(SchedulesDTO schedulesDTO) throws SQLException {
		int cnt = sqlSession.insert("myPage.insertSchedule", schedulesDTO);
		return cnt;
	}//insertSchedule
	
	// 펫 일정 카운트 [ 준용 ]
	@Override
	public int petScheduleCount(Integer pet_num) throws SQLException {
		int scheduleCnt = sqlSession.selectOne("myPage.petScheduleCount", pet_num);
		return scheduleCnt;
	}
	
	// 펫의 해당 하는 일정 가져오기 [ 준용 ]
	@Override
	public List<SchedulesDTO> getScheduleList(String clickDay, Integer pet_num) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clickDay", clickDay);
		map.put("pet_num", pet_num);
		List<SchedulesDTO> scheduleList = sqlSession.selectList("myPage.getScheduleList", map);
		return scheduleList;
	}//getScheduleList
	
	//유저 펫 일정 총 카운트 [ 준용 ]
	@Override
	public int scheduleListCnt(String user_id) throws SQLException {
		int scheduleListCnt = sqlSession.selectOne("myPage.scheduleListCnt", user_id);
		return scheduleListCnt;
	}//scheduleListCnt
	
	// 유저 펫 일정 리스트 가져오기 [ 준용 ]
	@Override
	public List<ScheduleListDTO> scheduleList(String user_id) throws SQLException {
		List<ScheduleListDTO> scheduleList = new ArrayList<ScheduleListDTO>();
		scheduleList = sqlSession.selectList("myPage.scheduleList", user_id);
		
		return scheduleList;
	}//scheduleList
	
	// 펫 일정 수정 정보 가져오기 [ 준용 ]
	@Override
	public SchedulesDTO petOneSchedule(Integer sche_num) throws SQLException {
		SchedulesDTO petOneSchedule = sqlSession.selectOne("myPage.petOneSchedule",sche_num); 
		return petOneSchedule;
	}//petOneSchedule
	
	// 핏 일정 수정
	@Override
	public void scheduleModify(SchedulesDTO schedulesDTO) throws SQLException {
		sqlSession.update("myPage.scheduleModify", schedulesDTO);
		
	}//scheduleModify
	
	// 펫 일정 삭제
	@Override
	public int deleteSchedule(Integer sche_num) throws SQLException {
		int deleteSuccessCnt = sqlSession.delete("myPage.deleteSchedule", sche_num);
		
		return deleteSuccessCnt;
	}//deleteSchedule
	
}//implements

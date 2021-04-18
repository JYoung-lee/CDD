package cdd.model.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cdd.model.dto.NotesDTO;
import cdd.model.dto.ScheduleListDTO;
import cdd.model.dto.SchedulesDTO;

public interface MyPageDAO {
	
	//============================================================= 추가  ============================================
	
	// UserProfile 사용 해당 유저의 일지 전부 카운트
	public int userProfileNoteCount(String user_id) throws SQLException;
	// UserProfile 사용 해당 유저의 일지 전부 가져오기
	public List<Object> userProfileNoteList(String user_id) throws SQLException;
	// UserProfile 사용 해당 유저의 일정 전부 카운트
	public int userProfileSchedulesCount(String user_id) throws SQLException;
	// UserProfile 사용 해당 유저의 일정 전부 가져오기
	public List<Object> userProfileSchedulesList(String user_id) throws SQLException;
	
	
	
	//============================================================= 일지 관련 ============================================
	
	// 일지 등록 [ 준용 ]
	public void insertNote(NotesDTO notedto) throws SQLException;

	// 펫 일지 카운트  [ 준용 ]
	public int getPetNoteCount(Integer pet_num, String clickDay) throws SQLException;
	
	// 펫 해당 날짜 일지 가져오기 [ 준용 ]
	public NotesDTO getPetNote(Integer pet_num, String clickDay) throws SQLException;
	
	// 유저 일지 총 카운트	[준용 ]
	public int getNoteListCnt(String user_id) throws SQLException;
	
	// 유저 일지 모두 가져오기 [ 준용 ] 
	public List<Object> getNoteList(String user_id) throws SQLException;
	
	// 펫 일지 수정(1개) 정보 가져오기 [ 준용 ]
	public NotesDTO getPetOneNote(Integer note_num) throws Exception;
	
	// 펫 일지 수정 [ 준용 ]
	public void noteModify(NotesDTO notesDTO) throws SQLException;

	// 펫 일지 삭제	[ 준용 ]
	public int deleteNote(Integer note_num) throws SQLException;
		
	//============================================================= 일정 관련 ============================================
	
	// 일정 등록 [ 준용 ]
	public int insertSchedule(SchedulesDTO schedulesDTO) throws SQLException;
	
	// 펫 일정 카운트 [ 준용 ]
	public int petScheduleCount(Integer pet_num) throws SQLException;
	
	// 유저의 펫 해당 일정 모두 가져오기 [ 준용 ]
	public List<SchedulesDTO> getScheduleList(String clickDay, Integer pet_num) throws SQLException;
	
	// 유저 펫 일정 총 카운트 [ 준용 ]
	public int scheduleListCnt(String user_id) throws SQLException;
	
	// 유저 펫 일정 리스트 가져오기 [ 준용 ]
	public List<ScheduleListDTO> scheduleList(String user_id) throws SQLException;
	
	// 펫 일정 수정 정보(1개) 가져오기 [ 준용 ]
	public SchedulesDTO petOneSchedule(Integer sche_num) throws SQLException;
	
	// 펫 일정 수정 [ 준용 ]
	public void scheduleModify(SchedulesDTO schedulesDTO) throws SQLException;
	
	// 펫 일정 삭제 [ 준용 ]
	public int deleteSchedule(Integer sche_num) throws SQLException;

	
}//MyPageDAO

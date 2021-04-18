package cdd.service.bean;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import cdd.model.dto.UserDTO;

public interface MainService {
	// 팔로우 리스트 가져오기 [선준]
	public List getFollowList(String id) throws Exception;
	
	// 대화 이력이 있는 유저 리스트 가져오기 [선준]
	public Map getChatUserAndStatus(String currId) throws Exception;
	
	// 다른 유저와의 dm리스트 가져오기 [선준]
	public List getDmList(String chatId, String memId) throws Exception;
	
	// 특정 유저 정보 가져오기 [선준]
	public UserDTO getUserInfo(String id) throws Exception;
	
	// dm 삽입 [선준]
	public void insertDm(Map dmAttr) throws Exception;
	
	// dm 삭제 [선준]
	public void deleteDm(Map users) throws Exception;
	
	// alarm 가져오기 [선준]
	public List getAlarms(String sessId) throws Exception;
	
	// 확인안한 dm 개수 가져오기 [선준]
	public Integer getUnChDmCnt(String memId) throws Exception;
	
	// dm Status 칼럼 update [선준]
	public void updateStatus(String chatId, String memId) throws Exception;
	
	// 해시태그 검색 결과 가져오기 [선준]
	public Map getSearchTags(String search, String memId) throws Exception;
	
	// 피드 검색 결과 가져오기 [선준]
	public List getSearchFeeds(String search, String memId) throws Exception;
	
	// 사용자 검색 결과 가져오기 [선준]
	public List getSearchUsers(String search) throws Exception;
	
	// 미확인 alarm 개수 가져오기 [선준]
	public Integer getUnChAlrmCnt(String memId) throws Exception;
	
	// alarms 테이블의 status 칼럼 값 변경
	public void updateAlarmStatus(String memId) throws Exception;
	
	// 메인첫페이지에서 팔로우한 사람들의 게시글 불러오기 [3.31 훈영 추가]
	public Map followsMainFeed(String user_id, int pageNum) throws Exception;
	
	// mainAllFeed 
	
	public Map getMainAllFeed(Integer pageNum) throws Exception;
}

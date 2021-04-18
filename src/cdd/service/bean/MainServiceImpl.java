package cdd.service.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cdd.model.dao.AlarmsDAO;
import cdd.model.dao.DmDAO;
import cdd.model.dao.DmUserRecDAO;
import cdd.model.dao.FeedsDAO;
import cdd.model.dao.FollowsDAO;
import cdd.model.dao.UserDAO;
import cdd.model.dto.FeedsAndPhotoDTO;
import cdd.model.dto.FeedsDTO;
import cdd.model.dto.UserDTO;

@Service
public class MainServiceImpl implements MainService{
	@Autowired
	private FollowsDAO followDAO = null;
	@Autowired
	private DmDAO dmDAO = null;
	@Autowired
	private DmUserRecDAO dmUserRecDAO = null;
	@Autowired
	private UserDAO userDAO = null;
	@Autowired
	private AlarmsDAO alarmsDAO = null;
	@Autowired
	private FeedsDAO feedsDAO = null;
	
	// 팔로우 리스트 가져오기 [선준]
	@Override
	public List getFollowList(String id) throws Exception{
		List followList = followDAO.getFollowList(id);
		return followList;
	}
	
	// 대화 이력이 있는 유저 리스트 가져오기 [선준]
	@Override
	public Map getChatUserAndStatus(String currId) throws Exception{
		
		List chatUserList = dmUserRecDAO.getChatUserList(currId);
		List chatStatus = dmDAO.getChatStatus(chatUserList, currId);
		Map chatUserAndStatus = new HashMap();
		
		for(int i=0; i<chatUserList.size(); i++) {
			chatUserAndStatus.put(chatUserList.get(i), chatStatus.get(i));
		}
		
		return chatUserAndStatus;
	}
	
	// 다른 유저와의 dm리스트 가져오기 [선준]
	@Override
	public List getDmList(String chatId, String memId) throws Exception{
		List dmList = dmDAO.getDmList(chatId, memId);
		return dmList;
	}
	
	// 특정 유저 정보 가져오기 [선준]
	@Override
	public UserDTO getUserInfo(String id) throws Exception{
		UserDTO user = userDAO.getMember(id);
		return user;
	}
	
	// dm 삽입 [선준]
	@Override
	public void insertDm(Map dmAttr) throws Exception {
		dmUserRecDAO.insertRec(dmAttr);
		dmDAO.insertDm(dmAttr);
	}
	
	// dm 삭제 [선준]
	@Override
	public void deleteDm(Map users) throws Exception {
		dmUserRecDAO.deleteRec(users);
		dmDAO.deleteDm(users);
		
	}
	
	// alarm 가져오기 [선준]
	@Override
	public List getAlarms(String sessId) throws Exception {
		List alarms = alarmsDAO.getAlarms(sessId);
		
		return alarms;
	}
	
	// 확인안한 dm 개수 가져오기 [선준]
	@Override
	public Integer getUnChDmCnt(String memId) throws Exception {
		int res = dmDAO.getUnChDmCnt(memId);
		return res;
	}
	
	// dm Status 칼럼 update [선준]
	@Override
	public void updateStatus(String chatId, String memId) throws Exception {
		dmDAO.updateStatus(chatId, memId);
	}
	
	// 해시태그 검색 결과 가져오기 [선준]
	@Override
	public Map getSearchTags(String search, String memId) throws Exception {
		// 태그 검색결과 list로 가져오기
		List searchTags = feedsDAO.getSearchTagList(search);
		Integer searchTagCount = feedsDAO.searchTagCount(search);
		Map hashResult = new HashMap();
		
		hashResult.put("searchTags", searchTags);
		hashResult.put("searchTagCount", searchTagCount);
		
		return hashResult;
	}
	
	// 피드 검색 결과 가져오기 [선준]
	@Override
	public List getSearchFeeds(String search, String memId) throws Exception {
		// 피드 검색 결과 가져오기
		List searchFeeds = feedsDAO.getSearchFeedList(search);
		for(int i=0; i<searchFeeds.size(); i++) {
			FeedsAndPhotoDTO f = (FeedsAndPhotoDTO)searchFeeds.get(i);
			// 팔로우 여부 확인
			if(f.getFeed_secret() == 1) {
				Integer res = followDAO.followCheck(f.getUser_id(), memId);
				if(res == 0) {
					searchFeeds.remove(i);
				}
			}
		}
		return searchFeeds;
	}
	
	// 사용자 검색 결과 가져오기 [선준]
	@Override
	public List getSearchUsers(String search) throws Exception {
		// 사용자 검색 결과 가져오기
		List searchUsers = userDAO.getSearchUsers(search);
		return searchUsers;
	}
	
	// 미확인 alarm 개수 가져오기 [선준]
	@Override
	public Integer getUnChAlrmCnt(String memId) throws Exception {
		int alarmCnt = alarmsDAO.getUnChAlrmCnt(memId);
		
		return alarmCnt;
	}
	
	// alarms 테이블의 status 칼럼 값 변경
	@Override
	public void updateAlarmStatus(String memId) throws Exception {
		alarmsDAO.updateAlarmStatus(memId);
	}
	
	@Override // [3.31 오훈영 추가]
	public Map followsMainFeed(String user_id, int pageNum) throws Exception {
		
		int feedView = 10;
		int startRow = (pageNum - 1) * feedView + 1;
		int endRow = startRow + feedView - 1;
		
		Map result = new HashMap();
		List follwofeedList = feedsDAO.followsMainFeed(user_id, startRow, endRow);
		Integer mainFeedCount = feedsDAO.countFollwsMainFeed(user_id);
		
		
		
		result.put("follwofeedList", follwofeedList);
		result.put("mainFeedCount", mainFeedCount);
		result.put("user_id", user_id);
		for(int i=0; i < follwofeedList.size(); i++) {
			FeedsDTO dto = (FeedsDTO)follwofeedList.get(i);
			dto.setBookCh(feedsDAO.bookCh(user_id, dto.getFeed_num()));
			dto.setLikeCh(feedsDAO.likeCh(dto.getFeed_num(), user_id));
			dto.setLikeCount(feedsDAO.countLikes(dto.getFeed_num()));
			follwofeedList.set(i, dto);
			result.put(dto.getFeed_num(), feedsDAO.getPhotos(dto.getFeed_num()));
			
		}
		return result;
	}
	
	// 메인올피드 가져오기
	@Override
	public Map getMainAllFeed(Integer pageNum) throws Exception {
		Map result = new HashMap();
		
		int feedView = 15;
		int startRow = (pageNum - 1) * feedView + 1;
		int endRow = startRow + feedView - 1;
		
		
		List mainAllFeed = feedsDAO.getMainAllFeed(startRow, endRow);
		Integer allCount = feedsDAO.getMainAllCount();
		
		result.put("mainAllFeed", mainAllFeed);
		result.put("allCount", allCount);
		return result;
	}
}

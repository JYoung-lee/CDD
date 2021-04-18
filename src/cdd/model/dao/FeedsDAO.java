package cdd.model.dao;

import java.util.List;
import java.util.Map;

import cdd.model.dto.Feed_PhotosDTO;
import cdd.model.dto.FeedsDTO;
import cdd.model.dto.Get_RepliesDTO;

public interface FeedsDAO {
	public void feedWrite(FeedsDTO dto, List<Feed_PhotosDTO> photos) throws Exception;
	public Integer nextFeedNum() throws Exception;
	public FeedsDTO getFeed(Integer feed_num) throws Exception;
	public List getPhotos(Integer feed_num) throws Exception;
	public void insertReply(Map <Object, Object> map) throws Exception;
	public List<Get_RepliesDTO> getReplies(int feed_num) throws Exception;
	public Integer likeCh(int feed_num, String user_id) throws Exception;
	public void insertLike(int feed_num, String user_id) throws Exception;
	public void deleteLike(int feed_num, String user_id) throws Exception;
	public Integer countLikes(int feed_num) throws Exception;
	public void insertFollow(String user_from, String user_to) throws Exception;
	public Integer followCh(String user_from, String user_to) throws Exception;
	public void deleteFollow(String user_from, String user_to) throws Exception;
	public Integer bookCh(String user_id, Integer feed_num) throws Exception;
	public void insertBookmark(String user_id, Integer feed_num) throws Exception;
	public void deleteBookmark(String user_id, Integer feed_num) throws Exception;
	
	// 메인올피드 가져오기 [훈영]
	public List getMainAllFeed(Integer startRow, Integer endRow) throws Exception;
	
	// 메인올피드 갯수 가져오기 [훈영]
	public Integer getMainAllCount();
	
	// 해시태그 검색결과 가져오기 [선준]
	public List getSearchTagList(String search) throws Exception;
	
	// 해시태그 검색갯수 가져오기 [훈영]
	public Integer searchTagCount(String search) throws Exception;
	
	// 피드 검색결과 가져오기 [선준]
	public List getSearchFeedList(String search) throws Exception;
	
	// feed_num 으로 피드 리스트 가져오기 [선준]
	public List getCollectionList(List collections) throws Exception;
	
	// 특정 사용자가 작성한 피드 개수 가져오기 [선준]
	public Integer getFeedCnt(String userId) throws Exception;
	
	// user_id로 팔로워들 게시글 가져오기 [3.31. 훈영 추가]
	public List followsMainFeed(String user_id, int startRow, int endRow) throws Exception;
	// user_id로 팔로워들 게시글 몇개인지 확인[4.03. 훈영 추가]
	public Integer countFollwsMainFeed(String user_id) throws Exception;
	public List getMyAllFeed(String user_id, Integer startRow, Integer endRow, Integer myCh) throws Exception;
	public Integer getMyFeedCount(String user_id, Integer myCh) throws Exception;
}

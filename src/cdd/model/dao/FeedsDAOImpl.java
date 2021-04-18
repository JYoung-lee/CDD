package cdd.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cdd.model.dto.Feed_PhotosDTO;
import cdd.model.dto.FeedsDTO;
import cdd.model.dto.Get_RepliesDTO;

@Repository
public class FeedsDAOImpl implements FeedsDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	@Override // 게시글 디비 저장
	public void feedWrite(FeedsDTO dto, List<Feed_PhotosDTO> photos) throws Exception {

		sqlSession.insert("feeds.insertFeed", dto);
		sqlSession.insert("feeds.insertPhotos", photos);

	}

	@Override
	public Integer nextFeedNum() throws Exception { // 피드 다음 번호
		Integer nextNum = 0;
		nextNum = sqlSession.selectOne("feeds.nextNum");

		return nextNum;
	}

	@Override
	public FeedsDTO getFeed(Integer feed_num) throws Exception { // 피드 가져오기

		FeedsDTO dto = sqlSession.selectOne("feeds.getFeed", feed_num);
		return dto;
	}

	@Override
	public List<Feed_PhotosDTO> getPhotos(Integer feed_num) throws Exception {

		List<Feed_PhotosDTO> photos = sqlSession.selectList("feeds.getPhotos", feed_num);
		return photos;
	}

	@Override
	public void insertReply(Map<Object, Object> map) throws Exception {
		sqlSession.insert("feeds.insertReply", map);
	}

	@Override
	public List<Get_RepliesDTO> getReplies(int feed_num) throws Exception {

		List<Get_RepliesDTO> replies = sqlSession.selectList("feeds.getReplies", feed_num);
		return replies;
	}

	@Override
	public Integer likeCh(int feed_num, String user_id) {

		Map map = new HashMap();
		map.put("feed_num", feed_num);
		map.put("user_id", user_id);

		Integer likech = sqlSession.selectOne("feeds.likeCh", map);
		return likech;
	}

	@Override
	public void insertLike(int feed_num, String user_id) {

		Map map = new HashMap();

		map.put("feed_num", feed_num);
		map.put("user_id", user_id);

		sqlSession.insert("feeds.insertLike", map);
	}

	@Override
	public void deleteLike(int feed_num, String user_id) {

		Map map = new HashMap();

		map.put("feed_num", feed_num);
		map.put("user_id", user_id);
		sqlSession.delete("feeds.deleteLike", map);

	}
	
	
	
	
	@Override
	public Integer countLikes(int feed_num) throws Exception {
		
		int countLikes = sqlSession.selectOne("feeds.countLikes", feed_num);
		return countLikes;
	}
	
	@Override
	public void insertFollow(String user_from, String user_to) throws Exception {
		
		Map map = new HashMap();

		map.put("user_from", user_from);
		map.put("user_to", user_to);
		
		sqlSession.insert("feeds.insertFollow", map);
		
	}
	
	@Override
	public Integer followCh(String user_from, String user_to) throws Exception {
		Map map = new HashMap();

		map.put("user_from", user_from);
		map.put("user_to", user_to);
		
		Integer followCh = sqlSession.selectOne("feeds.followCh", map);
		return followCh;
	}
	
	@Override
	public void deleteFollow(String user_from, String user_to) throws Exception {
		Map map = new HashMap();

		map.put("user_from", user_from);
		map.put("user_to", user_to);
		
		sqlSession.delete("feeds.deleteFollow", map);
	}
	
	@Override
	public Integer bookCh(String user_id, Integer feed_num) throws Exception {
		
		
		
		Map map = new HashMap();

		map.put("user_id", user_id);
		map.put("feed_num", feed_num);
		
		Integer bookCh = sqlSession.selectOne("feeds.bookCh", map);
		return bookCh;
	}
	
	@Override
	public void insertBookmark(String user_id, Integer feed_num) throws Exception {
		
		Map map = new HashMap();

		map.put("user_id", user_id);
		map.put("feed_num", feed_num);
		
		sqlSession.insert("feeds.insertBookmark", map);
	}
	
	@Override
	public void deleteBookmark(String user_id, Integer feed_num) throws Exception {
		
		Map map = new HashMap();

		map.put("user_id", user_id);
		map.put("feed_num", feed_num);
		
		sqlSession.delete("feeds.deleteBookmark", map);
	}
	
	// 해시태그 검색결과 가져오기 [선준]
	@Override
	public List getSearchTagList(String search) throws Exception {
		List searchTags = sqlSession.selectList("feeds.getSearchTags", search);
		return searchTags;
	}
	// 해시태그 검색결과 갯수 가져오기 [훈영]
	@Override
	public Integer searchTagCount(String search) throws Exception {
		Integer searchTagCount = sqlSession.selectOne("feeds.searchTagCount", search); 
		return searchTagCount;
	}
	
	// 피드 검색결과 가져오기 [선준]
	@Override
	public List getSearchFeedList(String search) throws Exception {
		List searchFeeds = sqlSession.selectList("feeds.getSearchFeeds", search);
		return searchFeeds;
	}
	
	// feed_num 으로 피드 리스트 가져오기 [선준]
	@Override
	public List getCollectionList(List collections) throws Exception {
		List collectionList = new ArrayList();
		for(int i=0; i<collections.size(); i++) {
			Integer feedNum = (Integer)collections.get(i);
			collectionList.add(sqlSession.selectOne("feeds.getFeedList",feedNum));
		}
		return collectionList;
	}
	
	// 특정 사용자가 작성한 피드 개수 가져오기 [선준]
	@Override
	public Integer getFeedCnt(String userId) throws Exception {
		int feedCnt = sqlSession.selectOne("feeds.getFeedCnt", userId);
		return feedCnt;
	}
	
	// [3.31 훈영 추가]
	@Override
	public List followsMainFeed(String user_id, int startRow, int endRow) throws Exception {
		
		Map map = new HashMap();
		
		map.put("user_id", user_id);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List follwofeedList = sqlSession.selectList("feeds.followsMainFeed", map);
		return follwofeedList;
	}
	
	// [4.03 훈영 추가]
	@Override
	public Integer countFollwsMainFeed(String user_id) throws Exception {
		Integer mainFeedCount = sqlSession.selectOne("feeds.countFollowsFeed", user_id);
		return mainFeedCount;
	}
	
	// [4.08 훈영 추가]
	@Override
	public List getMainAllFeed(Integer startRow, Integer endRow) throws Exception {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List mainAllFeed = sqlSession.selectList("feeds.getMainAllFeed", map);
		return mainAllFeed;
	}
	
	// [4.08 훈영 추가]
	@Override
	public Integer getMainAllCount() {
		
		Integer count = sqlSession.selectOne("feeds.getMainAllCount");
		return count;
	}
	@Override
	public List getMyAllFeed(String user_id, Integer startRow, Integer endRow, Integer myCh) throws Exception {
		
		Map map = new HashMap();
		map.put("user_id", user_id);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("myCh", myCh);
		List myAllFeed = sqlSession.selectList("feeds.getMyAllFeed", map);
		return myAllFeed;
	}
	@Override
	public Integer getMyFeedCount(String user_id, Integer myCh) throws Exception {
		Map map = new HashMap();
		map.put("user_id", user_id);
		map.put("myCh", myCh);
		Integer myFeedCount = sqlSession.selectOne("feeds.getMyFeedCount", map);
		return myFeedCount;
	}
	
	
}

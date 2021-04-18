package cdd.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FollowsDAOImpl implements FollowsDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// 팔로우한 사용자 리스트 가져오기 [선준]
	@Override
	public List getFollowList(String id) throws Exception{
		List followList = sqlSession.selectList("follow.getFollows", id);
		return followList;
	}
	
	// 팔로우 체크 [선준]
	@Override
	public Integer followCheck(String toId, String fromId) throws Exception {
		Map args = new HashMap();
		args.put("toId", toId);
		args.put("fromId", fromId);
		Integer res = sqlSession.selectOne("follow.followCh", args);
		return res;
	}
	
	// 팔로우한 사용자 수 [선준]
	@Override
	public Integer getFlwCnt(String userId) throws Exception {
		Integer flwCnt = sqlSession.selectOne("follow.getFlwCnt", userId);
		return flwCnt;
	}
	
	// 팔로워 수 [선준]
	@Override
	public Integer getFlwerCnt(String userId) throws Exception {
		Integer flwerCnt = sqlSession.selectOne("follow.getFlwerCnt", userId);
		return flwerCnt;
	}
	
	// 팔로워 리스트 가져오기 [선준]
	@Override
	public List getFollowerList(String userId) throws Exception {
		List followerList = sqlSession.selectList("follow.getFollowers", userId);
		return followerList;
	}
}

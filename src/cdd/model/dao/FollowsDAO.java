package cdd.model.dao;

import java.util.List;

public interface FollowsDAO {
	// 팔로우한 사용자 리스트 가져오기 [선준]
	public List getFollowList(String id) throws Exception;
	
	// 팔로우 체크 [선준]
	public Integer followCheck(String toId, String fromId) throws Exception;
	
	// 팔로우한 사용자 수 [선준]
	public Integer getFlwCnt(String userId) throws Exception;
	
	// 팔로워 사용자 수 [선준]
	public Integer getFlwerCnt(String userId) throws Exception;
	
	// 팔로워 리스트 가져오기 [선준]
	public List getFollowerList(String userId) throws Exception;
}

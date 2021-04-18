package cdd.model.dao;

import java.util.List;
import java.util.Map;

public interface DmUserRecDAO {
	// 대화 이력 조회 [선준]
	public List getChatUserList(String currId) throws Exception;
	
	// 대화 이력 추가 [선준]
	public void insertRec(Map dmAttr) throws Exception;
	
	// 대화 이력 삭제 [선준]
	public void deleteRec(Map users) throws Exception;
}

package cdd.model.dao;

import java.util.List;
import java.util.Map;

public interface DmDAO {
	// DM 리스트 가져오기 [선준]
	public List getDmList(String chatId, String memId) throws Exception;
	
	// DM 삽입 [선준]
	public void insertDm(Map dmAttr) throws Exception;
	
	// DM 삭제 [선준]
	public void deleteDm(Map users) throws Exception;
	
	// 미확인 dm 개수 가져오기 [선준]
	public Integer getUnChDmCnt(String memId) throws Exception;
	
	// dm Status칼럼 update [선준]
	public void updateStatus(String chatId, String memId) throws Exception;
	
	// dm 리스트 + 미확인 메시지 개수 [선준]
	public List getChatStatus(List chatUserList, String userId) throws Exception;
}

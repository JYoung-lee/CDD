package cdd.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DmDAOImpl implements DmDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// DM 리스트 가져오기 [선준]
	@Override
	public List getDmList(String chatId, String memId) {
		Map args = new HashMap();
		args.put("chatId", chatId);
		args.put("memId", memId);
		List dmList = sqlSession.selectList("dm.getDmList", args);
		return dmList;
	}
	
	// DM 삽입 [선준]
	@Override
	public void insertDm(Map dmAttr) throws Exception {
		sqlSession.insert("dm.insertDm1", dmAttr);
		sqlSession.insert("dm.insertDm2", dmAttr);
	}
	
	// DM 삭제 [선준]
	@Override
	public void deleteDm(Map users) throws Exception {
		sqlSession.delete("dm.deleteDm", users);
	}
	
	// 미확인 dm 개수 가져오기 [선준]
	@Override
	public Integer getUnChDmCnt(String memId) throws Exception {
		int res = sqlSession.selectOne("dm.getUnChDmCnt", memId);
		return res;
	}
	
	// dm Status칼럼 update [선준]
	@Override
	public void updateStatus(String chatId, String memId) throws Exception {
		Map args = new HashMap();
		args.put("chatId", chatId);
		args.put("memId", memId);
		sqlSession.update("dm.updateStatus", args);
	}
	
	// dm 리스트 + 미확인 메시지 개수 [선준]
	@Override
	public List getChatStatus(List chatUserList , String userId) throws Exception {
		List chatStatus = new ArrayList();
		for(int i=0; i<chatUserList.size(); i++) {
			Map args = new HashMap();
			args.put("userId", userId);
			args.put("chatId", chatUserList.get(i));
			chatStatus.add(sqlSession.selectOne("dm.getChatStatus", args));
		}
		return chatStatus;
	}
}

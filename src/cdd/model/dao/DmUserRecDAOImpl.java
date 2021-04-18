package cdd.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DmUserRecDAOImpl implements DmUserRecDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// 대화 이력 조회 [선준]
	@Override
	public List getChatUserList(String currId) throws Exception{
		List chatUserList = sqlSession.selectList("dmUserRec.getChatUserList", currId);
		return chatUserList;
	}
	
	// 대화 이력 추가 [선준]
	@Override
	public void insertRec(Map dmAttr) throws Exception {
		int res1 = sqlSession.selectOne("dmUserRec.checkRec1", dmAttr);
		int res2 = sqlSession.selectOne("dmUserRec.checkRec2", dmAttr);
		if(res1 == 0) {
			sqlSession.insert("dmUserRec.insertRec1", dmAttr);
		}
		if(res2 == 0) {
			sqlSession.insert("dmUserRec.insertRec2", dmAttr);
		}
	}

	// 대화 이력 삭제 [선준]
	@Override
	public void deleteRec(Map users) throws Exception {
		sqlSession.delete("dmUserRec.deleteRec",users);
	}
}

package cdd.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CollectionDAOImpl implements CollectionDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// 저장된 북마크 가져오기 [선준]
	@Override
	public List getCollectionFeedNum(String memId) throws Exception {
		List collections = sqlSession.selectList("collection.getList", memId);
		return collections;
	}
}

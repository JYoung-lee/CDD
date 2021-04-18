package cdd.model.dao;

import java.util.List;

public interface CollectionDAO {
	// 저장된 북마크 가져오기[선준]
	public List getCollectionFeedNum(String memId) throws Exception;
}

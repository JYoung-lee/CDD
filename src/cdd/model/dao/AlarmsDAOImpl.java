package cdd.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmsDAOImpl implements AlarmsDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	@Override
	public void insertAlarm(int feed_num, String alarm_fromId, String alarm_content, String user_to)
			throws Exception {
		
		Map map = new HashMap();
		map.put("feed_num", feed_num);
		map.put("user_to", user_to);
		map.put("alarm_content", alarm_content);
		map.put("alarm_fromId", alarm_fromId);
		map.put("alarm_fromProfile", null);
		
		sqlSession.insert("alarms.insertAlarms", map);
	}
		
		
		
	
	@Override
	public void insertAlarm(String alarm_fromId, String user_to, String alarm_content) throws Exception {
		Map map = new HashMap();
		map.put("feed_num", 0);
		map.put("user_to", user_to);
		map.put("alarm_content", alarm_content);
		map.put("alarm_fromId", alarm_fromId);
		map.put("alarm_fromProfile", null);
		
		sqlSession.insert("alarms.insertAlarms", map);
	}
	
	@Override
	public void deleteAlarm(int feed_num, String alarm_fromId) throws Exception {
		
		Map map = new HashMap();
		
		map.put("feed_num", feed_num);
		map.put("alarm_fromId", alarm_fromId);
		
		sqlSession.delete("alarms.deleteAlarms", map);
		
	}
	@Override
	public void deleteAlarm(String alarm_fromId, String user_to) throws Exception {
		Map map = new HashMap();
		
		map.put("feed_num", 0);
		map.put("alarm_fromId", alarm_fromId);
		map.put("user_to", user_to);
		
		sqlSession.delete("alarms.deleteAlarms", map);
	}
	
	// alarm 가져오기 [선준]
	@Override
	public List getAlarms(String sessId) throws Exception {
		List alarms = sqlSession.selectList("alarms.getAlarms", sessId);
		return alarms;
	}
	
	// 미확인 alarm 개수 가져오기 [선준]
	@Override
	public Integer getUnChAlrmCnt(String memId) throws Exception {
		Integer alarmRes = sqlSession.selectOne("alarms.getUnChAlrmCnt", memId);
		return alarmRes;
	}
	
	// alarms 테이블의 status 칼럼 값 변경
	@Override
	public void updateAlarmStatus(String memId) throws Exception {
		sqlSession.update("alarms.updateAlarmStatus", memId);
	}
}

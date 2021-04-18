package cdd.model.dao;

import java.util.List;

public interface AlarmsDAO {
	public void insertAlarm(int feed_num, String alarm_fromId, String alarm_content, String user_to) throws Exception;
	public void insertAlarm(String alarm_fromId, String user_to, String alarm_content) throws Exception;
	public void deleteAlarm(int feed_num, String alarm_fromId) throws Exception;
	public void deleteAlarm(String user_from, String user_to) throws Exception;
	// alarm 가져오기 [선준]
	public List getAlarms(String sessId) throws Exception;
	
	// 미확인 alarm 개수 가져오기 [선준]
	public Integer getUnChAlrmCnt(String memId) throws Exception;
	
	// alarms 테이블의 status 칼럼 값 변경
	public void updateAlarmStatus(String memId) throws Exception;
}

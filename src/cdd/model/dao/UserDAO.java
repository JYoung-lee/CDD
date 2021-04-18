package cdd.model.dao;

import java.util.HashMap;
import java.util.List;

import cdd.model.dto.UserDTO;

public interface UserDAO {
	
	// 회원 가입(승목)
	public void insertMember(UserDTO dto) throws Exception;

	// 회원 로그인(아이디 비번확인 - 로그인)(승목)
	public int idPwCheck(UserDTO dto) throws Exception;
	
	// 회원 차단 여부 확인 
	public int blockCh(String userId) throws Exception;

	// 회원 email 로 id 찾기(승목)
	public String findId(String email) throws Exception;

	// 회원 id, email 로 pw 찾기(승목)
	public int findPw(String id, String email) throws Exception;

	// pw 수정(승목)
	public void pwEdit(UserDTO dto) throws Exception;

	// 아이디 이메일 사용가능 여부(승목)
	public int idEmailAvailCheck(String id, String email) throws Exception;
	
	// 아이디로 회원정보 한명 가져오기(승목)
	public UserDTO getMember(String id) throws Exception;

	// 아이디로 회원정보 수정(승목)
	public void updateMember(UserDTO dto);
	
	// 아이디 패스워드로 회원 확인 [선준]
	public int pwCheck(String userId, String exPw) throws Exception;
	
	// 비밀번호 변경 [선준]
	public void pwUpdate(String userId, String newPw)throws Exception;
	
	// 사용자 검색 결과 [선준]
	public List getSearchUsers(String search) throws Exception;
}

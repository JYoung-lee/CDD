package cdd.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cdd.model.dto.UserDTO;

@Repository
public class UserDAOImpl implements  UserDAO{

	// sql 주입
	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	// 회원 가입(승목)
	@Override
	public void insertMember(UserDTO dto) throws Exception {
		sqlSession.insert("user.insertUser", dto);
	}

	// 회원 로그인(아이디 비번확인 - 로그인)(승목)
	@Override
	public int idPwCheck(UserDTO dto) throws Exception {
		int result = sqlSession.selectOne("user.idPwCheck", dto);
		return result;
	}
	
	// 회원 차단 여부 확인
	@Override
	public int blockCh(String userId) throws Exception {
		int bCh = sqlSession.selectOne("user.blockCh", userId);
		return bCh;
	}

	// 회원 email 로 id 찾기(승목)
	@Override
	public String findId(String email) throws Exception {
		System.out.println("dao email : " + email);
		String id = sqlSession.selectOne("user.findId", email);
		System.out.println("dao id : " + id);
		return id;
	}

	// 회원 id, email 로 pw 찾기(승목)
	@Override
	public int findPw(String id, String email) throws Exception {
		System.out.println("findPw");
		Map map = new HashMap();
		map.put("id", id);
		map.put("email", email);
		int result = sqlSession.selectOne("user.findPw", map);
		return result;
	}

	// pw 수정(승목)
	@Override
	public void pwEdit(UserDTO dto) throws Exception {
		System.out.println("findPw dao");
		sqlSession.update("user.pwEdit", dto);
		
	}
	
	// 아이디 사용가능 여부(승목)
	@Override
	public int idEmailAvailCheck(String id, String email) throws Exception {
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("email", email);
		
		int check = sqlSession.selectOne("user.idEmailAvail", map);
		return check;
	}

	// 아이디로 회원정보 한명 가져오기(승목)
	@Override
	public UserDTO getMember(String id) throws Exception {
		UserDTO result = sqlSession.selectOne("user.getMember", id);
		return result;
	}
	
	// 아이디로 회원정보 수정(승목)
	public void updateMember(UserDTO dto) {
		sqlSession.update("user.updateMember", dto);
	}
	
	// 아이디 패스워드로 회원 확인 [선준]
	@Override
	public int pwCheck(String userId, String exPw) throws Exception {
		Map args = new HashMap();
		args.put("userId", userId);
		args.put("exPw", exPw);
		int res = sqlSession.selectOne("user.pwCheck", args);
		return res;
	}
	
	// 비밀번호 변경 [선준]
	@Override
	public void pwUpdate(String userId, String newPw) throws Exception {
		Map args = new HashMap();
		args.put("userId", userId);
		args.put("newPw", newPw);
		sqlSession.update("user.pwUpdate", args);
	}
	
	// 사용자 검색결과 가져오기 [선준]
	@Override
	public List getSearchUsers(String search) throws Exception {
		List searchUsers = sqlSession.selectList("user.searchUsers", search);
		return searchUsers;
	}

}

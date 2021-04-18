package cdd.service.bean;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dto.UserDTO;

public interface UserService {
	
	// 회원 가입(승목)
	public void addMember(UserDTO dto) throws Exception;

	// 회원 로그인(아이디 비번확인 - 로그인)(승목)
	public int idPwCheck(UserDTO dto) throws Exception;
	
	// 회원 차단 여부 확인
	public int blockCh(String userId) throws Exception;

	// 회원 email 로 id 찾기(승목)
	public String getIdMember(String email) throws Exception;

	// 회원 id, email 로 pw 찾기(승목)
	public String findPw(String id, String email) throws Exception;

	// pw 수정(승목)
	public void pwEdit(UserDTO dto) throws Exception;

	// 아이디 이메일 사용가능 여부(승목)
	public int idEmailCheck(String id, String email) throws Exception;
	
	// 세션삭제(로그아웃)(승목)
	public void removeSessionAttr(String sessionName);

	// 로그아웃(승목)
	public void logout(String sessionName);
	
	// 패스워드 확인(승목)
	public int pwCheck(UserDTO dto) throws Exception;
	
	// 회원정보 한명가져오기(승목)
	public UserDTO getMember() throws Exception;

	// 회원정보 수정(승목)
	public void updateMember(UserDTO dto, MultipartHttpServletRequest request);
	
	// 프로필 드랍다운 pw변경 [선준]
	public Integer pwModifyPro(String userId, String exPw, String newPw) throws Exception;
	
	

}

package cdd.service.bean;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dao.UserDAO;
import cdd.model.dto.UserDTO;

@Repository
public class UserServiceImpl implements UserService {
	
	// userDAO 주입
	@Autowired
	private UserDAO userDAO = null;

	// 회원 가입(승목)
	@Override
	public void addMember(UserDTO dto) throws Exception {
		userDAO.insertMember(dto);
	}

	// 회원 로그인(아이디 비번확인 - 로그인)(승목)
	@Override
	public int idPwCheck(UserDTO dto) throws Exception {
		int result = userDAO.idPwCheck(dto);
		if(result == 1) {
			// block 여부 확인하기
			int bCh = blockCh(dto.getUser_id());
			if(bCh == 1) {
				result = 2;
			}else {
				// session.setAttribute("memId", memId); 세션 만들기
				RequestContextHolder.getRequestAttributes().setAttribute("memId", dto.getUser_id(), RequestAttributes.SCOPE_SESSION);
			}
		}
		return result;
	}
	
	// 회원 차단 여부 확인
	@Override
	public int blockCh(String userId) throws Exception{
		int bCh = userDAO.blockCh(userId);
		return bCh;
	}
	
	// 로그아웃(승목)
	@Override
	public void logout(String sessionName) {
		removeSessionAttr(sessionName);
	}
	
	// 세션삭제(로그아웃)(승목)
	@Override
	public void removeSessionAttr(String sessionName) {
		RequestContextHolder.getRequestAttributes().removeAttribute(sessionName, RequestAttributes.SCOPE_SESSION);
	}

	// 회원 email 로 id 찾기(승목)
	@Override
	public String getIdMember(String email) throws Exception {
		String id = userDAO.findId(email);
	
		return id;
	}

	// 회원 id, email 로 pw 찾기(승목)
	@Override
	public String findPw(String id, String email) throws Exception {
		int result = userDAO.findPw(id, email);
		String uri = "";
		if(result == 1) {
			uri = "user/pwEdit";
		}else {
			uri = "user/findIdPw";
		}
		return uri;
	}

	// pw 수정(승목)
	@Override
	public void pwEdit(UserDTO dto) throws Exception {
		userDAO.pwEdit(dto);
	}

	// 아이디 사용가능 여부(승목)
	@Override
	public int idEmailCheck(String id, String email) throws Exception {
		int result = userDAO.idEmailAvailCheck(id, email);
		return result;
	}
	
	// 패스워드 확인(승목)
	public int pwCheck(UserDTO dto) throws Exception {
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		dto.setUser_id(id);
		int result = userDAO.idPwCheck(dto);
		
		return result;
	}

	// 회원정보 한명 가져오기
	@Override
	public UserDTO getMember() throws Exception {
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		UserDTO result = userDAO.getMember(id);
		
		return result;
	}
	
	// 회원 정보 수정
	public void updateMember(UserDTO dto, MultipartHttpServletRequest request) {
		MultipartFile mf = null;
		mf = request.getFile("img");
		String orgName = mf.getOriginalFilename();
		String newName = null;
		
		if(orgName != "") {
			try {
				String imgName = orgName.substring(0, orgName.lastIndexOf('.'));
				String ext = orgName.substring(orgName.lastIndexOf('.'));
				long date = System.currentTimeMillis();
				newName = imgName + date + ext;
				
				String path = request.getRealPath("save");
				String imgPath = path + "\\" + newName;
				
				File copyFile = new File(imgPath);
				mf.transferTo(copyFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		dto.setUser_id(id);
		dto.setUser_profile(newName);
		userDAO.updateMember(dto);
	}
	
	// 프로필 드랍다운 pw변경 [선준]
	@Override
	public Integer pwModifyPro(String userId, String exPw, String newPw) throws Exception {
		int res = userDAO.pwCheck(userId, exPw);
		if(res == 0) {
			return res;
		}else {
			userDAO.pwUpdate(userId, newPw);
			return res;
		}
	}
}

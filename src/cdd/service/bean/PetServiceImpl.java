package cdd.service.bean;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dao.PetDAO;
import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.Pet_JJDTO;
import cdd.model.dto.Pet_SickDTO;
import cdd.model.dto.Pet_SurgDTO;

@Service
public class PetServiceImpl implements PetService{

	@Autowired
	private PetDAO petDAO = null;

	// 펫 Info 저장하기
	@Override
	public void insertPetInfo(Pet_InfoDTO pet_InfoDTO, MultipartHttpServletRequest request,Pet_SickDTO pet_SickDTO, Pet_JJDTO pet_JJDTO, Pet_SurgDTO pet_SurgDTO) throws Exception {
		MultipartFile mf = null;
		String newName = null;
		
		if(!getSession().equals("null")) {
			//세션값 user아이디 넣어주기
			pet_InfoDTO.setUser_id(getSession());
			// 펫 이미지를 넣었을경우
			if(request.getFile("pet_profileImg").getOriginalFilename() != "") {
				try {
					mf = request.getFile("pet_profileImg");
					// # 방법 2 중복처리하여 save저장시키는 버전
					// 오리지널 파일명 가져오기
					String orgName = mf.getOriginalFilename();
					//System.out.println("orgName : " + orgName);
					
					//ex) jsp13_01_이미지_웹서비스 기본동작과정.png 이미지 파일 자르기
					String imgName = orgName.substring(0, orgName.lastIndexOf('.')); //뒤에서부터 .을 기준으로 자른다.  substring 이름 짜르기
					String ext = orgName.substring(orgName.lastIndexOf('.'));
					long date = System.currentTimeMillis();
					newName = imgName + date + ext;
					
					String path = request.getRealPath("save");  // 파일경로가져오기
					//System.out.println("path : " + path);		//파일위치출력
					String imgPath = path + "\\" + newName;		//파일위치 + 이미지 이름
					File copyFile = new File(imgPath);			// 파일객체 생성 
					mf.transferTo(copyFile);// 폴더에 저장
					
					pet_InfoDTO.setPet_profile(newName);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}else {
				// 펫 이미지를 넣지 않았을경우
				pet_InfoDTO.setPet_profile("defaultimg.png");
			}//else
			
			//펫 품종 기타선택하지 않았을경우
			if(pet_InfoDTO.getKind_other().equals("")) {
				pet_InfoDTO.setKind_other("1"); // 선택하지 않음.
			}//if
	
			// 생일, 중성화 시기, 입양날이 몰랐을경우 
			if(pet_InfoDTO.getPet_ttday() == null) {
				pet_InfoDTO.setPet_ttday("0000.00.00");
			}
			if(pet_InfoDTO.getPet_birth() == null) {
				pet_InfoDTO.setPet_birth("0000.00.00");
			} 
			if(pet_InfoDTO.getPet_meet() == null) {
				pet_InfoDTO.setPet_meet("0000.00.00");
			}
			
			String pet_name = pet_InfoDTO.getPet_name();
			// pet info DB저장 
			petDAO.insertPetInfo(pet_InfoDTO); 
			
			//userid, pet_name 가져오기
			pet_InfoDTO = petDAO.getPetNumber(getSession(), pet_name);
			
			// 보유질환이 있을경우 저장
			if(!(pet_SickDTO.getPet_sickname().equals("") || pet_SickDTO.getPet_sickday().equals("") || pet_SickDTO.getPet_hospital().equals(""))) {
				pet_SickDTO.setUser_id(pet_InfoDTO.getUser_id());		// getPetNumber메서드에서 가져온 아이디 채워주기
				pet_SickDTO.setPet_number(pet_InfoDTO.getPet_number());	// getPetNumber메서드에서 가져온 펫 넘버 채워주기
				petDAO.insertPetSick(pet_SickDTO);						// 보유질환 DB저장
			
			}//if
	
			// 접종기록이 있을경유 저장
			if(!(pet_JJDTO.getPet_jjname().equals("") || pet_JJDTO.getPet_jjday().equals("")|| pet_JJDTO.getPet_jjhospital().equals(""))) {
				pet_JJDTO.setUser_id(pet_InfoDTO.getUser_id());			// getPetNumber메서드에서 가져온 아이디 채워주기
				pet_JJDTO.setPet_number(pet_InfoDTO.getPet_number());	// getPetNumber메서드에서 가져온 펫 넘버 채워주기
				petDAO.insertPetJJ(pet_JJDTO);							// 접종기록 DB저장
			
			}//if
			
			// 수술 기록이 있을경우 저장
			if(!(pet_SurgDTO.getPet_surgname().equals("") || pet_SurgDTO.getPet_surgday().equals("") || pet_SurgDTO.getPet_surghospi().equals(""))) {
				pet_SurgDTO.setUser_id(pet_InfoDTO.getUser_id());		// getPetNumber메서드에서 가져온 아이디 채워주기
				pet_SurgDTO.setPet_number(pet_InfoDTO.getPet_number());	// getPetNumber메서드에서 가져온 펫 넘버 채워주기
				petDAO.insertPetSurg(pet_SurgDTO);						// 수술기록 DB저장
				
			}//if
		}
		
	}// insertInfo
	
	// 펫 고유번호로 Info정보,질환기록,접종기록,수술기로가져오기
	@Override
	public Map<String, Object> getPetOneInfo(String profileId, Integer pet_number) throws Exception {
		Map<String , Object> pet_allInfo = new HashMap<String, Object>();
		
		if(profileId.equals(getSession()) || profileId == "") {
			// 펫 정보 가져오기
			Pet_InfoDTO pet_infoDTO = petDAO.getPetOneInfo(getSession(), pet_number);
			// DB에 저장된 펫종류,품종 가져오기
			String pet_typeName = petDAO.getOnePetKind(pet_infoDTO.getKind_num());
			String pet_kindName = petDAO.getOnePetType(pet_infoDTO.getType_num());
			
			// 펫 질환 가져오기
			int sickCount = petDAO.getSickCount(getSession(), pet_number);
			if(sickCount > 0) { //정보가 있으면 넣어주기
				List<Object> pet_sickDTOList = petDAO.getPetOneSick(getSession(), pet_number);
				
				pet_allInfo.put("pet_sickDTOList", pet_sickDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			// 펫 접종 가져오기
			int jjCount = petDAO.getJJCount(getSession(), pet_number);
			if(jjCount > 0) {
				List<Object> pet_jjDTOList = petDAO.getPetOnejj(getSession(), pet_number);
				pet_allInfo.put("pet_jjDTOList", pet_jjDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			// 펫 수술 가져오기
			int surgCount = petDAO.getSurgCount(getSession(), pet_number);
			if(surgCount > 0) {
				List<Object> pet_surgDTOList = petDAO.getPetOneSurg(getSession(), pet_number);
				
				pet_allInfo.put("pet_surgDTOList", pet_surgDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			String view = "/myPage/petInfoModifyForm"; 
			pet_allInfo.put("pet_infoDTO", pet_infoDTO); // Controller(petViewForm)로 넘기는 데이터
			pet_allInfo.put("pet_typeName", pet_typeName);
			pet_allInfo.put("pet_kindName", pet_kindName);
			pet_allInfo.put("sickCount", sickCount);	//	View에서 분기 처리할 데이터
			pet_allInfo.put("jjCount", jjCount);		//	View에서 분기 처리할 데이터
			pet_allInfo.put("surgCount", surgCount);	//	View에서 분기 처리할 데이터
			pet_allInfo.put("view", view);
		}else {
			// 펫 정보 가져오기
			Pet_InfoDTO pet_infoDTO = petDAO.getPetOneInfo(profileId, pet_number);
			// DB에 저장된 펫종류,품종 가져오기
			String pet_typeName = petDAO.getOnePetKind(pet_infoDTO.getKind_num());
			String pet_kindName = petDAO.getOnePetType(pet_infoDTO.getType_num());
			
			// 펫 질환 가져오기
			int sickCount = petDAO.getSickCount(profileId, pet_number);
			if(sickCount > 0) { //정보가 있으면 넣어주기
				List<Object> pet_sickDTOList = petDAO.getPetOneSick(profileId, pet_number);
				
				pet_allInfo.put("pet_sickDTOList", pet_sickDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			// 펫 접종 가져오기
			int jjCount = petDAO.getJJCount(profileId, pet_number);
			if(jjCount > 0) {
				List<Object> pet_jjDTOList = petDAO.getPetOnejj(profileId, pet_number);
				pet_allInfo.put("pet_jjDTOList", pet_jjDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			// 펫 수술 가져오기
			int surgCount = petDAO.getSurgCount(profileId, pet_number);
			if(surgCount > 0) {
				List<Object> pet_surgDTOList = petDAO.getPetOneSurg(profileId, pet_number);
				
				pet_allInfo.put("pet_surgDTOList", pet_surgDTOList); // Controller(petViewForm)로 넘기는 데이터
			}//if
			String view ="/myPage/petInfoView";
			pet_allInfo.put("pet_infoDTO", pet_infoDTO); // Controller(petViewForm)로 넘기는 데이터
			pet_allInfo.put("pet_typeName", pet_typeName);
			pet_allInfo.put("pet_kindName", pet_kindName);
			pet_allInfo.put("sickCount", sickCount);	//	View에서 분기 처리할 데이터
			pet_allInfo.put("jjCount", jjCount);		//	View에서 분기 처리할 데이터
			pet_allInfo.put("surgCount", surgCount);	//	View에서 분기 처리할 데이터
			pet_allInfo.put("view", view);
		}
		return pet_allInfo;
	}//getPetOneInfo
	
	// 유저에 해당하는 펫 정보 가져오기  //null 이면 나  null이 아니면 사용자
	   @Override 
	   public Map getPetInfoList(String profileId) throws Exception {
	      
	      // 이용자의 펫 정보가 있는지 확인
	      Map petInfo = new HashMap();
	      List petInfoList = null;
	      int count = -1;
	      if(profileId == null) {
	         count = petDAO.getPetInfoCount(getSession());
	         // 이용자의 펫 정보가 있으면 가져오고 없으면 가져오지 않는다.
	         if(count > 0) {
	            // 나의 펫정보 리스트로 담아오기
	            petInfoList = petDAO.getPetInfoList(getSession());   // 아이디로 펫 정보 확인
	         }//if
	      }else {
	         count = petDAO.getPetInfoCount(profileId);
	         if(count > 0) {
	            // 이용자의 펫정보 리스트로 담아오기
	            petInfoList = petDAO.getPetInfoList(profileId);   // 아이디로 펫 정보 확인
	         }//if
	      }//else
	      
	      
	      petInfo.put("petInfoList", petInfoList);         // Contorller로 보내는 데이터 
	      petInfo.put("count", count);                  // Contorller로 보내는 데이터
	      
	      return petInfo;
	   }//getPetInfo
	
	// 펫 종류 List 가져오기 ajax
	@Override
	public Map getPetType() throws Exception {
		List pettype = petDAO.getPetType();			// DB에 저장되어있는 펫 종류 데이터 가져오기
		Map pettypes = new HashMap();				
		pettypes.put("pettype", pettype);			// Contorller로 보내는 데이터
		
		return pettypes;
	}//getPetType
	
	// 펫 품종 List 가져오기 ajax
	@Override
	public List getPetKind(Integer type_num) throws Exception {
		List petkind = petDAO.getPetKind(type_num);	// DB에 저장되어있는 펫 품종 가져오기
		
		return petkind;
	}// getPetKind
	
	// 펫 Info 수정하기 ajax
	@Override
	public void petModifyInfo(Map<Object, Object> data) throws Exception {
		Pet_InfoDTO pet_infoDTO = new Pet_InfoDTO();
		pet_infoDTO.setUser_id(getSession());
		pet_infoDTO.setPet_number(Integer.parseInt(data.get("pet_number").toString()));
		pet_infoDTO.setPet_birth((String)data.get("pet_birth"));				// 생일
		pet_infoDTO.setPet_tt(Integer.parseInt(data.get("pet_tt").toString())); // 중성화
		pet_infoDTO.setPet_ttday((String)data.get("pet_ttday"));				// 중성화 날짜
		pet_infoDTO.setPet_meet((String)data.get("pet_meet"));					// 입양날
		
		petDAO.petModifyInfo(pet_infoDTO);
	}//petModifyInfo
	
	// 펫 이미지 수정 ajax  
	public String petUploadImg(MultipartHttpServletRequest request) throws Exception {
		Integer pet_number = Integer.parseInt(request.getParameter("pet_numberValue").toString());
		
		
		Pet_InfoDTO pet_infoDTO = new Pet_InfoDTO();
		pet_infoDTO.setUser_id(getSession());
		pet_infoDTO.setPet_number(pet_number);
		
		MultipartFile mf = null;
		String newName = null;
		
		try {
			mf = request.getFile("pet_profileImg");
			// # 방법 2 중복처리하여 save저장시키는 버전
			// 오리지널 파일명 가져오기
			String orgName = mf.getOriginalFilename();
			//System.out.println("orgName : " + orgName);
			
			//ex) jsp13_01_이미지_웹서비스 기본동작과정.png 이미지 파일 자르기
			String imgName = orgName.substring(0, orgName.lastIndexOf('.')); //뒤에서부터 .을 기준으로 자른다.  substring 이름 짜르기
			String ext = orgName.substring(orgName.lastIndexOf('.'));
			long date = System.currentTimeMillis();
			newName = imgName + date + ext;
			
			String path = request.getRealPath("save");  // 파일경로가져오기
			//System.out.println("path : " + path);		//파일위치출력
			String imgPath = path + "\\" + newName;		//파일위치 + 이미지 이름
			File copyFile = new File(imgPath);			// 파일객체 생성 
			mf.transferTo(copyFile);// 폴더에 저장
		
			pet_infoDTO.setPet_profile(newName);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		petDAO.petUploadImg(pet_infoDTO); 				// 새로운 이미지 DB에 저장
		String newImg = petDAO.getPetImg(pet_infoDTO); 	// 새로운 이미지 veiw 페이지에 넘기기
		
		return newImg;
	}//petUploadImg
	
	// 펫 질환,접종,수술 추가하기 ajax
	@Override
	public void petSickModify(Map<Object, Object> data) throws Exception {
		Pet_SickDTO pet_SickDTO = new Pet_SickDTO();
		pet_SickDTO.setUser_id(getSession());
		pet_SickDTO.setPet_number(Integer.parseInt(data.get("pet_number").toString()));
		pet_SickDTO.setSick_status(Integer.parseInt(data.get("sick_status").toString()));
		pet_SickDTO.setPet_sickname((String)data.get("pet_sickname"));
		pet_SickDTO.setPet_sickday((String)data.get("pet_sickday"));
		pet_SickDTO.setPet_hospital((String)data.get("pet_hospital"));
		
		// 보유질환이 추가했을 경우 저장
		if(!(pet_SickDTO.getSick_status() == 3 || pet_SickDTO.getPet_sickname().equals("N") || pet_SickDTO.getPet_sickday().equals("N") || pet_SickDTO.getPet_hospital().equals("N"))) {
			petDAO.insertPetSick(pet_SickDTO);						// 보유질환 DB저장
		
		}//if
		
		Pet_JJDTO pet_JJDTO = new Pet_JJDTO();
		pet_JJDTO.setUser_id(getSession());
		pet_JJDTO.setPet_number(Integer.parseInt(data.get("pet_number").toString()));
		pet_JJDTO.setPet_jjname((String)data.get("pet_jjname"));
		pet_JJDTO.setPet_jjday((String)data.get("pet_jjday"));
		pet_JJDTO.setPet_jjhospital((String)data.get("pet_jjhospital"));
		
		// 접종기록이 추가했을 경우 저장
		if(!(pet_JJDTO.getPet_jjname().equals("N") || pet_JJDTO.getPet_jjday().equals("N")|| pet_JJDTO.getPet_jjhospital().equals("N"))) {
			petDAO.insertPetJJ(pet_JJDTO);							// 접종기록 DB저장
		
		}//if
		
		Pet_SurgDTO pet_SurgDTO = new Pet_SurgDTO();
		pet_SurgDTO.setUser_id(getSession());
		pet_SurgDTO.setPet_number(Integer.parseInt(data.get("pet_number").toString()));
		pet_SurgDTO.setPet_surgname((String)data.get("pet_surgname"));
		pet_SurgDTO.setPet_surgday((String)data.get("pet_surgday"));
		pet_SurgDTO.setPet_surghospi((String)data.get("pet_surghospi"));
		
		// 수술 기록이 추가 했을경우 저장
		if(!(pet_SurgDTO.getPet_surgname().equals("N") || pet_SurgDTO.getPet_surgday().equals("N") || pet_SurgDTO.getPet_surghospi().equals("N"))) {
			petDAO.insertPetSurg(pet_SurgDTO);						// 수술기록 DB저장
			
		}//if
		
	}//petSickModify
	
	// Service에서 사용할 세션 메서드로 사용
	private String getSession() {
		//request 객체
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		//세션 꺼내기
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("memId");
		return user_id;
	}//getSession
	
	
	
	
}//PetServiceImpl

package cdd.service.bean;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.Pet_JJDTO;
import cdd.model.dto.Pet_SickDTO;
import cdd.model.dto.Pet_SurgDTO;

public interface PetService {

	// 펫 Info 정보 저장하기
	public void insertPetInfo(Pet_InfoDTO pet_InfoDTO, MultipartHttpServletRequest request,Pet_SickDTO pet_SickDTO, Pet_JJDTO pet_JJDTO, Pet_SurgDTO pet_SurgDTO) throws Exception;
	
	
	
	// 펫 고유번호로 Info정보,질환기록,접종기록,수술기로가져오기
	public Map getPetOneInfo(String user_id, Integer pet_number) throws Exception;
	// 유저에 저장된 펫 정보 가져오기
	public Map getPetInfoList(String profileId) throws Exception;
	// 펫 종류 List 가져오기
	public Map getPetType() throws Exception;
	// 펫 품종 List 가져오기
	public List getPetKind(Integer pet_num) throws Exception;
	
	// 펫 Info 수정하기 ajax
	public void petModifyInfo(Map<Object, Object> data) throws Exception;
	
	// 펫 이미지 수정 ajax
	public String petUploadImg(MultipartHttpServletRequest request) throws Exception;
	
	// 펫 질환,접종,수술 추가하기 ajax
	public void petSickModify(Map<Object, Object> data) throws Exception;
	
	
	
	
}//PetService

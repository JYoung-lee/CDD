package cdd.model.dao;

import java.sql.SQLException;
import java.util.List;

import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.Pet_JJDTO;
import cdd.model.dto.Pet_SickDTO;
import cdd.model.dto.Pet_SurgDTO;

public interface PetDAO {
	// 펫 종류 가져오기
	public List getPetTypes() throws Exception;
	
	// 펫 추가하기
	public void insertPetType(String petType) throws Exception;
	
	// 펫 삭제하기
	public void deletePetType(Integer typeNum) throws Exception;
	
	// 펫 품종 가져오기
	public List getKindList(Integer typeNum) throws Exception;
	
	// 펫 품종 추가하기
	public void insertPetKind(String kindName, Integer typeNum) throws Exception;
	
	// 펫 품종 삭제하기
	public void deletePetKind(Integer kindNum) throws Exception;
	
	// pet_Info 저장하기
	public void insertPetInfo(Pet_InfoDTO pet_InfoDTO) throws SQLException;
	// pet 질환 저장하기
	public void insertPetSick(Pet_SickDTO pet_SickDTO) throws SQLException;  
	// pet 접종기록 저장하기
	public void insertPetJJ(Pet_JJDTO pet_JJDTO) throws SQLException;
	// pet 수술기록 저장하기
	public void insertPetSurg(Pet_SurgDTO pet_SurgDTO) throws SQLException;
	
	// 유저의 펫 등록되어있는지 카운트
	public int getPetInfoCount(String user_id) throws SQLException;
	// 유저에 해당하는 펫 정보 가져오기
	public List<Object> getPetInfoList(String user_id) throws SQLException;
	
	// 해당 유저와 펫 질환 등록 카운트
	public int getSickCount(String user_id, Integer pet_number) throws SQLException;
	// 해당 유저와 펫 접종 등록 카운트
	public int getJJCount(String user_id, Integer pet_number) throws SQLException;
	// 해당 유저와 펫 수술 등록 카운트
	public int getSurgCount(String user_id, Integer pet_number) throws SQLException;
	
	// user_id, pet고유번호로 펫 정보 가져오기
	public Pet_InfoDTO getPetOneInfo(String user_id, Integer pet_number)throws SQLException;
	// user_id, pet고유번호로 펫 질환기록 가져오기
	public List<Object> getPetOneSick(String user_id, Integer pet_number)throws SQLException;
	// user_id, pet고유번호로 펫 접종기록 가져오기
	public List<Object> getPetOnejj(String user_id, Integer pet_number)throws SQLException;
	// user_id, pet고유번호로 펫 수술기록 가져오기
	public List<Object> getPetOneSurg(String user_id, Integer pet_number)throws SQLException;
	
	// 펫 Number 가져오기 (UserId,pet_name)
	public Pet_InfoDTO getPetNumber(String user_id, String pet_name) throws SQLException;
	// 펫 종류List 가져오기
	public List<Object> getPetType() throws SQLException;
	// 펫 품종List 가져오기
	public List<Object> getPetKind(Integer pet_num) throws SQLException;
	// 해당 유저의 펫 종류 가져오기
	public String getOnePetType(Integer type_num) throws SQLException;
	// 해당 유저의 펫 품종 가져오기
	public String getOnePetKind(Integer kind_num) throws SQLException;
	
	// petInfo 수정하기 ajax
	public void petModifyInfo(Pet_InfoDTO pet_infoDTO) throws SQLException;
	// 펫 이미지 변경 ajax
	public void petUploadImg(Pet_InfoDTO pet_infoDTO) throws SQLException;
	// 펫 해당 이미지 가져오기 ajax
	public String getPetImg(Pet_InfoDTO pet_infoDTO) throws SQLException;
}

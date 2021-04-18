package cdd.model.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cdd.model.dto.Pet_InfoDTO;
import cdd.model.dto.Pet_JJDTO;
import cdd.model.dto.Pet_SickDTO;
import cdd.model.dto.Pet_SurgDTO;

@Repository
public class PetDAOImpl implements PetDAO{
	@Autowired
	private SqlSession sqlSession = null;
	
	// 펫 종류 가져오기
	@Override
	public List getPetTypes() throws Exception {
		List petTypes = sqlSession.selectList("pet.getPetTypes");
		return petTypes;
	}
	
	// 펫 종류 추가하기
	@Override
	public void insertPetType(String petType) throws Exception {
		sqlSession.update("pet.insertPetType", petType);
	}
	
	// 펫 종류 삭제하기
	@Override
	public void deletePetType(Integer typeNum) throws Exception {
		sqlSession.delete("pet.deletePetType", typeNum);
	}
	
	// 펫 품종 가져오기
	@Override
	public List getKindList(Integer typeNum) throws Exception {
		List kindList = sqlSession.selectList("pet.getKindList", typeNum);
		return kindList;
	}
	
	// 펫 품종 추가하기
	@Override
	public void insertPetKind(String kindName, Integer typeNum) throws Exception {
		Map args = new HashMap();
		args.put("kindName", kindName);
		args.put("typeNum", typeNum);
		sqlSession.insert("pet.insertPetKind", args);
	}
	
	// 펫 품종 삭제하기
	@Override
	public void deletePetKind(Integer kindNum) throws Exception {
		sqlSession.delete("pet.deletePetKind", kindNum);
	}
	
	// pet_Info 저장하기
	@Override
	public void insertPetInfo(Pet_InfoDTO pet_InfoDTO) throws SQLException {
		sqlSession.insert("pet.insertPetInfo", pet_InfoDTO);
	}//insertPetInfo
	
	// pet 질환 저장하기
	@Override
	public void insertPetSick(Pet_SickDTO pet_SickDTO) throws SQLException {
		sqlSession.insert("pet.insertPetSick", pet_SickDTO);
	}//insertPetSick
	
	// pet 접종기록 저장하기
	@Override
	public void insertPetJJ(Pet_JJDTO pet_JJDTO) throws SQLException {
		sqlSession.insert("pet.insertPetJJ", pet_JJDTO);
	}//insertPetJJ

	// pet 수술기록 저장하기
	@Override
	public void insertPetSurg(Pet_SurgDTO pet_SurgDTO) throws SQLException {
		sqlSession.insert("pet.insertPetSurg", pet_SurgDTO);
	}//insertPetSurg
	
	// 펫 정보있는지 카운트 가져오기
	@Override
	public int getPetInfoCount(String user_id) throws SQLException {
		int count = sqlSession.selectOne("pet.getPetInfoCount", user_id);
		return count;
	}//getPetInfoCount
	
	// 유저에 해당하는 펫 정보 가져오기
	@Override
	public List<Object> getPetInfoList(String user_id) throws SQLException {
		List<Object> petInfoList = sqlSession.selectList("pet.getPetInfoList", user_id);
		return petInfoList;
	}//getPetInfoList
	
	
	// 해당 유저와 펫 질환 등록 카운트
	@Override
	public int getSickCount(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> sickMap = new HashMap<String, Object>();
		sickMap.put("user_id", user_id);
		sickMap.put("pet_number", pet_number);
		
		int sickCount = sqlSession.selectOne("pet.getSickCount", sickMap);
		return sickCount;
	}//getSickCount
	// 해당 유저와 펫 접종 등록 카운트
	@Override
	public int getJJCount(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> jjMap = new HashMap<String, Object>();
		jjMap.put("user_id", user_id);
		jjMap.put("pet_number", pet_number);
		
		int jjCount = sqlSession.selectOne("pet.getJJCount", jjMap);
		
		return jjCount;
	}//getJJCount
	// 해당 유저와 펫 수술 등록 카운트
	@Override
	public int getSurgCount(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> surgMap = new HashMap<String, Object>();
		surgMap.put("user_id", user_id);
		surgMap.put("pet_number", pet_number);
		
		int surgCount = sqlSession.selectOne("pet.getSurgCount", surgMap);
		
		return surgCount;
	}//getSurgCount
	
	// user_id, pet고유번호로 펫 정보 가져오기
	@Override
	public Pet_InfoDTO getPetOneInfo(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> infoMap = new HashMap<String, Object>();
		infoMap.put("user_id", user_id);
		infoMap.put("pet_number", pet_number);
		Pet_InfoDTO pet_infoDTO = sqlSession.selectOne("pet.getPetOneInfo", infoMap);
		
		return pet_infoDTO;
	}//getPetOneInfo
	
	// user_id, pet고유번호로 펫 질환 가져오기
	@Override
	public List<Object> getPetOneSick(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> sickMap = new HashMap<String, Object>();
		sickMap.put("user_id", user_id);
		sickMap.put("pet_number", pet_number);
		List<Object> pet_sickDTOList = sqlSession.selectList("pet.getPetSickList", sickMap);
		return pet_sickDTOList;
	}//getPetOneSick
	
	// user_id, pet고유번호로 펫 접종기록 가져오기
	@Override
	public List<Object> getPetOnejj(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> jjMap = new HashMap<String, Object>();
		jjMap.put("user_id", user_id);
		jjMap.put("pet_number", pet_number);
		List<Object> pet_jjDTOList = sqlSession.selectList("pet.getPetjjList", jjMap);
		return pet_jjDTOList;
	}//getPetOnejj
	
	// user_id, pet고유번호로 펫 수술기록 가져오기
	@Override
	public List<Object> getPetOneSurg(String user_id, Integer pet_number) throws SQLException {
		Map<String , Object> surgMap = new HashMap<String, Object>();
		surgMap.put("user_id", user_id);
		surgMap.put("pet_number", pet_number);
		List<Object> pet_surgDTOList = sqlSession.selectList("pet.getPetSurgList", surgMap);
		return pet_surgDTOList;
	}//Pet_SurgDTO
	
	// 펫 Number 가져오기
	@Override
	public Pet_InfoDTO getPetNumber(String user_id, String pet_name) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("pet_name", pet_name);
		
		Pet_InfoDTO pet_InfoDTO = sqlSession.selectOne("pet.getPetNumber", map);
		return pet_InfoDTO;
	}//getPetNumber

	// 펫 종류 List 가져오기
	@Override
	public List<Object> getPetType() throws SQLException {
		List<Object> pettype = sqlSession.selectList("pet.getType");
		
		return pettype;
	}//getPetType
	
	// 펫 품종 List 가져오기
	@Override
	public List<Object> getPetKind(Integer type_num) throws SQLException {
		List<Object> petkind = sqlSession.selectList("pet.getKind", type_num);
		
		return petkind;
	}//getPetKind
	
	// 해당 유저의 펫 종류 가져오기
	@Override
	public String getOnePetType(Integer type_num) throws SQLException {
		String pet_typeName = sqlSession.selectOne("pet.getOnePetType", type_num);
		return pet_typeName;
	}//getOnePetType
	
	// 해당 유저의 펫 품종 가져오기
	@Override
	public String getOnePetKind(Integer kind_num) throws SQLException {
		String pet_kindName =sqlSession.selectOne("pet.getOnePetKind", kind_num);
		return pet_kindName;
	}//getOnePetKind
	
	// petInfo 수정하기 ajax
	@Override
	public void petModifyInfo(Pet_InfoDTO pet_infoDTO) throws SQLException {
		sqlSession.update("pet.petModifyInfo", pet_infoDTO);
		
	}//petModifyInfo
	
	// 펫 이미지 변경 ajax
	@Override
	public void petUploadImg(Pet_InfoDTO pet_infoDTO) throws SQLException {
		sqlSession.update("pet.petUploadImg", pet_infoDTO);
	}//petUploadImg
	
	// 펫 해당 이미지 가져오기 ajax
	@Override
	public String getPetImg(Pet_InfoDTO pet_infoDTO) throws SQLException {
		// TODO Auto-generated method stub
		String newImg = sqlSession.selectOne("pet.getPetImg", pet_infoDTO);
		
		return newImg;
	}//getPetImg
}

package cdd.service.bean;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dto.FeedsDTO;
import cdd.model.dto.Get_RepliesDTO;


public interface FeedsService {
	
	public void feedWrite(FeedsDTO dto, MultipartHttpServletRequest request) throws Exception;
	public Map getFeed(Integer feed_num) throws Exception;
	public List<Get_RepliesDTO> RepliesProcess(Map<Object, Object> map) throws Exception;
	public Map heartProcess(Map<Object, Object> map) throws Exception;
	public Map followProcess(Map<Object, Object> map) throws Exception;
	public Map bookmarkProcess(Map<Object, Object> map) throws Exception;
	
	
	
	
	
}

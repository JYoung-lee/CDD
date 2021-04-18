package cdd.controller.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import cdd.model.dto.Feed_RepliesDTO;
import cdd.model.dto.FeedsDTO;
import cdd.model.dto.Get_RepliesDTO;
import cdd.service.bean.FeedsService;

@Controller
@RequestMapping("/feeds/")
public class FeedsController {
	
	@Autowired
	private FeedsService feedService = null;
	
	@RequestMapping("feedWriteForm.cdd")
	public String feedWriteForm(FeedsDTO dto, Model model) throws Exception{
		String user_id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		model.addAttribute("user_id", user_id);
		
		return "feeds/feedWriteForm";
	}
	
	@RequestMapping("feedWritePro.cdd")
	public String feedWritePro(FeedsDTO dto, MultipartHttpServletRequest request) throws Exception{
		
		
		feedService.feedWrite(dto, request);
		
		return "redirect:/main.cdd";
	}
	
	@RequestMapping("test.cdd") // 테스트는 나중에 지울것
	public String test() {
		return "feeds/test";
	}
	
	@RequestMapping("login.cdd")
	public String login() {
		
		return "feeds/login";
	}
	
	@RequestMapping("feedContent.cdd")
	public String feedContent(int feed_num, Model model, int index2) throws Exception{
		String user_id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		Map result = feedService.getFeed(feed_num);
		model.addAttribute("index2", index2);
		model.addAttribute("photos", result.get("photos"));
		model.addAttribute("feed", result.get("feed"));
		model.addAttribute("user_id", user_id);
		model.addAttribute("replies", result.get("replies"));
		model.addAttribute("likeCh", result.get("likeCh"));
		model.addAttribute("countLikes", result.get("countLikes"));
		model.addAttribute("followCh", result.get("followCh"));
		model.addAttribute("bookCh", result.get("bookCh"));
		return "feeds/feedContent";
	}
	
	@RequestMapping("feedContent2.cdd")
	public String feedContent(int feed_num, Model model) throws Exception{
		String user_id = (String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);
		
		Map result = feedService.getFeed(feed_num);
		model.addAttribute("photos", result.get("photos"));
		model.addAttribute("feed", result.get("feed"));
		model.addAttribute("user_id", user_id);
		model.addAttribute("replies", result.get("replies"));
		model.addAttribute("likeCh", result.get("likeCh"));
		model.addAttribute("countLikes", result.get("countLikes"));
		model.addAttribute("followCh", result.get("followCh"));
		model.addAttribute("bookCh", result.get("bookCh"));
		if(user_id.equals("admin")) {
			return "feeds/feedContentAdmin";
		}
		return "feeds/feedContent";
	}
	
	
	
	@RequestMapping("test2.cdd") // 테스트는 나중에 지울것
	public String test2() {
		return "feeds/test2";
	}
	
	@ResponseBody
	@RequestMapping(value = "feed_reply_level0.cdd", method = RequestMethod.POST)
	public String reply_level0(@RequestBody Map<Object, Object> map) throws Exception {
		
		ObjectMapper mapper = new ObjectMapper();
		
		List<Get_RepliesDTO> replies = feedService.RepliesProcess(map);
		String json = mapper.writeValueAsString(replies);
		
		return json;
	} 
	
	@ResponseBody
	@RequestMapping(value = "heartProcess.cdd", method = RequestMethod.POST)
	public String heartProcess(@RequestBody Map<Object, Object> map) throws Exception {
		
		ObjectMapper mapper = new ObjectMapper();
		Map jsonMap = feedService.heartProcess(map);
		String json = mapper.writeValueAsString(jsonMap);
		
		return json;
	} 
	
	@ResponseBody
	@RequestMapping(value = "followProcess.cdd", method = RequestMethod.POST)
	public String followProcess(@RequestBody Map<Object, Object> map) throws Exception {
		
		Map followCh = feedService.followProcess(map);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(followCh);
		return json;
	} 
	
	@ResponseBody
	@RequestMapping(value = "bookmarkProcess.cdd", method = RequestMethod.POST)
	public String bookmarkProcess(@RequestBody Map<Object, Object> map) throws Exception {
		
		Map bookMark = feedService.bookmarkProcess(map);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(bookMark);
		return json;
	} 
	
	
	@RequestMapping("reportPage.cdd") // 테스트는 나중에 지울것
	public String reportPage() {
		return "feeds/report";
	}
	
	
	


	
}

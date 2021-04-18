package cdd.controller.bean;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import cdd.model.dto.FeedsDTO;
import cdd.model.dto.UserDTO;
import cdd.service.bean.FeedsService;
import cdd.service.bean.MainService;
import cdd.service.bean.MyPageService;

@Controller
public class MainController {
	@Autowired
	private MainService mainService = null;
	@Autowired
	private MyPageService myPageService = null;
	
	// main 페이지
	@RequestMapping("main.cdd")
	public String main(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("memId");
				
		model.addAttribute("user_id", userId);
		if(userId == null) {
			return "redirect:/user/loginForm.cdd";
		}
		int pageNum = 1;
		Map result = mainService.followsMainFeed(userId, pageNum);
		
		List follwofeedList = (List)result.get("follwofeedList");
		
		model.addAttribute("follwofeedList", result.get("follwofeedList"));
		model.addAttribute("mainFeedCount", Integer.parseInt(result.get("mainFeedCount").toString()));
		
		for(int i =0; i < follwofeedList.size();i++) {
			
			
			FeedsDTO dto = (FeedsDTO)follwofeedList.get(i);
			
			List PhotoList = (List)result.get(dto.getFeed_num());
			model.addAttribute("photoList" + i , PhotoList);
		}
		return "main/main";
	}
	
	// 전체 피드 페이지
	@RequestMapping("mainAllFeed.cdd")
	public String mainAllFeed(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("memId");
		if(userId == null) {
			return "redirect:/user/loginForm.cdd";
		}
		int pageNum = 1;
		Map result = mainService.getMainAllFeed(pageNum);
		
		model.addAttribute("mainAllFeed", result.get("mainAllFeed"));
		model.addAttribute("allCount", result.get("allCount"));
		
		return "main/mainAllFeed";
	}
	
	// 헤더 호출
	@RequestMapping("header.cdd")
	public String header(HttpServletRequest request, Model model,String category) throws Exception{
		
		if(category == null) {
			category = "main";
		}
		System.out.println(category);
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		UserDTO userDto = mainService.getUserInfo(memId);
		int dmCnt = mainService.getUnChDmCnt(memId);
		int alarmCnt = mainService.getUnChAlrmCnt(memId);
		model.addAttribute("userDto", userDto);
		model.addAttribute("dmRes", dmCnt);
		model.addAttribute("alarmRes", alarmCnt);
		model.addAttribute("user_id", memId);
		model.addAttribute("category", category);
		return "header/header";
	}
	
	// dm 페이지
	@RequestMapping("dm.cdd")
	public String dm(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("memId");
		if(userId == null) {
			return "redirect:/user/loginForm.cdd";
		}else {
			UserDTO user = mainService.getUserInfo(userId);
			Map chatUserAndStatus = mainService.getChatUserAndStatus(userId);
			List followList = mainService.getFollowList(userId);
			model.addAttribute("chatUserAndStatus", chatUserAndStatus);
			model.addAttribute("user", user);
			model.addAttribute("followList", followList);
		}
		return "main/dm";
	}
	
	// dm : 팔로우 리스트 페이지
	@RequestMapping("followerList.cdd")
	public String followerList(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("memId");
		if(userId == null) {
			return "redirect:/user/loginForm.cdd";
		}
		
		List followList = mainService.getFollowList(userId);
		model.addAttribute("followList", followList);
		
		return  "main/followerList";
	}
	
	// 알람 (헤더) modal 페이지
	@RequestMapping("alarm.cdd")
	public String alarm(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String sessId = (String)session.getAttribute("memId");
		if(sessId == null) {
			return "redirect:/user/loginForm.cdd";
		}else {
			// url 요청시 alarms 테이블 status 모두 확인으로 변경
			mainService.updateAlarmStatus(sessId);
			
			List alarms = mainService.getAlarms(sessId);
			model.addAttribute("alarms", alarms);
		}
		
		return "main/alarm";
	}
	
	// 검색결과 페이지
	@RequestMapping("searchResult.cdd")
	public String searchResult(String search, HttpSession session, Model model) throws Exception{
		String memId = (String)session.getAttribute("memId");
		Map hashResult = mainService.getSearchTags(search, memId);
		List searchFeeds = mainService.getSearchFeeds(search, memId);
		List searchUsers = mainService.getSearchUsers(search);
		model.addAttribute("search", search);
		model.addAttribute("searchTags", hashResult.get("searchTags"));
		model.addAttribute("searchTagCount", hashResult.get("searchTagCount"));
		
		model.addAttribute("searchFeeds", searchFeeds);
		model.addAttribute("searchUsers", searchUsers);
		return "main/searchResult";
	}
	
	// ajax : dm 이력 리스트
	@ResponseBody
	@RequestMapping(value = "ajaxGetDmList.cdd", method = RequestMethod.POST)
	public String ajaxGetDmList(@RequestBody Map<Object, Object> map) throws Exception {
		String memId = (String)map.get("memId");
		String chatId = (String)map.get("chatId");
		List dmList = mainService.getDmList(chatId, memId);
		mainService.updateStatus(chatId, memId);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(dmList);
		
		return json;
	}
	
	// ajax : dm 메세지 보내기
	@ResponseBody
	@RequestMapping(value = "ajaxSendDm.cdd", method = RequestMethod.POST)
	public void ajaxSendDm(@RequestBody Map<Object, Object> map) throws Exception {
		mainService.insertDm(map);
	}
	
	// ajax : dm 대화 이력 삭제하기
	@ResponseBody
	@RequestMapping(value = "ajaxDeleteDM.cdd", method = RequestMethod.POST)
	public void ajaxDeleteDm(@RequestBody Map<Object, Object> map) throws Exception {
		mainService.deleteDm(map);
	}
	
	// 스크롤 내려오면 피드 추가 [4.4 훈영 추가]
		@ResponseBody
		@RequestMapping(value = "appendFeeds.cdd", method = RequestMethod.POST)
		public String appendFeeds(@RequestBody Map<Object, Object> map, HttpServletRequest request) throws Exception {
			HttpSession session = request.getSession();
			String userId = (String)session.getAttribute("memId");
			int pageNum = Integer.parseInt(map.get("pageNum").toString());
			
			ObjectMapper mapper = new ObjectMapper();
			Map jsonMap = mainService.followsMainFeed(userId, pageNum);
			String json = mapper.writeValueAsString(jsonMap);
			
			return json;
		}
		
	// 메인 올피드 스크롤 내려오면 추가
		@ResponseBody
		@RequestMapping(value = "appendAllFeeds.cdd", method = RequestMethod.POST)
		public String appendAllFeeds(@RequestBody Map<Object, Object> map, HttpServletRequest request) throws Exception {
			HttpSession session = request.getSession();
			String userId = (String)session.getAttribute("memId");
			int pageNum = Integer.parseInt(map.get("pageNum").toString());
			ObjectMapper mapper = new ObjectMapper();
			Map jsonMap = mainService.getMainAllFeed(pageNum);
			String json = mapper.writeValueAsString(jsonMap);
			
			return json; 
		}
		
		//에러 페이지
		@RequestMapping("errorPage.cdd")
		public String errorPage() {
			return "errorPage/errorPage";
		}
		
		
}

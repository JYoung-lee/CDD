package cdd.service.bean;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cdd.model.dao.AlarmsDAO;
import cdd.model.dao.FeedsDAO;
import cdd.model.dao.UserDAO;
import cdd.model.dto.Feed_PhotosDTO;
import cdd.model.dto.FeedsDTO;
import cdd.model.dto.Get_RepliesDTO;

@Service
public class FeedsServiceImpl implements FeedsService {

	@Autowired
	private FeedsDAO feedsDAO = null;
	@Autowired
	private AlarmsDAO alarmsDAO = null;
	

	@Override // 게시글 저장 로직
	public void feedWrite(FeedsDTO dto, MultipartHttpServletRequest request) throws Exception {

		String newName = null;
		List<MultipartFile> fileList = null;
		Feed_PhotosDTO feed_photoDTO = null;
		List<Feed_PhotosDTO> photos = new ArrayList<Feed_PhotosDTO>();
		Integer count = 0;
		Integer nextNum = feedsDAO.nextFeedNum();
		dto.setFeed_num(nextNum);

		try {
			fileList = request.getFiles("photo_dir");
			for (MultipartFile mf : fileList) {
				feed_photoDTO = new Feed_PhotosDTO();
				String orgName = mf.getOriginalFilename();
				// 이름 나누기 확장자 빼기
				String imgName = orgName.substring(0, orgName.lastIndexOf('.'));
				// 확장자 가져오기
				String ext = orgName.substring(orgName.lastIndexOf('.'));
				// 시간 추가한 새이름 저장될 이름!
				long date = System.currentTimeMillis();
				newName = dto.getUser_id() + imgName + date + ext;
				feed_photoDTO.setPhoto_dir(newName);
				feed_photoDTO.setPhoto_order(count);
				feed_photoDTO.setFeed_num(nextNum); // 이거 변경해야됨
				photos.add(feed_photoDTO);
				// 파일 저장
				String path = request.getRealPath("save");
				String imgPath = path + "\\" + newName;
				File copyFile = new File(imgPath);
				mf.transferTo(copyFile);
				count++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		feedsDAO.feedWrite(dto, photos);

	}

	@Override
	public Map getFeed(Integer feed_num) throws Exception {

		Map map = new HashMap();
		String user_id = (String) RequestContextHolder.getRequestAttributes().getAttribute("memId",
				RequestAttributes.SCOPE_SESSION);
		FeedsDTO feedDTO = feedsDAO.getFeed(feed_num);
		List<Feed_PhotosDTO> photos = feedsDAO.getPhotos(feed_num);
		List<Get_RepliesDTO> replies = feedsDAO.getReplies(feed_num);
		int countLikes = feedsDAO.countLikes(feed_num);
		int likeCh = feedsDAO.likeCh(feed_num, user_id);
		int followCh = feedsDAO.followCh(user_id, feedDTO.getUser_id());
		int bookCh = feedsDAO.bookCh(user_id, feed_num);
		map.put("feed", feedDTO);
		map.put("photos", photos);
		map.put("replies", replies);
		map.put("likeCh", likeCh);
		map.put("countLikes", countLikes);
		map.put("followCh", followCh);
		map.put("bookCh", bookCh);
		return map;
	}

	@Override
	public List<Get_RepliesDTO> RepliesProcess(Map<Object, Object> map) throws Exception {

		feedsDAO.insertReply(map);

		int feed_num = Integer.parseInt(map.get("feed_num").toString());
		List<Get_RepliesDTO> replies = feedsDAO.getReplies(feed_num);

		return replies;

	}

	@Override
	public Map heartProcess(Map<Object, Object> map) throws Exception {

		Integer likeCh = Integer.parseInt(map.get("likeCh").toString());
		Integer index2 = Integer.parseInt(map.get("index2").toString());
		Map result = null;

		if (likeCh == 0) { // 좋아요 눌렀을때
			Integer feed_num = Integer.parseInt(map.get("feed_num").toString());
			
			String user_id = map.get("user_id").toString();
			feedsDAO.insertLike(feed_num, user_id);
			String alarm_content = "님이 회원님의 게시물을 좋아합니다.";
			String user_to = map.get("user_to").toString();
			
			alarmsDAO.insertAlarm(feed_num, user_id, alarm_content,user_to);
			likeCh = feedsDAO.likeCh(feed_num, user_id);
			Integer likeCount = feedsDAO.countLikes(feed_num);
			
			result = new HashMap();

			result.put("user_id", user_id);
			result.put("feed_num", feed_num);
			result.put("likeCh", likeCh);
			result.put("user_to", user_to);
			result.put("index2", index2);
			result.put("likeCount", likeCount);
		} else if (likeCh == 1) { // 좋아요 취소했을때
			Integer feed_num = Integer.parseInt(map.get("feed_num").toString());
			String user_id = map.get("user_id").toString();
			String user_to = map.get("user_to").toString();
			feedsDAO.deleteLike(feed_num, user_id);
			alarmsDAO.deleteAlarm(feed_num, user_id);
			likeCh = feedsDAO.likeCh(feed_num, user_id);
			Integer likeCount = feedsDAO.countLikes(feed_num);
			result = new HashMap();

			result.put("user_id", user_id);
			result.put("feed_num", feed_num);
			result.put("likeCh", likeCh);
			result.put("user_to", user_to);
			result.put("index2", index2);
			result.put("likeCount", likeCount);
		}

		return result;
	}
	
	@Override
	public Map followProcess(Map<Object, Object> map) throws Exception {
		
		
		String user_from = map.get("user_from").toString();
		String user_to = map.get("user_to").toString();
		Integer followCh = Integer.parseInt(map.get("followCh").toString());
		Map result = null;
		
		if(followCh == 0) {
			feedsDAO.insertFollow(user_from, user_to);
			String alarm_content = "님이 회원님을 팔로우하기 시작했습니다";
			alarmsDAO.insertAlarm(user_from, user_to, alarm_content);
			followCh = feedsDAO.followCh(user_from, user_to);
			result = new HashMap();
			result.put("user_from", user_from);
			result.put("user_to", user_to);
			result.put("followCh", followCh);
			
			
		}else if(followCh == 1) {
			feedsDAO.deleteFollow(user_from, user_to);
			followCh = feedsDAO.followCh(user_from, user_to);
			alarmsDAO.deleteAlarm(user_from, user_to);
			result = new HashMap();
			result.put("user_from", user_from);
			result.put("user_to", user_to);
			result.put("followCh", followCh);
		}
		
		
		 
		
		
		
		
		
		return result;
	}
	
	@Override
		public Map bookmarkProcess(Map<Object, Object> map) throws Exception {
		
			String user_id = map.get("user_id").toString();
			int feed_num = Integer.parseInt(map.get("feed_num").toString());
			int bookCh = Integer.parseInt(map.get("bookCh").toString());
			Map result = null;
			
			if(bookCh == 0) {
				feedsDAO.insertBookmark(user_id, feed_num);
				bookCh = feedsDAO.bookCh(user_id, feed_num);
				result = new HashMap();
				result.put("user_id", user_id);
				result.put("feed_num", feed_num);
				result.put("bookCh", bookCh);
			}else if(bookCh == 1) {
				feedsDAO.deleteBookmark(user_id, feed_num);
				bookCh = feedsDAO.bookCh(user_id, feed_num);
				result = new HashMap();
				result.put("user_id", user_id);
				result.put("feed_num", feed_num);
				result.put("bookCh", bookCh);
				
			}
			
			
		
		
		
			return result;
		}	

}

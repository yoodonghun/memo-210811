package com.memo.post.bo;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	private static final int POST_MAX_SIZE = 2;
	
   public List<Post> getPostListByUserId(int userId, Integer prevId, Integer nextId) {
	   
	// 페이징 계산
			// 게시글 번호: 10 9 8 | 7 6 5 | 4 3 2 | 1
			//-- 만약 7 6 5 에서
				//  1) 이전 눌렀을 때: 7보다 큰 3개 가져오고 코드에서 reverse
				//  2) 다음 눌렀을 때: 5보다 작은 3개
			Integer standardId = null;
			String direction = null;
			if (prevId != null) {
				// '이전' 클릭
				direction = "prev";
				standardId = prevId;
				
				// 7보다 큰 3개   8 9 10이 나오므로 reverse 정렬 시킨다.
				List<Post> postList = postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
				Collections.reverse(postList);
				return postList;
			} else if (nextId != null) {
				// '다음' 클릭
				direction = "next";
				standardId = nextId;
			}
	   
	   
	   
	   
	   return postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
   }
   
  
}

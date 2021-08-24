package com.memo.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	
	@Autowired
	private PostBO postBO;
   
	@RequestMapping("/post_list_view")
	public String postListView(
			@RequestParam(value = "prevId", required=false) Integer prevIdParam,
			@RequestParam(value = "nextId", required=false) Integer nextIdParam,
			HttpServletRequest request, 
			Model model) {
		
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId == null) {
			//session 정보에 아이디가 없으면 => 로그인 페이지로 리다이렉트
			return "redirect:/user/sign_in_view";
		}
		
				
		List<Post> postList = postBO.getPostListByUserId(userId, prevIdParam, nextIdParam);
		if(postList.isEmpty() == false) {
			int prevId = postList.get(0).getId();
		    int nextId = postList.get(postList.size() - 1).getId();
		    
		    model.addAttribute("postList", postList); //리스트 중 가장 앞쪽(제일 큰 아이디)
			model.addAttribute("viewName", "post/post_list");// 리스트 중 가장 뒷쪽(제일 작은 아이디)
			model.addAttribute("prevId", prevId);
			model.addAttribute("nextId", nextId);
		}
		
		
		
		
		
		
		
		
		// 이전이나 다음이 없는 경우 nextId, prevId를 0으로 세팅한다.(뷰화면에서 0인지 검사)
		
		
		return "template/layout";
	}
}

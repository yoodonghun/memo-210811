package com.memo.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/post")
@Controller
public class PostController {
   
	@RequestMapping("/post_list_view")
	public String postListView(HttpServletRequest request, 
			Model model) {
		
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId == null) {
			//session 정보에 아이디가 없으면 => 로그인 페이지로 리다이렉트
		}
		
		model.addAttribute("viewName", "post/post_list");
		
		return "redirect:/user/sign_in_view";
	}
}

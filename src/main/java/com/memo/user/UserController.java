package com.memo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;

/*
 * 화면만 구성하는 컨트롤러
 * @author 
 * */
@RequestMapping("/user")
@Controller
public class UserController {
	@Autowired
	private UserBO userBO;
	
   
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/sign_up");
		return "template/layout";
	}
	
	/**
	 * 회원가입을 하는 서브밋 - NON AJAX
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return 로그인 화면으로 redirect
	 */
	@RequestMapping("/sign_up_for_submit")
	public String signUpForSubmit(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
	        @RequestParam("email") String email) {
		
		//암호화
		String encryptPassword = EncryptUtils.md5(password);
		//DB insert
		userBO.addUser(loginId, encryptPassword, name, email);
		
		return "redirect:/user/sign_up_view";
	}
	
}

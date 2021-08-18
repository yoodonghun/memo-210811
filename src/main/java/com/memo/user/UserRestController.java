package com.memo.user;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

/**
 * 데이터만 처리하는 API용 컨트롤러
 * @author user
 *
 */
@RequestMapping("/user")
@RestController //Controller + ResponseBody
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	
   @RequestMapping("is_duplicated_id")
   public Map<String, Boolean> isDuplicatedId(
		   @RequestParam("loginId") String loginId){
	   
	   Map<String, Boolean> result = new HashMap<>();
	   User user = userBO.selectUserByLoginId(loginId);
	   if(user == null) {
		   result.put("result", false);
	   }else {
		   result.put("result", true);
	   }
	   
	   
	   return result;
	   
   }
   
   @PostMapping("/sign_up_for_ajax")
   public Map<String, String> signUpForAjax(
		   @Param("loginId") String loginId,
			  @Param("password") String password,
			  @Param("name") String name,
			  @Param("email") String email){
	   
	   //암호화
	   String encryptPassword = EncryptUtils.md5(password);
	   
	   //insert DB
	   int row =  userBO.insertUser(loginId, encryptPassword, name, email);
	   
	   // 결과값 확인
	   Map<String, String> result = new HashMap<>();
	   if (row == 1) {
			result.put("result", "success");
		} else {
			result.put("error", "입력 실패");
		}
	   
	   return result;
	   
   }
   
   @PostMapping("sign_in")
   public Map<String, String> signIn(HttpServletRequest request,
		   @RequestParam("loginId") String loginId,
		   @RequestParam("password") String password){
	   
	   //password를 md5로 해싱한다
	   String encryptpassword =  EncryptUtils.md5(password);
	   
	   //loginId, password로 user를 가져와서 있으면 로그인 성공
	   User user = userBO.getUserByLoginIdAndPassword(loginId, encryptpassword);
	    Map<String, String> result = new HashMap<>();
	    
	   if(user != null) {
		   // 성공 : 세션에 저장(로그아웃 누르기 전까지 모든 페이지에 로그인 상태 유지)
		  HttpSession session = request.getSession();   
		  session.setAttribute("userLoginId", user.getLoginId());
		
	       result.put("result", "success");  
		   
	   }else {
		   // 실패 : 에러 처리 리턴
		   result.put("result", "fail");
		   result.put("massage", "존재하지 않는 아이디입니다");
		   
		   
	   }
	   
	   
	   
	   	   return result;
	   
   }
}
	   
	   
	   
	   
	   


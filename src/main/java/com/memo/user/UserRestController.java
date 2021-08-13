package com.memo.user;

import java.util.HashMap;
import java.util.Map;

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
	
	
   @PostMapping("is_duplicated_id")
   public Map<String, Boolean> isDuplicatedId(
		   @RequestParam("loginId") String loginId){
	   
	   Map<String, Boolean> result = new HashMap<>();
	   User user = userBO.getUserLoginId(loginId);
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
	   userBO.addUser(loginId, encryptPassword, name, email);
	   
	   // 결과값 확인
	   Map<String, String> result = new HashMap<>();
	   
	   return result;
	   
   }
}

package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;
import com.memo.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	
	
  public User selectUserByLoginId(String loginId) {
	  
	  return userDAO.selectUserByLoginId(loginId);
  }
  
  public User getUserByLoginIdAndPassword(String loginId, String password) {
	  return userDAO.selectUserByLoginIdAndPassword(loginId, password);
  }
  
  public int insertUser(String loginId, String password, String name, String email) {
	  return userDAO.insertUser(loginId, password, name, email);
	
  }
}

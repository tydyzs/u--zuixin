package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Role_user;
import com.tgb.util.Result;


public interface Role_userService {
	public Result  save(Role_user role_user);
	public Result  update(Role_user role_user);
//	public Result  delete(int role_user_id);
//	public Result  findById(int role_user_id);
//	public Result  findAll(String currentPage);
//	public Result  findCount();
	public Result  update_2(Role_user role_user);
	public Result deleteByUserID(int user_id);
	public Result deleteByRoleID(int role_id);
	public Result findByRoleID(int role_id);
}

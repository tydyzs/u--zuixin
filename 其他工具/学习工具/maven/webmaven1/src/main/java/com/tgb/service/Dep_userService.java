package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Dep_user;
import com.tgb.util.Result;


public interface Dep_userService {
	public Result  save(Dep_user dep_user);
	public Result  update(Dep_user dep_user);
	public Result  delete(int dep_user_id);
	public Result  findById(int dep_user_id);
	public Result  findAll(String currentPage);
	public Result  findCount();
	public Result  update_2(Dep_user dep_user);
}

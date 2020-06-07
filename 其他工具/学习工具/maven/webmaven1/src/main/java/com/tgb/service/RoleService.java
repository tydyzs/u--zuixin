package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Role;
import com.tgb.util.Result;


public interface RoleService {
	public Result  save(Role role);
	public Result  update(Role role);
	public Result  delete(int role_id);
	public Result  findById(int role_id);
	public Result  findAll(Map map);
	public Result  findByName(Map map);
	public Result  findCount(int project_id);
	public Result  findAll_2(int project_id);	
}

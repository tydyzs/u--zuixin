package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Role_module;
import com.tgb.util.Result;


public interface Role_moduleService {
	public Result  save(Role_module role_module);
	public Result  update(Role_module role_module);
	public Result  delete(int role_module_id);
	public Result  findById(int role_module_id);
	public Result  findAll(String currentPage);
	public Result  findCount();
	public Result  update_2(Role_module role_module);
	public Result  deleteByModuleID(int module_id);
	public Result  deleteByRoleID(int role_id);
	public Result  findByRoleId(int role_id);
}

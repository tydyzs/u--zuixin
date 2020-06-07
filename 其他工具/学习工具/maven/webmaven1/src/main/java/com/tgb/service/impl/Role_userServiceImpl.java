package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Role_userMapper;
import com.tgb.model.Role_user;
import com.tgb.service.Role_userService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Role_userServiceImpl implements Role_userService {
	
	@Resource
	private Role_userMapper mapper;

	public Result save(Role_user role_user) {
		Result result = new Result();
		Boolean b = mapper.save(role_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Role_user role_user) {
		Result result = new Result();
		Boolean b = mapper.update(role_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update_2(Role_user role_user) {
		Result result = new Result();
		Boolean b = mapper.update(role_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result deleteByUserID(int user_id) {
		Result result = new Result();
		Boolean b = mapper.deleteByUserID(user_id);
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result deleteByRoleID(int role_id) {
		Result result = new Result();
		Boolean b = mapper.deleteByRoleID(role_id);
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findByRoleID(int role_id) {
		Result result = new Result();
		List<Map> list = mapper.findByRoleID(role_id);	
		result.setStatus(0);
		result.setData(list);
		return result;
	}	
	
	

}

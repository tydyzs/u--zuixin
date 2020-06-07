package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.RoleMapper;
import com.tgb.model.Role;
import com.tgb.service.RoleService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class RoleServiceImpl implements RoleService {
	
	@Resource
	private RoleMapper mapper;

	public Result save(Role role) {
		Result result = new Result();
		Boolean b = mapper.save(role);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Role role) {
		Result result = new Result();
		Boolean b = mapper.update(role);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int role_id) {
		Result result = new Result();
		Boolean b = mapper.delete(role_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int role_id) {
		Result result = new Result();
		Map map = mapper.findById(role_id);		
		result.setStatus(0);
		result.setData(map);
		return result;
	}

	public Result findAll(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findAll(map);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	public Result findByName(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findByName(map);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}	
	public Result findCount(int project_id){
		Result result = new Result();
		int count = mapper.findCount(project_id);		
		result.setStatus(0);
		result.setData(count);
		return result;		
	}
	public Result findAll_2(int project_id) {
		Result result = new Result();
		List<Map> list = mapper.findAll_2(project_id);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}	
	
	

}

package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Role_moduleMapper;
import com.tgb.model.Role_module;
import com.tgb.service.Role_moduleService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Role_moduleServiceImpl implements Role_moduleService {
	
	@Resource
	private Role_moduleMapper mapper;

	public Result save(Role_module role_module) {
		Result result = new Result();
		Boolean b = mapper.save(role_module);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Role_module role_module) {
		Result result = new Result();
		Boolean b = mapper.update(role_module);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int role_module_id) {
		Result result = new Result();
		Boolean b = mapper.delete(role_module_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int role_module_id) {
		Result result = new Result();
		Map map = mapper.findById(role_module_id);		
		result.setStatus(0);
		result.setData(map);
		return result;
	}

	public Result findAll(String currentPage) {
		Result result = new Result();
		List<Map> list = mapper.findAll(currentPage);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	
	public Result findCount(){
		Result result = new Result();
		int count = mapper.findCount();		
		result.setStatus(0);
		result.setData(count);
		return result;		
	}
	public Result update_2(Role_module role_module) {
		Result result = new Result();
		Boolean b = mapper.update_2(role_module);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result deleteByModuleID(int module_id) {
		// TODO Auto-generated method stub
		return null;
	}

	public Result deleteByRoleID(int role_id) {
		Result result = new Result();
		boolean b = mapper.deleteByRoleID(role_id);
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}		
		return result;
	}

	public Result findByRoleId(int role_id) {
		Result result = new Result();
		List<Role_module> list = mapper.findByRoleId(role_id);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}	
	
	

}

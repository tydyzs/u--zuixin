package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Dep_userMapper;
import com.tgb.model.Dep_user;
import com.tgb.service.Dep_userService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Dep_userServiceImpl implements Dep_userService {
	
	@Resource
	private Dep_userMapper mapper;

	public Result save(Dep_user dep_user) {
		Result result = new Result();
		Boolean b = mapper.save(dep_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Dep_user dep_user) {
		Result result = new Result();
		Boolean b = mapper.update(dep_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int dep_user_id) {
		Result result = new Result();
		Boolean b = mapper.delete(dep_user_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int dep_user_id) {
		Result result = new Result();
		Map map = mapper.findById(dep_user_id);		
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
	public Result update_2(Dep_user dep_user) {
		Result result = new Result();
		Boolean b = mapper.update_2(dep_user);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}	
	
	

}

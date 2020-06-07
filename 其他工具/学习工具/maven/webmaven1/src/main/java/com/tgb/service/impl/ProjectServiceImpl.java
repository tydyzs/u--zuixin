package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.ProjectMapper;
import com.tgb.mapper.RoleMapper;
import com.tgb.model.Project;
import com.tgb.model.Role;
import com.tgb.service.ProjectService;
import com.tgb.service.RoleService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class ProjectServiceImpl implements ProjectService {
	
	@Resource
	private ProjectMapper mapper;	

	public Result findAll() {
		Result result = new Result();
		List<Project> list = mapper.findAll();		
		result.setStatus(0);
		result.setData(list);
		return result;
	}

}

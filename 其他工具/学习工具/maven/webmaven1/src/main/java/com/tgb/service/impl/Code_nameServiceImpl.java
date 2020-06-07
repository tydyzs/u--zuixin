package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Code_nameMapper;
import com.tgb.model.Code_name;
import com.tgb.service.Code_nameService;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Code_nameServiceImpl implements Code_nameService {
	
	@Resource
	private Code_nameMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Code_name> findAll() {
		List<Code_name> findAllList = mapper.findAll();
		return findAllList;
	}

	public Code_name findById(int id) {

		Code_name code_name = mapper.findById(id);
		
		return code_name;
	}

	public void save(Code_name code_name) {

		mapper.save(code_name);
	}

	public boolean update(Code_name code_name) {

		return mapper.update(code_name);
	}
	
	

}

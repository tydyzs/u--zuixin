package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.S_tablesMapper;
import com.tgb.model.S_tables;
import com.tgb.service.S_tablesService;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class S_tablesServiceImpl implements S_tablesService {
	
	@Resource
	private S_tablesMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<S_tables> findAll() {
		List<S_tables> findAllList = mapper.findAll();
		return findAllList;
	}

	public S_tables findById(int id) {

		S_tables s_tables = mapper.findById(id);
		
		return s_tables;
	}

	public void save(S_tables s_tables) {

		mapper.save(s_tables);
	}

	public boolean update(S_tables s_tables) {

		return mapper.update(s_tables);
	}
	
	

}

package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Include_colMapper;
import com.tgb.model.Include_col;
import com.tgb.service.Include_colService;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Include_colServiceImpl implements Include_colService {
	
	@Resource
	private Include_colMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Include_col> findAll() {
		List<Include_col> findAllList = mapper.findAll();
		return findAllList;
	}

	public Include_col findById(int id) {

		Include_col include_col = mapper.findById(id);
		
		return include_col;
	}

	public void save(Include_col include_col) {

		mapper.save(include_col);
	}

	public boolean update(Include_col include_col) {

		return mapper.update(include_col);
	}
	
	

}

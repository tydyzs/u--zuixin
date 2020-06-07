package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Where_colMapper;
import com.tgb.model.Where_col;
import com.tgb.service.Where_colService;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Where_colServiceImpl implements Where_colService {
	
	@Resource
	private Where_colMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Where_col> findAll() {
		List<Where_col> findAllList = mapper.findAll();
		return findAllList;
	}

	public Where_col findById(int id) {

		Where_col where_col = mapper.findById(id);
		
		return where_col;
	}

	public void save(Where_col where_col) {

		mapper.save(where_col);
	}

	public boolean update(Where_col where_col) {

		return mapper.update(where_col);
	}
	
	

}

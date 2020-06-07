package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TfunctionMapper;
import com.tgb.model.Tfunction;
import com.tgb.service.TfunctionService;



@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TfunctionServiceImpl implements TfunctionService {
	
	@Resource
	private TfunctionMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Tfunction> findAll() {
		List<Tfunction> findAllList = mapper.findAll();
		return findAllList;
	}

	public Tfunction findById(int id) {

		Tfunction tfunction = mapper.findById(id);
		
		return tfunction;
	}

	public void save(Tfunction tfunction) {

		mapper.save(tfunction);
	}

	public boolean update(Tfunction tfunction) {

		return mapper.update(tfunction);
	}
	
	

}

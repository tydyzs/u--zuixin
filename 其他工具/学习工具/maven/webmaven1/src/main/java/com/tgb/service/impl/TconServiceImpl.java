package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TconMapper;
import com.tgb.model.Tcon;
import com.tgb.service.TconService;



@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TconServiceImpl implements TconService {
	
	@Resource
	private TconMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Tcon> findAll() {
		List<Tcon> findAllList = mapper.findAll();
		return findAllList;
	}

	public Tcon findById(int id) {

		Tcon tcon = mapper.findById(id);
		
		return tcon;
	}

	public void save(Tcon tcon) {

		mapper.save(tcon);
	}

	public boolean update(Tcon tcon) {

		return mapper.update(tcon);
	}
	
	

}

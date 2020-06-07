package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TwhereMapper;
import com.tgb.model.Twhere;
import com.tgb.service.TwhereService;



@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TwhereServiceImpl implements TwhereService {
	
	@Resource
	private TwhereMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Twhere> findAll() {
		List<Twhere> findAllList = mapper.findAll();
		return findAllList;
	}

	public Twhere findById(int id) {

		Twhere twhere = mapper.findById(id);
		
		return twhere;
	}

	public void save(Twhere twhere) {

		mapper.save(twhere);
	}

	public boolean update(Twhere twhere) {

		return mapper.update(twhere);
	}
	
	

}

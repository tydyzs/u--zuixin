package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TorderMapper;
import com.tgb.model.Torder;
import com.tgb.service.TorderService;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TorderServiceImpl implements TorderService {
	
	@Resource
	private TorderMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Torder> findAll() {
		List<Torder> findAllList = mapper.findAll();
		return findAllList;
	}

	public Torder findById(int id) {

		Torder torder = mapper.findById(id);
		
		return torder;
	}

	public void save(Torder torder) {

		mapper.save(torder);
	}

	public boolean update(Torder torder) {

		return mapper.update(torder);
	}
	
	

}

package com.tgb.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TgroupMapper;
import com.tgb.model.Tgroup;
import com.tgb.service.TgroupService;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TgroupServiceImpl implements TgroupService {
	
	@Resource
	private TgroupMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Tgroup> findAll() {
		List<Tgroup> findAllList = mapper.findAll();
		return findAllList;
	}

	public Tgroup findById(int id) {

		Tgroup tgroup = mapper.findById(id);
		
		return tgroup;
	}

	public void save(Tgroup tgroup) {

		mapper.save(tgroup);
	}

	public boolean update(Tgroup tgroup) {

		return mapper.update(tgroup);
	}
	
	

}

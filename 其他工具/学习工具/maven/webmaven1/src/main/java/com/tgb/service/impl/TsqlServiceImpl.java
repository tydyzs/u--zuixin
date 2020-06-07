package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TsqlMapper;
import com.tgb.model.Tsql;
import com.tgb.service.TsqlService;



@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TsqlServiceImpl implements TsqlService {
	
	@Resource
	private TsqlMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Tsql> findAll() {
		List<Tsql> findAllList = mapper.findAll();
		return findAllList;
	}

	public Tsql findById(int id) {

		Tsql tsql = mapper.findById(id);
		
		return tsql;
	}

	public void save(Tsql tsql) {

		mapper.save(tsql);
	}

	public boolean update(Tsql tsql) {

		return mapper.update(tsql);
	}
	
	

}

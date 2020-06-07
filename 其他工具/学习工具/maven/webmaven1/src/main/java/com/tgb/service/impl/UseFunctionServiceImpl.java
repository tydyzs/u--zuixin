package com.tgb.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper.UseFunctionMapper;
import com.tgb.model.UseFunction;
import com.tgb.service.UseFunctionService;
import com.tgb.util.Result;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UseFunctionServiceImpl implements UseFunctionService {
	@Resource
	private UseCustomThemeMapper usecustomthememapper;	
	@Resource
	private UseFunctionMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<UseFunction> findAll() {
		List<UseFunction> findAllList = mapper.findAll();
		return findAllList;
	}

	public UseFunction findById(int id) {

		UseFunction useFunction = mapper.findById(id);
		
		return useFunction;
	}

	public void save(UseFunction useFunction,String useThemeName) {
		Integer useThemeId=usecustomthememapper.selectUseName(useThemeName);
		useFunction.setUseSubject_id(useThemeId);
		mapper.save(useFunction);
	}

	public boolean update(UseFunction useFunction) {

		return mapper.update(useFunction);
	}

	public Result findByUseSubject_id(int useSubject_id) {		
		List<Map> list = mapper.findByUseSubject_id(useSubject_id);
		Result result = new Result();
		result.setData(list);
		result.setStatus(0);
		return result;
	}
	
	

}

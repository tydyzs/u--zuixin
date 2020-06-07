package com.tgb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper.UseGroupMapper;
import com.tgb.model.UseGroup;
import com.tgb.service.UseGroupService;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UseGroupServiceImpl implements UseGroupService {
	@Resource
	private UseCustomThemeMapper usecustomthememapper;		
	@Resource
	private UseGroupMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<UseGroup> findAll() {
		List<UseGroup> findAllList = mapper.findAll();
		return findAllList;
	}

	public UseGroup findById(int id) {

		UseGroup useGroup = mapper.findById(id);
		
		return useGroup;
	}

	public void save(UseGroup useGroup,String useThemeName) {
		Integer useThemeId=usecustomthememapper.selectUseName(useThemeName);
		useGroup.setUseSubject_id(useThemeId);
		mapper.save(useGroup);
	}

	public boolean update(UseGroup useGroup) {

		return mapper.update(useGroup);
	}
	
	

}

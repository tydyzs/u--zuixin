package com.tgb.service;

import java.util.List;

import com.tgb.model.UseGroup;



public interface UseGroupService {
	void save(UseGroup useGroup,String useThemeName);
	boolean update(UseGroup useGroup);
	boolean delete(int id);
	UseGroup findById(int id);
	List<UseGroup> findAll();
}

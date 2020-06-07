package com.tgb.mapper;

import java.util.List;

import com.tgb.model.UseGroup;


public interface UseGroupMapper {

	void save(UseGroup useGroup);
	boolean update(UseGroup useGroup);
	boolean delete(int id);
	UseGroup findById(int id);
	List<UseGroup> findAll();
}

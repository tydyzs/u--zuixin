package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Tgroup;

public interface TgroupMapper {

	void save(Tgroup tgroup);
	boolean update(Tgroup tgroup);
	boolean delete(int id);
	Tgroup findById(int id);
	List<Tgroup> findAll();
}

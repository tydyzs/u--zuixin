package com.tgb.mapper;

import java.util.List;

import com.tgb.model.S_tables;

public interface S_tablesMapper {

	void save(S_tables s_tables);
	boolean update(S_tables s_tables);
	boolean delete(int id);
	S_tables findById(int id);
	List<S_tables> findAll();
}

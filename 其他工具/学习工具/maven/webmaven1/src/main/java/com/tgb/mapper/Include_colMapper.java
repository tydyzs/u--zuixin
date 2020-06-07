package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Include_col;

public interface Include_colMapper {

	void save(Include_col include_col);
	boolean update(Include_col include_col);
	boolean delete(int id);
	Include_col findById(int id);
	List<Include_col> findAll();
}

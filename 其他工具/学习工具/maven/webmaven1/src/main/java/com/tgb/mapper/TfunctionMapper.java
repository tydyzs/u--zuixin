package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Tfunction;

public interface TfunctionMapper {

	void save(Tfunction tfunction);
	boolean update(Tfunction tfunction);
	boolean delete(int id);
	Tfunction findById(int id);
	List<Tfunction> findAll();
}

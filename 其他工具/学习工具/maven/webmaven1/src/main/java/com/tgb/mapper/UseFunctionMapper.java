package com.tgb.mapper;

import java.util.List;
import java.util.Map;

import com.tgb.model.UseFunction;


public interface UseFunctionMapper {

	void save(UseFunction useFunction);
	boolean update(UseFunction useFunction);
	boolean delete(int id);
	UseFunction findById(int id);
	List<UseFunction> findAll();
	List<Map> findByUseSubject_id(int useSubject_id);
}

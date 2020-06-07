package com.tgb.service;

import java.util.List;

import com.tgb.model.UseFunction;
import com.tgb.util.Result;


public interface UseFunctionService {
	void save(UseFunction useFunction,String useThemeName);
	boolean update(UseFunction useFunction);
	boolean delete(int id);
	UseFunction findById(int id);
	List<UseFunction> findAll();
	public Result findByUseSubject_id(int useSubject_id);
}

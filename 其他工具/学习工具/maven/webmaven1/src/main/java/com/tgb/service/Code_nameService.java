package com.tgb.service;

import java.util.List;

import com.tgb.model.Code_name;

public interface Code_nameService {
	void save(Code_name code_name);
	boolean update(Code_name code_name);
	boolean delete(int id);
	Code_name findById(int id);
	List<Code_name> findAll();
}

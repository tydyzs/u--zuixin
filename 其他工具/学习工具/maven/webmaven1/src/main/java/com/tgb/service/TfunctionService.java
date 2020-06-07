package com.tgb.service;

import java.util.List;

import com.tgb.model.Tfunction;


public interface TfunctionService {
	void save(Tfunction tfunction);
	boolean update(Tfunction tfunction);
	boolean delete(int id);
	Tfunction findById(int id);
	List<Tfunction> findAll();
}

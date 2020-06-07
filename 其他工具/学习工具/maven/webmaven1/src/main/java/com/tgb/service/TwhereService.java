package com.tgb.service;

import java.util.List;

import com.tgb.model.Twhere;


public interface TwhereService {
	void save(Twhere twhere);
	boolean update(Twhere twhere);
	boolean delete(int id);
	Twhere findById(int id);
	List<Twhere> findAll();
}

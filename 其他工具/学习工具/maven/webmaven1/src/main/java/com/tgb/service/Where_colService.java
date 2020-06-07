package com.tgb.service;

import java.util.List;
import com.tgb.model.Where_col;


public interface Where_colService {
	void save(Where_col where_col);
	boolean update(Where_col where_col);
	boolean delete(int id);
	Where_col findById(int id);
	List<Where_col> findAll();
}

package com.tgb.service;


import java.util.List;

import com.tgb.model.Old_inc_col;
import com.tgb.util.Result;


public interface Old_inc_colService {
	void save(Old_inc_col old_inc_col);
	boolean update(Old_inc_col old_inc_col);
	public Result updateCol(String map3,String map4);
	boolean delete(int id);
	Old_inc_col findById(int id);
	List<Old_inc_col> findAll();
	public Result loadOldCols();
	public Result findByTid(int tId);//根据主题ID查询字段
	List<Old_inc_col> findByTids(List tables_id_1);
}

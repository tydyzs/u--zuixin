package com.tgb.mapper;



import java.util.List;

import com.tgb.model.Old_inc_col;

public interface Old_inc_colMapper {

	void save(Old_inc_col old_inc_col);
	boolean update(Old_inc_col old_inc_col);
	boolean update_1(Old_inc_col old_inc_col);
	boolean delete(int id);
	Old_inc_col findById(int id);
	List<Old_inc_col> findAll();
	List<Old_inc_col> findAll_1();
	List<Old_inc_col> findByTid(int tId);//根据主题ID查询字段
	List<Old_inc_col> findByTids(List tables_id_1);
}

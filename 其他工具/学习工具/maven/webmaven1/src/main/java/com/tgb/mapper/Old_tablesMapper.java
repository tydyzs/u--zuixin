package com.tgb.mapper;


import java.util.List;

import com.tgb.model.Old_tables;

public interface Old_tablesMapper {

	void save(Old_tables old_tables);
	boolean update(Old_tables old_tables);
	boolean update_1(Old_tables old_tables);
	boolean delete(int id);
	Old_tables findById(int id);
	List<Old_tables> findAll();//c_name不为null
	List<Old_tables> findAll_1();//所有记录
	List<Old_tables> findByIds(List tables_id_1);
	List<Old_tables> findAll_new(int currentPage);
	int find_count();
}

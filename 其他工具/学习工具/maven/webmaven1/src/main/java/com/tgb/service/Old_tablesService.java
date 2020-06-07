package com.tgb.service;


import java.util.List;

import com.tgb.model.Old_tables;
import com.tgb.util.Result;


public interface Old_tablesService {
	void save(Old_tables old_tables);
	boolean update(Old_tables old_tables);	
	public Result updateAlias(String map1,String map2);
	boolean delete(int id);
	Old_tables findById(int id);
	List<Old_tables> findAll();
	public Result loadOldTables();
	List<Old_tables> findByIds(List tables_id_1);
	public Result findAll_new(int currentPage);//分页查询
	public Result find_count();//查询表总数
}

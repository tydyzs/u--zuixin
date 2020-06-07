package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Tsql;
public interface TsqlMapper {

	void save(Tsql tsql);
	boolean update(Tsql tsql);
	boolean delete(int id);
	Tsql findById(int id);
	List<Tsql> findAll();
}

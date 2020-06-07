package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Torder;

public interface TorderMapper {

	void save(Torder torder);
	boolean update(Torder torder);
	boolean delete(int id);
	Torder findById(int id);
	List<Torder> findAll();
}

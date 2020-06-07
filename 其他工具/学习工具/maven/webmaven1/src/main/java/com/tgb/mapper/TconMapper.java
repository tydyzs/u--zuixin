package com.tgb.mapper;

import java.util.List;
import com.tgb.model.Tcon;

public interface TconMapper {
	void save(Tcon tcon);
	boolean update(Tcon tcon);
	boolean delete(int id);
	Tcon findById(int id);
	List<Tcon> findAll();
}

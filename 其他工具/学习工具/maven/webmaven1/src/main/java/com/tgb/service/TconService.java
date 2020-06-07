package com.tgb.service;

import java.util.List;

import com.tgb.model.Tcon;

public interface TconService {
	void save(Tcon tcon);
	boolean update(Tcon tcon);
	boolean delete(int id);
	Tcon findById(int id);
	List<Tcon> findAll();
}

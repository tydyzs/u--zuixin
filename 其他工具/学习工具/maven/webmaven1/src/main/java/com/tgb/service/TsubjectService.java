package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Old_tables;
import com.tgb.model.Tsubject;
import com.tgb.util.Result;

public interface TsubjectService {
	void save(Tsubject tsubject);
	boolean update(Tsubject tsubject);
	boolean delete(int id);
	Tsubject findById(int id);
	Result findById_2(int id);
	List<Tsubject> findAll();
	public Result deleteSubject(int id);
	public Result querySubject(String subjectName);//模糊查询业务主题
	Result checkSubject(Tsubject tsubject);
	Result findTableById(int id);
	Result findColById(int id);
	Result findConById(int id);
	Result findWhereById(int id);
	Result findFunctionById(int id);
	Result findGroupById(int id);
	public Result delete_Subject(int id);
	public Result queryOld_table(String c_name);
	Result findAll_new();
	public Result findSubjects_count();
	public Result AllSubjects(int currentPage);
	public Map finduser(String user_code);
}

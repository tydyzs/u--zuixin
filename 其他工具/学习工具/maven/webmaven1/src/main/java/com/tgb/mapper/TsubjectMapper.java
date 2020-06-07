package com.tgb.mapper;

import java.util.List;
import java.util.Map;

import com.tgb.model.Old_tables;
import com.tgb.model.Tsubject;
import com.tgb.model.Twhere;

public interface TsubjectMapper {

	void save(Tsubject tsubject);
	boolean update(Tsubject tsubject);
	boolean delete(int id);
	Tsubject findById(int id);
	Map findById_2(int id);
	List<Tsubject> findAll();
	public boolean delete_1(int id);//删除业务主题
	//public int findBySubject(int id);//查询业务主题
	public List<Tsubject> querySubject(String subjectName);//模糊查询业务主题
	int checkSubject(Tsubject tsubject);
	List<Map> findTableById(int id);
	List<Map> findColById(int id);
	List<Map> findConById(int id);
	List<Twhere> findWhereById(int id);
	List<Map> findFunctionById(int id);
	List<Map> findGroupById(int id);
	public boolean delete_subject(int id);
	public boolean delete_useSubject(int id);
	public List<Old_tables> queryOld_table(String c_name);
	public int findSubjects_count();//主题总数(未删除的)
	public List<Tsubject> AllSubjects(int currentPage);//分页主题列表
	public List<Object> finduser(String user_code);
	
}

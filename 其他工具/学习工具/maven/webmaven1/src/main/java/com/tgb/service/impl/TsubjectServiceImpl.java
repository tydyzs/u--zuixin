package com.tgb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TsubjectMapper;
import com.tgb.model.Old_tables;
import com.tgb.model.Tsubject;
import com.tgb.model.Twhere;
import com.tgb.model.UseTheme;
import com.tgb.service.TsubjectService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public  class TsubjectServiceImpl implements TsubjectService {
	
	@Resource
	private TsubjectMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Tsubject> findAll() {
		List<Tsubject> findAllList = mapper.findAll();
		return findAllList;
	}

	public Tsubject findById(int id) {

		Tsubject tsubject = mapper.findById(id);
		
		return tsubject;
	}

	public void save(Tsubject tsubject) {

		mapper.save(tsubject);
	}

	public boolean update(Tsubject tsubject) {

		return mapper.update(tsubject);
	}

	//根据主题ID删除业务主题
	public Result deleteSubject(int id) {
		Result result = new Result();
		mapper.delete_1(id);
		result.setStatus(0);
		result.setMsg("删除业务主题成功！");
		return result;
	}
	
	//根据主题名称模糊查询业务主题
	public Result querySubject(String subjectName){
		Result result = new Result();
		String a = "%"+subjectName+"%";
		List<Tsubject> querylList = mapper.querySubject(a);
		result.setStatus(0);
		result.setData(querylList);
		result.setMsg("查询业务主题成功！");
		return result;
	}
	//查看主题是否存在
	public Result checkSubject(Tsubject tsubject){
		Result result = new Result();
		int b = mapper.checkSubject(tsubject);
		if(b>0)
		{
			result.setStatus(1);
		}
		else
		{
			result.setStatus(0);
		}
		return result;
	}
	public Result findById_2(int id) {
		Result result = new Result();
		Map map = mapper.findById_2(id);
		result.setData(map);
		result.setStatus(0);
		return result;
	}	
	public Result findTableById(int id) {
		Result result = new Result();
		List<Map> list = mapper.findTableById(id);
		result.setData(list);
		result.setStatus(0);
		return result;
	}	
	public Result findColById(int id) {
		Result result = new Result();
		List<Map> list = mapper.findColById(id);
		result.setData(list);
		result.setStatus(0);
		return result;
	}
	public Result findConById(int id) {
		Result result = new Result();
		List<Map> list = mapper.findConById(id);
		result.setData(list);
		result.setStatus(0);
		return result;
	}	
	public Result findWhereById(int id) {
		Result result = new Result();
		List<Twhere> list = mapper.findWhereById(id);
//		Map map = new HashMap();
//		map.put("s_wheres",list);
//		map.put("ll", 1);
//		result.setData(map);
		result.setData(list);
		result.setStatus(0);
		return result;
	}
	public Result findFunctionById(int id) {
		Result result = new Result();
		List<Map> list = mapper.findFunctionById(id);
		result.setData(list);
		result.setStatus(0);
		return result;
	}
	public Result findGroupById(int id) {
		Result result = new Result();
		List<Map> list = mapper.findGroupById(id);
		result.setData(list);
		result.setStatus(0);
		return result;
	}	
	//根据主题ID删除业务主题
	public Result delete_Subject(int id) {
		Result result = new Result();
		Boolean b = mapper.delete_subject(id);
		Boolean c = mapper.delete_useSubject(id);
		if(b==true && c==true){
			result.setStatus(0);
			result.setMsg("删除业务主题成功！");			
		}else{
			result.setStatus(-1);
			result.setMsg("删除业务主题失败！");			
		}
		return result;
	}
	public Result queryOld_table(String c_name){
		Result result = new Result();
		List<Old_tables> ls = mapper.queryOld_table(c_name);
		result.setData(ls);
		result.setStatus(0);
		return result;		
		
	}
	public Result findAll_new(){
		Result result = new Result();
		List<Tsubject> querylList = mapper.findAll();
		result.setData(querylList);
		result.setStatus(0);
		return result;		
	}
	public Result findSubjects_count(){
		Result result = new Result();
		int subjects_count = mapper.findSubjects_count();
		result.setData(subjects_count);
		result.setStatus(0);
		return result;		
	}
	public Result AllSubjects(int currentPage){
		Result result = new Result();
		List<Tsubject> list_subjects = mapper.AllSubjects(currentPage);
		result.setData(list_subjects);
		result.setStatus(0);
		return result;			
	}
	
	public Map finduser(String user_code){
		Map map=(Map) mapper.finduser(user_code).get(0);
		return map;
	}
	
}

package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Department;
import com.tgb.util.Result;


public interface DepartmentService {
	public Result  save(Department department);
	public Result  update(Department department);
	public Result  delete(int department_id);
	public Result  findById(int department_id);
	public Result  findAll();	
	public Result  findByName(String department_name);
	public Result  findCount();
	//********使用TYPE
	public Result finddepartment();//查询用于生成树
	public Result find(String parent_id);//查询子节点放入表中
	public Result save(String parent_id ,String department_name);//新增
	public Result delete(String department_id);//删除节点
	public int findId(String parent_id);//查询数目，便于新增时生成id
	public Result updateDepartment(String department_id,String parent_id,String department_name);
	public Result findDepartmentName(String department_id);//根据机构ID查询 机构名称	
}

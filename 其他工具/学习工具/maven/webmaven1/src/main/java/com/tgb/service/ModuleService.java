package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.Module;
import com.tgb.util.Result;


public interface ModuleService {
	public Result  save(Module module);
	public Result  update(Module module);
	public Result  delete(int module_id);
	public Result  findById(int module_id);
	public Result  findAll();	
	public Result  findByName(String module_name);
	public Result  findCount();
	//********使用TYPE
	public Result findmodule(int project_id);//查询用于生成树
	public Result find(String parent_id);//查询子节点放入表中
	public Result save(String parent_id ,String module_name,String module_url,int project_id);//新增
	public Result delete(String module_id);//删除节点
	public int findId(String parent_id);//查询数目，便于新增时生成id
	public Result updateModule(String module_id,String parent_id,String module_name,String module_url,int project_id);
	public Result findModuleName(String module_id);//根据机构ID查询 机构名称	
}

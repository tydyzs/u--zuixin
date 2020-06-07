package com.tgb.mapper;

import java.util.HashMap;
import java.util.List;

import com.tgb.model.Module;

public interface ModuleMapper {

	boolean save(Module module);
	boolean update(Module module);
	boolean delete(int module_id);
	Module findById(int module_id);
	List<Module> findAll();
	//List<Map> findByName(@Param("user_code")String user_code,String currentPage);
	Module findByName(String module_name);
	int findCount();
	//*******使用TYPE方法
	public List<Module> findmodule(int project_id);//查询用于生成树
	public List<Module> find(int parent_id);//查询子节点放入表中	
	public int findmoduleId(HashMap map); //查看刚才	
	public Integer findId(int parent_id);//查询数目，便于新增时生成id
	public Integer find2(Module module);
	public int updateModules(Module module);//查询当前父id下除了此id其他名称叫这个的数量
	public void updateModule(Module module);
	public List<String> findModuleName(int module_id);//根据模块ID查询 模块名称
	public List<Integer> findByParent_Id(int parent_id);
}

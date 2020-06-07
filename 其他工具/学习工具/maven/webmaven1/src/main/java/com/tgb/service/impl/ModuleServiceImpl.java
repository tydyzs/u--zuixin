package com.tgb.service.impl;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Role_moduleMapper;
import com.tgb.mapper.ModuleMapper;
import com.tgb.model.Module;
import com.tgb.service.ModuleService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class ModuleServiceImpl implements ModuleService {
	
	@Resource
	private ModuleMapper mapper;
	@Resource
	private Role_moduleMapper role_module_mapper;		

	public Result save(Module module) {
		Result result = new Result();
		Boolean b = mapper.save(module);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Module module) {
		Result result = new Result();
		Boolean b = mapper.update(module);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int module_id) {
		Result result = new Result();
		Boolean b = mapper.delete(module_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int module_id) {
		Result result = new Result();
		Module module = mapper.findById(module_id);		
		result.setStatus(0);
		result.setData(module);
		return result;
	}

	public Result findAll() {
		Result result = new Result();
		List<Module> list = mapper.findAll();		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	public Result findByName(String module_name) {
		Result result = new Result();
		Module module = mapper.findByName(module_name);		
		result.setStatus(0);
		result.setData(module);
		return result;
	}	
	public Result findCount(){
		Result result = new Result();
		int count = mapper.findCount();		
		result.setStatus(0);
		result.setData(count);
		return result;		
	}
//***********************使用TYPE方法
	public Result findmodule(int project_id) {//查询所有生成树
		Result result=new Result();
	    List<Module> list=mapper.findmodule(project_id);
	    result.setData(list);
	    result.setStatus(0);
		return result;
	}

	public Result find(String parent_id) {//查询子节点生成表
		Result result=new Result();
		int i=Integer.parseInt(parent_id);
	    List<Module> list=mapper.find(i);
	    result.setData(list);
	    result.setStatus(0);
			return result;
	}

	public Result save(String parent_id,String module_name,String module_url,int project_id) {//新增节点
		Module module=new Module();
		Result result=new Result();		
		int i=Integer.parseInt(parent_id);
		module.setParent_id(i);
		module.setModule_url(module_url);
		module.setModule_name(module_name);
		module.setIs_del(0);
		module.setProject_id(project_id);
	if(mapper.find2(module)!=0){//name 存在了
			result.setStatus(2);
			return result;
		}else{
		mapper.save(module);
		HashMap map=new HashMap();
		map.put("parent_id", i);
		map.put("module_name", module_name);
		int id=mapper.findmoduleId(map);
		result.setStatus(0);
		result.setData(id);
		return result;
		}
	}

	//删除机构及所有子机构。如果机构或子机构有其他表关联数据，则不删除
	public Result delete(String module_id) {//删除		
		Result result=new Result();
		delId(module_id);//删除机构及下面所有的机构		
		result.setStatus(0);
		return result;	
	}

	//删除
	public void delId(String module_id){//下拉框：根据主题类型id查询所有下面的主题名称
		   int i=Integer.parseInt(module_id);
		   mapper.delete(i);//删除当前
		   role_module_mapper.deleteByModuleID(i);
			List<Integer> cId=mapper.findByParent_Id(i);//查询所有子id
			int a=cId.size();
			if(a!=0){//子id对应所有名称
				for(int j=0;j<cId.size();j++){
					delId(cId.get(j)+"");
			   }
			}
	}

	
	public int findId(String parent_id) {//查询数目用于生成id
		int i=Integer.parseInt(parent_id);
		int num=mapper.findId(i);
		return num;
	}

	
	
	public Result updateModule(String module_id,String parent_id,String module_name,String module_url,int project_id){
		Result result=new Result();
		
		Module module=new Module();
		module.setModule_id(Integer.parseInt(module_id));
		module.setParent_id(Integer.parseInt(parent_id));
		module.setModule_name(module_name);
		module.setModule_url(module_url);
		module.setProject_id(project_id);
		int num=mapper.updateModules(module);
		if(num>0){
			result.setStatus(1);
			return result;
		}else{
			mapper. updateModule(module);
			result.setStatus(0);
			return result;
		}
		
		
	}

	//根据机构ID查询 机构名称
	public Result findModuleName(String module_id) {
		Result result=new Result();
		List<String> ty = mapper.findModuleName(Integer.parseInt(module_id));
		String ty2 = ty.get(0);
		result.setStatus(0);
		result.setMsg(ty2);
		return result;
	}	
	
	

}

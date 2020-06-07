package com.tgb.service.impl;




import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Old_tablesMapper;
import com.tgb.model.Old_tables;
import com.tgb.service.Old_tablesService;
import com.tgb.util.Result;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Old_tablesServiceImpl implements Old_tablesService {
	
	@Resource
	private Old_tablesMapper mapper;
	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Old_tables> findAll() {
		List<Old_tables> findAllList = mapper.findAll();
		return findAllList;
	}

	public Old_tables findById(int id) {

		Old_tables old_tables = mapper.findById(id);
		
		return old_tables;
	}

	public void save(Old_tables old_tables) {

		mapper.save(old_tables);
	}

	public boolean update(Old_tables old_tables) {

		return mapper.update(old_tables);
	}
	//加载原始表表名列表
	public Result loadOldTables() {
		Result result = new Result();
		List<Old_tables> findAllList = mapper.findAll_1();
		result.setStatus(0);
		result.setData(findAllList);
		result.setMsg("加载原始表表名成功！");
		return result;
	}	
	//修改原始表别名
	public Result updateAlias(String map1,String map2) {
		updateAliass(map1,map2);
		Result result = new Result();
		result.setStatus(0);
		result.setMsg("修改表别名成功！");
		return result;
		
	}
	
	public void updateAliass(String str,String symbol){
		if("".equals(str)){
			return;
		}
		int a=str.indexOf(",");
		int b=symbol.indexOf(",");
		String tables_id=str.substring(0,a);
		String c_name=symbol.substring(0,b);
			Integer s_tables_id =Integer.parseInt(tables_id);
		
		Old_tables old_tables = new Old_tables();
		old_tables.setC_name(c_name);
		old_tables.setS_tables_id(s_tables_id);
		mapper.update_1(old_tables);
		
		String s=str.substring(a+1);
		String s2=symbol.substring(b+1);
		updateAliass(s,s2);

	}	
	public List<Old_tables> findByIds(List tables_id_1){
		List<Old_tables> l_tables = mapper.findByIds(tables_id_1);
		return l_tables;
	}
	public Result findAll_new(int currentPage) {
		Result result = new Result();				
		List<Old_tables> findAllList = mapper.findAll_new(currentPage);
		result.setStatus(0);
		result.setData(findAllList);
		return result;
	}	
	public Result find_count(){
		Result result = new Result();				
		int oldTables_count = mapper.find_count();
		result.setStatus(0);
		result.setData(oldTables_count);
		return result;		
	}
}

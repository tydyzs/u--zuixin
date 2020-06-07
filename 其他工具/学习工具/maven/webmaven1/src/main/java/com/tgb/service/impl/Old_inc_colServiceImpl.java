package com.tgb.service.impl;



import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Old_inc_colMapper;
import com.tgb.model.Old_inc_col;
import com.tgb.service.Old_inc_colService;
import com.tgb.util.Result;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class Old_inc_colServiceImpl implements Old_inc_colService {
	
	@Resource
	private Old_inc_colMapper mapper;

	public boolean delete(int id) {
		
		return mapper.delete(id);
	}

	public List<Old_inc_col> findAll() {
		List<Old_inc_col> findAllList = mapper.findAll();
		return findAllList;
	}

	public Old_inc_col findById(int id) {

		Old_inc_col old_inc_col = mapper.findById(id);
		
		return old_inc_col;
	}

	public void save(Old_inc_col old_inc_col) {

		mapper.save(old_inc_col);
	}

	public boolean update(Old_inc_col old_inc_col) {

		return mapper.update(old_inc_col);
	}
	public Result loadOldCols() {
		Result result = new Result();
		List<Old_inc_col> findAllList = mapper.findAll_1();
		result.setStatus(0);
		result.setData(findAllList);
		result.setMsg("加载原表包含字段成功！");
		return result;
		
	}	
	public Result updateCol(String map3,String map4) {
		updateCols(map3,map4);
		Result result = new Result();
		result.setStatus(0);
		result.setMsg("修改表字段别名成功！");
		return result;
	}
	
	public void updateCols(String str,String symbol){
		if("".equals(str)){
			return;
		}
		int a=str.indexOf(",");
		int b=symbol.indexOf(",");
		String colId=str.substring(0,a);
		String col_c_name=symbol.substring(0,b);
			Integer include_col_id =Integer.parseInt(colId);
		
		Old_inc_col old_inc_col  = new Old_inc_col();
		old_inc_col.setInclude_col_id(include_col_id);
		old_inc_col.setCol_c_name(col_c_name);
		mapper.update_1(old_inc_col);
		
		String s=str.substring(a+1);
		String s2=symbol.substring(b+1);
		updateCols(s,s2);

	}

	//根据主题ID查询字段
	public Result findByTid(int tId) {
		Result result = new Result();
		List<Old_inc_col> loadCol  = mapper.findByTid(tId);
		result.setStatus(0);
		result.setData(loadCol);
		result.setMsg("加载字段成功！");
		return result;
	}	
	public List<Old_inc_col> findByTids(List tables_id_1){		
		List<Old_inc_col> loadCol  = mapper.findByTids(tables_id_1);
		return loadCol;		
	}

}

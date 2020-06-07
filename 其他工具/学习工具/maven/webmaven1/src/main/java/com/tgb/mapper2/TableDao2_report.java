package com.tgb.mapper2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tgb.model.Old_inc_col;
import com.tgb.model.Old_tables;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface TableDao2_report {

	public List<String> findTalbe();
	public List<String> findcol(String tableName);
	public List<Map> findTalbe_2();
	public List<Map<String ,String>> findcol_2(String table_name);
	public List<String> findtablename(@Param("colname")String colname);
	public List<String> findtable_user(@Param("tablename")String tablename);
	
	public List<String> finCname(@Param("column_name")String column_name);
	
	
	
	//public List<String> bieming();
	//public void biemingsql(@Param("sql")String sql);
}

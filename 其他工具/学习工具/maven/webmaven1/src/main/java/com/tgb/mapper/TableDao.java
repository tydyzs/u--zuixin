package com.tgb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tgb.model.Old_inc_col;
import com.tgb.model.Old_tables;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface TableDao {

	public void newtable(String ename);
	public List<Old_tables> findtables();
	public void newCol(Old_inc_col col);
	public void newCol_2(Old_inc_col col);
	public void newtable_2(Old_tables old_tables);
	//*********************************
	public void newCol_3(@Param("list")List<Old_inc_col> list);
	public void newtable_3(@Param("list")List<Old_tables> list);
	
	public List<Old_tables> findname(String e_name);
	public int findcol(Old_inc_col col);
	public List<String> findcol_cname(@Param("e_name")String e_name);
}

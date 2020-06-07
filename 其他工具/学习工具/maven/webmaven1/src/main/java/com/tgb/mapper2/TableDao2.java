package com.tgb.mapper2;

import java.util.List;
import java.util.Map;

import com.tgb.model.Old_inc_col;
import com.tgb.model.Old_tables;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface TableDao2 {

	public List<String> findTalbe();
	public List<String> findcol(String tableName);
	public List<Map> findTalbe_2();
	public List<Map> findcol_2();
	//public List<Map> findcol_2_new(Map map);
	public List<Map> findcol_2_new(String tableName);
}

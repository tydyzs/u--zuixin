package com.tgb.service;


import java.util.Map;

import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */

public interface UtilService {
	public Result findUseTheme(String themeId);//根据主题id查询所有主题实例
	public Result findcol_type(String colname,String table_name);
	
}

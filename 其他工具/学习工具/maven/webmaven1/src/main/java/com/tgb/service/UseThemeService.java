package com.tgb.service;


import java.util.List;
import java.util.Map;

import com.tgb.model.UseTheme;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */

public interface UseThemeService {
	public Result findUseTheme(String typeId,String name,String themeId);//查询用于生成树
	public Result findname(String typeId);//主题名称下拉框
	public Result deleteuse(String useId);
	public Result queryUseTheme(String useName);
	public Result functions(String themeId);
	public Result findname_new(Map map);
	public Result Alltheme_count();
	public Result AllUsetheme_count();
	public Result findUsename_new(Map map);
	public Result Alltheme_only();
	public Result findUseThemeBySubject_id(Map map);//根据主题ID，查询所有使用主题
}

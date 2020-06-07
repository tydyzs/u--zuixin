package com.tgb.service;

import com.tgb.util.Result;

/**
 * 
 * @author 沈焕成
 * date 2016-06-03
 *
 */


public interface UseCustomService {
	public Result delUseTheme(Integer useThemeId);
	public Result findcolName(String themeId);
	public Result preservation(String sql,String useThemeName,String str1,String createPerson,String str2,String sorts,String themeId,String typeId,String selecta,String selectb,String operation,String conditionValue,String selectd,String connect);
	public Integer useCustom(String useThemeName,String themeId,String typeId,String createPerson);
	public Result allUseName(Integer useThemeId);
	public Result testxx();
}

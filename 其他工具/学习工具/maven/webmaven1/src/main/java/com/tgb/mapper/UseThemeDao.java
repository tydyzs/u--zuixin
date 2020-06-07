package com.tgb.mapper;

import java.util.List;
import java.util.Map;

import com.tgb.model.Theme;
import com.tgb.model.Themetype;
import com.tgb.model.UseTheme;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface UseThemeDao {

	public List<UseTheme> findUseTheme(Map map);//查询所有使用主题
	public List<Theme> findName(String typeId);//获取某个分类下所有主题name
	public List<Theme> Alltheme();//查询所有主题。时间降序
	public List<Integer> findId(Integer pId);//查询子id
	public String findthemename(int themeId);//根据主题id查询主题名称
	public String findtypename(int typeId);//根据类型id查询类型名称
	public void deleteuse(int useId);
	public List<UseTheme> queryUseTheme(String useName);//模糊查询使用主题
	
	public Integer checkdata(Integer typeId);//查看使用主题下有没有关联数据
	public List<Theme> findName_new(Map map);//获取某个分类下所有主题name
	public List<Theme> Alltheme_new(Map map);//查询所有主题。时间降序	
	public int Alltheme_count();//查询所有的主题总数
	public int AllUsetheme_count();//查询所有的使用主题总数
	public List<UseTheme> findUseName_new(Map map);//获取某个分类下所有使用主题name
	public List<UseTheme> AllUsetheme_new(Map map);//查询所有使用主题。时间降序
	public List<Map> Alltheme_only();
	public List<UseTheme> findUseThemeBySubject_id(Map map);//根据主题ID及用户，查询所有使用主题
}

package com.tgb.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tgb.model.Include_col;
import com.tgb.model.Old_tables;
import com.tgb.model.S_tables;
import com.tgb.model.Theme;
import com.tgb.model.Tsql;
import com.tgb.model.Tusesql;
import com.tgb.model.Use_col;
import com.tgb.model.Use_order;
import com.tgb.model.Use_subject;
import com.tgb.model.Use_where;
import com.tgb.model.Where_col;
import com.tgb.util.Result;

/**
 * 
 * @author ZGW
 *
 * @date 2016年6月2日
 */
public interface UseCustomThemeMapper {
	public List<Include_col> findcolName(int themeId) ;
	public List<Where_col> findwhere(int themeId);
	//public List<Where_col> findwhere2(int col_id);
	public List<Where_col> findwhere3(Map map);
	public void addUseSubject(Use_subject useSubject);//***新增使用主题
	public Integer selectUseName(@Param("useThemeName")String useThemeName);//根据使用主题名称查是否存在
	
	public int deleteUseName(Integer useThemeId);//根据使用主题id删除数据
	public int deleteUseName1(Integer useThemeId);
	public int deleteUseName2(Integer useThemeId);
	public int deleteUseName3(Integer useThemeId);
	public int deleteUseName4(Integer useThemeId);
	
	public Include_col findInclude(Integer INCLUDE_COL_ID);
	public void addUseCol(Use_col usecol);  //***新增使用主题字段
	public Integer queryTypeId(Integer themeId);//根据主题id查询分类id
	public S_tables findSTables(int tableid);//根据表名称id，查出使用主题表的数据
	public Old_tables findSTables2(int tableid);//根据表名称id，查出使用主题表的数据
	
	public void addorder(Use_order useorder);//*** 新增使用主题排序字段
	
	public void addWhere(Use_where usewhere);//*** 新增条件字段
	
	public void addTusesql(Tusesql tusesql);   //  ****新增：使用主题sql
	
	
	//******     根据使用主题id查询 ********
	public List<Use_col> queryCol(Integer useThemeId);
	public List<Use_order> queryOrder(Integer useThemeId);
	public List<Use_where> queryWhere(Integer useThemeId);
	
	
	
	/*根据主题id查sql语句*/
	public List<Tsql> finsql(@Param("themeId")int themeId);
	
	public Theme findTheme(@Param("themeId")int themeId);
	
	public String findcname(Include_col incol);
	public String testxx();
}

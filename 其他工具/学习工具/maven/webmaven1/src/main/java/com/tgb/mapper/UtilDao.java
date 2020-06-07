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
public interface UtilDao {

	public int findUseTheme(int themeid);//查询所有使用主题
}

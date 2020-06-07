package com.tgb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper.UseThemeDao;
import com.tgb.mapper.UtilDao;
import com.tgb.mapper2.SqlDao;
import com.tgb.model.Theme;
import com.tgb.model.UseTheme;
import com.tgb.model.Zspm_data;
import com.tgb.service.UseThemeService;
import com.tgb.service.UtilService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UtilServiceImpl implements UtilService {
	
	@Resource
	private UtilDao utildao;
	@Resource
	private SqlDao sqldao;
   
	
	public Result findUseTheme(String themeId){
		Result result=new Result();
		int num=utildao.findUseTheme(Integer.parseInt(themeId));
		result.setData(num);
		return result;
	}
	
	//根据字段名查询字段类型是否是日期
	public Result findcol_type(String colname,String table_name){
		Map map=new HashMap();
		map.put("col_name", colname);
		map.put("table_name", table_name);
		List<String> list= sqldao.findtype(map);
		Result result=new Result();
		if(list.size()>0){
			if(list.get(0).indexOf("DATE")!=-1||list.get(0).indexOf("TIMESTAMP")!=-1){//是日期类型
				result.setStatus(0);
			}else{
				result.setStatus(-1);
			}
			
		}else{//不是日期
			result.setStatus(-1);
		}
		return result;
	}
	
	
	
}

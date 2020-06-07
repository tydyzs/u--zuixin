package com.tgb.service2;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.tgb.model.Include_col;
import com.tgb.util.Result;

/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


public interface SqlService_2 {
	public Result implementsql(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception;//执行sql
	public String findcname(Include_col incol);
	public HSSFWorkbook ExporExcel(String sql, String num, String tomurl,
			String themeId,String[] split1,String[] split2) throws Exception;
	public Result implementsql(String sql,String num,String tomurl) throws Exception;
	public Result implementsql(String sql,String num,String tomurl,String themeId) throws Exception;//执行sql
}

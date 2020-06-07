package com.tgb.service2;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.tgb.model.Include_col;
import com.tgb.util.ExportExcel_new;
import com.tgb.util.ExportExcel_report;
import com.tgb.util.Result;

/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


public interface SqlService {
	public Result implementsql(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception;//执行sql
	public String findcname(Include_col incol);
	public HSSFWorkbook ExporExcel(String sql, String num, String tomurl,
			String themeId,String[] split1,String[] split2) throws Exception;
	public Result implementsql(String sql,String num,String tomurl) throws Exception;
	public Result implementsql(String sql,String num,String tomurl,String themeId) throws Exception;//执行sql
	public void ExporExcel_2(String sql, String num, String tomurl,
			String themeId,String[] split1,String[] split2) throws Exception;
	//分页导出EXCEL
	public void ExporExcel_3(String sql, int total_record_count,int perCount, String address,
			String excelName,String[] cTitle,String[] eTitle) throws Exception;
	//分页导出EXCEL
	public ExportExcel_new ExporExcel_4(String sql, int total_record_count,int perCount, String address,
			String excelName,String[] cTitle,String[] eTitle) throws Exception;	
	//分页导出EXCEL
	public int ExporExcel_5(String sql, int total_record_count,int perCount, String address,
			String excelName,String[] cTitle,String[] eTitle,String tomurl) throws Exception;		
	public ExportExcel_report excelexport(String ip,String sql,String sheet_num,String[] c_name,String[] e_name) throws Exception;
	public Result findzsdata(String num);

}

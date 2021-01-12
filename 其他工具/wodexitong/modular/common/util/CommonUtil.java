package cn.stylefeng.guns.modular.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;








import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * 
 * @author shc
 *2020-11-11
 */
public class CommonUtil {
	/**
	 * 字符串转Date
	 * 支持yyyyMMdd，yyyy-MM-dd，yyyy-MM-dd HH:mm:ss；其余返回null
	 */
	public static Date strToDate(String str){
		if(checknull(str)){
			return null;
		}
		String type="yyyyMMdd";
		if(str.indexOf("-")!=-1){
			type="yyyy-MM-dd";
		}
		if(str.indexOf(":")!=-1){
			type="yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(type);
	    Date date=null;
		try {
			date = simpleDateFormat.parse(str);
		} catch (ParseException e) {
			return null;
		}
	     return date;
	}
	/**
	 * Date转字符串
	 * 传入Date和格式（yyyy-MM-dd;yyyyMMdd;yyyy-MM-dd HH:mm:ss;yyyyMMddHHmmss)
	 */
	public static String dateToStr(Date date,String sf){
		System.out.println(date);
		SimpleDateFormat sdf = new SimpleDateFormat(sf);
		String dateStr=sdf.format(date);
		return dateStr;
	}
	
	
	
	
	/**
	 * 空置校验
	 * @return
	 */
	public static boolean checknull(Object str){
		boolean result=false;
		if("null".equals(str)||null==str||"".equals(str)){
			result=true;
		}
		return result;
	}
	/**
	 * 删除文件或文件夹
	 */
	public static void deleteFile(String filePath){
		File file=new File(filePath);
		while(file.exists()){//存在
			if(file.isFile()){//文件
				file.delete();
				return;
			}
			String [] s=file.list();//获取文件夹中的内容，文件夹名数组
			if(s.length==0){//空文件夹
				file.delete();
				return;
			}
			for(int i=0;i<s.length;i++){
				s[i]=filePath+"\\"+s[i];
				deleteFile(s[i]);
			}
		}
	}
	/**
	 * 获取uuid
	 */
	public static String getUuid(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	/**
	 * 获取机构板块查询条件
	 */

	

}

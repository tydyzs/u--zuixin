package cn.stylefeng.guns.modular.common.util;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;



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
	 * 字符串转Map
	 */
	public static Map strToMap(String json){
		Map map = new HashMap();
		JSONObject jsonObj = JSONObject.parseObject(json);
		map=jsonObj.getInnerMap();
		//map=jsonToMap(jsonObj,map);
		return map;
	}
	public static Map jsonToMap(JSONObject jsonObj,Map map){
		for(String key:jsonObj.keySet()){
			Object obj1=jsonObj.get(key);
			String typeName=obj1.getClass().getName();
			if("java.lang.String".equals(typeName)){
				map.put(key, obj1.toString());
			}
			if("net.sf.json.JSONObject".equals(typeName)){
				JSONObject json1=(JSONObject)obj1;
				int size=json1.size();
				if(size>0){
					Map newMap = new HashMap();
					Map data1=jsonToMap(json1,newMap);
					map.put(key, data1);
				}
			}
		}
		return map;
	}

	/**
	 * 创建多级目录文件
	 * @param path
	 * @throws IOException
	 */
	public static void createFile(String path){
		if (StringUtils.isNotEmpty(path)) {
			File file = new File(path);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			try {
				file.createNewFile();
			}catch(Exception e){
			}
		}
	}

	

}

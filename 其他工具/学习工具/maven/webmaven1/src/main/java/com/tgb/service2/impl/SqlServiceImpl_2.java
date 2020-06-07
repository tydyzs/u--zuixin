package com.tgb.service2.impl;

//import java.text.SimpleDateFormat;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;






import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper2.SqlDao;
import com.tgb.model.Include_col;
import com.tgb.service2.SqlService_2;
import com.tgb.util.EcxlTest;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class SqlServiceImpl_2 implements SqlService_2 {
	
	@Resource
	private SqlDao sqldao;
	@Resource
	private  UseCustomThemeMapper usecustomthememapper;
	@Autowired
	private EcxlTest ecxlTest;
	

    public Result implementsql(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
    	Result result=new Result();
    	Map map=new HashMap();
    	map.put("sql", sql);
    	List<Object> obj1=null;
    	try
    	{
       obj1=sqldao.implementsql(map);
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getStackTrace());
    		throw e;
    	}
    	
    	List<Object> obj2=new ArrayList<Object>();
     	
     	for(int i=0;i<obj1.size();i++){//给日期数据转换str格式
     		try{
     			obj2.add(dateStr((Map<String, Object>) obj1.get(i)));
     		}
     		catch(Exception e){
     			System.out.println("gggggggggggg :"+i);
     			e.printStackTrace();
     		}
     		
     	}
    	
    	
    	
    	List<Object> obj=new ArrayList<Object>();
     	
     	for(int i=0;i<obj2.size();i++){//先给没有的属性添加属性并赋值为空
     		try{
     			obj.add(dateStr1((Map<String, Object>) obj1.get(i), split2, split2));
     		}
     		catch(Exception e){
     			System.out.println("kkkkkkkkkk :"+i);
     		}
     		
     	}

    	System.out.println(obj.size());
    	result.setStatus(0);
    	result.setData(obj);
    	return result;
	}
    
    public Result implementsql(String sql,String num,String tomurl) throws Exception{
    	Result result=new Result();
    	Map map=new HashMap();
    	map.put("sql", sql);
    	List<Object> obj1=null;
    	try
    	{
       obj1=sqldao.implementsql(map);
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getStackTrace());
    		throw e;
    	}
    	
    	List<Object> obj=new ArrayList<Object>();
    	for(int i=0;i<obj1.size();i++){
    		try{
    			obj.add(dateStr((Map<String, Object>) obj1.get(i)));
    		}
    		catch(Exception e){
    			System.out.println("gggggggggggg :"+i);
    		}
    		
    	}

    	System.out.println(obj.size());
    	result.setStatus(0);
    	result.setData(obj);
    	return result;
	}   
  /*  public HSSFWorkbook ExporExcel(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
    	Map map=new HashMap();
     	map.put("sql", sql);
     	List<Object> obj1=null;
     	try
     	{
        obj1=sqldao.implementsql(map);
     	}
     	catch(Exception e)
     	{
     		System.out.println(e.getStackTrace());
     		throw e;
     	}
     	
    List<Object> obj2=new ArrayList<Object>();
     	
     	for(int i=0;i<obj1.size();i++){//给日期数据转换str格式
     		try{
     			obj2.add(dateStr((Map<String, Object>) obj1.get(i)));
     		}
     		catch(Exception e){
     			System.out.println("gggggggggggg :"+i);
     		}
     		
     	}
    	
    	
    	
    	List<Object> obj=new ArrayList<Object>();
     	
     	for(int i=0;i<obj2.size();i++){//先给没有的属性添加属性并赋值为空
     		try{
     			obj.add(dateStr1((Map<String, Object>) obj1.get(i), split2, split2));
     		}
     		catch(Exception e){
     			System.out.println("gggggggggggg :"+i);
     			System.out.println(obj1.get(i).toString());
     		}
     		
     	}
     	
        		//测试导出
            	//EcxlTest et=new EcxlTest();
            	//如果服务器在d盘这里c需要改成d且服务器名字一直
            	HSSFWorkbook wb = ecxlTest.daochu(obj,tomurl+"/img/Excel/aaa.xls",themeId);//将数据导出到服务端
            	
            	return wb;
            		
    	}*/   
    
 public HSSFWorkbook ExporExcel(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
	Map map=new HashMap();
 	map.put("sql", sql);
 	List<Object> obj1=null;
 	try
 	{
    obj1=sqldao.implementsql(map);
 	}
 	catch(Exception e)
 	{
 		System.out.println(e.getStackTrace());
 		throw e;
 	}
 	
List<Object> obj2=new ArrayList<Object>();
 	
 	for(int i=0;i<obj1.size();i++){//给日期数据转换str格式
 		try{
 			obj2.add(dateStr((Map<String, Object>) obj1.get(i)));
 		}
 		catch(Exception e){
 			System.out.println("gggggggggggg :"+i);
 		}
 		
 	}
	
	
	
	List<Object> obj=new ArrayList<Object>();
 	
 	for(int i=0;i<obj2.size();i++){//先给没有的属性添加属性并赋值为空
 		try{
 			obj.add(dateStr1((Map<String, Object>) obj1.get(i), split2, split2));
 		}
 		catch(Exception e){
 			System.out.println("gggggggggggg :"+i);
 			System.out.println(obj1.get(i).toString());
 		}
 		
 	}
 	
    		//测试导出
        	//EcxlTest et=new EcxlTest();
        	//如果服务器在d盘这里c需要改成d且服务器名字一直
        	HSSFWorkbook wb = ecxlTest.daochu(obj,tomurl+"/img/Excel/aaa.xls",themeId);//将数据导出到服务端
        	
        	return wb;
        		
	}
    
  //将hash集合中的所有date数据转换成str类型
    public static Map<String,Object> dateStr(Map<String, Object> map) throws NoSuchMethodException, SecurityException{
    	String sss="";
    	String date="";
    	for(String key : map.keySet()){
    		 sss=(Class<? extends String>) map.get(key).getClass()+"";
			// DecimalFormat df=new DecimalFormat("0.000");
			// if("class java.math.BigDecimal".equals(sss)){
			//	 map.get(key)=df.format(map.get(key));java.sql.Timestamp.timestampValue()
		//	 }class oracle.sql.TIMESTAMP
    		 //if("class java.sql.Timestamp".equals(sss) || "class oracle.sql.TIMESTAMP".equals(sss)){
    		 if("class oracle.sql.TIMESTAMP".equals(sss)){
//    			 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");    			 
//    			 date=sdf.format(map.get(key));
//    			 map.put(key, date);
    			 Class clz = map.get(key).getClass();
    			 Method method = clz.getMethod("timestampValue", null);
    			 Date date1 = new Date();
				try {
					date1 = (Date)method.invoke(map.get(key));
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch(Exception e){
					System.out.println("key="+key+";value="+map.get(key));
					e.printStackTrace();
				}
    			 map.put(key, date1.toString());
    		 }
    		 if("class java.sql.Timestamp".equals(sss))
    		 {
    			 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");    			 
    			 date=sdf.format(map.get(key));
    			 map.put(key, date);  			 
    		 }
    	}
    	return map;
    }
    
    
    //测试转换是否成功
    public static void main(String[] args) {
    	//String tomurl=Class.class.getClass().getResource("/").getPath();
    	Map<String ,Object> map=new HashMap<String ,Object>();
    	map.put("str1", new Date());
    	map.put("str2", "132");
    	try {
			map=dateStr(map);
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//***   强map中的date转换成str格式
    	System.out.println(map);
    	
	}
  
  //根据主题id和字段英文名查询中文名
  	public String findcname(Include_col incol){
  		String cname=usecustomthememapper.findcname(incol);
  		return cname;
  	}
    //将map中不存在的属性赋值为空
    public static Map<String,Object> dateStr1(Map<String, Object> map,String[] split1,String[] split2){
    	Map<String, Object> map1=new HashMap<String, Object>();
    	
    	for(int i=0;i<split2.length;i++){
    		Object obj=map.get(split2[i]);
    		if(obj==null){
    			map1.put(split2[i]," ");
    		}else{
    			map1.put(split2[i],map.get(split2[i]));
    		}
    	}
    	
	return map1;
	} 	
    public Result implementsql(String sql,String num,String tomurl,String themeId) throws Exception{
    	Result result=new Result();
    	Map map=new HashMap();
    	map.put("sql", sql);
    	List<Object> obj1=null;
    	try
    	{
       obj1=sqldao.implementsql(map);
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getStackTrace());
    		throw e;
    	}
    	
    	List<Object> obj=new ArrayList<Object>();
    	for(int i=0;i<obj1.size();i++){
    		try{
    			obj.add(dateStr((Map<String, Object>) obj1.get(i)));
    		}
    		catch(Exception e){
    			System.out.println("gggggggggggg :"+i);
    		}
    		
    	}

    	System.out.println(obj.size());
    	result.setStatus(0);
    	result.setData(obj);
    	return result;
	}   

}

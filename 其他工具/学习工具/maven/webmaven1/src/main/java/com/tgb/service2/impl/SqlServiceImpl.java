package com.tgb.service2.impl;

//import java.text.SimpleDateFormat;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

















import com.tgb.mapper.TableDao;
import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper2.SqlDao;
import com.tgb.mapper2.TableDao2_report;
import com.tgb.model.Include_col;
import com.tgb.model2.zsxm;
import com.tgb.service2.SqlService;
import com.tgb.util.EcxlTest;
import com.tgb.util.ExportExcel_new;
import com.tgb.util.ExportExcel_report;
import com.tgb.util.Is_excel;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class SqlServiceImpl implements SqlService {
	
	@Resource
	private SqlDao sqldao;
	@Resource
	private  UseCustomThemeMapper usecustomthememapper;
	@Autowired
	private EcxlTest ecxlTest;
	@Resource
	private TableDao2_report tabledao2_report;
	@Resource
	private TableDao tabledao;
	

    public Result implementsql(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
    	Result result=new Result();
    	Map map=new HashMap();
    	map.put("sql", sql);
    	
    	//优化测试sql性能
    	if(num.equals("0")){
    	Map map1=new HashMap();
    	String testsql="select * from (select rownum testsql_ro from ("+sql+") )testsql  where testsql.testsql_ro<2";
    	map1.put("sql", testsql);
    	map=map1;
    	}
    	
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
public HSSFWorkbook ExporExcel(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
    	Map map=new HashMap();//fach_py_lrb
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
    
public void ExporExcel_2(String sql,String num,String tomurl,String themeId,String[] split1,String[] split2) throws Exception{
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
 	
 			//将表头导入
 			//ExportExcel ee = new ExportExcel("表格标题", headerList);
 			List<String> userList = new ArrayList<String>();
 			Collections.addAll(userList, split1);
 	        ExportExcel_new ee = new ExportExcel_new("", userList); 
 	        //ExportExcel_new ee = new ExportExcel_new("", split1);
 			//导入表体
 			for (int i = 0; i < obj1.size(); i++) {
 				Row row = ee.addRow();
 				for (int j = 0; j < split2.length; j++) {
 					String aa = split2[j];
 					ee.addCell(row, j, ((Map)(obj1.get(i))).get(aa));
 				}
 			}
 			//创建.xlsx文件
 			ee.writeFile("f:/"+themeId+".xlsx");
 			ee.dispose();
 			//log.debug("Export success.");
 			System.out.println("导出完成1！");       	
        	
        		
	}
public void ExporExcel_3(String sql, int total_record_count,int perCount, String address,
		String excelName,String[] cTitle,String[] eTitle) throws Exception{
	//int totalPage = total_record_count/perCount == 0 ? total_record_count/perCount : total_record_count/perCount + 1;
	int totalPage = (total_record_count+perCount-1)/perCount;
	System.out.println("共"+totalPage+"页");
	Map map=new HashMap();
	List<Object> obj1=null;
	ExportExcel_new ee=null;
	String sql1 = "";
	for(int i=0;i<totalPage;i++){
		sql1 = "select * from (select t.*,rownum rn from ("+sql+") t )"
		  	      +" where rn>"+i*perCount+" and rn<="+(i+1)*perCount;
		 	map.put("sql", sql1);
		 	
		 	try
		 	{
		 		obj1=sqldao.implementsql(map);
	 			List<String> userList = new ArrayList<String>();
	 			Collections.addAll(userList, cTitle);
	 	        ee = new ExportExcel_new("", userList,excelName+"_"+i); 
	 			for (int k = 0; k < obj1.size(); k++) {
	 				Row row = ee.addRow();
	 				for (int j = 0; j < eTitle.length; j++) {
	 					String aa = eTitle[j];
	 					ee.addCell(row, j, ((Map)(obj1.get(k))).get(aa));
	 				}
	 			}
 		 		
		 	}
		 	catch(Exception e)
		 	{
		 		System.out.println(e.getStackTrace());
		 		throw e;
		 	} 
		 	map.remove("sql");
		 	obj1.clear();
		 	System.out.println("第"+(i+1)+"页完成");
	}
		ee.writeFile(address+":/"+excelName+".xlsx");
		ee.dispose();
		System.out.println("导出完成1！");	
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
    	LinkedHashMap<String, Object> map1=new LinkedHashMap<String, Object>();
    	
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
    public ExportExcel_new ExporExcel_4(String sql, int total_record_count,int perCount, String address,
    		String excelName,String[] cTitle,String[] eTitle) throws Exception{
    	//int totalPage = total_record_count/perCount == 0 ? total_record_count/perCount : total_record_count/perCount + 1;
    	int totalPage = (total_record_count+perCount-1)/perCount;
    	//System.out.println("共"+totalPage+"页");
    	//SXSSFWorkbook wb = new SXSSFWorkbook(1000);
    	Map map=new HashMap();
    	List<Object> obj1=null;
    	ExportExcel_new ee=null;
    	//ee.setWb(wb);
    	String sql1 = "";
    	for(int i=0;i<totalPage;i++){
    		sql1 = "select * from (select t.*,rownum rn from ("+sql+") t )"
    		  	      +" where rn>"+i*perCount+" and rn<="+(i+1)*perCount;
    		 	map.put("sql", sql1);
    		 	
    		 	try
    		 	{
    		 		obj1=sqldao.implementsql(map);
    	 			List<String> userList = new ArrayList<String>();
    	 			Collections.addAll(userList, cTitle);
    	 			if(ee==null){
    	 				ee = new ExportExcel_new("", userList,excelName+"_"+i);	
    	 			}else{
    	 				ee.initialize("", userList,excelName+"_"+i);
    	 			}
    	 	        
    	 	        //ee.setWb(wb);
    	 			for (int k = 0; k < obj1.size(); k++) {
    	 				Row row = ee.addRow();
    	 				for (int j = 0; j < eTitle.length; j++) {
    	 					String aa = eTitle[j];
    	 					ee.addCell(row, j, ((Map)(obj1.get(k))).get(aa));
    	 				}
    	 			}
     		 		
    		 	}
    		 	catch(Exception e)
    		 	{
    		 		System.out.println(e.getStackTrace());
    		 		throw e;
    		 	} 
    		 	map.remove("sql");
    		 	obj1.clear();
    		 	//System.out.println("第"+(i+1)+"页完成");
    	}
//    		ee.writeFile("/img/"+excelName+".xlsx");
//    		ee.dispose();
//    		System.out.println("导出完成1！");	
    	return ee;
    } 
    public int ExporExcel_5(String sql, int total_record_count,int perCount, String address,
    		String excelName,String[] cTitle,String[] eTitle,String tomurl) throws Exception{
    	//int totalPage = total_record_count/perCount == 0 ? total_record_count/perCount : total_record_count/perCount + 1;
    	int totalPage = (total_record_count+perCount-1)/perCount;
    	int return_num = 0;
    	Map map=new HashMap();
    	List<Object> obj1=null;
    	ExportExcel_new ee=null;
    	String sql1 = "";
    	for(int i=0;i<totalPage;i++){
    		sql1 = "select * from (select t.*,rownum rn from ("+sql+") t )"
    		  	      +" where rn>"+i*perCount+" and rn<="+(i+1)*perCount;
    		 	map.put("sql", sql1);
    		 	
    		 	try
    		 	{
    		 		obj1=sqldao.implementsql(map);
    	 			List<String> userList = new ArrayList<String>();
    	 			Collections.addAll(userList, cTitle);
    	 			if(ee==null){
    	 				ee = new ExportExcel_new("", userList,excelName+"_"+i);	
    	 			}else{
    	 				ee.initialize("", userList,excelName+"_"+i);
    	 			}
    	 	        
    	 	        //ee.setWb(wb);
    	 			for (int k = 0; k < obj1.size(); k++) {
    	 				Row row = ee.addRow();
    	 				for (int j = 0; j < eTitle.length; j++) {
    	 					String aa = eTitle[j];
    	 					ee.addCell(row, j, ((Map)(obj1.get(k))).get(aa));
    	 				}
    	 			}
     		 		return_num = 1;
    		 	}
    		 	catch(Exception e)
    		 	{
    		 		return_num = 0;
    		 		System.out.println(e.getStackTrace());
    		 		throw e;
    		 	} 
    		 	map.remove("sql");
    		 	obj1.clear();
    		 	//System.out.println("第"+(i+1)+"页完成");
    	}
    		ee.writeFile(tomurl+"/img/Excel/"+excelName+".xlsx");
    		ee.dispose();
    		System.out.println("导出完成1！");	
    	return return_num;
    }    
    
    
    
    /******引入自定义报表导出excel*/
  //单句sql导出excel
  	public ExportExcel_report excelexport(String sql,String ip,String sheet_num,String[] c_name,String[] e_name) throws Exception{
  		
  		
  	//******添加代码使导出的excel分页。每页显示30000条***********
  		int excelnum=Integer.parseInt(sheet_num);
  		//先查询总数量
  		int count=(Integer) findnumber(sql).getData();
  		int nums=count%excelnum==0?count/excelnum:count/excelnum+1;//总页数
  		ExportExcel_report listee=null;
  		SXSSFWorkbook wb1 = new SXSSFWorkbook(1000);
  	
  			for (int y = 0; y < nums; y++) {
  				int strnumber=y*excelnum+1;
  				int endnumber=(y+1)*excelnum>count?count:(y+1)*excelnum;
  				
  				Map map=new HashMap();
  		    	map.put("sql", sql);
  		    	map.put("strnumber", strnumber);
  		    	map.put("endnumber", endnumber+1);
  		    	
  		    	System.out.println("第"+strnumber+"-"+(endnumber+1)+"条数据开始导出************");
  		    	if(Is_excel.map.get(ip).equals("new")){
  		    		System.out.println("导出excel已中断！");
  		    		return null;
  		    	}
  		    	Is_excel.map1.put(ip, "导出进度：第"+strnumber+"-"+(endnumber+1)+"条数据，请勿离开页面。");
  		    	List<Object> obj1=null;
  		    	try
  		    	{
  		       obj1=sqldao.implementsql1(map);
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
  		     	obj2=newkey(obj2);
  		     	//****
  		     	List<Object> objs=new ArrayList<Object>();
  		     	for(int i=0;i<obj2.size();i++){//先给没有的属性添加属性并赋值为空
  		     		try{
  		     			objs.add(dateStr1((Map<String, Object>) obj1.get(i), c_name, e_name));
  		     		}
  		     		catch(Exception e){
  		     			System.out.println("kkkkkkkkkk :"+i);
  		     		}
  		     		
  		     	}
  		     	obj2=objs;
  		     	//*****
  				//添加表头
  				List<String> headerList = new ArrayList();
  				//遍历属性值（给定表头）
  		    	Map<String ,Object> map3=(Map<String, Object>) obj2.get(0);
  		    	String cname="";
  		    	for (int i = 0; i < c_name.length; i++) {
  		    		headerList.add(c_name[i]);
				}
  		     	/* for(String key: map3.keySet()){
  		    		//List<Form_codeSet> list=userepotrdao.findcname(key);
  		     		 try {
  		     			 //List<String> list=tabledao2_report.finCname(key);
  		     			 List<String> list=tabledao.findcol_cname(key);
  		          		int n=0;
  		         		if(list!=null&&list.size()>0){//如果英文名存在对应的中文名
  		     	    		for (int i = 0; i < list.size(); i++) {
  		     					if(null!=list.get(i)&&!"".equals(list.get(i))){
  		     						cname=list.get(i);
  		     						n=1;
  		     					}
  		     				}
  		         		}else{
  		         			cname=key;
  		         		}
  		         		if(n==0){
  		         			cname=key;	
  		         		}
  						
  					} catch (Exception e) {
  						cname=key;
  					}
  		     		
  		    		headerList.add(cname.trim());
  		     	 }*/
  		     	 int ns=headerList.indexOf("RO");
  		     	 if(ns!=-1){
  		     	headerList.remove(ns);//不要RO
  		     	 }
  				//导入表体
  		     	Map<String ,String> map4=null;
  		        List<String> dataRowList=new ArrayList<String>();
  		        List<List<String>> dataList=new ArrayList<List<String>>();
  		     	 for(int i=0;i<obj2.size();i++){
  		     		 map4=(Map<String, String>) obj2.get(i);
  		     		 
  		     		dataRowList = new ArrayList();//某行的每一单元格数据
  			     	 for(String key: map4.keySet()){
  			     		if(!"RO".equals(key)){
  			     		 Object obj=map4.get(key);
   			     		String str1=(Class<? extends String>) obj.getClass()+"";
   			     		String str="";
   			     		if("class java.math.BigDecimal".equals(str1)){
   			    				 DecimalFormat df=new DecimalFormat("0.000");
   			    				str=df.format(map4.get(key));
   			    	  }else{
   			     		str=map4.get(key)+"";
   			    	  }
   			     		dataRowList.add(str);
  			     		}
  			      	 }
  			     	dataList.add(dataRowList);
  		     	 }
  		     	 
  		     	 
  					//表头
  			     	listee = new ExportExcel_report("", headerList,"第"+(y+1)+"页数据",wb1); 
  				//导入表体
  					for (int i = 0; i < dataList.size(); i++) {
  						Row row = listee.addRow();
  						for (int j = 0; j < dataList.get(i).size(); j++) {
  							listee.addCell(row, j, dataList.get(i).get(j));
  						}
  					}
  						
  					
  	   }
  			
  		
  		
  		
      	System.out.println("导出成功2");
      	return listee;
  		
      	
  	   }
    
	//单句sql分页功能
	   //单句sql查出数据总量
	public Result findnumber(String sql){
		Result result= new Result();
		Map map=new HashMap();
 	map.put("sql", sql);
 	Integer i =null;
 	try
 	{
     i=sqldao.findnumber(map);
 	}
 	catch(Exception e)
 	{//sql语法错误
 		result.setStatus(-1);
 		return result;
 	}
 	result.setData(i);
		return result;
	}
	
	 //1.将mybatis用map返回中  含有"别名."的key(例如： sum(a.test_id)）  编译错误。这里重新编译   2.将value为null改为空
    public List<Object> newkey(List<Object> obj){
    	List<Object> objs=new ArrayList<Object>();
    	
    	Map<String ,Object> map1=null;
    	Map<String ,Object> map2=null;
    	
    	
    	for (int i = 0; i < obj.size(); i++) {
			map1=(Map<String ,Object>) obj.get(i);
			map2=new LinkedHashMap<String ,Object>();
			   String value="";
			  for(String key :map1.keySet()){//{FEIJINAVG=8048, AVG(T={FEIJINLEIXING)=3.03012048192771084337349397590361445783}}(SUM,MAX,MIN,AVG)
			   key=key;
			   //小数点格式化
			   
				   
				   String str1=(Class<? extends String>) map1.get(key).getClass()+"";
		     		if("class java.math.BigDecimal".equals(str1)){
		    				 DecimalFormat df=new DecimalFormat("0.0000");
		    				value=df.format(map1.get(key));
			    	  }else{
			    		  value=map1.get(key)+"";
			    	  }
	     		
	     		
	     		
	     		//不合格：
	     		//key=AVG(T
			   //value={FEIJINLEIXING)=3.03012048192771084337349397590361445783}
			   
	     		//转换为合格
			   if((value.indexOf("{")==0&&value.indexOf("=")!=-1&&value.indexOf("}")!=-1)){
				   key=key+"."+value.substring(1,value.indexOf("="));
				   value=value.substring(value.indexOf("=")+1,value.length()-1);
			   }
			   
			   map2.put(key, value);
			 }
			   objs.add(map2);
		}
    	return objs;
    }
    
    
    
    //查询树状征收项目
    public Result findzsdata(String num){
    	Result result=new Result();
    	List<zsxm> listobj = null;
    	if("0".equals(num)){
    	 listobj=sqldao.findzsxm();
    	}else if("1".equals(num)){
    	 listobj=sqldao.findzspm();	
    	}else{
    	 listobj=sqldao.findgljg();		
    	}
    	int a=0;
    	for (int i = 0; i < listobj.size(); i++) {//如果找不到父节点，将父id设置为root
    		a=0;
			String Pid=listobj.get(i).getpId();
			for (int j = 0; j < listobj.size(); j++) {
				String id=listobj.get(j).getId();
				if(Pid.equals(id)){
					a=1;
				}
			}
			
			if(a==0){//如果找不到父节点，将父id设置为root
				listobj.get(i).setpId("root");
			}
			
		}
    	
    	
    	
    	
    	zsxm zs=new zsxm();
    	zs.setId("root");
    	zs.setName("全选");
    	zs.setpId("all");
    	listobj.add(zs);
    	result.setData(listobj);
    	return result;
    }

}

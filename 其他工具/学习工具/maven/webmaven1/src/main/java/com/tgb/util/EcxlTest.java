package com.tgb.util;

import java.io.FileOutputStream;
import java.lang.reflect.Field;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.model.Include_col;
import com.tgb.model.Themetype;
import com.tgb.service2.SqlService;
import com.tgb.service2.impl.SqlServiceImpl;

@Component
public class EcxlTest {

	@Autowired
	private  UseCustomThemeMapper usecustomthememapper;
	
	public static void main(String[] args) {
		 //导出excel
		
			 Map map = new HashMap();
			 map.put("code","sss");
			 map.put("id","1");
			 map.put("name","分类一");
			 map.put("pid","0");
			 map.put("Is_del","0");
		     List<Object> objlist=new ArrayList<Object>();
		     for(int i=0;i<10000;i++){
		    	 objlist.add(map);
		     }
		     
		     EcxlTest aa = new EcxlTest();
		     aa.daochu_2(objlist,"f:/66.xls");//将需要导入的数据对象(list)和导入路径传参过去
		  
	 }
	 
	 
	 

	 public HSSFWorkbook daochu(List<Object> objlist ,String str,String themeId){
	 	 
		 //***   固定内容   *****
		 
	     // 第一步，创建一个webbook，对应一个Excel文件  
	     HSSFWorkbook wb = new HSSFWorkbook();  
	     // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
	     HSSFSheet sheet = wb.createSheet("学生表一");  
	     // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
	     HSSFRow row = sheet.createRow((int) 0);  
	     // 第四步，创建单元格，并设置值表头 设置表头居中  
	     HSSFCellStyle style = wb.createCellStyle();  
	     style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
	     HSSFCell cell = row.createCell((short) 0);  
	     

//   ************       一。       未知类和属性名      直接先查询属性名（写表头），然后取值（写表体）   *************
	    //模拟一个未知属性的类
	   
	     String name="";
	     String value="";
	     
	     java.util.Calendar clndr=java.util.Calendar.getInstance();
	     
	   //  Field[] field=type.getClass().getDeclaredFields();//根据对象type获取这个类的类组
	       Field[] field=objlist.get(0).getClass().getDeclaredFields();//获取这个类的类组
	     
	     //写表头
	     HashMap<String,Object> map0=(HashMap<String,Object>) objlist.get(0);//第y条数据转换成map
	     int j=0;
		 for (String key : map0.keySet()) {
			Include_col incol=new Include_col();
			incol.setCol_e_name(key);
			incol.setSubject_id(Integer.parseInt(themeId));
//			SqlServiceImpl sqlimp=new SqlServiceImpl();
			 String cname=usecustomthememapper.findcname(incol);//表头用中文名
			 if(incol.getCol_e_name().equals("FUNCTION")){
				 cname = "函数";
			 }
			 //写表头
			 cell.setCellValue(cname);  //英文名
		     cell.setCellStyle(style);  
		     cell = row.createCell((short) j+1); 
		     j++;
         }
	   
				
	     
	     //写表体
	     for(int y=0;y<objlist.size();y++){//循环实体list。因为这里实体类只模拟一条数据.正常从数据库查询的事list
	    	 row = sheet.createRow((int) y +1); //每多一条实体类数据：行+1（y++) 
	    			 HashMap<String,Object> map=(HashMap<String,Object>) objlist.get(y);//第y条数据转换成map
	              int x=0;
	    			 for (String key : map.keySet()) {
	    				 String sss=(Class<? extends String>) map.get(key).getClass()+"";
	    				 DecimalFormat df=new DecimalFormat("0.000");
	    				 if("class java.math.BigDecimal".equals(sss)){
	    					 value=df.format(map.get(key));
	    				 }else{
	    					value =map.get(key)+"";//获取第y条数据的第x个属性的值
	    				 }
		 		         // 第四步，创建单元格，并设置值  
		 		         row.createCell((short) x).setCellValue(value);  
		 		         x++;
		     }
	    	 
	    	 cell = row.createCell((short) field.length); 
	    	 
	     }
	     
	  
	     
	     
 //  *************  二。   已知实力类  和其属性 名   。。。直接加表头和属性值    ***************
	     
	     
	     //直接写入属性（表头）
/*	     cell.setCellValue("分类id");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 1);  
	     
	     cell.setCellValue("分类名称");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 2);  
	     
	     cell.setCellValue("分类编码");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 3);  
	     
	     cell.setCellValue("分类父id");  
	     cell.setCellStyle(style);  */
	     

	     /*  
	     // 第五步，写入实体数据 实际应用中这些数据从数据库得到，  
	     List<Themetype> thelist =  new ArrayList<Themetype>();
	     Themetype t=new Themetype();
	     t.setCode("sss");
	     t.setId(1);
	     t.setName("分类一");
	     t.setpId(0);
	     thelist.add(t);
	     Themetype t1=new Themetype();
	     t1.setCode("222");
	     t1.setId(2);
	     t1.setName("分类二");
	     t1.setpId(1);
	     thelist.add(t1);
	   
	     
	     Themetype tt=null;
	     for (int i = 0; i < thelist.size(); i++)  
	     {  
	         row = sheet.createRow((int) i + 1);  
	         tt = (Themetype) thelist.get(i);  
	         // 第四步，创建单元格，并设置值  
	         row.createCell((short) 0).setCellValue((double) tt.getId());  
	         row.createCell((short) 1).setCellValue(tt.getCode());
	         row.createCell((short) 2).setCellValue(tt.getName());  
	         row.createCell((short) 3).setCellValue((double) tt.getpId()); 
	         cell = row.createCell((short) 4); 
	     }  */
	     
	   
	     
// *************************	固定格式    ******************   
	     //   一。将得到的流保存在服务器
	     
	     // 将文件存到指定位置  
//	     try  
//	     {  
//	         FileOutputStream fout = new FileOutputStream(str);  
//	         
//	         wb.write(fout);  
//	         fout.close();  
//	         
//	     }  
//	     catch (Exception e)  
//	     {  
//	         e.printStackTrace();  
//	     } 
	     
	     //二.将流返回给controller。直接return给页面
	     return wb;
	  
	 }
	 
public HSSFWorkbook daochu_2(List<Object> objlist ,String str){
	 	 
		 //***   固定内容   *****
		 
	     // 第一步，创建一个webbook，对应一个Excel文件  
	     HSSFWorkbook wb = new HSSFWorkbook();  
	     // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
	     HSSFSheet sheet = wb.createSheet("学生表一");  
	     // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
	     HSSFRow row = sheet.createRow((int) 0);  
	     // 第四步，创建单元格，并设置值表头 设置表头居中  
	     HSSFCellStyle style = wb.createCellStyle();  
	     style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
	     HSSFCell cell = row.createCell((short) 0);  
	     

//   ************       一。       未知类和属性名      直接先查询属性名（写表头），然后取值（写表体）   *************
	    //模拟一个未知属性的类
	   
	     String name="";
	     String value="";
	     
	     java.util.Calendar clndr=java.util.Calendar.getInstance();
	     
	   //  Field[] field=type.getClass().getDeclaredFields();//根据对象type获取这个类的类组
	       Field[] field=objlist.get(0).getClass().getDeclaredFields();//获取这个类的类组
	     
	     //写表头
	     HashMap<String,Object> map0=(HashMap<String,Object>) objlist.get(0);//第y条数据转换成map
	     int j=0;
		 for (String key : map0.keySet()) {
			Include_col incol=new Include_col();
			incol.setCol_e_name(key);
			incol.setSubject_id(424);
//			SqlServiceImpl sqlimp=new SqlServiceImpl();
			 String cname="aaa";//表头用中文名
			 if(incol.getCol_e_name().equals("FUNCTION")){
				 cname = "函数";
			 }
			 //写表头
			 cell.setCellValue(cname);  //英文名
		     //cell.setCellStyle(style);  
		     cell = row.createCell((short) j+1); 
		     j++;
         }
	   
				
	     
	     //写表体
	     for(int y=0;y<objlist.size();y++){//循环实体list。因为这里实体类只模拟一条数据.正常从数据库查询的事list
	    	 row = sheet.createRow((int) y +1); //每多一条实体类数据：行+1（y++) 
	    			 HashMap<String,Object> map=(HashMap<String,Object>) objlist.get(y);//第y条数据转换成map
	              int x=0;
	    			 for (String key : map.keySet()) {
	    				 String sss=(Class<? extends String>) map.get(key).getClass()+"";
	    				 DecimalFormat df=new DecimalFormat("0.000");
	    				 if("class java.math.BigDecimal".equals(sss)){
	    					 value=df.format(map.get(key));
	    				 }else{
	    					value =map.get(key)+"";//获取第y条数据的第x个属性的值
	    				 }
		 		         // 第四步，创建单元格，并设置值  
		 		         row.createCell((short) x).setCellValue(value);  
		 		         x++;
		     }
	    	 
	    	 cell = row.createCell((short) field.length); 
	    	 
	     }
	     
	  
	     
	     
 //  *************  二。   已知实力类  和其属性 名   。。。直接加表头和属性值    ***************
	     
	     
	     //直接写入属性（表头）
/*	     cell.setCellValue("分类id");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 1);  
	     
	     cell.setCellValue("分类名称");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 2);  
	     
	     cell.setCellValue("分类编码");  
	     cell.setCellStyle(style);  
	     cell = row.createCell((short) 3);  
	     
	     cell.setCellValue("分类父id");  
	     cell.setCellStyle(style);  */
	     

	     /*  
	     // 第五步，写入实体数据 实际应用中这些数据从数据库得到，  
	     List<Themetype> thelist =  new ArrayList<Themetype>();
	     Themetype t=new Themetype();
	     t.setCode("sss");
	     t.setId(1);
	     t.setName("分类一");
	     t.setpId(0);
	     thelist.add(t);
	     Themetype t1=new Themetype();
	     t1.setCode("222");
	     t1.setId(2);
	     t1.setName("分类二");
	     t1.setpId(1);
	     thelist.add(t1);
	   
	     
	     Themetype tt=null;
	     for (int i = 0; i < thelist.size(); i++)  
	     {  
	         row = sheet.createRow((int) i + 1);  
	         tt = (Themetype) thelist.get(i);  
	         // 第四步，创建单元格，并设置值  
	         row.createCell((short) 0).setCellValue((double) tt.getId());  
	         row.createCell((short) 1).setCellValue(tt.getCode());
	         row.createCell((short) 2).setCellValue(tt.getName());  
	         row.createCell((short) 3).setCellValue((double) tt.getpId()); 
	         cell = row.createCell((short) 4); 
	     }  */
	     
	   
	     
// *************************	固定格式    ******************   
	     //   一。将得到的流保存在服务器
	     
	     // 将文件存到指定位置  
//	     try  
//	     {  
//	         FileOutputStream fout = new FileOutputStream(str);  
//	         
//	         wb.write(fout);  
//	         fout.close();  
//	         
//	     }  
//	     catch (Exception e)  
//	     {  
//	         e.printStackTrace();  
//	     } 
	     
	     //二.将流返回给controller。直接return给页面
	     return wb;
	  
	 }	 
	 
}




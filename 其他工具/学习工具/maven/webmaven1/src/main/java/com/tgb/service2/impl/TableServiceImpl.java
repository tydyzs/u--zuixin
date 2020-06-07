package com.tgb.service2.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.TableDao;
import com.tgb.mapper2.TableDao2;
import com.tgb.model.Old_inc_col;
import com.tgb.model.Old_tables;
import com.tgb.service2.TableService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class TableServiceImpl implements TableService {
	
	@Resource
	private TableDao tabledao;
	@Resource
	private TableDao2 tabledao2;
	@Resource
	private SqlSessionFactory sqlSessionFactory;

    
/*public Result findCol_new_old() throws IOException{
	SqlSession batchSqlSession = null;
	batchSqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH,false);
	int batchCount = 1000;
	
	Result result=new Result();
	List<Old_tables> ls = tabledao.findtables();
	for(int i=0;i<ls.size();i++){
		Old_tables old_tables = ls.get(i);
		int s_tables_id = old_tables.getS_tables_id();
		//String table_e_name = old_tables.getE_name();
		 //根据表名查询所有列
		 Old_inc_col col=new Old_inc_col();
		 Map map_new = new HashMap();
		 map_new.put("owner", old_tables.getE_name().substring(0,old_tables.getE_name().indexOf(".")));
		 map_new.put("table_name", old_tables.getE_name().substring(old_tables.getE_name().indexOf(".")+1));
		 List<Map> colList=tabledao2.findcol_2_new(map_new);
		 for(int j=0;j<colList.size();j++){//循环每一个字段名。开始新增字段表
				col.setCol_e_name("null");
				col.setCol_c_name("null");
				col.setS_tables_id(s_tables_id);    			
				Map<String,String> map1 = colList.get(j);	
				for(Map.Entry<String,String> entry : map1.entrySet()){
		   			 if(entry.getKey().equals("COLUMN_NAME")){col.setCol_e_name(entry.getValue());}
		   			 if(entry.getKey().equals("COMMENTS")){col.setCol_c_name(entry.getValue());}					
				}
//		   		Iterator<Map.Entry<String,String>> entries1 = map1.entrySet().iterator();
//		   		 while(entries1.hasNext())
//		   		 {
//		   			 Map.Entry<String, String> entry1 = entries1.next(); 
//		   			 if(entry1.getKey().equals("COLUMN_NAME")){col.setCol_e_name(entry1.getValue());}
//		   			 if(entry1.getKey().equals("COMMENTS")){col.setCol_c_name(entry1.getValue());}
//
//		   		 }
//				try
//				{
//					tabledao.newCol_2(col);
//				}
//				catch(Exception e)
//				{
//					System.out.println("有问题的表"+col.getS_tables_id());
//					e.printStackTrace();
//				}		   		 
		   		tabledao.newCol_2(col);
				}		 
		 batchSqlSession.commit();
		 colList.clear();
		 batchSqlSession.clearCache();
	}	
	batchSqlSession.close();	
	return result;
	
}

*/
//*********************************************************
public Result findTable_new(){
	int table_new=0;
	 int col_new=0;
	 
	Result result=new Result();
	List<Map> talbeString=tabledao2.findTalbe_2();//查询所有的表名
	//[{TABLE_NAME=ZS_YJSF, COMMENTS=纳税人应缴税费},
	String ename="";
	Old_tables old_tables = new Old_tables();
	for(int i=0;i<talbeString.size();i++){//循环将表英文名存入tables表中
		System.out.println(i+"********************************************************************");
		if(i==1679){
			System.out.println(12);
		}
		 old_tables.setC_name("null");
		 old_tables.setE_name("null");
		 Map map = talbeString.get(i);
		 //ename=map.get("ename");
		 Iterator<Map.Entry<String,String>> entries = map.entrySet().iterator();
		 while(entries.hasNext())
		 {
			 Map.Entry<String, String> entry = entries.next();
			 System.out.println("Key="+entry.getKey()+",value="+entry.getValue());    			 
			 if(entry.getKey().equals("TABLE_NAME")){old_tables.setE_name(entry.getValue());}
			 if(entry.getKey().equals("COMMENTS")){old_tables.setC_name(entry.getValue());}
			 
			 if(old_tables.getC_name().length()>100){old_tables.setC_name(old_tables.getE_name());}//如果中文名过（页面显示不美观）长直接采用英文名

		 }
		 
		 String e_names="";
		 
		 
		 List<Old_tables> listtable=tabledao.findname(old_tables.getE_name());
		 int s_tables_id;
		 if(listtable.size()==0){//本地库不存在则新增
		 tabledao.newtable_2(old_tables); 
		 s_tables_id = old_tables.getS_tables_id();
		 table_new++;
		 e_names=old_tables.getE_name();
		 }else{
		 s_tables_id = listtable.get(0).getS_tables_id();
		 e_names= listtable.get(0).getE_name();
		 }
		 
		 
		 //根据表名查询所有列
		 Old_inc_col col=new Old_inc_col();
		 List<Map> colList=tabledao2.findcol_2_new(e_names);
		 for(int j=0;j<colList.size();j++){//循环每一个字段名。开始新增字段表
				col.setCol_e_name("null");
				col.setCol_c_name("null");
				col.setS_tables_id(s_tables_id);    			
				Map map1 = colList.get(j);	       		 
		   		Iterator<Map.Entry<String,String>> entries1 = map1.entrySet().iterator();
		   		 while(entries1.hasNext())
		   		 {
		   			 Map.Entry<String, String> entry1 = entries1.next(); 
		   			 if(entry1.getKey().equals("COLUMN_NAME")){col.setCol_e_name(entry1.getValue());}
		   			 if(entry1.getKey().equals("COMMENTS")){col.setCol_c_name(entry1.getValue());}
		   			if(col.getCol_c_name().length()>100){col.setCol_c_name(col.getCol_e_name());}//如果中文名过（页面显示不美观）长直接采用英文名
		   		 }
				try
				{
					if(tabledao.findcol(col)==0){
					tabledao.newCol_2(col);
					col_new++;
					}
				}
				catch(Exception e)
				{
					System.out.println("有问题的表"+col.getS_tables_id());
					e.printStackTrace();
				}			
				}		 
		 
	}
	System.out.println("******此次更新新增表数量为："+table_new);
	System.out.println("******此次更新新增字段数量为："+col_new);

		result.setStatus(0);		
	
	//result.setData(talbeString);
	return result;
}
}

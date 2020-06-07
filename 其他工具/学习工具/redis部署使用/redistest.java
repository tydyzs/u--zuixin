package org.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.junit.Test;

import redis.clients.jedis.Jedis;

public class redistest {
	//@Test
	public  void testString(){
		Jedis jedis =new Jedis("150.21.25.79",6379);
		//设置key value
		jedis.set("name", "shenhuancheng");
		System.out.println(jedis.get("name"));
		//设置多个key value
		jedis.mset("name", "shenhuancheng","nianling","25");
		System.out.println(jedis.get("nianling"));
		//  ++操作
		jedis.set("age","25");
		System.out.println(jedis.get("age"));
		jedis.incr("age");
		System.out.println(jedis.get("age"));
	}
	


public List<Map> getdata(){
	List<Map> listdata=new ArrayList<Map>();
	Map map=null;
	for (int i = 0; i < 500; i++) {
		map=new HashMap();
		for (int j = 0; j < 10; j++) {
			map.put("key"+j, "value"+j);
		}
		listdata.add(map);
	}
	return listdata;
}


//将数据写入redis中.写入表名/写入数据
public  void setdata(String table_name,List<Map> map_list){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	int i;
	for ( i = 0; i < map_list.size(); i++) {
		Map map=map_list.get(i);
		String data_num=table_name+"_"+i;//用于记录第几条数据
		jedis.hmset(data_num, map);//载入一条记录
		String data_list_name=table_name;//建立set并用于保存所有map名字
		jedis.rpush(data_list_name, data_num);
		System.out.println("新增1条数据");
	}
	System.out.println(i+"条数据新增成功");
}


//获取数据并输出(表名/分页起止)
public  void getdata(String table_name,String [] key_list,Long numstr,Long numend){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	 table_name="tabletest";
	 
	 Long data_length=jedis.llen(table_name);//获取list长度
	 System.out.println(data_length);
	 if(numstr<0||numend<0){//如果分页参数为-1：查询所有
		 numstr=(long) 0; numend=data_length;
	 }
	 List<Map> list_data=new ArrayList<Map>();
	for (Long i = numstr; i < numend; i++) {
		String data_n_name=jedis.lrange(table_name, i, i).get(0);//redis起止位置（留头也留尾）
	   // List<String> map_data_n=jedis.hmget(data_n_name,"key0","key1","key2","key3");
	    Set<String> sd=jedis.hkeys(data_n_name);//所有key
	    Map data_map=new HashMap();
	    
	    
	    
	    if(key_list.length==0){//如果没有指定具体字段，则查所有字段
		    for(String key_n:sd){
		    	String value_n=jedis.hmget(data_n_name, key_n).get(0);
		    	data_map.put(key_n,value_n);
		    	System.out.print(key_n+"--"+value_n);
		    }
	    }else{
	    	 for(String key_n:key_list){
			    	String value_n=jedis.hmget(data_n_name, key_n).get(0);
			    	data_map.put(key_n,value_n);
			    System.out.println(key_n+"--"+value_n);
			 }
	    }
	    System.out.println();
	    list_data.add(data_map);
	    //map_data_n=jedis.hmget(data_n_name,jedis.hkeys(key));
	}
	System.out.println(list_data);
	System.out.println("总数据量："+list_data.size());
}

//获取数据并输出(表名/分页起止)
public  void deldata(String table_name,String [] key_list,Long numstr,Long numend){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	 table_name="tabletest";
	 
	 Long data_length=jedis.llen(table_name);//获取list长度
	 System.out.println(data_length);
	 if(numstr<0||numend<0){//如果分页参数为-1：查询所有
		 numstr=(long) 0; numend=data_length;
	 }
	for (Long i = numstr; i < numend; i++) {
		String data_n_name=jedis.lrange(table_name, i, i).get(0);//redis起止位置（留头也留尾）
	   // List<String> map_data_n=jedis.hmget(data_n_name,"key0","key1","key2","key3");
	    Set<String> sd=jedis.hkeys(data_n_name);//所有key
	    
	    int nums=0;
	    if(key_list.length==0){//如果没有指定具体字段，则查所有字段
		    for(String key_n:sd){
		    	//jedis.hdel(data_n_name, key_n);
		    	System.out.println("删除"+jedis.hdel(data_n_name, key_n)+"条数据");
		    	nums++;
		    }
	    }else{
	    	 for(String key_n:key_list){
	    		//jedis.hdel(data_n_name, key_n);
	    		System.out.println("删除"+jedis.hdel(data_n_name, key_n)+"条数据");
	    		nums++;
	    	 }
	    }
	    jedis.del(data_n_name);//删除某条数据(莫个map_key)
	}
	jedis.del(table_name);//删除整个表的key(list_map_key)
}



@Test
public void test_redis_data(){
	  
	//a();//新增  
	 //b();//查询
	 c();//删除

	
}
public void a(){
	//新增
	List<Map> map_list=getdata();
	String table_name="tabletest";
	setdata(table_name,map_list);//写入数据（设置表名，和数据）
}
public void b(){
	   //查询
		//String [] key_list={};
		String table_name1="tabletest";
		String [] key_list={"key1","key2","key3"};//查询具体字段.若leng为0则查询所有字段
		getdata(table_name1,key_list,(long)0,(long)1);//表/字段/分页参数：后两个参数为分页（含前不含后）
		
}
public void c(){
	//删除数据
	String table_name2="tabletest";
	//String [] key_list1={};//删除具体字段.若leng为0则查询所有字段
	String [] key_list1={};
	deldata(table_name2,key_list1,(long)0,(long)-3);//表/字段/分页参数：后两个参数为分页（含前不含后）
	
}






}

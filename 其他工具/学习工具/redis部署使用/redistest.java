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
		//����key value
		jedis.set("name", "shenhuancheng");
		System.out.println(jedis.get("name"));
		//���ö��key value
		jedis.mset("name", "shenhuancheng","nianling","25");
		System.out.println(jedis.get("nianling"));
		//  ++����
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


//������д��redis��.д�����/д������
public  void setdata(String table_name,List<Map> map_list){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	int i;
	for ( i = 0; i < map_list.size(); i++) {
		Map map=map_list.get(i);
		String data_num=table_name+"_"+i;//���ڼ�¼�ڼ�������
		jedis.hmset(data_num, map);//����һ����¼
		String data_list_name=table_name;//����set�����ڱ�������map����
		jedis.rpush(data_list_name, data_num);
		System.out.println("����1������");
	}
	System.out.println(i+"�����������ɹ�");
}


//��ȡ���ݲ����(����/��ҳ��ֹ)
public  void getdata(String table_name,String [] key_list,Long numstr,Long numend){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	 table_name="tabletest";
	 
	 Long data_length=jedis.llen(table_name);//��ȡlist����
	 System.out.println(data_length);
	 if(numstr<0||numend<0){//�����ҳ����Ϊ-1����ѯ����
		 numstr=(long) 0; numend=data_length;
	 }
	 List<Map> list_data=new ArrayList<Map>();
	for (Long i = numstr; i < numend; i++) {
		String data_n_name=jedis.lrange(table_name, i, i).get(0);//redis��ֹλ�ã���ͷҲ��β��
	   // List<String> map_data_n=jedis.hmget(data_n_name,"key0","key1","key2","key3");
	    Set<String> sd=jedis.hkeys(data_n_name);//����key
	    Map data_map=new HashMap();
	    
	    
	    
	    if(key_list.length==0){//���û��ָ�������ֶΣ���������ֶ�
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
	System.out.println("����������"+list_data.size());
}

//��ȡ���ݲ����(����/��ҳ��ֹ)
public  void deldata(String table_name,String [] key_list,Long numstr,Long numend){
	Jedis jedis =new Jedis("150.21.25.79",6379);
	 table_name="tabletest";
	 
	 Long data_length=jedis.llen(table_name);//��ȡlist����
	 System.out.println(data_length);
	 if(numstr<0||numend<0){//�����ҳ����Ϊ-1����ѯ����
		 numstr=(long) 0; numend=data_length;
	 }
	for (Long i = numstr; i < numend; i++) {
		String data_n_name=jedis.lrange(table_name, i, i).get(0);//redis��ֹλ�ã���ͷҲ��β��
	   // List<String> map_data_n=jedis.hmget(data_n_name,"key0","key1","key2","key3");
	    Set<String> sd=jedis.hkeys(data_n_name);//����key
	    
	    int nums=0;
	    if(key_list.length==0){//���û��ָ�������ֶΣ���������ֶ�
		    for(String key_n:sd){
		    	//jedis.hdel(data_n_name, key_n);
		    	System.out.println("ɾ��"+jedis.hdel(data_n_name, key_n)+"������");
		    	nums++;
		    }
	    }else{
	    	 for(String key_n:key_list){
	    		//jedis.hdel(data_n_name, key_n);
	    		System.out.println("ɾ��"+jedis.hdel(data_n_name, key_n)+"������");
	    		nums++;
	    	 }
	    }
	    jedis.del(data_n_name);//ɾ��ĳ������(Ī��map_key)
	}
	jedis.del(table_name);//ɾ���������key(list_map_key)
}



@Test
public void test_redis_data(){
	  
	//a();//����  
	 //b();//��ѯ
	 c();//ɾ��

	
}
public void a(){
	//����
	List<Map> map_list=getdata();
	String table_name="tabletest";
	setdata(table_name,map_list);//д�����ݣ����ñ����������ݣ�
}
public void b(){
	   //��ѯ
		//String [] key_list={};
		String table_name1="tabletest";
		String [] key_list={"key1","key2","key3"};//��ѯ�����ֶ�.��lengΪ0���ѯ�����ֶ�
		getdata(table_name1,key_list,(long)0,(long)1);//��/�ֶ�/��ҳ����������������Ϊ��ҳ����ǰ������
		
}
public void c(){
	//ɾ������
	String table_name2="tabletest";
	//String [] key_list1={};//ɾ�������ֶ�.��lengΪ0���ѯ�����ֶ�
	String [] key_list1={};
	deldata(table_name2,key_list1,(long)0,(long)-3);//��/�ֶ�/��ҳ����������������Ϊ��ҳ����ǰ������
	
}






}

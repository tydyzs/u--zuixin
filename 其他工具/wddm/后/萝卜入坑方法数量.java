package com.didispace.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/*萝卜入坑方法种类*/
public class test {
	
	private static int nums=13;
	private static int dg=1;
	private static int sum=0;
	private static List list=new ArrayList();
	public static void main(String[] args) {
		String q=getdate();
		set_br_num();
		set_fa(1);
		String z=getdate();
		System.out.println("执行完成!用时："+q+"--"+z);
		System.out.println("种类："+sum+"种");
	}
	
	public static String getdate(){
		Date  date=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss") ; //使用了默认的格式创建了一个日期格式化对象。
		String time = dateFormat.format(date); //可以把日期转换转指定格式的字符串
		System.out.println("当前的系统时间："+ time);
		return time;
	}
	
	
	
	public  static void set_fa(int br_num){
		
		for (int i = 1; i <= nums; i++) {
			String str=br_num+"--"+i;
			Map map=getlist(list, br_num,i);
			boolean b=(boolean) map.get("b");
			if(!b){
				continue;
			}
			list=(List) map.get("list");
			list.add(str);
			if(list.size()==nums){
				sum++;
				System.out.println(list.toString());
			}
			dg=br_num;
			if(dg<nums){
				dg++;
			    set_fa(dg);
			}
			
		}
	}
	
	public static Map getlist(List list,int num,int j){
		boolean b=true;
		List list1=new ArrayList();
		for (int i = 1; i < num; i++) {
			String v_j=(String) list.get(i-1);
			list1.add(v_j);
			String sv=(String) list.get(i-1);
			int v=Integer.parseInt(sv.substring(sv.indexOf("--")+2));
			if(v==j){
				b=false;
				break;
			}
		}
		HashMap map=new HashMap();
		map.put("list", list1);
		map.put("b", b);
		return map;
	}
	
	public static boolean distinct(List list){
		boolean b=true;
		String str="";
		for (int i = 0; i < list.size(); i++) {
			String s1=(String) list.get(i);
			String s2=s1.substring(s1.indexOf("--")+2);
			if(str.indexOf(s2+"%%")==-1){
				str+=s2+"%%";
			}else{
				b=false;
				break;
			}
		}
		return b;
		
	}
	
	private static Map br_num_map =new HashMap();
	public  static void set_br_num(){
		br_num_map.put("br1",  0);br_num_map.put("br2",  0);br_num_map.put("br3",  0);
		br_num_map.put("br4",  0);br_num_map.put("br5",  0);br_num_map.put("br6",  0);
		br_num_map.put("br7",  0);br_num_map.put("br8",  0);br_num_map.put("br9",  0);
		br_num_map.put("br10", 0);br_num_map.put("br11", 0);br_num_map.put("br12", 0);
		br_num_map.put("br13", 0);br_num_map.put("br14", 0);br_num_map.put("br15", 0);
	}
	public static boolean is_distinct(int j,int num){
		boolean b=true;
		if(num!=1){
			for(int i = 0; i < num; i++) {
				if(j==(int)br_num_map.get("br"+(i+1))){
					b=false;
					break;
				}
			}
		}
		return b;
	}
}

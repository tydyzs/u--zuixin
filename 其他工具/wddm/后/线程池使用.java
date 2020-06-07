package com.tgb.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UserMapper;

public class static_data {
	
	//
	public static  Map<String,List> map_pai=new HashMap<String,List>();//
	public static  Map<String,String> map_yanse=new HashMap<String,String>();//归谁执行(保存上一步的颜色)
	public static  Map<String,String> map_zt=new HashMap<String,String>();//是否可吃（是否已分蓝红;0:未分，1：已分）
	public static  Map<String,String> map_yanse_zt=new HashMap<String,String>();//记录
	//线程池
	public static ExecutorService fixedThreadPool=Executors.newFixedThreadPool(10);
	
	//访问监控留痕。
	public static synchronized  void set_fwjl(Map map,UserMapper mapper){
		try {
			 String times = mapper.fw_times(map);
		     Integer ti = Integer.valueOf(Integer.parseInt(times));
		     if ((ti.intValue() > 5) || (ti.intValue() == -1)) {
		       mapper.fwjl(map);
		     }
		     System.out.println("请求验证完成！");
		} catch (Exception e) {
			System.err.println(e);
		}
    

	}
	public  void static_thread(Map map,UserMapper mapper,String zt){//将任务交给线程处理
		//线程方案
		/*Thread a=new Thread(new MyThread(map, mapper,zt));
		a.start();*/
		//线程池方案
		ExecutorService fixedThreadPool = static_data.fixedThreadPool;//获取线程池对象
		if(fixedThreadPool==null){
			static_data.fixedThreadPool=Executors.newFixedThreadPool(20);	
		}
		fixedThreadPool.execute(new Runnable () {//通过线程池创建线程并执行任务（任务执行完线程不销毁，而是回到线程池）
			public void run () {
				if(zt.equals("0")){//处理请求（判断是否需要登记此ip）
					static_data.set_fwjl(map,mapper);
					}else if(zt.equals("1")){//追加到ip数据表里
						String ip=(String) map.get("ip");
						String ipdata="本地";
						if(!"127.0.0.1".equals(ip)){
							Ip i=new Ip();
							ipdata=i.find_data(ip);
						}
						map.put("ipdata", ipdata);
						try {
							mapper.insert_ip(map);
						} catch (Exception e) {
							System.err.println("ip已存在**********");
						}
						
					}
				}
		});

	
		
	}
}

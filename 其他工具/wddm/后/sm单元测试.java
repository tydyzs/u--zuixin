package com.tgb.sm_test;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.tgb.mapper.UserMapper;
import com.tgb.util.Static_data;

public class UserTest {

	public static void main(String[] args) {
		ApplicationContext applicationContext =new ClassPathXmlApplicationContext("classpath:/config/spring-common.xml");
		UserMapper userMapper =(UserMapper) applicationContext.getBean("userMapper");
		Object obj =userMapper.query_liuyan_all();
		System.out.println(obj);
	}
	
	public Object getObject(){
		UserMapper userMapper =Static_data.userMapper;
		Object obj =userMapper.query_liuyan_all();
		System.out.println(obj);
		return obj;
	}
}

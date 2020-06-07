package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.service.UserService;
import com.example.demo.util.Result;

@RestController    //@RestController自动返回json
public class HelloController {
	//依赖注入
    @Autowired
    UserService userService;
    
	//第一个测试
	  @RequestMapping("/hello")
	    public String index(String userName,String a) {
	        return "Hello World："+userName+a;
	    }
	  //测试get
	  @RequestMapping(value = "/test_get", method = RequestMethod.GET)
	    public String index1(@RequestParam(value = "userName") String userName,HttpServletRequest req) {
	        return "Hello World："+userName;
	    }
	//通过RequestMethod.POST表示请求需要时POST方式
	    @RequestMapping(value = "/test_post", method = RequestMethod.POST)
	    String index2(@RequestParam(value = "userName") String userName){
	        return "Hello " + userName;
	    }
	    
	   //返回json数据对象 
	  @RequestMapping("/test1")
	    public List<Map> test1() {
		  List<Map> listresult=new ArrayList<Map>();
		  Map map=new HashMap();
		  map.put("key1", "value1");
		  map.put("key2", "value2");
		  map.put("key3", "value3");
		  listresult.add(map);
		  listresult.add(map);
	        return listresult;
	    }
	  
	  
	//ssm测试 
	  @RequestMapping("/testssm")
	    public Result testssm(String username) {
		 Result result=userService.queryUserByUserName(username);
	        return result;
	    }

}

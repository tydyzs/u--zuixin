package com.example.demo.service.serviceImp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.UserTestDao;
import com.example.demo.service.UserService;
import com.example.demo.util.Result;

@Service
public class UserServiceImpl implements UserService{
     @Autowired
     UserTestDao mapper;

    @Override
    public Result queryUserByUserName(String username) {
    	Result result=new Result();
    	Map map=new HashMap();
    	map.put("names", username);
        List<Object> list = mapper.selectUser1(username);
        result.setData(list);
        return result;
    }

}

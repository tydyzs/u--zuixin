package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserTestDao {
    List<Object> selectUser( Map map);
    List<Object> selectUser1( String username);
}

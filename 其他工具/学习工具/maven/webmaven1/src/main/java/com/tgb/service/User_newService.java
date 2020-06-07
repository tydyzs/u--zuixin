package com.tgb.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import com.tgb.model.User_new;
import com.tgb.util.Result;


public interface User_newService {
	public Result  save(User_new user_new);
	public Result  update(User_new user_new);
	public Result  delete(int user_id);
	public Result  findById(int user_id);
	public Result  findAll(String currentPage);
	//public Result  findByName(String user_code);
	public Result  findByName(Map map);
	public Result  findByName_new(Map map);
	public Result  findCount();
	public Result  checkUser(User_new user_new);
	public Result  importUser_new(InputStream file,String name) throws InvalidFormatException, IOException;
	public Result  findAll_new();
	public Result  findModByUserCode(Map map);
	public Result  findModByPanentID(Map map);
	public Result finduserdata(String user_code);
}

package com.tgb.mapper;

import java.util.List;
import java.util.Map;



import org.apache.ibatis.annotations.Param;

import com.tgb.model.User_new;

public interface User_newMapper {

	boolean save(User_new user_new);
	boolean update(User_new user_new);
	boolean delete(int user_id);
	Map findById(int user_id);
	List<Map> findAll(String currentPage);
	//List<Map> findByName(@Param("user_code")String user_code,String currentPage);
	List<Map> findByName(Map map);
	List<Map> findByName_new(Map map);
	int findCount();//查询所有部门下人员总数
	int findCount_new();//查询用户总数 
	List<User_new> checkUser(User_new user_new);
	List<Map> findModRoleByUserId(int user_id);
	List<Map> findAll_new();
	List<Map> findModByUserCode(Map map);//根据user_code,project_id查寻菜单
	List<Map> findModByPanentID(Map map);//根据user_code,project_id,parent_id查寻菜单
	Object finduserdata(String user_code);
}

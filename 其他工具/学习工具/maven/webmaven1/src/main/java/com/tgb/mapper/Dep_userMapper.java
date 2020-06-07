package com.tgb.mapper;

import java.util.List;
import java.util.Map;




import org.apache.ibatis.annotations.Param;

import com.tgb.model.Dep_user;
import com.tgb.model.User_new;

public interface Dep_userMapper {

	boolean save(Dep_user dep_user);
	boolean update(Dep_user dep_user);
	boolean delete(int dep_user_id);
	Map findById(int dep_user_id);
	List<Map> findAll(String currentPage);
	int findCount();
	boolean update_2(Dep_user dep_user);
	boolean deleteByDepID(int department_id);
}

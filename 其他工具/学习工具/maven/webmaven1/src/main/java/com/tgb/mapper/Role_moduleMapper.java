package com.tgb.mapper;

import java.util.List;
import java.util.Map;




import org.apache.ibatis.annotations.Param;

import com.tgb.model.Role_module;
import com.tgb.model.User_new;

public interface Role_moduleMapper {

	boolean save(Role_module role_module);
	boolean update(Role_module role_module);
	boolean delete(int role_module_id);
	Map findById(int role_module_id);
	List<Map> findAll(String currentPage);
	int findCount();
	boolean update_2(Role_module role_module);
	boolean deleteByModuleID(int module_id);
	boolean deleteByRoleID(int role_id);
	List<Role_module> findByRoleId(int role_id);
}

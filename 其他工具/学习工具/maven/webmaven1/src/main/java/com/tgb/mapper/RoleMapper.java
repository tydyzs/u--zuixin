package com.tgb.mapper;

import java.util.List;
import java.util.Map;




import org.apache.ibatis.annotations.Param;

import com.tgb.model.Role;

public interface RoleMapper {

	boolean save(Role role);
	boolean update(Role role);
	boolean delete(int role_id);
	Map findById(int role_id);
	List<Map> findAll(Map map);
	List<Map> findByName(Map map);
	int findCount(int project_id);
	List<Map> findAll_2(int project_id);
}

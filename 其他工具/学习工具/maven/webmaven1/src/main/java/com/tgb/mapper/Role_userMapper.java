package com.tgb.mapper;

import java.util.List;
import java.util.Map;

import com.tgb.model.Role_user;

public interface Role_userMapper {

	boolean save(Role_user role_user);
	boolean update(Role_user role_user);
	boolean deleteByUserID(int user_id);
	boolean deleteByRoleID(int role_id);
	List<Map> findByRoleID(int role_id);
}

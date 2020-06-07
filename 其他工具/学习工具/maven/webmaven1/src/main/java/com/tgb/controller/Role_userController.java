package com.tgb.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Role_user;
import com.tgb.service.Role_userService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/role_user")
public class Role_userController {
	@Resource
	private Role_userService Role_userService;
	

	
	/**
	 * 跳转到添加角色界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddRoleUser")
	@ResponseBody
	public Result toAddRoleUser(HttpServletRequest request,Role_user role_user){		
		Result result = new Result();
		Role_userService.save(role_user);
		int role_user_id = role_user.getRole_user_id();
		result.setStatus(0);
		result.setData(role_user_id);
		return result;
	}

	/**
	 *编辑角色
	 * @param Role
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateRoleUser")
	@ResponseBody
	public Result updateRoleUser(HttpServletRequest request,Role_user role_user){		
		Result result = new Result();		
		Role_userService.update(role_user);
		result.setStatus(0);
		return result;		
	}
	/**
	 *根据角色ID删除
	 * @param Role_id
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteByRoleID")
	@ResponseBody
	public Result deleteByRoleID(HttpServletRequest request,String role_id){		
		Result result = new Result();		
		Role_userService.deleteByRoleID(Integer.parseInt(role_id));
		result.setStatus(0);
		return result;		
	}
	/**
	 *根据角色ID查询
	 * @param Role_id
	 * @param request
	 * @return
	 */
	@RequestMapping("/findByRoleID")
	@ResponseBody	
	public Result findByRoleID(HttpServletRequest request,String role_id){		
		Result result = new Result();		
		result = Role_userService.findByRoleID(Integer.parseInt(role_id));
		result.setStatus(0);
		return result;		
	}
		
}












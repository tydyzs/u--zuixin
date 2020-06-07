package com.tgb.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Role_module;
import com.tgb.service.Role_moduleService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/role_module")
public class Role_moduleController {
	@Resource
	private Role_moduleService role_moduleService;
	

	
	/**
	 * 跳转到添加角色界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddRoleModule_mod")
	@ResponseBody
	public Result toAddRoleModule(HttpServletRequest request,Role_module role_module){		
		Result result = new Result();
		role_moduleService.save(role_module);
		int role_module_id = role_module.getRole_module_id();
		result.setStatus(0);
		result.setData(role_module_id);
		return result;
	}

	/**
	 *编辑角色
	 * @param Role
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateRoleModule_mod")
	@ResponseBody
	public Result updateRoleModule(HttpServletRequest request,Role_module role_module){		
		Result result = new Result();		
		role_moduleService.update(role_module);
		result.setStatus(0);
		return result;		
	}
	/**
	 *根据角色ID删除
	 * @param Role_id
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteByRoleID_mod")
	@ResponseBody
	public Result deleteByRoleID(HttpServletRequest request,String role_id){		
		Result result = new Result();		
		role_moduleService.deleteByRoleID(Integer.parseInt(role_id));
		result.setStatus(0);
		return result;		
	}
	/**
	 *根据角色ID查询
	 * @param Role_id
	 * @param request
	 * @return
	 */
	@RequestMapping("/findByRoleID_mod")
	@ResponseBody	
	public Result findByRoleID(HttpServletRequest request,String role_id){		
		Result result = new Result();		
		result = role_moduleService.findByRoleId(Integer.parseInt(role_id));		
		return result;		
	}
		
}












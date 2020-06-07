package com.tgb.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Role;
import com.tgb.service.RoleService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Resource
	private RoleService RoleService;
	
	/**
	 * 获取所有角色列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllRole")
	@ResponseBody
	public Result getAllRole(String currentPage,String project_id,HttpServletRequest request){
		Map map = new HashMap();
		map.put("currentPage", currentPage);
		map.put("project_id", project_id);
		Result result = new Result();
		result = RoleService.findAll(map);	
		return result;
	}
	/**
	 * 获取所有角色列表2
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllRole_2")
	@ResponseBody
	public Result getAllRole_2(String project_id,HttpServletRequest request){
		int project_id_2 = Integer.parseInt(project_id);
		Result result = new Result();
		result = RoleService.findAll_2(project_id_2);	
		return result;
	}	
	/**
	 * 跳转到添加角色界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddRole")
	@ResponseBody
	public Result toAddRole(HttpServletRequest request,Role role){		
		Result result = new Result();
		RoleService.save(role);
		int role_id = role.getRole_id();
		result.setStatus(0);
		result.setData(role_id);
		return result;
	}

	/**
	 *编辑角色
	 * @param Role
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateRole")
	@ResponseBody
	public Result updateRole(HttpServletRequest request,Role role){		
		Result result = new Result();		
		RoleService.update(role);
		result.setStatus(0);
		return result;		
	}
	/**
	 * 根据id查询单个角色
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getRole")
	@ResponseBody
	public Result getRole(String role_id,HttpServletRequest request){		
		Result result = new Result();
		result = RoleService.findById(Integer.parseInt(role_id));		
		return result;		
	}
	
	//根据主题ID删除业务主题
	@RequestMapping("/delRole")
	@ResponseBody
	public Result delRole(int role_id){
		Result result =  RoleService.delete(role_id);
		result.setStatus(0);
		return result;
	}


		//根据角色名或者角色编码模糊查询角色
		@RequestMapping("/queryByName")
		@ResponseBody
		public Result queryByName(String role_name,String currentPage,String project_id){
			Map map = new HashMap();
			map.put("role_name", role_name);
			map.put("currentPage", currentPage);
			map.put("project_id", project_id);
			Result result =  RoleService.findByName(map);
			return result;
		}
		//查询角色数量
		@RequestMapping("/findCount")
		@ResponseBody
		public Result findCount(String project_id){
			int project_id_2 = Integer.parseInt(project_id);
			Result result =  RoleService.findCount(project_id_2);
			return result;
		}		
			
		
}












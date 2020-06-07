package com.tgb.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Project;
import com.tgb.service.ProjectService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/project")
public class ProjectController {
	@Resource
	private ProjectService ProjectService;
	
	/**
	 * 获取所有角色列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllProject")
	@ResponseBody
	public Result getAllProject(HttpServletRequest request){
		Result result = new Result();
		result = ProjectService.findAll();	
		return result;
	}	
		
}












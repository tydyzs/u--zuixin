package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tgb.model.Tgroup;
import com.tgb.service.TgroupService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/tgroup")
public class TgroupController {

	@Autowired
	private TgroupService tgroupService;
	
	/**
	 * 获取所有主题分组列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTgroup")
	public String getAllTgroup(HttpServletRequest request){
		
		List<Tgroup> findAll = tgroupService.findAll();
		
		request.setAttribute("tgroupList", findAll);
		return "/allTgroup";
	}
	
	/**
	 * 跳转到添加主题分组界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTgroup")
	public String toAddTgroup(HttpServletRequest request){
		
		return "/addTgroup";
	}
	/**
	 * 添加主题分组并重定向
	 * @param Tgroup
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTgroup")
	public Result addTgroup(Tgroup tgroup,HttpServletRequest request){		

		Result result = new Result();
		try
		{
			tgroupService.save(tgroup);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;		
	}
	
	/**
	 *编辑主题分组
	 * @param Tgroup
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTgroup")
	public String updateTgroup(Tgroup tgroup,HttpServletRequest request){
		
		
		if(tgroupService.update(tgroup)){
			tgroup = tgroupService.findById(tgroup.getGroup_id());
			request.setAttribute("tgroup", tgroup);
			return "redirect:/tgroup/getAllTgroup";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个主题分组
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTgroup")
	public String getTgroup(int id,HttpServletRequest request){
		
		request.setAttribute("tgroup", tgroupService.findById(id));
		return "/editTgroup";
	}
	/**
	 * 删除主题分组
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTgroup")
	public void delTgroup(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(tgroupService.delete(id)){
			result = "{\"result\":\"success\"}";
		}
		
		response.setContentType("application/json");
		
		try {
			PrintWriter out = response.getWriter();
			out.write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}

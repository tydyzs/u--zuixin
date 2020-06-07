package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.S_tables;
import com.tgb.service.S_tablesService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/s_tables")
public class S_tablesController {

	@Autowired
	private S_tablesService s_tablesService;
	
	/**
	 * 获取所有主题包含表列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllS_tables")
	public String getAllS_tables(HttpServletRequest request){
		
		List<S_tables> findAll = s_tablesService.findAll();
		
		request.setAttribute("s_tablesList", findAll);
		return "/allS_tables";
	}
	
	/**
	 * 跳转到添加主题包含表界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddS_tables")
	public String toAddS_tables(HttpServletRequest request){
		
		return "/addS_tables";
	}
	/**
	 * 添加主题包含表并重定向
	 * @param S_tables
	 * @param request
	 * @return
	 */
	@RequestMapping("/addS_tables")
	@ResponseBody
	public Result addS_tables(S_tables s_tables,HttpServletRequest request){
		Result result = new Result();
		try
		{
			s_tablesService.save(s_tables);
			int s_tables_id = s_tables.getS_tables_id();
			result.setData(s_tables_id);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;
	}
	
	/**
	 *编辑主题包含表
	 * @param S_tables
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateS_tables")
	public String updateS_tables(S_tables s_tables,HttpServletRequest request){
		
		
		if(s_tablesService.update(s_tables)){
			s_tables = s_tablesService.findById(s_tables.getS_tables_id());
			request.setAttribute("s_tables", s_tables);
			return "redirect:/s_tables/getAllS_tables";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个主题包含表
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getS_tables")
	public String getS_tables(int id,HttpServletRequest request){
		
		request.setAttribute("s_tables", s_tablesService.findById(id));
		return "/editS_tables";
	}
	/**
	 * 删除主题包含表
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delS_tables")
	public void delS_tables(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(s_tablesService.delete(id)){
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

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

import com.tgb.model.Include_col;
import com.tgb.service.Include_colService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/include_col")
public class Include_colController {

	@Autowired
	private Include_colService include_colService;
	
	/**
	 * 获取所有包含列列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllInclude_col")
	public String getAllInclude_col(HttpServletRequest request){
		
		List<Include_col> findAll = include_colService.findAll();
		
		request.setAttribute("include_colList", findAll);
		return "/allInclude_col";
		
	}
	
	/**
	 * 跳转到添加包含列界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddInclude_col")
	public String toAddInclude_col(HttpServletRequest request){
		
		return "/addInclude_col";
	}
	/**
	 * 添加包含列并重定向
	 * @param Include_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/addInclude_col")
	@ResponseBody
	public Result addInclude_col(Include_col include_col,HttpServletRequest request){
		
		Result result = new Result();
		//System.out.println("Is_function:"+tsubject.getIs_function()+" subject_name="+tsubject.getSubject_name()+" t_type_id="+tsubject.getT_type_id()+" setdate="+tsubject.getSetdate());	
		try
		{
			include_colService.save(include_col);
			int include_col_id = include_col.getInclude_col_id();			
			result.setStatus(0);
			result.setData(include_col_id);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		return result;
	}
	
	/**
	 *编辑包含列
	 * @param Include_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateInclude_col")
	public String updateInclude_col(Include_col include_col,HttpServletRequest request){
		
		
		if(include_colService.update(include_col)){
			include_col = include_colService.findById(include_col.getInclude_col_id());
			request.setAttribute("include_col", include_col);
			return "redirect:/include_col/getAllInclude_col";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个包含列
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getInclude_col")
	public String getInclude_col(int id,HttpServletRequest request){
		
		request.setAttribute("include_col", include_colService.findById(id));
		return "/editInclude_col";
	}
	/**
	 * 删除包含列
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delInclude_col")
	public void delInclude_col(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(include_colService.delete(id)){
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

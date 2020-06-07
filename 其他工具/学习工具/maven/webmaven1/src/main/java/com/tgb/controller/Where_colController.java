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

import com.tgb.model.Where_col;
import com.tgb.service.Where_colService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/where_col")
public class Where_colController {

	@Autowired
	private Where_colService where_colService;
	
	/**
	 * 获取所有条件字段列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllWhere_col")
	public String getAllWhere_col(HttpServletRequest request){
		
		List<Where_col> findAll = where_colService.findAll();
		
		request.setAttribute("where_colList", findAll);
		return "/allWhere_col";
	}
	
	/**
	 * 跳转到添加条件字段界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddWhere_col")
	public String toAddWhere_col(HttpServletRequest request){
		
		return "/addWhere_col";
	}
	/**
	 * 添加条件字段并重定向
	 * @param Where_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/addWhere_col")
	@ResponseBody
	public Result addWhere_col(Where_col where_col,HttpServletRequest request){
		
		//return "redirect:/where_col/getAllWhere_col";
		Result result = new Result();
		try
		{
			where_colService.save(where_col);
//			System.out.println(	"s_tables_id:"+where_col.getS_tables_id()+
//							"  e_name"+where_col.getE_name()+
//							"c_name"+where_col.getC_name()+
//							"include_col_id"+where_col.getInclude_col_id()+
//							"col_c_name"+where_col.getCol_c_name()+
//							"col_e_name"+where_col.getCol_e_name()+
//							"subject_id"+where_col.getSubject_id());
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;		
	}
	
	/**
	 *编辑条件字段
	 * @param Where_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateWhere_col")
	public String updateWhere_col(Where_col where_col,HttpServletRequest request){
		
		
		if(where_colService.update(where_col)){
			where_col = where_colService.findById(where_col.getWhere_col_id());
			request.setAttribute("where_col", where_col);
			return "redirect:/where_col/getAllWhere_col";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个条件字段
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getWhere_col")
	public String getWhere_col(int id,HttpServletRequest request){
		
		request.setAttribute("where_col", where_colService.findById(id));
		return "/editWhere_col";
	}
	/**
	 * 删除条件字段
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delWhere_col")
	public void delWhere_col(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(where_colService.delete(id)){
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

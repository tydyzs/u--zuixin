package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tgb.model.Tsql;
import com.tgb.service.TsqlService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/tsql")
public class TsqlController {

	@Autowired
	private TsqlService tsqlService;
	
	/**
	 * 获取所有主题sql列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTsql")
	public String getAllTsql(HttpServletRequest request){
		
		List<Tsql> findAll = tsqlService.findAll();		
		request.setAttribute("tsqlList", findAll);
		return "/allTsql";
	}
	
	/**
	 * 跳转到添加主题sql界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTsql")
	public String toAddTsql(HttpServletRequest request){
		
		return "/addTsql";
	}
	/**
	 * 添加主题sql并重定向
	 * @param Tsql
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTsql")
	public Result addTsql(Tsql tsql,HttpServletRequest request){
		//return "redirect:/tsql/getAllTsql";
		Result result = new Result();
		try
		{
			tsqlService.save(tsql);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;			
	}
	
	/**
	 *编辑主题sql
	 * @param Tsql
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTsql")
	public String updateTsql(Tsql tsql,HttpServletRequest request){
		
		
		if(tsqlService.update(tsql)){
			tsql = tsqlService.findById(tsql.getSql_id());
			request.setAttribute("tsql", tsql);
			return "redirect:/tsql/getAllTsql";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个主题sql
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTsql")
	public String getTsql(int id,HttpServletRequest request){
		
		request.setAttribute("tsql", tsqlService.findById(id));
		return "/editTsql";
	}
	/**
	 * 删除主题sql
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTsql")
	public void delTsql(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(tsqlService.delete(id)){
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

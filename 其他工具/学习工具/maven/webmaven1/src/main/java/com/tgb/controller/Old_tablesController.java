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

import com.tgb.model.Old_tables;
import com.tgb.service.Old_tablesService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/old_tables")
public class Old_tablesController {

	@Autowired
	private Old_tablesService old_tablesService;
	
	/**
	 * 获取所有数据准备表列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllOld_tables")
	public String getAllOld_tables(HttpServletRequest request){
		
		List<Old_tables> findAll = old_tablesService.findAll();
		
		request.setAttribute("old_tablesList", findAll);
		return "/allOld_tables";
	}
	
	/**
	 * 跳转到添加数据准备表界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOld_tables")
	public String toAddOld_tables(HttpServletRequest request){
		
		return "/addOld_tables";
	}
	/**
	 * 添加数据准备表并重定向
	 * @param Old_tables
	 * @param request
	 * @return
	 */
	@RequestMapping("/addOld_tables")
	public String addOld_tables(Old_tables old_tables,HttpServletRequest request){
		old_tablesService.save(old_tables);
		return "redirect:/old_tables/getAllOld_tables";
	}
	
	/**
	 *编辑数据准备表
	 * @param Old_tables
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateOld_tables")
	public String updateOld_tables(Old_tables old_tables,HttpServletRequest request){
		
		
		if(old_tablesService.update(old_tables)){
			old_tables = old_tablesService.findById(old_tables.getS_tables_id());
			request.setAttribute("old_tables", old_tables);
			return "redirect:/old_tables/getAllOld_tables";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个数据准备表
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getOld_tables")
	public String getOld_tables(int s_tables_id,HttpServletRequest request){
		
		request.setAttribute("old_tables", old_tablesService.findById(s_tables_id));
		return "/editOld_tables";
	}
	/**
	 * 删除数据准备表
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delOld_tables")
	public void delOld_tables(int s_tables_id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(old_tablesService.delete(s_tables_id)){
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
	@RequestMapping("/loadOldTables.do")
	@ResponseBody
	public Result execute(){
		Result result = old_tablesService.loadOldTables();
		return result;
	}
	@RequestMapping("/updateAlias.do")
	@ResponseBody
	public Result execute(String map1,  String map2){
		
		Result result = old_tablesService.updateAlias(map1,map2);
		return result;
	}	
}

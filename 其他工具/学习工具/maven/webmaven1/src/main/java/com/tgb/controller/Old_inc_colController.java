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

import com.tgb.model.Old_inc_col;
import com.tgb.service.Old_inc_colService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/old_inc_col")
public class Old_inc_colController {

	@Autowired
	private Old_inc_colService old_inc_colService;
	
	/**
	 * 获取所有原始表包含字段列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllOld_inc_col")
	public String getAllOld_inc_col(HttpServletRequest request){
		
		List<Old_inc_col> findAll = old_inc_colService.findAll();
		
		request.setAttribute("old_inc_colList", findAll);
		return "/allOld_inc_col";
	}
	
	/**
	 * 跳转到添加原始表包含字段界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOld_inc_col")
	public String toAddOld_inc_col(HttpServletRequest request){
		
		return "/addOld_inc_col";
	}
	/**
	 * 添加原始表包含字段并重定向
	 * @param Old_inc_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/addOld_inc_col")
	public String addOld_inc_col(Old_inc_col Old_inc_col,HttpServletRequest request){
		old_inc_colService.save(Old_inc_col);
		return "redirect:/old_inc_col/getAllOld_inc_col";
	}
	
	/**
	 *编辑原始表包含字段
	 * @param Old_inc_col
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateOld_inc_col")
	public String updateOld_inc_col(Old_inc_col old_inc_col,HttpServletRequest request){
		
		
		if(old_inc_colService.update(old_inc_col)){
			old_inc_col = old_inc_colService.findById(old_inc_col.getInclude_col_id());
			request.setAttribute("Old_inc_col", old_inc_col);
			return "redirect:/old_inc_col/getAllOld_inc_col";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个原始表包含字段
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getOld_inc_col")
	public String getOld_inc_col(int id,HttpServletRequest request){
		
		request.setAttribute("old_inc_col", old_inc_colService.findById(id));
		return "/editOld_inc_col";
	}
	/**
	 * 删除原始表包含字段
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delOld_inc_col")
	public void delOld_inc_col(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(old_inc_colService.delete(id)){
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
	@RequestMapping("/loadOldCols.do")
	@ResponseBody
	public Result execute(){
		
		Result result = old_inc_colService.loadOldCols();
		return result;
	}
	@RequestMapping("/updateAlias.do")
	@ResponseBody
	public Result execute(String map3,String map4){
		Result result = old_inc_colService.updateCol(map3,map4);
		return result;
	}
	
	/**
	 * 根据主题ID加载相应字段
	 */
	@RequestMapping("/loadCol.do")
	@ResponseBody
	public Result execute(int tId){
		Result result = old_inc_colService.findByTid(tId);
		return result;
	}
	
}











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

import com.tgb.model.Tfunction;
import com.tgb.service.TfunctionService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/tfunction")
public class TfunctionController {

	@Autowired
	private TfunctionService tfunctionService;
	
	/**
	 * 获取所有函数列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTfunction")
	public String getAllTfunction(HttpServletRequest request){
		
		List<Tfunction> findAll = tfunctionService.findAll();
		
		request.setAttribute("tfunctionList", findAll);
		return "/allTfunction";
	}
	
	/**
	 * 跳转到添加函数界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTfunction")
	public String toAddTfunction(HttpServletRequest request){
		
		return "/addTfunction";
	}
	/**
	 * 添加函数并重定向
	 * @param Tfunction
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTfunction")
	@ResponseBody
	public Result addTfunction(Tfunction tfunction,HttpServletRequest request){	
		
		Result result = new Result();
		try
		{
			tfunctionService.save(tfunction);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;
	}
	
	/**
	 *编辑函数
	 * @param tfunction
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTfunction")
	public String updateTfunction(Tfunction tfunction,HttpServletRequest request){
		
		
		if(tfunctionService.update(tfunction)){
			tfunction = tfunctionService.findById(tfunction.getFunction_id());
			request.setAttribute("tfunction", tfunction);
			return "redirect:/tfunction/getAllTfunction";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个函数
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTfunction")
	public String getTfunction(int id,HttpServletRequest request){
		
		request.setAttribute("tfunction", tfunctionService.findById(id));
		return "/editTfunction";
	}
	/**
	 * 删除函数
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTfunction")
	public void delTfunction(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(tfunctionService.delete(id)){
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

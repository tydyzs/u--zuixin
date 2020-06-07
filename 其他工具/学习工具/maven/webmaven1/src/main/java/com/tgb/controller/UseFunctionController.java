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

import com.tgb.model.UseFunction;
import com.tgb.service.UseFunctionService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/useFunction")
public class UseFunctionController {

	@Autowired
	private UseFunctionService useFunctionService;
	
	/**
	 * 获取所有函数列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllUseFunction")
	public String getAllUseFunction(HttpServletRequest request){
		
		List<UseFunction> findAll = useFunctionService.findAll();
		
		request.setAttribute("useFunctionList", findAll);
		return "/allUseFunction";
	}
	
	/**
	 * 跳转到添加函数界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddUseFunction")
	public String toAddUseFunction(HttpServletRequest request){
		
		return "/addUseFunction";
	}
	/**
	 * 添加函数并重定向
	 * @param UseFunction
	 * @param request
	 * @return
	 */
	@RequestMapping("/addUseFunction")
	@ResponseBody
	public Result addUseFunction(String function_name,String f_col_c_name,String f_col_e_name,String useThemeName,HttpServletRequest request){	
		
		Result result = new Result();
		UseFunction useFunction = new UseFunction();
		useFunction.setFunction_name(function_name);
		useFunction.setCol_c_name(f_col_c_name);
		useFunction.setCol_e_name(f_col_e_name);		
		try
		{
			useFunctionService.save(useFunction,useThemeName);
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
	 * @param useFunction
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateUseFunction")
	public String updateUseFunction(UseFunction useFunction,HttpServletRequest request){
		
		
		if(useFunctionService.update(useFunction)){
			useFunction = useFunctionService.findById(useFunction.getFunction_id());
			request.setAttribute("useFunction", useFunction);
			return "redirect:/useFunction/getAllUseFunction";
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
	@RequestMapping("/getUseFunction")
	public String getUseFunction(int id,HttpServletRequest request){
		
		request.setAttribute("useFunction", useFunctionService.findById(id));
		return "/editUseFunction";
	}
	/**
	 * 删除函数
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delUseFunction")
	public void delUseFunction(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(useFunctionService.delete(id)){
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
	@RequestMapping("/findByUseSubject_id")
	@ResponseBody
	public Result findByUseSubject_id(String useSubject_id,HttpServletRequest request){
		int useSubject_id_2 = Integer.parseInt(useSubject_id);
		Result result = useFunctionService.findByUseSubject_id(useSubject_id_2);
		return result;
	}	
}

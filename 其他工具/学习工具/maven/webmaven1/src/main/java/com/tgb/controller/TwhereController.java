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

import com.tgb.model.Twhere;
import com.tgb.service.TwhereService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/twhere")
public class TwhereController {

	@Autowired
	private TwhereService twhereService;
	
	/**
	 * 获取所有条件列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTwhere")
	public String getAllTwhere(HttpServletRequest request){
		
		List<Twhere> findAll = twhereService.findAll();
		
		request.setAttribute("twhereList", findAll);
		return "/allTwhere";
	}
	
	/**
	 * 跳转到添加条件界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTwhere")
	public String toAddTwhere(HttpServletRequest request){
		
		return "/addTwhere";
	}
	/**
	 * 添加条件并重定向
	 * @param Twhere
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTwhere")
	@ResponseBody
	public Result addTwhere(Twhere twhere,HttpServletRequest request){
		
		//return "redirect:/twhere/getAllTwhere";
		Result result = new Result();
		try
		{
			twhereService.save(twhere);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;		
	}
	
	/**
	 *编辑条件
	 * @param Twhere
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTwhere")
	public String updateTwhere(Twhere twhere,HttpServletRequest request){
		
		
		if(twhereService.update(twhere)){
			twhere = twhereService.findById(twhere.getWhere_id());
			request.setAttribute("twhere", twhere);
			return "redirect:/twhere/getAllTwhere";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个条件
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTwhere")
	public String getTwhere(int id,HttpServletRequest request){
		
		request.setAttribute("twhere", twhereService.findById(id));
		return "/editTwhere";
	}
	/**
	 * 删除条件
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTwhere")
	public void delTwhere(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(twhereService.delete(id)){
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

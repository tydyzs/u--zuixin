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

import com.tgb.model.Tcon;
import com.tgb.service.TconService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/tcon")
public class TconController {

	@Autowired
	private TconService tconService;
	
	/**
	 * 获取所有表连接列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTcon")
	public String getAllTcon(HttpServletRequest request){
		
		List<Tcon> findAll = tconService.findAll();
		
		request.setAttribute("tconList", findAll);
		return "/allTcon";
	}
	
	/**
	 * 跳转到添加表连接界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTcon")
	public String toAddTcon(HttpServletRequest request){
		
		return "/addTcon";
	}
	/**
	 * 添加表连接并重定向
	 * @param Tcon
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTcon")
	@ResponseBody
	public Result addTcon(Tcon tcon,HttpServletRequest request){
		
		//return "redirect:/tcon/getAllTcon";
		Result result = new Result();
		try
		{
			tconService.save(tcon);
			//int con_id = tcon.getCon_id();
			//result.setData(con_id);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;
	}
	
	/**
	 *编辑表连接
	 * @param Tcon
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTcon")
	public String updateTcon(Tcon tcon,HttpServletRequest request){
		
		
		if(tconService.update(tcon)){
			tcon = tconService.findById(tcon.getCon_id());
			request.setAttribute("tcon", tcon);
			return "redirect:/tcon/getAllTcon";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个表连接
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTcon")
	public String getTcon(int id,HttpServletRequest request){
		
		request.setAttribute("tcon", tconService.findById(id));
		return "/editTcon";
	}
	/**
	 * 删除表连接
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTcon")
	public void delTcon(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(tconService.delete(id)){
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

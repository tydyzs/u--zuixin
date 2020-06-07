package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tgb.model.Torder;
import com.tgb.service.TorderService;

@Controller
@RequestMapping("/torder")
public class TorderController {

	@Autowired
	private TorderService torderService;
	
	/**
	 * 获取所有排序列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTorder")
	public String getAllTorder(HttpServletRequest request){
		
		List<Torder> findAll = torderService.findAll();
		
		request.setAttribute("torderList", findAll);
		return "/allTorder";
	}
	
	/**
	 * 跳转到添加排序界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTorder")
	public String toAddTorder(HttpServletRequest request){
		
		return "/addTorder";
	}
	/**
	 * 添加排序并重定向
	 * @param Torder
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTorder")
	public String addTorder(Torder Torder,HttpServletRequest request){
		torderService.save(Torder);
		return "redirect:/torder/getAllTorder";
	}
	
	/**
	 *编辑排序
	 * @param Torder
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTorder")
	public String updateTorder(Torder torder,HttpServletRequest request){
		
		
		if(torderService.update(torder)){
			torder = torderService.findById(torder.getOrder_id());
			request.setAttribute("torder", torder);
			return "redirect:/torder/getAllTorder";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个排序
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTorder")
	public String getTorder(int id,HttpServletRequest request){
		
		request.setAttribute("torder", torderService.findById(id));
		return "/editTorder";
	}
	/**
	 * 删除排序
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTorder")
	public void delTorder(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(torderService.delete(id)){
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

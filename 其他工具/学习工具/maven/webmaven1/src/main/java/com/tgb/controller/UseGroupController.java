package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.tgb.model.UseGroup;
import com.tgb.service.UseGroupService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/useGroup")
public class UseGroupController {

	@Autowired
	private UseGroupService useGroupService;
	
	/**
	 * 获取所有主题分组列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllUseGroup")
	public String getAllUseGroup(HttpServletRequest request){
		
		List<UseGroup> findAll = useGroupService.findAll();
		
		request.setAttribute("useGroupList", findAll);
		return "/allUseGroup";
	}
	
	/**
	 * 跳转到添加主题分组界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddUseGroup")
	public String toAddUseGroup(HttpServletRequest request){
		
		return "/addUseGroup";
	}
	/**
	 * 添加主题分组并重定向
	 * @param UseGroup
	 * @param request
	 * @return
	 */
	@RequestMapping("/addUseGroup")
	public Result addUseGroup(String g_col_c_name,String g_col_e_name,String useThemeName,HttpServletRequest request){		

		Result result = new Result();
		UseGroup useGroup = new UseGroup();
		useGroup.setCol_c_name(g_col_c_name);
		useGroup.setCol_e_name(g_col_e_name);		
		try
		{
			useGroupService.save(useGroup,useThemeName);
			result.setStatus(0);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		
		return result;		
	}
	
	/**
	 *编辑主题分组
	 * @param UseGroup
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateUseGroup")
	public String updateUseGroup(UseGroup useGroup,HttpServletRequest request){
		
		
		if(useGroupService.update(useGroup)){
			useGroup = useGroupService.findById(useGroup.getGroup_id());
			request.setAttribute("useGroup", useGroup);
			return "redirect:/useGroup/getAllUseGroup";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个主题分组
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getUseGroup")
	public String getUseGroup(int id,HttpServletRequest request){
		
		request.setAttribute("useGroup", useGroupService.findById(id));
		return "/editUseGroup";
	}
	/**
	 * 删除主题分组
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delUseGroup")
	public void delUseGroup(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(useGroupService.delete(id)){
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

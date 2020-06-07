package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Old_inc_col;
import com.tgb.model.Old_tables;
import com.tgb.model.Tsubject;
import com.tgb.service.Old_inc_colService;
import com.tgb.service.Old_tablesService;
import com.tgb.service.TsubjectService;
import com.tgb.util.GetSessionUser;
import com.tgb.util.Result;

@Controller
@RequestMapping("/tsubject")
public class TsubjectController {
	@Resource
	private Old_tablesService old_tablesService;
	@Resource
	private Old_inc_colService old_inc_colService;
	@Autowired
	private TsubjectService tsubjectService;
	
	/**
	 * 获取所有用户列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllTsubject")
	public String getAllTsubject(HttpServletRequest request){
		
		List<Tsubject> findAll = tsubjectService.findAll();
		
		request.setAttribute("tsubjectList", findAll);
		return "/allTsubject";
	}
	
	/**
	 * 跳转到添加用户界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddTsubject")
	public String toAddTsubject(HttpServletRequest request){
		
		return "/addTsubject";
	}
	/**
	 * 添加用户并重定向
	 * @param Tsubject
	 * @param request
	 * @return
	 */
	@RequestMapping("/addTsubject")
	@ResponseBody
	public Result addTsubject(Tsubject tsubject,HttpServletRequest request){
		Date date = new Date();
		tsubject.setSetdate(date);
		tsubject.setModify_date(date);
		Result result = new Result();
		String user_code = GetSessionUser.getUser(request);
		String user_name=(String) tsubjectService.finduser(user_code).get("USER_NAME");
		tsubject.setSetman(user_name);
		//tsubject.setSetman(user_code);
		//System.out.println("Is_function:"+tsubject.getIs_function()+" subject_name="+tsubject.getSubject_name()+" t_type_id="+tsubject.getT_type_id()+" setdate="+tsubject.getSetdate());	
		try
		{
			tsubjectService.save(tsubject);
			int subject_id = tsubject.getSubject_id();		
			//System.out.println("subject_id="+subject_id);
			result.setStatus(0);
			result.setData(subject_id);
		}
		catch(Exception e)
		{
			result.setStatus(-1);
		}
		return result;
	}
	/**
	 * 添加用户并重定向
	 * @param Tsubject
	 * @param request
	 * @return
	 */
	@RequestMapping("/checkSubject")
	@ResponseBody
	public Result checkSubject(Tsubject tsubject,HttpServletRequest request){
		Result result = new Result();
		//System.out.println("Is_function:"+tsubject.getIs_function()+" subject_name="+tsubject.getSubject_name()+" t_type_id="+tsubject.getT_type_id()+" setdate="+tsubject.getSetdate());	
//		try
//		{
			result = tsubjectService.checkSubject(tsubject);		
//		}
//		catch(Exception e)
//		{
//			result.setStatus(1);
//		}
		return result;
	}	
	/**
	 *编辑用户
	 * @param Tsubject
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateTsubject")
	public String updateTsubject(Tsubject tsubject,HttpServletRequest request){
		
		
		if(tsubjectService.update(tsubject)){
			tsubject = tsubjectService.findById(tsubject.getSubject_id());
			request.setAttribute("tsubject", tsubject);
			return "redirect:/tsubject/getAllTsubject";
		}else{
			return "/error";
		}
	}
	/**
	 * 根据id查询单个用户
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getTsubject")
	public String getTsubject(int id,HttpServletRequest request){
		
		request.setAttribute("tsubject", tsubjectService.findById(id));
		return "/editTsubject";
	}
	/**
	 * 删除用户
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delTsubject")
	public void delTsubject(int id,HttpServletRequest request,HttpServletResponse response){
		String result = "{\"result\":\"error\"}";
		
		if(tsubjectService.delete(id)){
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
	@RequestMapping("/getTables")
	@ResponseBody
	public Result setSubject(HttpServletRequest request){
		List<Old_tables> l_tables = old_tablesService.findAll();
		List<Old_inc_col> l_cols = old_inc_colService.findAll();
		Map map = new HashMap();
		map.put("l_tables",l_tables);
		map.put("l_cols", l_cols);
		Result result = new Result();
		result.setData(map);
		return result;
	}
	
	//根据主题ID删除业务主题
	@RequestMapping("/delTsubject2")
	@ResponseBody
	public Result execute(int id){
		Result result =  tsubjectService.deleteSubject(id);
		return result;
	}
	
	//根据主题名称查询业务主题
		@RequestMapping("/querySubject")
		@ResponseBody
		public Result execute(String subjectName){
			Result result =  tsubjectService.querySubject(subjectName);
			return result;
		}
		
		@RequestMapping("/getTables_new")
		@ResponseBody
		public Result setSubject_new(HttpServletRequest request,String tables_id_1){
			List ls = new ArrayList();
			String str[] = tables_id_1.split(",");
			for(int i=0;i<str.length;i++){
				ls.add(str[i]);
			}
			List<Old_tables> l_tables = old_tablesService.findByIds(ls);
			List<Old_inc_col> l_cols = old_inc_colService.findByTids(ls);
			Map map = new HashMap();
			map.put("l_tables",l_tables);
			map.put("l_cols", l_cols);
			Result result = new Result();
			result.setData(map);
			return result;
		}
		@RequestMapping("/getSubject_2")
		@ResponseBody
		public Result getSubject_2(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findById_2(subject_id);
			return result;
		}	
		@RequestMapping("/findTableById")
		@ResponseBody
		public Result findTableById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findTableById(subject_id);
			return result;
		}
		@RequestMapping("/findColById")
		@ResponseBody
		public Result findColById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findColById(subject_id);
			return result;
		}
		@RequestMapping("/findConById")
		@ResponseBody
		public Result findConById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findConById(subject_id);
			return result;
		}
		@RequestMapping("/findWhereById")
		@ResponseBody
		public Result findWhereById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findWhereById(subject_id);
			return result;
		}
		@RequestMapping("/findFunctionById")
		@ResponseBody
		public Result findFunctionById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findFunctionById(subject_id);
			return result;
		}
		@RequestMapping("/findGroupById")
		@ResponseBody
		public Result findGroupById(int subject_id,HttpServletRequest request){
			Result result = tsubjectService.findGroupById(subject_id);
			return result;
		}
		//根据主题ID删除业务主题
		@RequestMapping("/delete_Subject")
		@ResponseBody
		public Result delete_Subject(int subject_id){
			Result result =  tsubjectService.delete_Subject(subject_id);
			return result;
		}
		//根据表名模糊查询表
		@RequestMapping("/queryOld_table")
		@ResponseBody
		public Result queryOld_table(String c_name){
			Result result =  tsubjectService.queryOld_table(c_name);
			return result;
		}
		//查询所有主题
		@RequestMapping("/findAll_new")
		@ResponseBody
		public Result findAll_new(){
			Result result =  tsubjectService.findAll_new();
			return result;
		}
		//查询所有表
		@RequestMapping("/getTables_2")
		@ResponseBody
		public Result setSubject_2(HttpServletRequest request,int currentPage){
			Result result = old_tablesService.findAll_new(currentPage);
			return result;
		}		
		//查询表总数
		@RequestMapping("/find_count")
		@ResponseBody
		public Result findTables_count(HttpServletRequest request){
			Result result = old_tablesService.find_count();
			return result;
		}	
		//查询主题总数
		@RequestMapping("/findSubjects_count")
		@ResponseBody
		public Result findSubjects_count(HttpServletRequest request){
			Result result = tsubjectService.findSubjects_count();
			return result;
		}
		//查询分页主题
		@RequestMapping("/allSubjects")
		@ResponseBody
		public Result allSubjects(HttpServletRequest request,String currentPage){
			int currentPage_new = Integer.parseInt(currentPage);
			Result result = tsubjectService.AllSubjects(currentPage_new);
			return result;
		}			
}












package com.tgb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service.ThemetypeService;
import com.tgb.service.UseThemeService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Controller
@RequestMapping("/use")
public class UseThemeController {


	@Resource
	private UseThemeService usethemeservice;
	
	
	@RequestMapping("/findUseTheme.do")
	@ResponseBody
	public Result findUseTheme(String typeId,String name,String themeId){
		Result result=usethemeservice.findUseTheme(typeId,name,themeId);
	return result;
	}
	
	

	@RequestMapping("/findname.do")
	@ResponseBody
	public Result findname(String typeId){
		Result result=usethemeservice.findname(typeId);
		System.out.println(result);
		
	return result;
	}
	
	@RequestMapping("/findname_new.do")
	@ResponseBody
	public Result findname_new(String typeId,String currentPage){
		Map map = new HashMap();
		map.put("typeId", typeId);
		map.put("currentPage", currentPage);
		Result result=usethemeservice.findname_new(map);
		System.out.println(result);
		
	return result;
	}	
	
	@RequestMapping("/deleteUse.do")
	@ResponseBody
	public Result deleteUse(String useId){
		//Result result=usethemeservice.findname(typeId);
			Result result=usethemeservice.deleteuse(useId);
	return result;
	}
	
	
		@RequestMapping("/queryUseTheme.do")
		@ResponseBody
		public Result query(String useName){
			//Result result=usethemeservice.findname(typeId);
				Result result=usethemeservice.queryUseTheme(useName);
		return result;
		}
		
		
		@RequestMapping("/functions.do")
		@ResponseBody
		public Result functions(String themeId){
			Result result=usethemeservice.functions(themeId);
		return result;
		}
		@RequestMapping("/Alltheme_count.do")
		@ResponseBody
		public Result Alltheme_count(){
			Result result=usethemeservice.Alltheme_count();
			System.out.println(result);
			
		return result;
		}
		@RequestMapping("/AllUsetheme_count.do")
		@ResponseBody
		public Result AllUsetheme_count(){
			Result result=usethemeservice.AllUsetheme_count();
			System.out.println(result);
			
		return result;
		}	
		@RequestMapping("/findUsename_new.do")
		@ResponseBody
		public Result findUsename_new(String typeId,String currentPage){
			Map map = new HashMap();
			map.put("typeId", typeId);
			map.put("currentPage", currentPage);
			Result result=usethemeservice.findUsename_new(map);
			System.out.println(result);
			
		return result;
		}
		@RequestMapping("/alltheme_only")
		@ResponseBody
		public Result alltheme_only(){
			Result result=usethemeservice.Alltheme_only();
			//System.out.println(result);
			
		return result;
		}	
		@RequestMapping("/findUseThemeBySubject_id")
		@ResponseBody
		public Result findUseThemeBySubject_id(String subject_id,HttpServletRequest request){
			int subject_id_1 = Integer.parseInt(subject_id);
			HttpSession session = request.getSession(); 
			String setman = session.getAttribute("user_code").toString();
			Map map = new HashMap();
			map.put("subject_id", subject_id_1);
			map.put("setman", setman);
			Result result=usethemeservice.findUseThemeBySubject_id(map);
		return result;
		}		
}

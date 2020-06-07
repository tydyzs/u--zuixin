package com.tgb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service.ThemetypeService;
import com.tgb.service.UseThemeService;
import com.tgb.service.UtilService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 *添加utilcontroller方便几个通用查询一起跟新
 *
 */


@Controller
@RequestMapping("/util")
public class UtilController {


	@Resource
	private UtilService utilservice;
	
	
	@RequestMapping("/findUseTheme.do")
	@ResponseBody
	public Result findUseTheme(String themeId){
		Result result=utilservice.findUseTheme(themeId);
	return result;
	}
	
	@RequestMapping("/findcol_type.do")
	@ResponseBody
	public Result findcol_type(String colname,String table_name){
		Result result=utilservice.findcol_type(colname,table_name);
	return result;
	}
	
	
	
	

}

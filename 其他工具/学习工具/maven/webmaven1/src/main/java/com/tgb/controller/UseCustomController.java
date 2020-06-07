package com.tgb.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service.ThemetypeService;
import com.tgb.service.UseCustomService;
import com.tgb.service.UseThemeService;
import com.tgb.util.Base64;
import com.tgb.util.GetSessionUser;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-03
 *
 */


@Controller
@RequestMapping("/useCustom")
public class UseCustomController {


	@Resource
	private UseCustomService usecustomservice;
	
	
	@RequestMapping("/findCustom.do")
	@ResponseBody
	public Result findUseTheme(String themeId){
		Result result=usecustomservice.findcolName(themeId);
	return result;
	}
	
	
	
	
	//保存使用自定义主题
	@RequestMapping("/preservation.do")
	@ResponseBody
	public Result preservation(String sql,String useThemeName,String str1,String createPerson,String str2,String sorts,String themeId,String typeId,String selecta,String selectb,String operation,String conditionValue,String selectd,String connect,HttpServletRequest request){
		Base64 ba=new Base64();
		sql=ba.getStr(sql);
		createPerson = GetSessionUser.getUser(request);
		Integer i=usecustomservice.useCustom(useThemeName, themeId, typeId, createPerson);
		if(i==-1){//使用主题名称不存在 且 新增使用主题成功。然后新增其他的
			Result result=usecustomservice.preservation(sql,useThemeName, str1, createPerson, str2, sorts, themeId, typeId, selecta, selectb, operation, conditionValue, selectd, connect);
			
			
			
			return result;
		}else{//使用主题名称已存在。直接将其id返回给页面
		Result result=new Result();
		result.setStatus(i);
		return result;
		}
		
		
	}
	
	
	//如果保存时使用主题名已经存在先删除，在新增
	@RequestMapping("/delUseName.do")
	@ResponseBody
	public Result delUseTheme(Integer useThemeId){
		Result result1=usecustomservice.delUseTheme(useThemeId);
	return result1;
	}
	
	
	
	
	
	//  *******   根据使用主题id 查询    ********
	
		@RequestMapping("/allUseName.do")
		@ResponseBody
		public Result allUseName(String useThemeId){
			Integer useThemeId1=Integer.parseInt(useThemeId);
			Result result=usecustomservice.allUseName(useThemeId1);
		return result;
		}
		//  *******   测试多条SQL    ********
		
		@RequestMapping("/testxx.do")
		@ResponseBody
		public Result testxx(){
			
			Result result=usecustomservice.testxx();
		return result;
		}	
	

}

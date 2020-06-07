package com.tgb.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service.ThemetypeService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Controller
@RequestMapping("/type")
public class ThemetypeController {


	@Resource
	private ThemetypeService themetypeservice;
	
	/**
	 * 获取所有节点
	 * @param request
	 * @return
	 */
	@RequestMapping("/findtype.do")
	@ResponseBody
	public Result fintype(){
		Result result=themetypeservice.findtype();
	return result;
	}
	
	//点击节点加载子节点到表格中
	@RequestMapping("/findSonType.do")
	@ResponseBody
	public Result findSonType(String pId){
		Result result=themetypeservice.find(pId);
	return result;
	}
	
	//新增
		@RequestMapping("/addSonType.do")
		@ResponseBody
		public Result addSonType(String pId ,String name){
			Result result=themetypeservice.save(pId,name);
		return result;
		}

	//删除
	@RequestMapping("/removeSonType.do")
	@ResponseBody
	public Result removeSonType(String id){
		Result result=themetypeservice.delete(id);
	return result;
	}
	
	//修改
		@RequestMapping("/updateType.do")
		@ResponseBody
		public Result updateType(String id,String pId,String name){
			Result result=themetypeservice.updateType(id,pId,name);
		return result;
		}
		
		
		//根据分类ID查询 分类名称
		@RequestMapping("/selectType.do")
		@ResponseBody
		public Result findTypeName(String id){
			Result result1=themetypeservice.findTypeName(id);
		return result1;
		}
	
}

package com.tgb.controller2;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service2.TableService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Controller
@RequestMapping("/table")
public class TableController {


	@Resource
	private TableService tableservice;
	
	@RequestMapping("/findtable_2.do")
	@ResponseBody
	public Result ImplementSql_2(){
		//Result result=tableservice.findTable();
		Result result=tableservice.findTable_new();
	return result;
	}	
}

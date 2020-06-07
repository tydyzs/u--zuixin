package com.tgb.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Module;
import com.tgb.service.ModuleService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/module")
public class ModuleController {
	@Resource
	private ModuleService moduleService;

	
	/**
	 * 获取所有部门列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllModule")
	@ResponseBody
	public Result getAllModule(HttpServletRequest request){
		Result result = new Result();
		result = moduleService.findAll();	
		return result;
	}
	
	/**
	 * 跳转到添加部门界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddModule")
	@ResponseBody
	public Result toAddModule(HttpServletRequest request,Module Module){		
		Result result = new Result();
		moduleService.save(Module);
		int module_id = Module.getModule_id();
		result.setData(module_id);
		result.setStatus(0);
		return result;
	}

	/**
	 *编辑部门
	 * @param Module
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateModule")
	@ResponseBody
	public Result updateModule(Module Module,HttpServletRequest request){		
		Result result = new Result();
		result = moduleService.update(Module);		
		return result;		
	}
	/**
	 * 根据id查询单个部门
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getModule")
	@ResponseBody
	public Result getModule(String module_id,HttpServletRequest request){		
		Result result = new Result();
		result = moduleService.findById(Integer.parseInt(module_id));		
		return result;		
	}
	
	//根据主题ID删除业务主题
	@RequestMapping("/delModule")
	@ResponseBody
	public Result delModule(int module_id){
		Result result =  moduleService.delete(module_id);
		return result;
	}


		//根据部门名或者部门编码模糊查询部门
		@RequestMapping("/queryByName")
		@ResponseBody
		public Result queryByName(String user_code){
			Result result =  moduleService.findByName(user_code);
			return result;
		}
		//查询部门数量
		@RequestMapping("/findCount")
		@ResponseBody
		public Result findCount(){
			Result result =  moduleService.findCount();
			return result;
		}	
	//**************************************使用分类方法***************
		@RequestMapping("/findtype_dep.do")
		@ResponseBody
		public Result findmodule(String project_id){
			int project_id_2 = Integer.parseInt(project_id);
			Result result=moduleService.findmodule(project_id_2);
		return result;
		}
		
		//点击节点加载子节点到表格中
		@RequestMapping("/findSonType_dep.do")
		@ResponseBody
		public Result find(String pId){
			String parent_id = pId;
			Result result=moduleService.find(parent_id);
		return result;
		}
		
		//新增
			@RequestMapping("/addSonType_dep.do")
			@ResponseBody
			public Result save(String pId ,String name,String module_url,String project_id){
				String parent_id = pId;
				String module_name = name;
				int project_id_2 = Integer.parseInt(project_id);
				Result result=moduleService.save(parent_id,module_name,module_url,project_id_2);
			return result;
			}

		//删除
		@RequestMapping("/removeSonType_dep.do")
		@ResponseBody
		public Result delete(String id){
			String module_id = id;
			Result result=moduleService.delete(module_id);
		return result;
		}
		
		//修改
			@RequestMapping("/updateType_dep.do")
			@ResponseBody
			public Result updateModule(String id,String pId,String name,String module_url,String project_id){
				String module_id = id;
				String parent_id = pId;
				String module_name = name;
				int project_id_2 = Integer.parseInt(project_id);
				Result result=moduleService.updateModule(module_id,parent_id,module_name,module_url,project_id_2);
			return result;
			}
			
			
			//根据分类ID查询 分类名称
			@RequestMapping("/selectType_dep.do")
			@ResponseBody
			public Result findModuleName(String id){
				String module_id = id;
				Result result1=moduleService.findModuleName(module_id);
			return result1;
			}		
		
		
}












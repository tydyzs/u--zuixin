package com.tgb.controller;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Department;
import com.tgb.service.DepartmentService;
import com.tgb.util.Result;

@Controller
@RequestMapping("/department")
public class DepartmentController {
	@Resource
	private DepartmentService departmentService;

	
	/**
	 * 获取所有部门列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllDepartment")
	@ResponseBody
	public Result getAllDepartment(HttpServletRequest request){
		Result result = new Result();
		result = departmentService.findAll();	
		return result;
	}
	
	/**
	 * 跳转到添加部门界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddDepartment")
	@ResponseBody
	public Result toAddDepartment(HttpServletRequest request,Department Department){		
		Result result = new Result();
		departmentService.save(Department);
		int department_id = Department.getDepartment_id();
		result.setData(department_id);
		result.setStatus(0);
		return result;
	}

	/**
	 *编辑部门
	 * @param Department
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateDepartment")
	@ResponseBody
	public Result updateDepartment(Department Department,HttpServletRequest request){		
		Result result = new Result();
		result = departmentService.update(Department);		
		return result;		
	}
	/**
	 * 根据id查询单个部门
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getDepartment")
	@ResponseBody
	public Result getDepartment(String department_id,HttpServletRequest request){		
		Result result = new Result();
		result = departmentService.findById(Integer.parseInt(department_id));		
		return result;		
	}
	
	//根据主题ID删除业务主题
	@RequestMapping("/delDepartment")
	@ResponseBody
	public Result delDepartment(int department_id){
		Result result =  departmentService.delete(department_id);
		return result;
	}


		//根据部门名或者部门编码模糊查询部门
		@RequestMapping("/queryByName")
		@ResponseBody
		public Result queryByName(String user_code){
			Result result =  departmentService.findByName(user_code);
			return result;
		}
		//查询部门数量
		@RequestMapping("/findCount")
		@ResponseBody
		public Result findCount(){
			Result result =  departmentService.findCount();
			return result;
		}	
	//**************************************使用分类方法***************
		@RequestMapping("/findtype_dep.do")
		@ResponseBody
		public Result finddepartment(){
			Result result=departmentService.finddepartment();
		return result;
		}
		
		//点击节点加载子节点到表格中
		@RequestMapping("/findSonType_dep.do")
		@ResponseBody
		public Result find(String pId){
			String parent_id = pId;
			Result result=departmentService.find(parent_id);
		return result;
		}
		
		//新增
			@RequestMapping("/addSonType_dep.do")
			@ResponseBody
			public Result save(String pId ,String name){
				String parent_id = pId;
				String department_name = name;
				Result result=departmentService.save(parent_id,department_name);
			return result;
			}

		//删除
		@RequestMapping("/removeSonType_dep.do")
		@ResponseBody
		public Result delete(String id){
			String department_id = id;
			Result result=departmentService.delete(department_id);
		return result;
		}
		
		//修改
			@RequestMapping("/updateType_dep.do")
			@ResponseBody
			public Result updateDepartment(String id,String pId,String name){
				String department_id = id;
				String parent_id = pId;
				String department_name = name;			
				Result result=departmentService.updateDepartment(department_id,parent_id,department_name);
			return result;
			}
			
			
			//根据分类ID查询 分类名称
			@RequestMapping("/selectType_dep.do")
			@ResponseBody
			public Result findDepartmentName(String id){
				String department_id = id;
				Result result1=departmentService.findDepartmentName(department_id);
			return result1;
			}		
		
		
}












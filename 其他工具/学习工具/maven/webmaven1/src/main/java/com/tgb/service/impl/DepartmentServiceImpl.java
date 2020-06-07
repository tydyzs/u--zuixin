package com.tgb.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.Dep_userMapper;
import com.tgb.mapper.DepartmentMapper;
import com.tgb.model.Department;
import com.tgb.service.DepartmentService;
import com.tgb.util.Result;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class DepartmentServiceImpl implements DepartmentService {
	
	@Resource
	private DepartmentMapper mapper;
	@Resource
	private Dep_userMapper dep_user_mapper;		

	public Result save(Department department) {
		Result result = new Result();
		Boolean b = mapper.save(department);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(Department department) {
		Result result = new Result();
		Boolean b = mapper.update(department);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int department_id) {
		Result result = new Result();
		Boolean b = mapper.delete(department_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int department_id) {
		Result result = new Result();
		Department department = mapper.findById(department_id);		
		result.setStatus(0);
		result.setData(department);
		return result;
	}

	public Result findAll() {
		Result result = new Result();
		List<Department> list = mapper.findAll();		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	public Result findByName(String department_name) {
		Result result = new Result();
		Department department = mapper.findByName(department_name);		
		result.setStatus(0);
		result.setData(department);
		return result;
	}	
	public Result findCount(){
		Result result = new Result();
		int count = mapper.findCount();		
		result.setStatus(0);
		result.setData(count);
		return result;		
	}
//***********************使用TYPE方法
	public Result finddepartment() {//查询所有生成树
		Result result=new Result();
	    List<Department> list=mapper.finddepartment();
	    result.setData(list);
	    result.setStatus(0);
		return result;
	}

	public Result find(String parent_id) {//查询子节点生成表
		Result result=new Result();
		int i=Integer.parseInt(parent_id);
	    List<Department> list=mapper.find(i);
	    result.setData(list);
	    result.setStatus(0);
			return result;
	}

	public Result save(String parent_id,String department_name) {//新增节点
		Department department=new Department();
		Result result=new Result();		
		int i=Integer.parseInt(parent_id);
		department.setParent_id(i);
		department.setDepartment_code("");
		department.setDepartment_name(department_name);
		department.setIs_del(0);
		department.setRemark("");
	if(mapper.find2(department)!=0){//name 存在了
			result.setStatus(2);
			return result;
		}else{
		mapper.save(department);
		HashMap map=new HashMap();
		map.put("parent_id", i);
		map.put("department_name", department_name);
		int id=mapper.finddepartmentId(map);
		result.setStatus(0);
		result.setData(id);
		return result;
		}
	}

	//删除机构及所有子机构。如果机构或子机构有其他表关联数据，则不删除
	public Result delete(String department_id) {//删除		
		Result result=new Result();
		delId(department_id);//删除机构及下面所有的机构		
		result.setStatus(0);
		return result;	
	}

	//删除
	public void delId(String department_id){//下拉框：根据主题类型id查询所有下面的主题名称
		   int i=Integer.parseInt(department_id);
		   mapper.delete(i);//删除当前
		   dep_user_mapper.deleteByDepID(i);
			List<Integer> cId=mapper.findByParent_Id(i);//查询所有子id
			int a=cId.size();
			if(a!=0){//子id对应所有名称
				for(int j=0;j<cId.size();j++){
					delId(cId.get(j)+"");
			   }
			}
	}

	
	public int findId(String parent_id) {//查询数目用于生成id
		int i=Integer.parseInt(parent_id);
		int num=mapper.findId(i);
		return num;
	}

	
	
	public Result updateDepartment(String department_id,String parent_id,String department_name){
		Result result=new Result();
		
		Department department=new Department();
		department.setDepartment_id(Integer.parseInt(department_id));
		department.setParent_id(Integer.parseInt(parent_id));
		department.setDepartment_name(department_name);
		int num=mapper.updateDepartments(department);
		if(num>0){
			result.setStatus(1);
			return result;
		}else{
			mapper. updateDepartment(department);
			result.setStatus(0);
			return result;
		}
		
		
	}

	//根据机构ID查询 机构名称
	public Result findDepartmentName(String department_id) {
		Result result=new Result();
		List<String> ty = mapper.findDepartmentName(Integer.parseInt(department_id));
		String ty2 = ty.get(0);
		result.setStatus(0);
		result.setMsg(ty2);
		return result;
	}	
	
	

}

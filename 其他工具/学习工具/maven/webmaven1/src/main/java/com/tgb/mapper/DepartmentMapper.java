package com.tgb.mapper;

import java.util.HashMap;
import java.util.List;

import com.tgb.model.Department;

public interface DepartmentMapper {

	boolean save(Department department);
	boolean update(Department department);
	boolean delete(int department_id);
	Department findById(int department_id);
	List<Department> findAll();
	//List<Map> findByName(@Param("user_code")String user_code,String currentPage);
	Department findByName(String department_name);
	int findCount();
	//*******使用TYPE方法
	public List<Department> finddepartment();//查询用于生成树
	public List<Department> find(int parent_id);//查询子节点放入表中
	//public void save(Department department);//新增
	public int finddepartmentId(HashMap map); //查看刚才
	//public void delete(int id);//删除节点
	public Integer findId(int parent_id);//查询数目，便于新增时生成id
	public Integer find2(Department department);
	public int updateDepartments(Department department);//查询当前父id下除了此id其他名称叫这个的数量
	public void updateDepartment(Department department);
	public List<String> findDepartmentName(int department_id);//根据机构ID查询 机构名称
	public List<Integer> findByParent_Id(int parent_id);
	public Department finddepIdByCode(String department_code);//根据部门编码查询部门ID
}

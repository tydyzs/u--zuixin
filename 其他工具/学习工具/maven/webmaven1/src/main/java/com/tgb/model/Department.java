package com.tgb.model;


/**
 * 用户
 * @author 李春瑞
 *
 */
public class Department {

	public int getDepartment_id() {
		return department_id;
	}


	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}


	public String getDepartment_code() {
		return department_code;
	}


	public void setDepartment_code(String department_code) {
		this.department_code = department_code;
	}


	public String getDepartment_name() {
		return department_name;
	}


	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}


	public int getParent_id() {
		return parent_id;
	}


	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public int getIs_del() {
		return is_del;
	}


	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}

	private int department_id;
	private String department_code;
	private String department_name;
	private int parent_id;
	private String remark;
	private int is_del;


	public Department() {
		// TODO Auto-generated constructor stub
		super();
	}
}

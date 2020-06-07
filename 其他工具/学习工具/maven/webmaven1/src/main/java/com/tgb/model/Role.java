package com.tgb.model;

import java.util.Date;




/**
 * 用户
 * @author 李春瑞
 *
 */
public class Role {
	
	public int getRole_id() {
		return role_id;
	}

	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	
	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	private int role_id;
	private int project_id;
	private String role_name;
	private String remark;

	public Role() {
		// TODO Auto-generated constructor stub
		super();
	}
}

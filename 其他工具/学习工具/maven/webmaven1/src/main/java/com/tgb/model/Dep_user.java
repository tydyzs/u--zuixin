package com.tgb.model;

import java.util.Date;




/**
 * 用户
 * @author 李春瑞
 *
 */
public class Dep_user {

	public int getDep_user_id() {
		return dep_user_id;
	}
	public void setDep_user_id(int dep_user_id) {
		this.dep_user_id = dep_user_id;
	}
	public int getDepartment_id() {
		return department_id;
	}
	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	private int dep_user_id;
	private int department_id;
	private int user_id;
	private String position;
	private String duty;
	private String remark;
	public Dep_user() {
		// TODO Auto-generated constructor stub
		super();
	}
}

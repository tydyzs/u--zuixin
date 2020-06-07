package com.tgb.model;



/**
 * 用户
 * @author 李春瑞
 *
 */
public class Project {

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	private int project_id;
	private String project_name;

	public Project() {
		// TODO Auto-generated constructor stub
		super();
	}
}

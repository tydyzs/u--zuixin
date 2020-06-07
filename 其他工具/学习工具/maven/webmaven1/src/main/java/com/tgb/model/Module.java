package com.tgb.model;

import java.util.Date;




/**
 * 用户
 * @author 李春瑞
 *
 */
public class Module {
	
	public int getModule_id() {
		return module_id;
	}


	public void setModule_id(int module_id) {
		this.module_id = module_id;
	}

	public int getProject_id() {
		return project_id;
	}


	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}	

	public String getModule_name() {
		return module_name;
	}


	public void setModule_name(String module_name) {
		this.module_name = module_name;
	}


	public String getModule_url() {
		return module_url;
	}


	public void setModule_url(String module_url) {
		this.module_url = module_url;
	}


	public int getParent_id() {
		return parent_id;
	}


	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}


	public int getIs_del() {
		return is_del;
	}


	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}


	private int module_id;
	private int project_id;
	private String module_name;
	private String module_url;
	private int parent_id;
	private int is_del; 


	public Module() {
		// TODO Auto-generated constructor stub
		super();
	}
}

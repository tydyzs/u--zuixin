package com.tgb.model;


/**
 * 用户
 * @author 李春瑞
 *
 */
public class Role_module {

	
	public int getRole_module_id() {
		return role_module_id;
	}

	public void setRole_module_id(int role_module_id) {
		this.role_module_id = role_module_id;
	}

	public int getRole_id() {
		return role_id;
	}

	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}

	public int getModule_id() {
		return module_id;
	}

	public void setModule_id(int module_id) {
		this.module_id = module_id;
	}

	private int role_module_id;
	private int role_id;
	private int module_id;
	
	public Role_module() {
		// TODO Auto-generated constructor stub
		super();
	}
}

package com.tgb.model;


/**
 * 用户
 * @author 李春瑞
 *
 */
public class Module2 {

	 
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getpId() {
		return pId;
	}
	public void setpId(Integer pId) {
		this.pId = pId;
	}
	 public String getModule_url() {
		return module_url;
	}
	public void setModule_url(String module_url) {
		this.module_url = module_url;
	}


	 private Integer id;
	 private String name;
	 private Integer pId;
	 private String module_url;
	 private int is_del;
	 
	public Module2() {
		// TODO Auto-generated constructor stub
		super();
	}
}

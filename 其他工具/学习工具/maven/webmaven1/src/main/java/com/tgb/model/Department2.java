package com.tgb.model;


/**
 * 用户
 * @author 李春瑞
 *
 */
public class Department2 {

	private Integer id;
	 private String name;
	 private Integer pId;
	 private String code;
	 private int is_del;
	 
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}


	public Department2() {
		// TODO Auto-generated constructor stub
		super();
	}
}

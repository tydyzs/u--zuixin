/**
 * @author 李春瑞
 * @date 2016年6月1日
 */
package com.tgb.model;

import java.io.Serializable;

/**
 * @author 李春瑞
 *
 */
public class Include_col implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @author 李春瑞
	 */
	public Include_col() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getInclude_col_id() {
		return include_col_id;
	}
	public void setInclude_col_id(int include_col_id) {
		this.include_col_id = include_col_id;
	}
	public int getS_tables_id() {
		return s_tables_id;
	}
	public void setS_tables_id(int s_tables_id) {
		this.s_tables_id = s_tables_id;
	}
	public String getCol_c_name() {
		return col_c_name;
	}
	public void setCol_c_name(String col_c_name) {
		this.col_c_name = col_c_name;
	}
	public String getCol_e_name() {
		return col_e_name;
	}
	public void setCol_e_name(String col_e_name) {
		this.col_e_name = col_e_name;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public int getIs_project() {
		return is_project;
	}
	public void setIs_project(int is_project) {
		this.is_project = is_project;
	}
	public int getIs_where() {
		return is_where;
	}
	public void setIs_where(int is_where) {
		this.is_where = is_where;
	}
	public int getIs_code() {
		return is_code;
	}
	public void setIs_code(int is_code) {
		this.is_code = is_code;
	}
	public int getIs_group() {
		return is_group;
	}
	public void setIs_group(int is_group) {
		this.is_group = is_group;
	}
	public String getCol_e_name_alias() {
		return col_e_name_alias;
	}
	public void setCol_e_name_alias(String col_e_name_alias) {
		this.col_e_name_alias = col_e_name_alias;
	}	
	private int include_col_id;
	private int s_tables_id;
	private String col_c_name;
	private String col_e_name;
	private String col_e_name_alias;
	private int subject_id;
	private int is_project;
	private int is_where;
	private int is_code;
	private int is_group;

}

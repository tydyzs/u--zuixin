/**
 * @author 李春瑞
 * @date 2016年6月2日
 */
package com.tgb.model;

import java.io.Serializable;

/**
 * @author 李春瑞
 *
 */
public class Where_col implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Where_col() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getWhere_col_id() {
		return where_col_id;
	}
	public void setWhere_col_id(int where_col_id) {
		this.where_col_id = where_col_id;
	}
	public int getS_tables_id() {
		return s_tables_id;
	}
	public void setS_tables_id(int s_tables_id) {
		this.s_tables_id = s_tables_id;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public int getInclude_col_id() {
		return include_col_id;
	}
	public void setInclude_col_id(int include_col_id) {
		this.include_col_id = include_col_id;
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
	public String getCol_e_name_alias() {
		return col_e_name_alias;
	}
	public void setCol_e_name_alias(String col_e_name_alias) {
		this.col_e_name_alias = col_e_name_alias;
	}	
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	private int where_col_id;
	private int s_tables_id;
	private String e_name;
	private String c_name;
	private int include_col_id;
	private String col_c_name;
	private String col_e_name;
	private String col_e_name_alias;
	private int subject_id;	

}

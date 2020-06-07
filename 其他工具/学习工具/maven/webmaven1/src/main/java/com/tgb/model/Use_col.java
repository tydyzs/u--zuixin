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
public class Use_col implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Use_col() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getUse_col_id() {
		return use_col_id;
	}
	public void setUse_col_id(int use_col_id) {
		this.use_col_id = use_col_id;
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
	public int getInclude_col_id() {
		return include_col_id;
	}
	public void setInclude_col_id(int include_col_id) {
		this.include_col_id = include_col_id;
	}
	public int getUse_subject_id() {
		return use_subject_id;
	}
	public void setUse_subject_id(int use_subject_id) {
		this.use_subject_id = use_subject_id;
	}	
	private int use_col_id;
	private int s_tables_id;
	private String col_c_name;
	private String col_e_name;
	private int subject_id;
	private int include_col_id;	
	private int use_subject_id;

}

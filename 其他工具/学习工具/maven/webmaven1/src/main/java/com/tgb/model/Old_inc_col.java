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
public class Old_inc_col implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Old_inc_col(){
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
	private int include_col_id;
	private int s_tables_id;
	private String col_c_name;
	private String col_e_name;

}

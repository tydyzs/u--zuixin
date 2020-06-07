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
public class Use_where implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Use_where() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getUse_where_id() {
		return use_where_id;
	}
	public void setUse_where_id(int use_where_id) {
		this.use_where_id = use_where_id;
	}
	public String getL_bracket() {
		return l_bracket;
	}
	public void setL_bracket(String l_bracket) {
		this.l_bracket = l_bracket;
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
	public String getCol_e_name() {
		return col_e_name;
	}
	public void setCol_e_name(String col_e_name) {
		this.col_e_name = col_e_name;
	}
	public String getCol_c_name() {
		return col_c_name;
	}
	public void setCol_c_name(String col_c_name) {
		this.col_c_name = col_c_name;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getCol_value() {
		return col_value;
	}
	public void setCol_value(String col_value) {
		this.col_value = col_value;
	}
	public String getR_bracket() {
		return r_bracket;
	}
	public void setR_bracket(String r_bracket) {
		this.r_bracket = r_bracket;
	}
	public String getConnector() {
		return connector;
	}
	public void setConnector(String connector) {
		this.connector = connector;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public int getUse_subject_id() {
		return use_subject_id;
	}
	public void setUse_subject_id(int use_subject_id) {
		this.use_subject_id = use_subject_id;
	}
	private int use_where_id;
	private String l_bracket;
	private int s_tables_id;
	private String e_name;
	private String c_name;
	private int include_col_id;
	private String col_e_name;
	private String col_c_name;
	private String operator;
	private String col_value;//注此处可能为 clob,
	private String r_bracket;
	private String connector;
	private int subject_id;
	private int  use_subject_id;	

}

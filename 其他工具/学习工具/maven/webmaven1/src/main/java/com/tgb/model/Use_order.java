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
public class Use_order implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Use_order() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getUse_order_id() {
		return use_order_id;
	}
	public void setUse_order_id(int use_order_id) {
		this.use_order_id = use_order_id;
	}
	public int getS_tables_id() {
		return s_tables_id;
	}
	public void setS_tables_id(int s_tables_id) {
		this.s_tables_id = s_tables_id;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public int getOrder_col_id() {
		return order_col_id;
	}
	public void setOrder_col_id(int order_col_id) {
		this.order_col_id = order_col_id;
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
	public String getOrder_dct() {
		return order_dct;
	}
	public void setOrder_dct(String order_dct) {
		this.order_dct = order_dct;
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
	private int use_order_id;
	private int s_tables_id;
	private String c_name;
	private String e_name;
	private int order_col_id;
	private String col_c_name;
	private String col_e_name;
	private String order_dct;
	private int subject_id;
	private int use_subject_id;	

}

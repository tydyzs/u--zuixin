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
public class UseFunction implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public UseFunction() {
		// TODO Auto-generated constructor stub
		super();
	}
	
	public int getFunction_id() {
		return function_id;
	}
	public void setFunction_id(int function_id) {
		this.function_id = function_id;
	}
	public String getFunction_name() {
		return function_name;
	}
	public void setFunction_name(String function_name) {
		this.function_name = function_name;
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
	public String getCol_id() {
		return col_id;
	}
	public void setCol_id(String col_id) {
		this.col_id = col_id;
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
	public int getUseSubject_id() {
		return useSubject_id;
	}
	public void setUseSubject_id(int useSubject_id) {
		this.useSubject_id = useSubject_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private int function_id;
	private String function_name;
	private int s_tables_id;
	private String c_name;
	private String e_name;
	private String col_id;
	private String col_c_name;
	private String col_e_name;
	private int useSubject_id;	
	

}

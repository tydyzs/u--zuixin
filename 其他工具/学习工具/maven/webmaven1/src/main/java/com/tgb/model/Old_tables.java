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
public class Old_tables implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Old_tables() {
		// TODO Auto-generated constructor stub		
		super();
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
	private int s_tables_id;
	private String c_name;
	private String e_name;

}

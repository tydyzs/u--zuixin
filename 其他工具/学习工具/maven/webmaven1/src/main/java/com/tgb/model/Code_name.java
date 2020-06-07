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
public class Code_name implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Code_name() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getCode_name_id() {
		return code_name_id;
	}
	public void setCode_name_id(int code_name_id) {
		this.code_name_id = code_name_id;
	}
	public int getTable_id() {
		return table_id;
	}
	public void setTable_id(int table_id) {
		this.table_id = table_id;
	}
	public int getCol_id() {
		return col_id;
	}
	public void setCol_id(int col_id) {
		this.col_id = col_id;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	private int code_name_id;
	private int table_id;
	private int col_id;
	private int subject_id;	

}

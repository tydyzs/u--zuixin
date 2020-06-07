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
public class Tusesql implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Tusesql() {
		// TODO Auto-generated constructor stub
		super();
	}
	
	public int getUsesql_id() {
		return usesql_id;
	}

	public void setUsesql_id(int usesql_id) {
		this.usesql_id = usesql_id;
	}

	public String getSql_content() {
		return sql_content;
	}
	public void setSql_content(String sql_content) {
		this.sql_content = sql_content;
	}

	public int getUse_subject_id() {
		return use_subject_id;
	}
	public void setUse_subject_id(int use_subject_id) {
		this.use_subject_id = use_subject_id;
	}

	private int usesql_id;
	private String sql_content;//因有的条件字段为clob所以此处也设置为 clob,
	private int use_subject_id;

}

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
public class Tsql implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Tsql() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getSql_id() {
		return sql_id;
	}
	public void setSql_id(int sql_id) {
		this.sql_id = sql_id;
	}
	public String getSql_content() {
		return sql_content;
	}
	public void setSql_content(String sql_content) {
		this.sql_content = sql_content;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	private int sql_id;
	private String sql_content;//因有的条件字段为clob所以此处也设置为 clob,
	private int subject_id;

}

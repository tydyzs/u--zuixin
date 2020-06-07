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
public class Tcon implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Tcon() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getCon_id() {
		return con_id;
	}
	public void setCon_id(int con_id) {
		this.con_id = con_id;
	}
	public int getS_tables_id_1() {
		return s_tables_id_1;
	}
	public void setS_tables_id_1(int s_tables_id_1) {
		this.s_tables_id_1 = s_tables_id_1;
	}
	public String getC_name_1() {
		return c_name_1;
	}
	public void setC_name_1(String c_name_1) {
		this.c_name_1 = c_name_1;
	}
	public String getE_name_1() {
		return e_name_1;
	}
	public void setE_name_1(String e_name_1) {
		this.e_name_1 = e_name_1;
	}
	public int getInclude_col_id_1() {
		return include_col_id_1;
	}
	public void setInclude_col_id_1(int include_col_id_1) {
		this.include_col_id_1 = include_col_id_1;
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
	public String getS_tables_id_2() {
		return s_tables_id_2;
	}
	public void setS_tables_id_2(String s_tables_id_2) {
		this.s_tables_id_2 = s_tables_id_2;
	}
	public String getC_name_2() {
		return c_name_2;
	}
	public void setC_name_2(String c_name_2) {
		this.c_name_2 = c_name_2;
	}
	public String getE_name_2() {
		return e_name_2;
	}
	public void setE_name_2(String e_name_2) {
		this.e_name_2 = e_name_2;
	}
	public int getInclude_col_id_2() {
		return include_col_id_2;
	}
	public void setInclude_col_id_2(int include_col_id_2) {
		this.include_col_id_2 = include_col_id_2;
	}
	public String getCon_way() {
		return con_way;
	}
	public void setCon_way(String con_way) {
		this.con_way = con_way;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getCol_c_name2() {
		return col_c_name2;
	}
	public void setCol_c_name2(String col_c_name2) {
		this.col_c_name2 = col_c_name2;
	}
	public String getCol_e_name2() {
		return col_e_name2;
	}
	public void setCol_e_name2(String col_e_name2) {
		this.col_e_name2 = col_e_name2;
	}
	private int con_id;
	private int s_tables_id_1;
	private String c_name_1;
	private String e_name_1;
	private int include_col_id_1;
	private String col_c_name;
	private String col_e_name;
	private String s_tables_id_2;
	private String c_name_2;
	private String e_name_2;
	private int include_col_id_2;
	private String con_way;
	private int subject_id;
	private int sort;
	private String col_c_name2;
	private String col_e_name2;

}

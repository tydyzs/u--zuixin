/**
 * @author 李春瑞
 * @date 2016年6月1日
 */
package com.tgb.model;

import java.io.Serializable;
import java.sql.Date;

/**
 * @author 李春瑞
 *
 */
public class SetTheme implements Serializable {

	private static final long serialVersionUID = 1L;
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public int getT_type_id() {
		return t_type_id;
	}
	public void setT_type_id(int t_type_id) {
		this.t_type_id = t_type_id;
	}
	public String getSetman() {
		return setman;
	}
	public void setSetman(String setman) {
		this.setman = setman;
	}
	public Date getSetdate() {
		return setdate;
	}
	public void setSetdate(Date setdate) {
		this.setdate = setdate;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public int getIs_function() {
		return is_function;
	}
	public void setIs_function(int is_function) {
		this.is_function = is_function;
	}
	public int getIs_groupby() {
		return is_groupby;
	}
	public void setIs_groupby(int is_groupby) {
		this.is_groupby = is_groupby;
	}
	public int getIs_order() {
		return is_order;
	}
	public void setIs_order(int is_order) {
		this.is_order = is_order;
	}
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
//	public SetTheme(int subject_id,String subject_name,int t_type_id,String setman,Date setdate,Date modify_date,int is_function,int is_groupby,int is_order,int is_del){
//		super();
//		this.subject_id = subject_id;
//		this.is_del = is_del;
//		this.is_function = is_function;
//		this.is_groupby = is_groupby;
//	}
	private int subject_id;
	private String subject_name;
	private int t_type_id;
	private String setman;
	private Date setdate;
	private Date modify_date;	
	private int is_function;
	private int is_groupby;
	private int is_order;
	private int is_del;

}

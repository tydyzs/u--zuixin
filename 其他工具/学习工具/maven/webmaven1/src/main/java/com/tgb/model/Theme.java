package com.tgb.model;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public class Theme implements Serializable{

	private Integer subject_id;
	private String subject_name;
	private Integer t_type_id;
	private String setman;
	private Date setDate;
	private Date modify_date;
	private String is_function;
	private String is_groupby;
	private String is_order;
	private String is_del;
	public Integer getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(Integer subject_id) {
		this.subject_id = subject_id;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public Integer getT_type_id() {
		return t_type_id;
	}
	public void setT_type_id(Integer t_type_id) {
		this.t_type_id = t_type_id;
	}
	public String getSetman() {
		return setman;
	}
	public void setSetman(String setman) {
		this.setman = setman;
	}
	public Date getSetDate() {
		return setDate;
	}
	public void setSetDate(Date setDate) {
		this.setDate = setDate;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getIs_function() {
		return is_function;
	}
	public void setIs_function(String is_function) {
		this.is_function = is_function;
	}
	public String getIs_groupby() {
		return is_groupby;
	}
	public void setIs_groupby(String is_groupby) {
		this.is_groupby = is_groupby;
	}
	public String getIs_order() {
		return is_order;
	}
	public void setIs_order(String is_order) {
		this.is_order = is_order;
	}
	public String getIs_del() {
		return is_del;
	}
	public void setIs_del(String is_del) {
		this.is_del = is_del;
	}
	
}

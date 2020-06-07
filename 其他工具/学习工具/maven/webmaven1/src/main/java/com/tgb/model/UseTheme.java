package com.tgb.model;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public class UseTheme implements Serializable{

	private Integer use_subject_id;
	private Integer type_id;
	private Integer subject_id;
	private String use_subject_name;//使用主题名称
	private String setman;//创建者
	private Date setdate;//创建时间
	private Integer is_del;//是否删除
	private String themeName;//存放主题名称
	private String typeName;//存放入库类型
	
	
	
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getThemeName() {
		return themeName;
	}
	public void setThemeName(String themeName) {
		this.themeName = themeName;
	}
	public Integer getUse_subject_id() {
		return use_subject_id;
	}
	public void setUse_subject_id(Integer use_subject_id) {
		this.use_subject_id = use_subject_id;
	}
	public Integer getType_id() {
		return type_id;
	}
	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}
	public Integer getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(Integer subject_id) {
		this.subject_id = subject_id;
	}
	public String getUse_subject_name() {
		return use_subject_name;
	}
	public void setUse_subject_name(String use_subject_name) {
		this.use_subject_name = use_subject_name;
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
	public Integer getIs_del() {
		return is_del;
	}
	public void setIs_del(Integer is_del) {
		this.is_del = is_del;
	}
	
	
}

/**
 * @author 李春瑞
 * @date 2016年6月2日
 */
package com.tgb.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 李春瑞
 *
 */
public class Use_subject implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * @author 李春瑞
	 */
	public Use_subject() {
		// TODO Auto-generated constructor stub
		super();
	}
	public int getUse_subject_id() {
		return use_subject_id;
	}
	public void setUse_subject_id(int use_subject_id) {
		this.use_subject_id = use_subject_id;
	}
	public int getType_id() {
		return type_id;
	}
	public void setType_id(int type_id) {
		this.type_id = type_id;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
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
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
	private int use_subject_id;
	private int type_id;
	private int subject_id;
	private String use_subject_name;
	private String setman;
	private Date setdate;
	private int is_del;

}

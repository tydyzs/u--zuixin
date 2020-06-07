package com.tgb.model;

import java.util.Date;




/**
 * 用户
 * @author 李春瑞
 *
 */
public class User_new {

	

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_code() {
		return user_code;
	}

	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEMAIL() {
		return EMAIL;
	}

	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

	public String getTEL() {
		return TEL;
	}

	public void setTEL(String tEL) {
		TEL = tEL;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getStation() {
		return station;
	}

	public void setStation(int station) {
		this.station = station;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getLogin_lasttime() {
		return login_lasttime;
	}

	public void setLogin_lasttime(Date login_lasttime) {
		this.login_lasttime = login_lasttime;
	}

	public int getLogin_num() {
		return login_num;
	}

	public void setLogin_num(int login_num) {
		this.login_num = login_num;
	}
	public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}	

	private int user_id;
	private String user_code;
	private String user_name;
	private String password;
	private String EMAIL;
	private String TEL;
	private String mobile;
	private int station;
	private String remark;
	private Date login_lasttime;
	private int login_num;
	private String user_image;

	public User_new(int user_id, String user_code, String user_name,String password,String EMAIL,String TEL,String mobile,int station,String remark,Date login_lasttime,int login_num,String user_image ) {
		super();
		this.user_id = user_id;
		this.user_code = user_code;
		this.user_name = user_name;
		this.password = password;
		this.EMAIL = EMAIL;
		this.TEL = TEL;
		this.mobile = mobile;
		this.remark = remark;
		this.station = station;
		this.login_num = login_num;
		this.login_lasttime = login_lasttime;
		this.user_image = user_image;

	}
	public User_new() {
		// TODO Auto-generated constructor stub
		super();
	}
}

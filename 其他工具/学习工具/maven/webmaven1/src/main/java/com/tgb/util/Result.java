package com.tgb.util;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public class Result {
	private int status;
	private String msg;
	private Object data;
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}

package com.tgb.util;

import javax.servlet.http.HttpServletRequest;

public class GetSessionUser {
	public static String getUser(HttpServletRequest request){
		String user_code = request.getSession().getAttribute("user_code").toString();
		return user_code;
	}

}

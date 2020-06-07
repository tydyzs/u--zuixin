package com.tgb.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Controller
public class LoginInterceptor_new  extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String path = request.getServletPath();
		String user_code_md5 = request.getParameter("user_code");
		if(path.matches("")){
			return true;
		}else{
			HttpSession session = request.getSession();
			String user_code = session.getAttribute("user_code").toString();
			if(user_code!=null||!"".equals(user_code)){
				return true;
			}else{
				response.sendRedirect(request.getContextPath()+"/login.jsp");
				return false;
			}
		}
	}
	
}
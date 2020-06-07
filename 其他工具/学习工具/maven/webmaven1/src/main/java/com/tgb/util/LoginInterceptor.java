package com.tgb.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.tgb.service.TsubjectService;
@Controller
public class LoginInterceptor implements HandlerInterceptor {
	@Autowired
	private TsubjectService tsubjectService;
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception arg3)
			throws Exception {

	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {

	}
	
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		// 获取请求的URL
//		// System.out.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//		// String url = request.getRequestURI();
//		// if(url.indexOf("login.jsp")>=0){
//		// return true;
//		// }
//		// 获取Session
////		String user_code_md5 = "";
////		user_code_md5 = request.getParameter("user_code");
////		System.out.println("登录的用户名为:" + user_code_md5);
//		HttpSession session = request.getSession();
////		session.setAttribute("user_code", "00001");
////		return true;
//		//****************************************
//		AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
//		String user_code = "";
//		if (null != principal) {
//			user_code = principal.getName();
//			session.setAttribute("user_code", user_code);
//			System.out.println("这次登录的用户名为:" + user_code);
//			return true;
//
//		} else {
//			System.out.println("没登录"+request.getContextPath());
//			return false;
//		}
////************************************************
//		//不符合条件的跳转到登录界面
//		//request.getRequestDispatcher("/login.jsp").forward(request, response);
//		//response.sendRedirect("/GeneralSearch/login.jsp");		
//		//return false;
//
//		// session.setAttribute("user_code_1", user_code_1);
//		// String user_code = (String) session.getAttribute("user_code");
//		// if (user_code != null) {
//		// return true;
//		// }
//		// // 不符合条件的跳转到登录界面
//		// response.sendRedirect("/login.jsp");
//		// return false;
//
//	
//	}
	@RequestMapping("/preHandle")
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60*60);
		return true;
		/*if (null != session.getAttribute("user_code")) {
			String user_code_md5 = session.getAttribute("user_code").toString();
			session.setAttribute("user_code", user_code_md5);
			String user_name=(String) tsubjectService.finduser(user_code_md5).get("USER_NAME");
			session.setAttribute("user_name", user_name);
			System.out.println("登录的用户名为:" + user_code_md5);
			return true;

		} else {
			System.out.println("没登录"+request.getContextPath());
			response.sendRedirect(request.getContextPath()+"/login.jsp");			
			System.out.println("没登录kkk"+request.getContextPath());
			return false;
		}
*/
	
	}	

}

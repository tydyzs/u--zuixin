/**   
 * Filename:    LoginController.java   
 * Copyright:   Copyright (c)2014  
 * Company:     com.idata 
 * @version:    1.0
 * @author:     kzq     
 * Create at:   2016年10月8日 下午2:36:30   
 * Description:  
 *     
 */
package com.tgb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author kzq
 * @date 2016年10月8日
 */
@Controller
@RequestMapping("")
public class LoginController {
	@RequestMapping("/logincas/login")
	public String login(HttpServletRequest request) {
		System.out.println(11111);
		return "redirect:http://150.21.25.80:8080/cas/login";
	}

	@RequestMapping({ "/logincas", "" })
	public String index(HttpServletRequest request) {
		System.out.println(11111);
		return "index";
	}
}

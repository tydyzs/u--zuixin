package com.tgb.controller;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.service.UserService;
import com.tgb.util.Result;


@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	  private static final int IMG_HEIGHT = 100;
	    // 图片宽度
	    private static final int IMG_WIDTH = 30;
	    // 验证码长度
	    private static final int CODE_LEN = 4;


	    @RequestMapping("/sc_post")
	    protected void doPost1(HttpServletRequest req, HttpServletResponse resp)
	            throws IOException {
	    	String dm_id = req.getParameter("dm_id");
	        // 用于绘制图片，设置图片的长宽和图片类型（RGB)
	        BufferedImage bi = new BufferedImage(IMG_HEIGHT, IMG_WIDTH, BufferedImage.TYPE_INT_RGB);
	        // 获取绘图工具
	        Graphics graphics = bi.getGraphics();
	        graphics.setColor(new Color(100, 230, 200)); // 使用RGB设置背景颜色
	        graphics.fillRect(0, 0, 100, 30); // 填充矩形区域

	        // 验证码中所使用到的字符
	        char[] codeChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456".toCharArray();
	        String captcha = ""; // 存放生成的验证码
	        Random random = new Random();
	        for(int i = 0; i < CODE_LEN; i++) { // 循环将每个验证码字符绘制到图片上
	            int index = random.nextInt(codeChar.length);
	            // 随机生成验证码颜色
	            graphics.setColor(new Color(random.nextInt(150), random.nextInt(200), random.nextInt(255)));
	            // 将一个字符绘制到图片上，并制定位置（设置x,y坐标）
	            graphics.drawString(codeChar[index] + "", (i * 20) + 15, 20);
	            captcha += codeChar[index];
	        }
	        // 将生成的验证码code放入sessoin中
	        req.getSession().setAttribute(dm_id, captcha);
	        // 通过ImageIO将图片输出
	        ImageIO.write(bi, "JPG", resp.getOutputStream());
	    } 
	

	 @RequestMapping("/yz_post")
	 @ResponseBody
   protected Result doPost(HttpServletRequest req, HttpServletResponse resp)
           throws ServletException, IOException {
       // 获取存放在session中的验证码
      // String code = (String) req.getSession().getAttribute("code");
		 String dm_id = req.getParameter("dm_id");
       String code = (String) req.getSession().getAttribute(dm_id);
       // 获取页面提交的验证码
       String inputCode = req.getParameter("code");
       Result result=new Result();
       if(code.toLowerCase().equals(inputCode.toLowerCase())) { // 验证码不区分大小写
           // 验证成功，跳转到成功页面
          // req.getRequestDispatcher("/success.jsp").forward(req, resp);
    	   
    	   result.setMsg("正确");
       } else { // 验证失败
         //  req.getRequestDispatcher("/fail.jsp").forward(req, resp);
    	   result.setMsg("错误");
       }
       return result;
   }
	 

	 
}

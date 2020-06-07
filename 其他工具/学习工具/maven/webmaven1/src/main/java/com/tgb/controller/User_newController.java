package com.tgb.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tgb.model.Dep_user;
import com.tgb.model.User_new;
import com.tgb.service.Dep_userService;
import com.tgb.service.User_newService;
import com.tgb.util.ExportExcelUtil;
import com.tgb.util.LockUserCode;
import com.tgb.util.Result;

@Controller
@RequestMapping("/user_new")
public class User_newController {
	@Resource
	private User_newService user_newService;
	@Resource
	private Dep_userService dep_userService;
	
	/**
	 * 获取所有用户列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllUser_new")
	@ResponseBody
	public Result getAllUser_new(String currentPage,HttpServletRequest request){
		Result result = new Result();
		result = user_newService.findAll(currentPage);	
		return result;
	}
	
	/**
	 * 跳转到添加用户界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddUser_new")
	@ResponseBody
	public Result toAddUser_new(HttpServletRequest request,User_new user_new){		
		Result result = new Result();
		user_newService.save(user_new);
		int user_id = user_new.getUser_id();
		result.setStatus(0);
		result.setData(user_id);
		return result;
	}

	/**
	 *编辑用户
	 * @param User_new
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateUser_new")
	@ResponseBody
	public Result updateUser_new(HttpServletRequest request,String user_code,String user_name,String password,String EMAIL,String TEL,String mobile,String user_image,String station,String remark,
			String login_num,String department_id,String user_id,String position,String duty,String remark_2,String dep_user_id){		
		Result result = new Result();
		User_new user_new = new User_new();
		user_new.setUser_code(user_code);
		user_new.setEMAIL(EMAIL);
		user_new.setLogin_num(Integer.parseInt(login_num));
		user_new.setMobile(mobile);
		user_new.setPassword(password);
		user_new.setRemark(remark);
		user_new.setStation(Integer.parseInt(station));
		user_new.setTEL(TEL);			
		user_new.setUser_image(user_image);
		user_new.setUser_name(user_name);
		user_new.setUser_id(Integer.parseInt(user_id));
		user_newService.update(user_new);
		Dep_user dep_user = new Dep_user();
		dep_user.setDepartment_id(Integer.parseInt(department_id));
		dep_user.setDuty(duty);
		dep_user.setPosition(position);
		dep_user.setRemark(remark_2);
		dep_user.setUser_id(Integer.parseInt(user_id));
		dep_user.setDep_user_id(Integer.parseInt(dep_user_id));
		dep_userService.update(dep_user);
		result.setStatus(0);
//		result.setData(user_id);
		return result;		
	}
	/**
	 * 根据id查询单个用户
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getUser_new")
	@ResponseBody
	public Result getUser_new(String user_id,HttpServletRequest request){		
		Result result = new Result();
		result = user_newService.findById(Integer.parseInt(user_id));		
		return result;		
	}
	
	//根据主题ID删除业务主题
	@RequestMapping("/delUser_new")
	@ResponseBody
	public Result delUser_new(int user_id){
		Result result =  user_newService.delete(user_id);
		return result;
	}


		//根据用户名或者用户编码模糊查询用户
		@RequestMapping("/queryByName")
		@ResponseBody
		public Result queryByName(String user_code,String currentPage){
			Map map = new HashMap();
			map.put("user_code", user_code);
			map.put("currentPage", currentPage);
			Result result =  user_newService.findByName(map);
			return result;
		}
		//根据用户编码md5查询用户
		@RequestMapping("/queryByName_new")
		@ResponseBody
		public Result queryByName_new(String user_code,HttpServletRequest request){
			user_code = LockUserCode.decrypt(user_code, "24401830000").substring(7);
			//user_code = LockUserCode.decrypt(user_code, "24401830000").substring(7);
			Map map = new HashMap();
			map.put("user_code", user_code);			
			Result result =  user_newService.findByName_new(map);
			List<Map> list = (List<Map>)result.getData();
			String user_code_new = list.get(0).get("USER_CODE").toString();
			//String user_code_md5 = list.get(0).get("USER_CODE_MD5").toString();
			HttpSession session = request.getSession(); 
			session.setAttribute("user_code", user_code_new);
			//session.setAttribute("user_code_md5", user_code_md5);
			return result;
		}		
		//查询用户数量
		@RequestMapping("/findCount")
		@ResponseBody
		public Result findCount(){
			Result result =  user_newService.findCount();
			return result;
		}		
		@RequestMapping("/AddUser_new")
		@ResponseBody
		public Result AddUser_new(HttpServletRequest request,String user_code,String user_name,String password,String EMAIL,String TEL,String mobile,String user_image,String station,String remark,
				String login_num,String department_id,String user_id,String position,String duty,String remark_2){

		
			Result result = new Result();
			User_new user_new = new User_new();
			user_new.setUser_code(user_code);
			user_new.setEMAIL(EMAIL);
			user_new.setLogin_num(Integer.parseInt(login_num));
			user_new.setMobile(mobile);
			user_new.setPassword(password);
			user_new.setRemark(remark);
			user_new.setStation(Integer.parseInt(station));
			user_new.setTEL(TEL);			
			user_new.setUser_image(user_image);
			user_new.setUser_name(user_name);			
			
			//判断是否存在
			Result result1 =  user_newService.checkUser(user_new);
			if(result1.getStatus()==0){
				result.setStatus(1);
			}else{
				user_newService.save(user_new);					
				int user_id_2 = user_new.getUser_id();
				Dep_user dep_user = new Dep_user();
				dep_user.setDepartment_id(Integer.parseInt(department_id));
				dep_user.setDuty(duty);
				dep_user.setPosition(position);
				dep_user.setRemark(remark_2);
				dep_user.setUser_id(user_id_2);
				dep_userService.save(dep_user);
				result.setStatus(0);				
			}			
			
//			

//			result.setData(user_id);
			return result;
		}	
		//用户登录检查
		@RequestMapping("/checkUser")
		@ResponseBody
		public Result checkUser(HttpSession httpSession,User_new user_new){
			Result result =  user_newService.checkUser(user_new);
			if(result.getStatus()==0){
				httpSession.setAttribute("user_code", user_new.getUser_code());
				httpSession.setAttribute("password", user_new.getPassword());
			}
			return result;
		}	
		//导入用户EXCEL
		@RequestMapping("/importUser_new")
		@ResponseBody
		public void importUser_new(@RequestParam("file") MultipartFile file,HttpServletRequest request,HttpServletResponse response) throws IOException{
			Result result = new Result();
			try {
				String name=file.getOriginalFilename();
				InputStream ins = file.getInputStream();
				result =  user_newService.importUser_new(ins,name);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}			
			//return result;
			response.sendRedirect("/ZcSearch/jsp/User_Manage.jsp");
		}
		//导出用户EXCEL
		@RequestMapping("/exportUser_new")
		@ResponseBody
		public Result exportUser_new(HttpServletRequest request,HttpServletResponse response){
			Result result = new Result();
			String tomurl=request.getSession().getServletContext().getRealPath("/");
			try {
				OutputStream os = null;  
				Workbook wb = null;    //工作薄
				FileOutputStream os1 = null;
				try {
					//模拟数据库取值					
					result = user_newService.findAll_new();
					List<Map> ls = (List<Map>)result.getData();
					
					//导出Excel文件数据
					ExportExcelUtil util = new ExportExcelUtil();
					//File file =util.getExcelDemoFile(tomurl+"img\\ExportExcelModel\\cc.xls");
					//String aa = tomurl+"img\\ExportExcelModel\\cc.xls";
					//String bb = tomurl+"img\\ExportExcelModel\\cc_2.xls";
					String aa = tomurl+"img/ExportExcelModel/cc.xls";
					String bb = tomurl+"img/ExportExcelModel/cc_2.xls";					
					File file =new File(aa);
					String sheetName="sheet1";  
					wb = util.writeNewExcel(file, sheetName,ls);
					os1 = new FileOutputStream(bb);
					wb.write(os1);

					
					result.setStatus(0);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				finally{
					os1.flush();
					os1.close();
					//((FileOutputStream) wb).close();				
				}								
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return result;
		}
		//根据user_code,project_id查寻主菜单
		@RequestMapping("/findModByUserCode")
		@ResponseBody
		public Result findModByUserCode(String user_code,String project_id){
			Map map = new HashMap();
			map.put("user_code", user_code);
			map.put("project_id", project_id);
			Result result =  user_newService.findModByUserCode(map);
			return result;
		}
		//根据user_code,project_id,parent_id查寻子菜单
		@RequestMapping("/findModByPanentID")
		@ResponseBody
		public Result findModByPanentID(String user_code,String project_id,String parent_id){
			Map map = new HashMap();
			map.put("user_code", user_code);
			map.put("project_id", project_id);
			map.put("parent_id", parent_id);
			Result result =  user_newService.findModByPanentID(map);
			return result;
		}	
		
		//
		@RequestMapping("/finduserdata")
		@ResponseBody
		public Result finduserdata(String user_code){
			Result result =  user_newService.finduserdata(user_code);
			return result;
		}	
		
}












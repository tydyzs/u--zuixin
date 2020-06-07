package com.tgb.controller2;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tgb.model.Include_col;
import com.tgb.service.UseCustomService;
import com.tgb.service2.SqlService;
import com.tgb.util.Base64;
import com.tgb.util.ExportExcel_new;
import com.tgb.util.ExportExcel_report;
import com.tgb.util.Is_excel;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Controller
@RequestMapping("/sql")
public class SqlController {


	@Resource
	private SqlService Sqlservice;
	@Resource
	private UseCustomService usecustomservice;	
	/**
	 * 执行sql
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/implementsql.do")
	@ResponseBody
	public Result ImplementSql(HttpServletRequest request,HttpServletResponse response,String sql,String num,String themeId,String map1,String map2){
		Base64 ba=new Base64();
		sql=ba.getStr(sql);
		//map2 = changeMap(map2,themeId);
		String[] split1 = map1.split(",");
		String[] split2 = map2.split(",");
		String tomurl=request.getSession().getServletContext().getRealPath("/");
		Result result = new Result();
		try
		{
			result=Sqlservice.implementsql(sql,num,tomurl,themeId,split1,split2);
			return result;
		}
		catch(Exception e)
		{
			 e.printStackTrace();
			 result.setStatus(-1);
			 return result;
		}
		
	}
	
	@RequestMapping("/implementsql_3.do")
	@ResponseBody
	public Result ImplementSql(HttpServletRequest request,HttpServletResponse response,String sql,String num,String themeId){
		Base64 ba=new Base64();
		sql=ba.getStr(sql);
		String tomurl=request.getSession().getServletContext().getRealPath("/");
		Result result = new Result();
		try
		{
			result=Sqlservice.implementsql(sql,num,tomurl,themeId);
			return result;
		}
		catch(Exception e)
		{
			 e.printStackTrace();
			 result.setStatus(-1);
			 return result;
		}
		
	}	
	
	@RequestMapping("/implementsql_2.do")
	@ResponseBody
	public Result ImplementSql_2(HttpServletRequest request,HttpServletResponse response,String sql,String num){
		Base64 ba=new Base64();
		sql=ba.getStr(sql);
		String tomurl=request.getSession().getServletContext().getRealPath("/");
		Result result = new Result();
		try
		{
			result=Sqlservice.implementsql(sql,num,tomurl);
			return result;
		}
		catch(Exception e)
		{
			 e.printStackTrace();
			 result.setStatus(-1);
			 return result;
		}
		
	}	
	
	
	//导出excel
	@RequestMapping("/ExporExcel.do")
	@ResponseBody
	public void ExporExcel(HttpServletRequest request,HttpServletResponse response,String sql,String num,String themeId,String map1,String map2){
		//map1 = changeMap(map1,themeId);
		String[] split1 = map1.split(",");
		String[] split2 = map2.split(",");
		String tomurl=request.getSession().getServletContext().getRealPath("/");
		Result result = new Result();
		try
		{
			 	HSSFWorkbook wb = Sqlservice.ExporExcel(sql,num,tomurl,themeId,split1,split2);
				response.reset();
		        response.setContentType("application/octet-stream; charset=utf-8");
		        response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode("导出excel.xls", "UTF-8"));
				wb.write(response.getOutputStream());
				
//				
		}
		catch(Exception e)
		{
			 e.printStackTrace();
		}
	}
	public String changeMap(String map,String themeId ){
		String map2 = "";
		String[] split1 = map.split(",");
		Result result=usecustomservice.findcolName(themeId);
		Map map3 = (Map)result.getData();
		List<Include_col> list1 = (List<Include_col>)map3.get("list1");
		for(int i=0;i<split1.length;i++){
			for(Include_col aa : list1){
				if(aa.getCol_e_name_alias().equals(split1[i])){
					map2 = map2+aa.getCol_e_name()+",";
				}
			}			
		}
		map2 = map2.substring(0, map2.length()-1);
		System.out.println(map2);
		return map2;
	}
	//导出excel
		@RequestMapping("/ExporExcel_2.do")
		@ResponseBody
		public void ExporExcel_2(HttpServletRequest request,HttpServletResponse response,String sql,String num,String themeId,String map1,String map2){
			//map1 = changeMap(map1,themeId);
			String[] split1 = map1.split(",");
			String[] split2 = map2.split(",");
			String tomurl=request.getSession().getServletContext().getRealPath("/");
			Result result = new Result();
			try
			{
				 	Sqlservice.ExporExcel_2(sql, num, tomurl, themeId, split1, split2);
			}
			catch(Exception e)
			{
				 e.printStackTrace();
			}
		}	
		//导出excel
		@RequestMapping("/ExporExcel_3.do")
		@ResponseBody
		public void ExporExcel_3(HttpServletRequest request,HttpServletResponse response,String sql,int total_record_count,int perCount,String address,String excelName,String cTitle,String eTitle){
			//map1 = changeMap(map1,themeId);
			String[] split1 = cTitle.split(",");
			String[] split2 = eTitle.split(",");
			String tomurl=request.getSession().getServletContext().getRealPath("/");
			Result result = new Result();
			try
			{
				 	Sqlservice.ExporExcel_3(sql, total_record_count, perCount, address, excelName, split1, split2);
			}
			catch(Exception e)
			{
				 e.printStackTrace();
			}
		}
		//导出excel
		@RequestMapping("/ExporExcel_4.do")
		@ResponseBody
		public void ExporExcel_4(HttpServletRequest request,HttpServletResponse response,String sql,int total_record_count,int perCount,String address,String excelName,String cTitle,String eTitle) throws UnsupportedEncodingException{
			//map1 = changeMap(map1,themeId);
			//String s_new = URLDecoder.decode(cTitle.replaceAll("%", "%25"),"UTF-8");
			//String s_new = new String(cTitle.getBytes("ISO8859-1"),"UTF-8");
			//String s_new = URLDecoder.decode(cTitle,"UTF-8");
			//s_new = URLDecoder.decode(s_new.replaceAll("%", "%25"),"UTF-8");
			String[] split1 = cTitle.split(",");
//			for(int i=0;i<split1.length;i++){
//				//split1[i] = URLDecoder.decode(split1[i].replaceAll("%", "%25"),"UTF-8");
//				split1[i] = URLDecoder.decode(split1[i],"UTF-8");
//			}
			String[] split2 = eTitle.split(",");
			String tomurl=request.getSession().getServletContext().getRealPath("/");			
			Result result = new Result();
			try
			{
				    ExportExcel_new wb1 = Sqlservice.ExporExcel_4(sql, total_record_count, perCount, address, excelName, split1, split2);
					response.reset();
			        response.setContentType("application/octet-stream; charset=utf-8");
			        response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode("导出excel.xls", "UTF-8"));	
			        response.setBufferSize(1024);
			        //response.flushBuffer();
			        wb1.write(response.getOutputStream());
			        response.flushBuffer();
					wb1.dispose();
					
			}
			catch(Exception e)
			{
				 e.printStackTrace();
			}
		}
		//导出excel
				@RequestMapping("/ExporExcel_5.do")
				@ResponseBody
				public Result ExporExcel_5(HttpServletRequest request,HttpServletResponse response,String sql,int total_record_count,int perCount,String address,String excelName,String cTitle,String eTitle){

					String[] split1 = cTitle.split(",");
					String[] split2 = eTitle.split(",");
					String tomurl=request.getSession().getServletContext().getRealPath("/");
					Result result = new Result();
					try
					{
						    int return_num = Sqlservice.ExporExcel_5(sql, total_record_count, perCount, address, excelName, split1, split2,tomurl);
						    if(return_num==1){
							    result.setData(return_num);
							    result.setStatus(0);						    	
						    }else{
						    	result.setStatus(1);
						    }
							
					}
					catch(Exception e)
					{
						result.setStatus(1);
						e.printStackTrace();
					}
					return result;
				}
				
				

				//自定义报表导出excel（单独sql)
				@RequestMapping("/excelexport.do")
				public void excelexport(HttpServletRequest request,HttpServletResponse response,String sql,String excelname,String sheet_num,String[] c_name,String[] e_name) throws Exception{
					Base64 ba=new Base64();
					sql=ba.getStr(sql);
					String ip=request.getHeader("x-forwarded-for");
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("WL-Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getRemoteAddr();
					}
					
					try {
						ExportExcel_report listee =Sqlservice.excelexport(sql,ip,sheet_num,c_name,e_name);
						response.reset();
				        response.setContentType("application/octet-stream; charset=utf-8");
				        response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(excelname+".xlsx", "UTF-8"));
				        listee.write(response.getOutputStream());
				        Is_excel.map.remove(ip);
					} catch (IOException e) {
						Is_excel.map.remove(ip);
						e.printStackTrace();
					}
				}
				
				//自定义报表导出excel.验证excel是否正在导出（单独sql)
				@RequestMapping("/excelexport1.do")
				@ResponseBody
				public Result excelexport1(HttpServletRequest request,HttpServletResponse response,String excelname) throws Exception{
					Result result=new Result();
					String ip=request.getHeader("x-forwarded-for");
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("WL-Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getRemoteAddr();
					}
					if(Is_excel.map.get(ip)!=null&&!Is_excel.map.get(ip).equals("new")){
						result.setStatus(-1);//正在导出
						if(Is_excel.map1.get(ip)==null){Is_excel.map1.put(ip,"正在导出！");}
						result.setData(Is_excel.map1.get(ip));
					}else{
						result.setStatus(0);//没有导出
					Is_excel.map.put(ip, excelname);
					}
					return result;
					
				}
				//自定义报表导出excel.验证excel是否正在导出（单独sql)
				@RequestMapping("/excelexport2.do")
				public void excelexport2(HttpServletRequest request,HttpServletResponse response) throws Exception{
					String ip=request.getHeader("x-forwarded-for");
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getHeader("WL-Proxy-Client-IP");
					}
					if(ip==null||ip.length()==0||"unknown".equalsIgnoreCase(ip)){
						ip=request.getRemoteAddr();
					}
					Is_excel.map.put(ip, "new");
					
				}
				
				
				//查询征收项目和征收品目数据
				@RequestMapping("/findzsdata.do")
				@ResponseBody
				public Result findzsdata(String num){
					Result result=Sqlservice.findzsdata(num);
					return result;
				}	
				
	
}

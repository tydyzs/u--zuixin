package com.tgb.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.DepartmentMapper;
import com.tgb.mapper.User_newMapper;
import com.tgb.model.Dep_user;
import com.tgb.model.Department;
import com.tgb.model.User_new;
import com.tgb.service.Dep_userService;
import com.tgb.service.DepartmentService;
import com.tgb.service.User_newService;
import com.tgb.util.ExcelImport;
import com.tgb.util.Result;
import com.tgb.util.WDWUtil;

@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class User_newServiceImpl implements User_newService {
	
	@Resource
	private User_newMapper mapper;
	@Resource
	private DepartmentMapper d_mapper;
	@Resource
	private DepartmentService departmentService;
	@Resource
	private Dep_userService dep_userService;	

	public Result save(User_new user_new) {
		Result result = new Result();
		Boolean b = mapper.save(user_new);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result update(User_new user_new) {
		Result result = new Result();
		Boolean b = mapper.update(user_new);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result delete(int user_id) {
		Result result = new Result();
		Boolean b = mapper.delete(user_id);	
		if(b==true){
			result.setStatus(0);
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}

	public Result findById(int user_id) {
		Result result = new Result();
		Map map = mapper.findById(user_id);		
		result.setStatus(0);
		result.setData(map);
		return result;
	}

	public Result findAll(String currentPage) {
		Result result = new Result();
		List<Map> list = mapper.findAll(currentPage);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	public Result findByName(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findByName(map);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}
	public Result findByName_new(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findByName_new(map);		
		result.setStatus(0);
		result.setData(list);
		return result;
	}		
	public Result findCount(){
		Result result = new Result();
		int count = mapper.findCount();		
		result.setStatus(0);
		result.setData(count);
		return result;		
	}

	public Result checkUser(User_new user_new) {
		Result result = new Result();
		List<User_new> list = mapper.checkUser(user_new);
		int b = list.size(); 
		if(b>0){
			result.setStatus(0);						
		}
		else{
			result.setStatus(-1);
		}
		return result;
	}
	public Result importUser_new(File file,String name) throws InvalidFormatException, IOException{
		//判断文件时2003版本还是2007版本
		boolean isExcel2003 = true; 
		if(WDWUtil.isExcel2007(name)){
			isExcel2003 = false;
		}		
		Result result = new Result();
		InputStream is = new FileInputStream(file);
		try{
			/** 根据版本选择创建Workbook的方式 */
			Workbook wb = null;			
			//当excel是2003时
			if(isExcel2003){
				wb = new HSSFWorkbook(is); 				
				}
		    else{
					wb = new XSSFWorkbook(is);					
				}
			//得到第一个shell  
			Sheet sheet=wb.getSheetAt(0);
			//得到Excel的行数
			int totalRows=sheet.getPhysicalNumberOfRows();
			//得到Excel的列数(前提是有行数)
			int totalCells = 0;
			if(totalRows>=1 && sheet.getRow(0) != null){
				totalCells=sheet.getRow(0).getPhysicalNumberOfCells();
				}
			//循环Excel行数,从第二行开始。标题不入库
			for(int r=1;r<totalRows;r++)
			{
				User_new user_new = new User_new();
				Department department = new Department();
				Dep_user dep_user = new Dep_user();
				Row row = sheet.getRow(r);
				if (row == null) continue;
				//循环Excel的列,0:税务人员代码,1:用户名,2:所在组织编码,3:组织名称,4:职务
					 for(int c = 0; c <totalCells; c++)
					 {
						 Cell cell = row.getCell(c); 
						 if (null != cell)
						 {
							 //第一列
							 if(c==0){
								 String user_code = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 user_code = cell.getStringCellValue();
								 }								 
								 user_new.setUser_code(user_code);
							 }							 
							 else if(c==1){
								 /**
		                          * 处理：使用POI读excel文件，当遇到特殊格式的字串，比如“13612345678”，等等，
		                          * 这样的本来是一个字符串，但是POI在读的时候总是以数值型识别，由此，这样的电话号码读出来后总是1.3XXX+E4
		                          */
								//DecimalFormat df = new DecimalFormat("#");
								//String cellValue=df.format(cell.getNumericCellValue());
								 String user_name = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 user_name = cell.getStringCellValue();
								 }								 
								 user_new.setUser_name(user_name);

							 }
							 else if(c==2){	
								 String department_code = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_code = cell.getStringCellValue();
								 }								 
								 department.setDepartment_code(department_code);
							 }
							 else if(c==3){	
								 String department_name = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_name = cell.getStringCellValue();
								 }								 
								 department.setDepartment_name(department_name);
							 }
							 else if(c==4){	
								 String department_pos = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_pos = cell.getStringCellValue();
								 }								 
								dep_user.setPosition(department_pos);
							 }								 
						 }					 
					 }
//***********************addUser,addDepartment,addDep_user						
						user_new.setEMAIL("");
						user_new.setLogin_num(0);
						user_new.setMobile("");
						user_new.setPassword("1234567");
						user_new.setRemark("");
						user_new.setStation(0);
						user_new.setTEL("");			
						user_new.setUser_image("");
						//user_new.setUser_name(user_name);	
						save(user_new);
						int user_id_2 = user_new.getUser_id();	
						//addDepartment**************
						//查看Department是否存在
						int department_id_2 = 0;
						Department dd = d_mapper.finddepIdByCode(department.getDepartment_code());
						if(null!=dd){
							department_id_2 = dd.getDepartment_id();
						}else{
							department.setIs_del(0);
							department.setParent_id(1);
							department.setRemark("");
							departmentService.save(department);
							department_id_2 = department.getDepartment_id();							
						}

						//addDep_user******************											
						dep_user.setDepartment_id(department_id_2);
						dep_user.setDuty("");
						//dep_user.setPosition(position);
						dep_user.setRemark("");
						dep_user.setUser_id(user_id_2);	
						dep_userService.save(dep_user);
					}
			result.setStatus(0);
			//file.delete();
				
			}
		catch (IOException e){
			e.printStackTrace();
		}		
		is.close();
		
		
//		ExcelImport ei = new ExcelImport();
//		ei.ExcelImport1(file, 0);		
//		for (int i = ei.getDataRowNum()-1; i < ei.getLastDataRowNum(); i++) {//开始读取表的每一条（ei.getDataRowNum()-1：从表头开始读取）
//			Row row = ei.getRow(i);
//			for (int j = 0; j < ei.getLastCellNum(); j++) {//循环某条数据的每一个值
//				Object val = ei.getCellValue(row, j);
//				System.out.print(val+", ");
//			}
//			System.out.print("\n");
//		}			
		return result;
	}

	public Result findAll_new() {
		Result result = new Result();
		List<Map> list = mapper.findAll_new();
		result.setData(list);
		return result;
	}

	public Result findModByUserCode(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findModByUserCode(map);
		result.setData(list);
		result.setStatus(0);
		return result;
	}

	public Result findModByPanentID(Map map) {
		Result result = new Result();
		List<Map> list = mapper.findModByPanentID(map);
		result.setData(list);
		result.setStatus(0);
		return result;
	}
	public Result importUser_new(InputStream ins,String name) throws InvalidFormatException, IOException{
		//判断文件时2003版本还是2007版本
		boolean isExcel2003 = true; 
		if(WDWUtil.isExcel2007(name)){
			isExcel2003 = false;
		}		
		Result result = new Result();
		InputStream is = ins;
		try{
			/** 根据版本选择创建Workbook的方式 */
			Workbook wb = null;			
			//当excel是2003时
			if(isExcel2003){
				wb = new HSSFWorkbook(is); 				
				}
		    else{
					wb = new XSSFWorkbook(is);					
				}
			//得到第一个shell  
			Sheet sheet=wb.getSheetAt(0);
			//得到Excel的行数
			int totalRows=sheet.getPhysicalNumberOfRows();
			//得到Excel的列数(前提是有行数)
			int totalCells = 0;
			if(totalRows>=1 && sheet.getRow(0) != null){
				totalCells=sheet.getRow(0).getPhysicalNumberOfCells();
				}
			//循环Excel行数,从第二行开始。标题不入库
			for(int r=1;r<totalRows;r++)
			{
				User_new user_new = new User_new();
				Department department = new Department();
				Dep_user dep_user = new Dep_user();
				Row row = sheet.getRow(r);
				if (row == null) continue;
				//循环Excel的列,0:税务人员代码,1:用户名,2:所在组织编码,3:组织名称,4:职务
					 for(int c = 0; c <totalCells; c++)
					 {
						 Cell cell = row.getCell(c); 
						 if (null != cell)
						 {
							 //第一列
							 if(c==0){
								 String user_code = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 user_code = cell.getStringCellValue();
								 }								 
								 user_new.setUser_code(user_code);
							 }							 
							 else if(c==1){
								 /**
		                          * 处理：使用POI读excel文件，当遇到特殊格式的字串，比如“13612345678”，等等，
		                          * 这样的本来是一个字符串，但是POI在读的时候总是以数值型识别，由此，这样的电话号码读出来后总是1.3XXX+E4
		                          */
								//DecimalFormat df = new DecimalFormat("#");
								//String cellValue=df.format(cell.getNumericCellValue());
								 String user_name = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 user_name = cell.getStringCellValue();
								 }								 
								 user_new.setUser_name(user_name);

							 }
							 else if(c==2){	
								 String department_code = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_code = cell.getStringCellValue();
								 }								 
								 department.setDepartment_code(department_code);
							 }
							 else if(c==3){	
								 String department_name = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_name = cell.getStringCellValue();
								 }								 
								 department.setDepartment_name(department_name);
							 }
							 else if(c==4){	
								 String department_pos = "";
								 if(cell.getStringCellValue()==null){
									 
								 }else{
									 department_pos = cell.getStringCellValue();
								 }								 
								dep_user.setPosition(department_pos);
							 }								 
						 }					 
					 }
//***********************addUser,addDepartment,addDep_user						
						user_new.setEMAIL("");
						user_new.setLogin_num(0);
						user_new.setMobile("");
						user_new.setPassword("1234567");
						user_new.setRemark("");
						user_new.setStation(0);
						user_new.setTEL("");			
						user_new.setUser_image("");
						//user_new.setUser_name(user_name);	
						save(user_new);
						int user_id_2 = user_new.getUser_id();	
						//addDepartment**************
						//查看Department是否存在
						int department_id_2 = 0;
						Department dd = d_mapper.finddepIdByCode(department.getDepartment_code());
						if(null!=dd){
							department_id_2 = dd.getDepartment_id();
						}else{
							department.setIs_del(0);
							department.setParent_id(1);
							department.setRemark("");
							departmentService.save(department);
							department_id_2 = department.getDepartment_id();							
						}

						//addDep_user******************											
						dep_user.setDepartment_id(department_id_2);
						dep_user.setDuty("");
						//dep_user.setPosition(position);
						dep_user.setRemark("");
						dep_user.setUser_id(user_id_2);	
						dep_userService.save(dep_user);
					}
			result.setStatus(0);
			//file.delete();
				
			}
		catch (IOException e){
			e.printStackTrace();
		}		
		is.close();
		
		
//		ExcelImport ei = new ExcelImport();
//		ei.ExcelImport1(file, 0);		
//		for (int i = ei.getDataRowNum()-1; i < ei.getLastDataRowNum(); i++) {//开始读取表的每一条（ei.getDataRowNum()-1：从表头开始读取）
//			Row row = ei.getRow(i);
//			for (int j = 0; j < ei.getLastCellNum(); j++) {//循环某条数据的每一个值
//				Object val = ei.getCellValue(row, j);
//				System.out.print(val+", ");
//			}
//			System.out.print("\n");
//		}			
		return result;
	}	
	
	public Result finduserdata(String user_code){
		Result result=new Result();
		Object obj=mapper.finduserdata(user_code);
		result.setData(obj);
		return result;
		
	}

}

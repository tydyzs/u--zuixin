package com.tgb.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tgb.model.User_new;

public class ReadExcel {
//总行数
private int totalRows = 0;
//总条数
private int totalCells = 0; 
//错误信息接收器
private String errorMsg;
//构造方法
 public ReadExcel(){}

//得到总行数
public int getTotalRows(){ return totalRows;} 
//得到总列数
public int getTotalCells() { return totalCells;} 
public String getErrorInfo() { return errorMsg; }
/**
     * 描述：验证EXCEL文件
     * @param filePath
     * @return
     */
public boolean validateExcel(String filePath){
	if (filePath == null || !(WDWUtil.isExcel2003(filePath) || WDWUtil.isExcel2007(filePath))){
		errorMsg = "文件名不是excel格式";
		return false;
}
return true;
}

/**描述 :读EXCEL文件
     * @param fielName
     * @return
     */
public List<User_new> getExcelInfo(String fileName,MultipartFile Mfile){
//把spring文件上传的MultipartFile转换成File
	CommonsMultipartFile cf= (CommonsMultipartFile)Mfile; 
	DiskFileItem fi = (DiskFileItem)cf.getFileItem();
	File file = fi.getStoreLocation(); 
	List<User_new> userList=new ArrayList<User_new>();
	InputStream is = null;
		try{
			//验证文件名是否合格
			if(!validateExcel(fileName)){
				return null;
			}
			//判断文件时2003版本还是2007版本
			boolean isExcel2003 = true; 
			if(WDWUtil.isExcel2007(fileName)){
				isExcel2003 = false;
			}
			is = new FileInputStream(file);
			userList=getExcelInfo(is, isExcel2003); 
			is.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	finally{
		if(is!=null)
		{
			try{
				is.close();
			}catch(IOException e){
				is = null;
				e.printStackTrace();
			}
		}
	}
	return userList;
	}
	/**
     * 此方法两个参数InputStream是字节流。isExcel2003是excel是2003还是2007版本
     * @param is
     * @param isExcel2003
     * @return
     * @throws IOException
     */
public List<User_new> getExcelInfo(InputStream is,boolean isExcel2003){

	List<User_new> userList=null;
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
			userList=readExcelValue(wb);
		}
		catch (IOException e){
			e.printStackTrace();
		}
		return userList;
		}
	/**
     * 读取Excel里面的信息
     * @param wb
     * @return
     */
private List<User_new> readExcelValue(Workbook wb){ 
//得到第一个shell  
Sheet sheet=wb.getSheetAt(0);
//得到Excel的行数
this.totalRows=sheet.getPhysicalNumberOfRows();
//得到Excel的列数(前提是有行数)
if(totalRows>=1 && sheet.getRow(0) != null){
	this.totalCells=sheet.getRow(0).getPhysicalNumberOfCells();
	}
	List<User_new> userList=new ArrayList<User_new>();
	User_new user_new = new User_new();
	//循环Excel行数,从第二行开始。标题不入库
	for(int r=1;r<totalRows;r++)
	{
		Row row = sheet.getRow(r);
		if (row == null) continue;
		//循环Excel的列
			 for(int c = 0; c <this.totalCells; c++)
			 {
				 Cell cell = row.getCell(c); 
				 if (null != cell)
				 {
					 //第一列
					 if(c==0){
						//获得第一列<用户名>，放到到用户基本信息bean中。
						 //user_new.setUserName(cell.getStringCellValue());
					 }
					 //获得第二列<手机号>，放到到用户登录bean中。作为登录账号及密码
					 else if(c==1){
						 /**
                          * 处理：使用POI读excel文件，当遇到特殊格式的字串，比如“13612345678”，等等，
                          * 这样的本来是一个字符串，但是POI在读的时候总是以数值型识别，由此，这样的电话号码读出来后总是1.3XXX+E4
                          */
						DecimalFormat df = new DecimalFormat("#");
						String cellValue=df.format(cell.getNumericCellValue());
						//userLogin.setAccount(cellValue);
						//userLogin.setPwd(cellValue);
					 }
//第三列目前不入库，只是展示即可

//第四列<用户地址>,放到到用户基本信息bean中。
					 else if(c==3){
					 //userInfo.setCompanyAdd(cell.getStringCellValue());
					 }
				 }
			 }
			 //添加其他值，入库时需要
			 //userLogin.setUserId(Utils.getzId());//存放用户ID
			 //userLogin.setInsertTime(Utils.getshortDate());//注册时间
			 //userLogin.setUserRole("2"); //默认导入的用户都为供应商级别
			 //userInfo.setUserInfoid(Utils.getzId());//存放用户ID
			 //userInfo.setUserId(userLogin.getUserId());//基本信息的用户ID
			 //user.setUserInfo(userInfo);
			 //user.setUserLogin(userLogin);
			 //userList.add(user);
			}
		return userList;
	}
}

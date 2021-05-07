package com.hse.workmanager.common;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;


import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.fcb.erp.tools.upload.DownloadFile;
import com.hse.pub.common.CommonUtil;
import com.hse.pub.doc.ExcelImport;
import com.hse.workmanager.emergencyManage.AnalysisInstitutionalization;
import com.hse.workmanager.emergencyManage.AnalysisReservePlanDealFile;
import com.hse.workmanager.emergencyManage.AnalysisReservePlanFile;
import com.hse.workmanager.emergencyManage.KvpManagerStandardImp;

import commonj.sdo.DataObject;

/**
 * <pre>
 * 解析已上传的文件
 * </pre>
 * @author shc 
 * @version 1.00.00
 * 
 */
@Bizlet("解析已上传的文件")
public class AnalysisFileUtil{
	/**
	 * 解析应急物资模板文件
	 */
	@Bizlet("AnalysisFileUtil")
	public DataObject AnalysisFileUtil(DataObject fileData) {
		DataObject res = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		String relationId=fileData.getString("relationId");
		String groupId=fileData.getString("groupId");
		//创建数据，附件信息
		DataObject fileEnt = DataObjectUtil.createDataObject("com.fcb.erp.tools.upload.fileUpload.Atfileupload");
		fileEnt.set("relationid",relationId);
		fileEnt.set("groupid",groupId);
		DatabaseUtil.expandEntityByTemplate("default", fileEnt, fileEnt);
		String sid=fileEnt.getString("sid");
		fileData.set("sid", sid);
		String filePath = DownloadFile.downloadImportFile(sid);//文件服务器方式
		//String filePath=fileEnt.getString("filePath");//服务器本地路径方式
		
		//开始处理文件
		if("uploadReservePlanTemplate".equals(groupId)){//应急预案导入
			AnalysisReservePlanFile analysisReservePlanFile=new AnalysisReservePlanFile();
			res=analysisReservePlanFile.analysisReservePlanFile(filePath);
			List<String> filePathList =(List<String>)res.get("deleteFile");
			if(!CommonUtil.checknull(filePathList)){
				for(String filePaths:filePathList){
					CommonUtil.deleteFile(filePaths);
				}
			}
		}else if("uploadEqptInfoTemplate".equals(groupId)){
			AnalysisReservePlanFile analysisReservePlanFile=new AnalysisReservePlanFile();
			res=analysisReservePlanFile.analysisReserveEqptInfoExcelFile(filePath);
			List<String> filePathList =(List<String>)res.get("deleteFile");
			if(!CommonUtil.checknull(filePathList)){
				for(String filePaths:filePathList){
					CommonUtil.deleteFile(filePaths);
				}
			}
		}else if("uploadWorkcheckTemplate".equals(groupId)){
			AnalysisReservePlanDealFile analysisReservePlanFile=new AnalysisReservePlanDealFile();
			res=analysisReservePlanFile.analysisReservePlanFile(filePath);
			List<String> filePathList =(List<String>)res.get("deleteFile");
			if(!CommonUtil.checknull(filePathList)){
				for(String filePaths:filePathList){
					CommonUtil.deleteFile(filePaths);
				}
			}
		}else if("KvpManagerStandard".equals(groupId)){//管理标准导入模板
			KvpManagerStandardImp kvpmanagerstandardimp=new KvpManagerStandardImp();
			String stId=fileData.getString("stId");
			res=kvpmanagerstandardimp.analysisFile(filePath,stId);
			List<String> filePathList =(List<String>)res.get("deleteFile");
			if(!CommonUtil.checknull(filePathList)){
				for(String filePaths:filePathList){
					CommonUtil.deleteFile(filePaths);
				}
			}
		}else if("lawDir".equals(groupId) || "LawDetailListFile".equals(groupId) ||
				"NewReguLationFile".equals(groupId) || "NewOperatFile".equals(groupId)){//制度化管理导入
			AnalysisInstitutionalization analysis=new AnalysisInstitutionalization();
			res=analysis.analysisZdFile(filePath,groupId);
			List<String> filePathList =(List<String>)res.get("deleteFile");
			if(!CommonUtil.checknull(filePathList)){
				for(String filePaths:filePathList){
					CommonUtil.deleteFile(filePaths);
				}
			}
		}
		CommonUtil.deleteFile(filePath);
		res.set("sid", fileEnt.getString("sid"));
		return res;
	}
	
	
	/**
	 * 获取excel的数据
	 * @param filePath：excel路径
	 * @param startRowNum：从第几行开始解析
	 * @return
	 * @throws IOException 
	 * @throws InvalidFormatException 
	 */
	public static List<List<String>> getExcelData(String filePath,int startRowNum) throws InvalidFormatException, IOException{
		List<List<String>> excelData=new ArrayList<List<String>>();
		ExcelImport ei = new ExcelImport();
		ei.ExcelImport1(filePath, 1);
		for (int i = startRowNum-1; i < ei.getLastDataRowNum(); i++) {//开始读取表的每一条（ei.getDataRowNum()-1：从表头开始读取）
			Row row = ei.getRow(i);
			List<String> rowData=new ArrayList<String>();
			boolean b=false;//判断此行是否全是空值。全是空值则不用管
			for (int j = 0; j < ei.getLastCellNum(); j++) {//循环某条数据的每一个值
				Object val = ei.getCellValue(row, j);
				if(i>=2&&j==5&&!CommonUtil.checknull(val)){//日期
					val = CommonUtil.dateToStr(row.getCell(j).getDateCellValue(), "yyyy-MM-dd");
				}
				if(i>=2&&(j==8||j==3)&&!CommonUtil.checknull(val)){//电话
					String typeName=val.getClass().getName();
					int length= typeName.lastIndexOf(".");
					String type =typeName.substring(length+1);
					if("Double".equals(type)){
						DecimalFormat df = new DecimalFormat("0");
						val=df.format(val);
					}
				}
				String value=val==null?"":val.toString();
				if(!CommonUtil.checknull(value)){
					b=true;
				}
				value=getCellValueByCell(row.getCell(j));
				value=value.trim();
				rowData.add(value);
			}
			if(b){
				excelData.add(rowData);
			}
		}
		return excelData;
	}
	
	//解析excel获取字符串
    public static List<List<String>> getExcelDataString(String filePath,int startRowNum) throws IOException {
		List<List<String>> excelData=new ArrayList<List<String>>();
        InputStream is=new FileInputStream(filePath);
        HSSFWorkbook wb=new HSSFWorkbook(is);
        HSSFSheet sheet=wb.getSheetAt(0);
        evaluator=wb.getCreationHelper().createFormulaEvaluator();
        int rowNum=sheet.getLastRowNum();
        for (int i = startRowNum; i <=rowNum; i++) {
			List<String> rowData=new ArrayList<String>();
            Row  row=sheet.getRow(i);
            if(!CommonUtil.checknull(row)){
	            for (Cell cell : row) {
	            	rowData.add(getCellValueByCell(cell));
	            }
	            if(rowData.size()!=0){
	            	excelData.add(rowData);
	            }
            }
        }
        is.close();
        return excelData;
    }
    //解析excel获取字符串（为空获取）
    public static List<List<String>> getExcelDataString1(String filePath,int startRowNum) throws IOException {
    	List<List<String>> excelData=new ArrayList<List<String>>();
    	InputStream is=new FileInputStream(filePath);
    	HSSFWorkbook wb=new HSSFWorkbook(is);
    	HSSFSheet sheet=wb.getSheetAt(0);
    	evaluator=wb.getCreationHelper().createFormulaEvaluator();
    	int rowNum=sheet.getLastRowNum();
    	for (int i = startRowNum; i <=rowNum; i++) {
    		List<String> rowData=new ArrayList<String>();
    		Row  row=sheet.getRow(i);
    		if(!CommonUtil.checknull(row)){
    			for (int j=0;j<row.getLastCellNum();j++) {
    				Cell cell=row.getCell(j);
    				String v=getCellValueByCell(cell);
    				if(CommonUtil.checknull(v)){
    					v="";
    				}
    				rowData.add(v);
    			}
    			if(rowData.size()!=0){
    				excelData.add(rowData);
    			}
    		}
    	}
    	is.close();
    	return excelData;
    }
    
    
    
    
    
    //向Excel中写数据(若第一行未空，追加一个字符串）
    public static void editExcel(String filePath){
    	try {
	        InputStream is=new FileInputStream(filePath);
	        HSSFWorkbook wb=new HSSFWorkbook(is);
	        HSSFSheet sheet=wb.getSheetAt(0);
	        evaluator=wb.getCreationHelper().createFormulaEvaluator();
	        int rowNum=sheet.getLastRowNum();
	        for (int i = 0; i <=rowNum; i++) {
	            Row  row=sheet.getRow(i);
	            Cell cell = row.getCell(0);
	            if(CommonUtil.checknull(getCellValueByCell(cell))){
	            	cell.setCellValue("-");
	            }
	        }
    		is.close();
	        OutputStream out = null;
            out = new FileOutputStream(filePath);
            wb.write(out);
            out.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    
  //解析excel获取字符串 多个sheet
    public static List<List<String>> getExcelDataStringMulSheet(String filePath,int startRowNum,int sheetIndex) throws IOException {
		List<List<String>> excelData=new ArrayList<List<String>>();
        InputStream is=new FileInputStream(filePath);
        HSSFWorkbook wb=new HSSFWorkbook(is);
        HSSFSheet sheet=wb.getSheetAt(sheetIndex);
        evaluator=wb.getCreationHelper().createFormulaEvaluator();
        int rowNum=sheet.getLastRowNum();
        for (int i = startRowNum; i <=rowNum; i++) {
			List<String> rowData=new ArrayList<String>();
            Row  row=sheet.getRow(i);
            if(!CommonUtil.checknull(row)){
	            for (Cell cell : row) {
	            	rowData.add(getCellValueByCell(cell));
	            }
	            if(rowData.size()!=0){
	            	excelData.add(rowData);
	            }
            }
        }
        is.close();
        return excelData;
    }
    
	 //获取单元格各类型值，返回字符串类型
	private static FormulaEvaluator evaluator;
    private static String getCellValueByCell(Cell cell) {
        //判断是否为null或空串
        if (cell==null || cell.toString().trim().equals("")) {
            return "";
        }
        String cellValue = "";
        int cellType=cell.getCellType();
        if(cellType==Cell.CELL_TYPE_FORMULA){ //表达式类型
            cellType=evaluator.evaluate(cell).getCellType();
        }
        
        switch (cellType) {
        case Cell.CELL_TYPE_STRING: //字符串类型
            cellValue= cell.getStringCellValue().trim();
            cellValue=StringUtils.isEmpty(cellValue) ? "" : cellValue; 
            break;
        case Cell.CELL_TYPE_BOOLEAN:  //布尔类型
            cellValue = String.valueOf(cell.getBooleanCellValue()); 
            break; 
        case Cell.CELL_TYPE_NUMERIC: //数值类型
             if (HSSFDateUtil.isCellDateFormatted(cell)) {  //判断日期类型
                 cellValue =CommonUtil.dateToStr(cell.getDateCellValue(), "yyyy-MM-dd");
             } else {  //否
                 cellValue = new DecimalFormat("#.######").format(cell.getNumericCellValue()); 
             } 
            break;
        default: //其它类型，取空串吧
            cellValue = "";
            break;
        }
        return cellValue;
    }
	
	/**
	 * 根据字典值获取字典码
	 * @return
	 */
	public static String getDict(String dictTypeId,String dictValue){
		DataObject entity=DataObjectUtil.createDataObject("com.fcb.erp.tools.dict.EosDictEntry");
		entity.set("dicttypeid",dictTypeId);
		entity.set("dictname",dictValue);
		DatabaseUtil.expandEntityByTemplate("default", entity, entity);
		return entity.getString("dictid");
	}
	
	/**
	 * 根据单位名称，获取单位ID
	 * @return
	 */
	public static String getOrgId(String orgName){
		DataObject entity=DataObjectUtil.createDataObject("com.hse.organization.orgdataset.OrgOrganization");
		entity.set("orgname",orgName);
		DatabaseUtil.expandEntityByTemplate("default", entity, entity);
		return entity.getString("orgid");
	}
	
	
	public static void main(String[] args) {
		String filePath="C:\\Users\\shc\\Desktop\\新建文件夹\\test\\应急预案导入.xlsx";
		int startRowNum=0;//解析起始行
		List<List<String>> excelData=new ArrayList<List<String>>();
		excelData=getExcelDataString(filePath,startRowNum);;//获取字符串
		//excelData=getExcelDataString1(filePath,startRowNum);//获取字符串（为空设置为空字符串）
	}

	
	
	
	
}

package teamActivity;

import java.awt.Font;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

import com.eos.data.datacontext.UserObject;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import com.fcb.erp.tools.importExport.ExcelTemplate;
import com.fcb.erp.tools.importExport.ExcelUtil;
import com.hse.pub.common.CommonUtil;

import commonj.sdo.DataObject;

/**
 * <pre>
 * Title: 班组活动
 * Description: 班组活动（班组活动计划，班组活动记录）
 * </pre>
 * @author shc 
 * @version 1.00.00
 * 
 */
@Bizlet("TeamActivity")
public class TeamActivity{
	//获取现有excel并设置值和样式（包含合并单元格）  
	@Bizlet("exportData")
	public byte[] exportData(String templateFilename) throws Exception {
		String templateDir = ApplicationContext.getInstance().getWarRealPath()+ "/excel-config/";
		if (!templateDir.endsWith("/")) {
			templateDir += "/";
		}
		String templateFile = templateDir + templateFilename;
		templateFile="D:/ruanjian/EOS/apache-tomcat-9.0.27/webapps/default/excel-config/recordDetailed.xls";
		FileInputStream fileInputStream=new FileInputStream(templateFile); 
        POIFSFileSystem poifsFileSystem=new POIFSFileSystem(fileInputStream);
        HSSFWorkbook Workbook=new HSSFWorkbook(poifsFileSystem);
       // HSSFSheet sheet=Workbook.getSheet("sheet2");  //根据name获取sheet表
        HSSFSheet sheet=Workbook.getSheetAt(0);//获取第n个sheet
        //int rowNum=sheet.getLastRowNum();//最后一行的行号
        setCol(sheet,Workbook,1,1,"斗格项目部");
        setCol(sheet,Workbook,1,4,"中建三局公司");
        setCol(sheet,Workbook,2,1,"线上软件设计");
        setCol(sheet,Workbook,4,0,"实践部");
        setCol(sheet,Workbook,4,2,"施工部");
        setCol(sheet,Workbook,4,4,"信息部");
        setStyle(sheet, Workbook,1,1,1,2);
        setStyle(sheet, Workbook,1,1,4,5);
        setStyle(sheet, Workbook,2,2,1,5);
        setStyle(sheet, Workbook,4,4,0,1);
        setStyle(sheet, Workbook,4,4,2,3);
        setStyle(sheet, Workbook,4,4,4,5);
        setStyle(sheet, Workbook,5,5,1,5);
        setStyle(sheet, Workbook,6,6,1,5);
        setStyle(sheet, Workbook,7,7,1,5);
        setStyle(sheet, Workbook,8,8,1,5);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Workbook.write(out);
		byte[] data = out.toByteArray();
		out.close();
		return data;
	}
	/**
	 * 设置单元格的值（如果是合并单元格只需要设置最前行和最前列）
	 */
	public void setCol(HSSFSheet sheet, HSSFWorkbook Workbook,int rowNum,int colNum,String str){
		HSSFRow row=sheet.getRow(rowNum);  
		HSSFCell cell=row.createCell(colNum);
		cell.setCellValue(str); //设置该行中某一单元格的值
		//setCellStyle(Workbook,cell);
	}
	
	/**
	 * 设置某个单元格样式
	 */
	public void setCellStyle(HSSFWorkbook Workbook,HSSFCell cell){
		HSSFCellStyle cellStyle = Workbook.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
        cell.setCellStyle(cellStyle);
	}
	
	/**
	 * 设置合并单元格样式
	 */
	public void setStyle(HSSFSheet sheet,HSSFWorkbook Workbook,int i1,int i2,int i3,int i4){
		CellRangeAddress cra =new CellRangeAddress(i1, i2, i3, i4); // 起始行, 终止行, 起始列, 终止列
		sheet.addMergedRegion(cra);
		// 使用RegionUtil类为合并后的单元格添加边框
		RegionUtil.setBorderBottom(1, cra, sheet, Workbook); // 下边框
		RegionUtil.setBorderLeft(1, cra, sheet, Workbook); // 左边框
		RegionUtil.setBorderRight(1, cra, sheet,Workbook); // 有边框
		RegionUtil.setBorderTop(1, cra, sheet,Workbook); // 上边框
	}
		
}

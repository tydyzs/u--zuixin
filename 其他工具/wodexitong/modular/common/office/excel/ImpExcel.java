package cn.stylefeng.guns.modular.common.office.excel;

import cn.stylefeng.guns.modular.common.util.CommonUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

public class ImpExcel {
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
            Row row=sheet.getRow(i);
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
                cellValue= StringUtils.isEmpty(cellValue) ? "" : cellValue;
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
}

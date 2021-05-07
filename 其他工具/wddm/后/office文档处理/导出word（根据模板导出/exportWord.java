package com.hse.workmanager.emergencyManage;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTShd;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STVerticalJc;

import com.eos.system.annotation.Bizlet;
import com.hse.pub.common.CommonUtil;

import commonj.sdo.DataObject;

@Bizlet("导出word")
public class exportWord {

	/**
	 * 应急管理导出word公共方法
	 * @param resData 列表数据
	 * @param param 参数
	 * @return
	 */
	@Bizlet("exportWord")
	public static byte[] exportExcel(DataObject[] resData,DataObject param) throws Exception {
		byte[] res={};
		String wordType=param.getString("wordType");
		//应急组织机构导出word
		if("yjzzjg".equals(wordType)){
			res=yjzzjg(resData);
		}
		//应急救援队伍
		if("yjjydw".equals(wordType)){
			res=yjjydw(resData);
		}
		//应急专家库名录
		if("yjzjkml".equals(wordType)){
			res=yjzjkml(resData);
		}
		//应急物资
		if("yjwz".equals(wordType)){
			res=yjwz(resData);
		}
		//应急预案
		if("yjya".equals(wordType)){
			res=yjya(resData);
		}
		return res;
	}
	
	/**
	 * 应急预案数据分组
	 */
	public static Map<String,List<DataObject>> groupYjya(DataObject[] resData){
		Map<String,List<DataObject>> map=new HashMap<String,List<DataObject>>();
		List<DataObject> reservePlanType1=new ArrayList<DataObject>();
		List<DataObject> reservePlanType21=new ArrayList<DataObject>();
		List<DataObject> reservePlanType22=new ArrayList<DataObject>();
		List<DataObject> reservePlanType23=new ArrayList<DataObject>();
		List<DataObject> reservePlanType24=new ArrayList<DataObject>();
		List<DataObject> reservePlanType3=new ArrayList<DataObject>();
		map.put("reservePlanType1", reservePlanType1);
		map.put("reservePlanType21", reservePlanType21);
		map.put("reservePlanType22", reservePlanType22);
		map.put("reservePlanType23", reservePlanType23);
		map.put("reservePlanType24", reservePlanType24);
		map.put("reservePlanType3", reservePlanType3);
		for(int i=0;i<resData.length;i++){
			DataObject data_i=resData[i];
			String reservePlanType=data_i.getString("RESERVE_PLAN_TYPE");
			String specialReservePlan=data_i.getString("SPECIAL_RESERVE_PLAN");
			if(!"2".equals(reservePlanType)){
				map.get("reservePlanType"+reservePlanType).add(data_i);
			}else{
				map.get("reservePlanType"+reservePlanType+specialReservePlan).add(data_i);
			}
		}
		return map;
	}
	
	/**
	 * 应急预案
	 * @param resData
	 * @param param
	 * @return
	 * @throws Exception
	 */
	private static int zxyjyaNum=1;
	public static byte[] yjya(DataObject[] resData) throws Exception{
		//数据分组
		Map<String,List<DataObject>> map=groupYjya(resData);
		//创建word
		XWPFDocument doc= new XWPFDocument();
		//添加标题
		XWPFParagraph titleParagraph = doc.createParagraph();
		//设置段落居中
		titleParagraph.setAlignment(ParagraphAlignment.CENTER);
		XWPFRun titleParagraphRun = titleParagraph.createRun();
		titleParagraphRun.setText("应急预案清单");
		titleParagraphRun.setColor("000000");
		titleParagraphRun.setFontSize(18);
		titleParagraphRun.setBold(true);
		
		XWPFTable table = doc.createTable(resData.length+4, 4);
		//设置列宽
		int[] cellWidthArr={360*2,360*5,360*8,360*5};
		setCellWidth(table,cellWidthArr);
		
		int rowNum=0;//记录当前行号
		//列头		
		XWPFTableRow row0=table.getRow(rowNum);
		setCellText(row0.getCell(0), "序号", "CCCCCC", cellWidthArr[0]);  
		setCellText(row0.getCell(1), "预案名称", "CCCCCC", cellWidthArr[1]);  
		setCellText(row0.getCell(2), "预案名称", "CCCCCC", cellWidthArr[2]);  
		setCellText(row0.getCell(3), "预案编号", "CCCCCC", cellWidthArr[3]);  
		mergeCellsHorizontal(table,rowNum,1,2);
		rowNum++;
		//开始写入数据
		List<DataObject> listObj=map.get("reservePlanType1");
		rowNum=setYjyaTableCol(listObj,rowNum,table,"突发事件总体应急预案","一",cellWidthArr);
		
		XWPFTableRow row1=table.getRow(rowNum);
		setCellText(row1.getCell(0), "二", "", cellWidthArr[0]);  
		setCellText(row1.getCell(1), "专项应急预案", "eeeeee", cellWidthArr[1]);  
		setCellText(row1.getCell(2), "专项应急预案", "eeeeee", cellWidthArr[2]);  
		setCellText(row1.getCell(3), "", "eeeeee", cellWidthArr[3]);  
		mergeCellsHorizontal(table,rowNum,1,3);
		rowNum++;
		
		zxyjyaNum=1;
		listObj=map.get("reservePlanType21");
		rowNum=setYjyaTableCol1(listObj,rowNum,table,"自然灾害类");
		listObj=map.get("reservePlanType22");
		rowNum=setYjyaTableCol1(listObj,rowNum,table,"事故灾害类");
		listObj=map.get("reservePlanType23");
		rowNum=setYjyaTableCol1(listObj,rowNum,table,"公共卫生事件类");
		listObj=map.get("reservePlanType24");
		rowNum=setYjyaTableCol1(listObj,rowNum,table,"社会安全事件类");
		
		listObj=map.get("reservePlanType3");
		rowNum=setYjyaTableCol(listObj,rowNum,table,"现场处置方案","三",cellWidthArr);
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		doc.write(out);
		byte[] res=out.toByteArray();
		return res;
	}
	//应急预案设置表格数据（普通预案类型）
	public static int setYjyaTableCol(List<DataObject> listObj,int rowNum,XWPFTable table,String typeName,String typeNum,int[] cellWidthArr){
		XWPFTableRow row1=table.getRow(rowNum);
		setCellText(row1.getCell(0), typeNum, "", cellWidthArr[0]);  
		setCellText(row1.getCell(1), typeName, "eeeeee", cellWidthArr[1]);  
		setCellText(row1.getCell(2), typeName, "eeeeee", cellWidthArr[2]);  
		setCellText(row1.getCell(3), "", "eeeeee", cellWidthArr[3]);  
		mergeCellsHorizontal(table,rowNum,1,3);
		rowNum++;
		
		if(listObj.size()>0){
			XWPFTableRow row_n;
			for (int j = 0; j < listObj.size(); j++) {
				DataObject obj_j=listObj.get(j);
				row_n =table.getRow(rowNum);
				row_n.getCell(0).setText(j+1+"");
				row_n.getCell(1).setText((String)CommonUtil.changeNull(obj_j.getString("RESERVE_PLAN_NAME"), ""));
				row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("RESERVE_PLAN_NAME"), ""));
				row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("RESERVE_PLAN_CODE"), ""));
				mergeCellsHorizontal(table,rowNum,1,2);
				rowNum++;
			}
		}
		return rowNum;
	}
	//应急预案设置表格数据（专项应急预案）
	public static int setYjyaTableCol1(List<DataObject> listObj,int rowNum,XWPFTable table,String typeName){
		int rowNumBegin=rowNum;
		if(listObj.size()>0){
			XWPFTableRow row_n;
			for (int j = 0; j < listObj.size(); j++) {
				DataObject obj_j=listObj.get(j);
				row_n =table.getRow(rowNum);
				//row_n.getCell(0).setText(j+1+"");
				row_n.getCell(0).setText(zxyjyaNum+"");
				row_n.getCell(1).setText(typeName);
				row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("RESERVE_PLAN_NAME"), ""));
				row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("RESERVE_PLAN_CODE"), ""));
				rowNum++;
				zxyjyaNum++;
			}
		}
		int rowNumEnd=rowNum;
		mergeCellsVertically(table,1,rowNumBegin,rowNumEnd);
		return rowNum;
	}
	
	
	
	/**
	 * 应急物资
	 * @param resData
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static byte[] yjwz(DataObject[] resData) throws Exception{
		//创建word
		XWPFDocument doc= new XWPFDocument();
		//添加标题
		XWPFParagraph titleParagraph = doc.createParagraph();
		//设置段落居中
		titleParagraph.setAlignment(ParagraphAlignment.CENTER);
		XWPFRun titleParagraphRun = titleParagraph.createRun();
		titleParagraphRun.setText("应急设施、装备、物资清单");
		titleParagraphRun.setColor("000000");
		titleParagraphRun.setFontSize(18);
		titleParagraphRun.setBold(true);
		
		XWPFTable table = doc.createTable(resData.length+1, 8);
		XWPFTableRow row1=table.getRow(0);
		setCellText(row1.getCell(0), "序号", "CCCCCC", 1600);  
		setCellText(row1.getCell(1), "名称", "CCCCCC", 1600);  
		setCellText(row1.getCell(2), "数量", "CCCCCC", 1600);  
		setCellText(row1.getCell(3), "型号", "CCCCCC", 1600);  
		setCellText(row1.getCell(4), "存放位置", "CCCCCC", 1600);  
		setCellText(row1.getCell(5), "负责人", "CCCCCC", 1600);  
		setCellText(row1.getCell(6), "联系方式", "CCCCCC", 1600);  
		setCellText(row1.getCell(7), "所属单位", "CCCCCC", 1600);  
		//设置列宽
		int[] cellWidthArr={360*2,360*5,360*5,360*5,360*5,360*5,360*5,360*8};
		setCellWidth(table,cellWidthArr);
		//开始写入数据
		XWPFTableRow row_n;
		for (int j = 0; j < resData.length; j++) {
			DataObject obj_j=resData[j];
			row_n =table.getRow(j+1);
			row_n.getCell(0).setText(j+1+"");
			row_n.getCell(1).setText((String)CommonUtil.changeNull(obj_j.getString("MATERIAL_NAME"), ""));
			row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("DEPOSIT_NUM"), ""));
			row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("MATERIAL_MODEL"), ""));
			row_n.getCell(4).setText((String)CommonUtil.changeNull(obj_j.getString("DEPOSIT_PLACE"), ""));
			row_n.getCell(5).setText((String)CommonUtil.changeNull(obj_j.getString("PERSON_LIABLE_NAME"), ""));
			row_n.getCell(6).setText((String)CommonUtil.changeNull(obj_j.getString("PERSON_LIABLE_MOBILENO"), ""));
			row_n.getCell(7).setText((String)CommonUtil.changeNull(obj_j.getString("ORGNAME"), ""));
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		doc.write(out);
		byte[] res=out.toByteArray();
		return res;
	}
	/**
	 * 应急专家库名录
	 * @param resData
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static byte[] yjzjkml(DataObject[] resData) throws Exception{
		//创建word
    	XWPFDocument doc= new XWPFDocument();
    	//添加标题
    	XWPFParagraph titleParagraph = doc.createParagraph();
    	//设置段落居中
    	titleParagraph.setAlignment(ParagraphAlignment.CENTER);
    	XWPFRun titleParagraphRun = titleParagraph.createRun();
    	titleParagraphRun.setText("应急专家库名录");
    	titleParagraphRun.setColor("000000");
    	titleParagraphRun.setFontSize(18);
    	titleParagraphRun.setBold(true);
    	
		//数据类型分组
		List<DataObject> expertType1=new ArrayList<DataObject>();
		List<DataObject> expertType2=new ArrayList<DataObject>();
		List<DataObject> expertType3=new ArrayList<DataObject>();
		List<DataObject> expertType4=new ArrayList<DataObject>();
		for(DataObject obj:resData){
			String expertTypeDict=obj.getString("EXPERT_TYPE_DICT");
			//自然灾害
			if("1".equals(expertTypeDict)){
				expertType1.add(obj);
			}
			//事故灾难
			if("2".equals(expertTypeDict)){
				expertType2.add(obj);
			}
			//公共卫生事件
			if("3".equals(expertTypeDict)){
				expertType3.add(obj);
			}
			//社会安全事件
			if("4".equals(expertTypeDict)){
				expertType4.add(obj);
			}
		}
		int tableLength=1+(expertType1.size()>0?expertType1.size()+1:0)
						+(expertType2.size()>0?expertType2.size()+1:0)
						+(expertType3.size()>0?expertType3.size()+1:0)
						+(expertType4.size()>0?expertType4.size()+1:0);
		//创建表格
		XWPFTable table = doc.createTable(tableLength, 6);
    	XWPFTableRow row1=table.getRow(0);
		setCellText(row1.getCell(0), "序号", "CCCCCC", 1600);  
		setCellText(row1.getCell(1), "姓名", "CCCCCC", 1600);  
		setCellText(row1.getCell(2), "职称", "CCCCCC", 1600);  
		setCellText(row1.getCell(3), "专业", "CCCCCC", 1600);  
		setCellText(row1.getCell(4), "联系电话", "CCCCCC", 1600);  
		setCellText(row1.getCell(5), "常驻地址", "CCCCCC", 1600);  
		//设置列宽
		int[] cellWidthArr={360*2,360*5,360*5,360*5,360*5,360*8};
		setCellWidth(table,cellWidthArr);
		//开始写入数据
		int titleRowNum=1;
		String title="";
		if(expertType1.size()>0){
			title="一、自然灾害类突发事件应急专家";
			yjzjkmlSetData(expertType1,1,title,titleRowNum,table);
			titleRowNum+=expertType1.size()+1;
		}
		if(expertType2.size()>0){
			title="二、事故灾害类突发事件应急专家";
			yjzjkmlSetData(expertType2,2,title,titleRowNum,table);
			titleRowNum+=expertType2.size()+1;
		}
		if(expertType3.size()>0){
			title="三、公共卫生事件类突发事件应急专家";
			yjzjkmlSetData(expertType3,3,title,titleRowNum,table);
			titleRowNum+=expertType3.size()+1;
		}
		if(expertType4.size()>0){
			title="四、社会安全事件类突发事件应急专家";
			yjzjkmlSetData(expertType4,4,title,titleRowNum,table);
			titleRowNum+=expertType4.size()+1;
		}
    	ByteArrayOutputStream out = new ByteArrayOutputStream();
    	doc.write(out);
    	byte[] res=out.toByteArray();
		return res;
	}
	/**
	 * 应急专家库写入数据
	 * @param resData
	 * @return
	 */
	public static void yjzjkmlSetData(List<DataObject> expertTypeData,int type,String title,int titleRowNum,XWPFTable table){
		XWPFTableRow row_n;
		//设置标题
		mergeCellsHorizontal(table,titleRowNum, 0,5);
		table.getRow(titleRowNum).getCell(0).setText(title);
		
		XWPFTableCell cell = table.getRow(titleRowNum).getCell(0);
		CTTc cttc = cell.getCTTc();
		CTTcPr ctPr = cttc.addNewTcPr();
		ctPr.addNewVAlign().setVal(STVerticalJc.CENTER);
		cttc.getPList().get(0).addNewPPr().addNewJc().setVal(STJc.CENTER);
		table.getRow(titleRowNum).setHeight(500);
		//写入数据
		for (int j = 0; j < expertTypeData.size(); j++) {
			DataObject obj_j=expertTypeData.get(j);
			row_n =table.getRow(titleRowNum+j+1);
			row_n.getCell(0).setText(j+1+"");
			row_n.getCell(1).setText((String)CommonUtil.changeNull(obj_j.getString("EXPERT_NAME"), ""));
			row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("POSITIONAL_TITLES"), ""));
			row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("MAJOR"), ""));
			row_n.getCell(4).setText((String)CommonUtil.changeNull(obj_j.getString("CONTACT_NUMBER"), ""));
			row_n.getCell(5).setText((String)CommonUtil.changeNull(obj_j.getString("PERMANENT_ADDRESS"), ""));
		}
	}
	/**
	 * 应急救援队伍
	 * @param resData
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static byte[] yjjydw(DataObject[] resData) throws Exception{
		//创建word
		XWPFDocument doc= new XWPFDocument();
		//添加标题
		XWPFParagraph titleParagraph = doc.createParagraph();
		//设置段落居中
		titleParagraph.setAlignment(ParagraphAlignment.CENTER);
		XWPFRun titleParagraphRun = titleParagraph.createRun();
		titleParagraphRun.setText("应急救援队伍名单");
		titleParagraphRun.setColor("000000");
		titleParagraphRun.setFontSize(18);
		titleParagraphRun.setBold(true);
		
		XWPFTable table = doc.createTable(resData.length+1, 5);
		XWPFTableRow row1=table.getRow(0);
		setCellText(row1.getCell(0), "序号", "CCCCCC", 1600);  
		setCellText(row1.getCell(1), "姓名", "CCCCCC", 1600);  
		setCellText(row1.getCell(2), "工种", "CCCCCC", 1600);  
		setCellText(row1.getCell(3), "所在部门", "CCCCCC", 1600);  
		setCellText(row1.getCell(4), "联系电话", "CCCCCC", 1600);  
		//设置列宽
		int[] cellWidthArr={360*2,360*5,360*5,360*8,360*5};
		setCellWidth(table,cellWidthArr);
		//开始写入数据
		XWPFTableRow row_n;
		for (int j = 0; j < resData.length; j++) {
			DataObject obj_j=resData[j];
			row_n =table.getRow(j+1);
			row_n.getCell(0).setText(j+1+"");
			row_n.getCell(1).setText((String)CommonUtil.changeNull(obj_j.getString("EMPNAME"), ""));
			row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("STATION"), ""));
			row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("DEPARTNAME"), ""));
			row_n.getCell(4).setText((String)CommonUtil.changeNull(obj_j.getString("MOBILENO"), ""));
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		doc.write(out);
		byte[] res=out.toByteArray();
		return res;
	}
	/**
	 * 
	 * @param cell
	 * @param text
	 * @param bgcolor
	 * @param width
	 */
    public static void setCellText(XWPFTableCell cell,String text, String bgcolor, int width) {  
        CTTc cttc = cell.getCTTc();  
        CTTcPr cellPr = cttc.addNewTcPr();  
        cellPr.addNewTcW().setW(BigInteger.valueOf(width));  
        //cell.setColor(bgcolor);  
        CTTcPr ctPr = cttc.addNewTcPr();  
        CTShd ctshd = ctPr.addNewShd();  
        ctshd.setFill(bgcolor);  
        ctPr.addNewVAlign().setVal(STVerticalJc.CENTER);  
        cttc.getPList().get(0).addNewPPr().addNewJc().setVal(STJc.CENTER);  
        cell.setText(text);  
    }  
	/**
	 * 应急组织机构导出word
	 * @param resData
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static byte[] yjzzjg(DataObject[] resData) throws Exception{
		//创建word
		XWPFDocument doc= new XWPFDocument();
		//添加标题
		XWPFParagraph titleParagraph = doc.createParagraph();
		//设置段落居中
		titleParagraph.setAlignment(ParagraphAlignment.CENTER);
		XWPFRun titleParagraphRun = titleParagraph.createRun();
		titleParagraphRun.setText("应急组织机构成员台帐");
		titleParagraphRun.setColor("000000");
		titleParagraphRun.setFontSize(18);
		titleParagraphRun.setBold(true);
		
		XWPFTable table = doc.createTable(resData.length+1, 4);
		XWPFTableRow row1=table.getRow(0);
		setCellText(row1.getCell(0), "机构名称", "CCCCCC", 1600);  
		setCellText(row1.getCell(1), "职务", "CCCCCC", 1600);  
		setCellText(row1.getCell(2), "姓名", "CCCCCC", 1600);  
		setCellText(row1.getCell(3), "联系电话", "CCCCCC", 1600);  
		//设置列宽
		int[] cellWidthArr={360*8,360*5,360*5,360*5};
		setCellWidth(table,cellWidthArr);
		//合并单元格
		String organizationDataId_start="";
		String postId_start="";
		int startNumOrg=1;
		int startNumPost=1;
		for(int j=1;j<=resData.length;j++){
			//String organizationDataId=resData[j-1].getString("ORGANIZATION_DATA_ID");
			String organizationDataId=resData[j-1].getString("EMERGENCY_ORGANIZATION_NAME");
			String postId=resData[j-1].getString("POST_ID");
			//组织机构合并
			if(!organizationDataId_start.equals(organizationDataId)){//组织机构与上一条数据相同
				//出现不同
				organizationDataId_start=organizationDataId;
				if(j!=1){
					mergeCellsVertically(table,0,startNumOrg,j-1);
					startNumOrg=j;
				}
			}
			//职务合并
			if(!postId_start.equals(postId)){//组织机构与上一条数据相同，且职务相同
				postId_start=postId;
				if(j!=1){
					mergeCellsVertically(table,1,startNumPost,j-1);
					startNumPost=j;
				}
			}
			if(startNumOrg!=j){
				mergeCellsVertically(table,0,startNumOrg,j);
			}
			if(startNumPost!=j){
				mergeCellsVertically(table,1,startNumPost,j);
			}
		}
		XWPFTableRow row_n;
		for (int j = 0; j < resData.length; j++) {
			DataObject obj_j=resData[j];
			row_n =table.getRow(j+1);
			row_n.getCell(0).setText((String)CommonUtil.changeNull(obj_j.getString("EMERGENCY_ORGANIZATION_NAME"), ""));
			row_n.getCell(1).setText((String)CommonUtil.changeNull(obj_j.getString("EMERGENCY_POST"), ""));
			row_n.getCell(2).setText((String)CommonUtil.changeNull(obj_j.getString("EMPNAME"), ""));
			row_n.getCell(3).setText((String)CommonUtil.changeNull(obj_j.getString("MOBILENO"), ""));
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		doc.write(out);
		byte[] res=out.toByteArray();
		return res;
	}
	/**
	 *  word跨行并单元格
	 * @param table 
	 * @param col 合并列号
	 * @param fromRow 起始行号
	 * @param toRow 结束行号
	 */
	public static void mergeCellsVertically(XWPFTable table, int col, int fromRow, int toRow) {  
        for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {  
            XWPFTableCell cell = table.getRow(rowIndex).getCell(col);  
            if ( rowIndex == fromRow ) {  
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.RESTART);  
            } else {  
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE);  
            }  
        }  
    }
	/**
	 *  跨列合并
	 */
	public  static void mergeCellsHorizontal(XWPFTable table, int row, int fromCell, int toCell) {
        for (int cellIndex = fromCell; cellIndex <= toCell; cellIndex++) {
            XWPFTableCell cell = table.getRow(row).getCell(cellIndex);
            if ( cellIndex == fromCell ) {
                // The first merged cell is set with RESTART merge value
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART);
            } else {
                // Cells which join (merge) the first one, are set with CONTINUE
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.CONTINUE);
            }
        }
	}
	/**
	 * 设置表格列宽
	 */
	public static void setCellWidth(XWPFTable table,int[] cellWidthArr){
		List<XWPFTableRow> rows=table.getRows();
		for(XWPFTableRow row:rows){
			for(int i=0;i<cellWidthArr.length;i++){
				CTTcPr tcpr = row.getCell(i).getCTTc().addNewTcPr();
				CTTblWidth cellw = tcpr.addNewTcW();
				cellw.setType(STTblWidth.DXA);
				cellw.setW(BigInteger.valueOf(cellWidthArr[i]));
			}
		}
	}
}

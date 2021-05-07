package com.hse.pub.doc.word;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.TextAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlToken;
import org.openxmlformats.schemas.drawingml.x2006.main.CTNonVisualDrawingProps;
import org.openxmlformats.schemas.drawingml.x2006.main.CTPositiveSize2D;
import org.openxmlformats.schemas.drawingml.x2006.wordprocessingDrawing.CTInline;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTP;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTPPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STJc;
//import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
  
/** shc20201109
 * 适用于word 2007 
 * poi 版本 3.7 
 */  
public class WordUtil {
    /**
     *适用于word 2007
     * @param param   需要替换的参数
     * @param template 模板
     */
    public static XWPFDocument generateWord(Map<String, Object> param, String template) {
        XWPFDocument doc = null;
        try {
            OPCPackage pack = POIXMLDocument.openPackage(template);//通过路径获取word模板
            doc = new CustomXWPFDocument(pack);
            //通过InputStream 获取模板，此方法适用于jar包部署
          //  doc = new CustomXWPFDocument(template);
            if (param != null && param.size() > 0) {
                //处理段落
                List<XWPFParagraph> paragraphList = doc.getParagraphs();
                processParagraphs(paragraphList, param, doc);
                //处理表格
                Iterator<XWPFTable> it = doc.getTablesIterator();
                while (it.hasNext()) {
                    XWPFTable table = it.next();
                    List<XWPFTableRow> rows = table.getRows();
                    for (XWPFTableRow row : rows) {
                        List<XWPFTableCell> cells = row.getTableCells();
                        for (XWPFTableCell cell : cells) {
                            List<XWPFParagraph> paragraphListTable = cell.getParagraphs();
                            processParagraphs(paragraphListTable, param, doc);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doc;
    }

    /**
     * 处理段落
     * @param paragraphList
     * @throws FileNotFoundException
     * @throws InvalidFormatException
     */
    public static void processParagraphs(List<XWPFParagraph> paragraphList, Map<String, Object> param, XWPFDocument doc) throws InvalidFormatException, FileNotFoundException {
        if (paragraphList != null && paragraphList.size() > 0) {
            for (XWPFParagraph paragraph : paragraphList) {
                List<XWPFRun> runs = paragraph.getRuns();
                for (XWPFRun run : runs) {
                    String text = run.getText(0);
                    if (text != null) {
                        boolean isSetText = false;
                        for (Entry<String, Object> entry : param.entrySet()) {
                            //String key = "${" + entry.getKey() + "}";
                            String key = entry.getKey();
                            if (text.indexOf(key) != -1) {
                                isSetText = true;
                                Object value = entry.getValue();
                                if (value instanceof String) {//文本替换
                                	String[] str=((String) value).split("\n");
                                	if(str!=null&&str.length>1){
                                		isSetText=false;
                                		run.setText(str[0], 0); // set first line into XWPFRun
        				                for(int i=1;i<str.length;i++){
        				                    run.addBreak();//中断
        				                    run.setText(str[i]);
        				                }
                                	}else{
                                        text = text.replace(key, value.toString());
                                	}

                                } else if (value instanceof Map) {    //图片替换
                                    text = text.replace(key, "");
                                    Map pic = (Map) value;
                                    int width = Integer.parseInt(pic.get("width").toString());
                                    int height = Integer.parseInt(pic.get("height").toString());
                                    int picType = getPictureType(pic.get("type").toString());
                                    //获取图片流，因本人项目中适用流
                                    //InputStream is = (InputStream) pic.get("content");
                                    String byteArray = (String) pic.get("content");
                                    CTInline inline = run.getCTR().addNewDrawing().addNewInline();
                                    insertPicture(doc, byteArray, inline, width, height,picType);
                                 
                                }
                            }
                        }
                        if (isSetText) {
                            run.setText(text, 0);
                        }
                    }
                }
            }
        }
    }

    /**
     * 获取图片对应类型代码
     * @param picType
     * @return int
     */
    private static int getPictureType(String picType) {
        int res = CustomXWPFDocument.PICTURE_TYPE_PICT;
        if (picType != null) {
            if (picType.equalsIgnoreCase("png")) {
                res = CustomXWPFDocument.PICTURE_TYPE_PNG;
            } else if (picType.equalsIgnoreCase("dib")) {
                res = CustomXWPFDocument.PICTURE_TYPE_DIB;
            } else if (picType.equalsIgnoreCase("emf")) {
                res = CustomXWPFDocument.PICTURE_TYPE_EMF;
            } else if (picType.equalsIgnoreCase("jpg") || picType.equalsIgnoreCase("jpeg")) {
                res = CustomXWPFDocument.PICTURE_TYPE_JPEG;
            } else if (picType.equalsIgnoreCase("wmf")) {
                res = CustomXWPFDocument.PICTURE_TYPE_WMF;
            }
        }
        return res;
    }

    /**
     * insert Picture
     * @param document
     * @param filePath
     * @param inline
     * @param width
     * @param height
     * @throws InvalidFormatException
     * @throws FileNotFoundException
     */
    private static void insertPicture(XWPFDocument document, String filePath,
                                      CTInline inline, int width,
                                      int height,int imgType) throws InvalidFormatException,
            FileNotFoundException {
            //通过流获取图片，因本人项目中，是通过流获取
        //document.addPictureData(imgFile,imgType);
        document.addPictureData(new FileInputStream(filePath),imgType);
        int id = document.getAllPictures().size() - 1;
        final int EMU = 9525;
        width *= EMU;
        height *= EMU;
        String blipId =
                document.getAllPictures().get(id).getPackageRelationship().getId();
        String picXml = getPicXml(blipId, width, height);
        XmlToken xmlToken = null;
        try {
            xmlToken = XmlToken.Factory.parse(picXml);
        } catch (XmlException xe) {
            xe.printStackTrace();
        }
        inline.set(xmlToken);
        inline.setDistT(0);
        inline.setDistB(0);
        inline.setDistL(0);
        inline.setDistR(0);
        CTPositiveSize2D extent = inline.addNewExtent();
        extent.setCx(width);
        extent.setCy(height);
        CTNonVisualDrawingProps docPr = inline.addNewDocPr();
        docPr.setId(id);
        docPr.setName("IMG_" + id);
        docPr.setDescr("IMG_" + id);
    }

    /**
     * get the xml of the picture
     *
     * @param blipId
     * @param width
     * @param height
     * @return
     */
    private static String getPicXml(String blipId, int width, int height) {
        String picXml =
                "" + "<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">" +
                        "   <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" +
                        "      <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" +
                        "         <pic:nvPicPr>" + "            <pic:cNvPr id=\"" + 0 +
                        "\" name=\"Generated\"/>" + "            <pic:cNvPicPr/>" +
                        "         </pic:nvPicPr>" + "         <pic:blipFill>" +
                        "            <a:blip r:embed=\"" + blipId +
                        "\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\"/>" +
                        "            <a:stretch>" + "               <a:fillRect/>" +
                        "            </a:stretch>" + "         </pic:blipFill>" +
                        "         <pic:spPr>" + "            <a:xfrm>" +
                        "               <a:off x=\"0\" y=\"0\"/>" +
                        "               <a:ext cx=\"" + width + "\" cy=\"" + height +
                        "\"/>" + "            </a:xfrm>" +
                        "            <a:prstGeom prst=\"rect\">" +
                        "               <a:avLst/>" + "            </a:prstGeom>" +
                        "         </pic:spPr>" + "      </pic:pic>" +
                        "   </a:graphicData>" + "</a:graphic>";
        return picXml;
    }
    
    /**
     * set table
     * @param args
     * @throws Exception
     */
    public static XWPFDocument setTable(XWPFDocument document,List<List<String>> data){
	    	//获取所有表格
	    	List<XWPFTable> tables = document.getTables();
	    	//这里取第一个表格
	    	XWPFTable table = tables.get(0);
	    	//表格的插入行
	    	for (int i = 0; i < data.size(); i++) {//遍历要添加的数据的list
	             XWPFTableRow newRow = table.insertNewTableRow(i+1);//为表格添加行
	             List<String> strings =  data.get(i);//获取list中的字符串数组
	             for (int j = 0; j < strings.size(); j++) {//遍历list中的字符串数组
	                 String strings1 =  strings.get(j);
	                 newRow.createCell();//在新增的行上面创建cell
	                 newRow.getCell(j).setText(strings1);//给每个cell赋值。
	             }
	    	}
	    	return document;
    }
    
    /**
     * set table
     * @param args
     * @throws Exception
     */
    public static XWPFDocument setTableByHid(XWPFDocument document,List<List<String>> data){
	    	//获取所有表格
	    	List<XWPFTable> tables = document.getTables();
	    	//这里取第一个表格
	    	XWPFTable table = tables.get(0);
	    	//XWPFParagraph p = document.createParagraph();
	    	//表格的插入行
	    	for (int i = 0; i < data.size(); i++) {//遍历要添加的数据的list
	             XWPFTableRow newRow = table.insertNewTableRow(i+5);//为表格添加行
	             List<String> strings =  data.get(i);//获取list中的字符串数组
	             for (int j = 0; j < strings.size(); j++) {//遍历list中的字符串数组
	                 String strings1 =  strings.get(j);
	                 newRow.createCell();//在新增的行上面创建cell
	                 XWPFTableCell cell0 = newRow.getCell(j);
	                 XWPFParagraph p = cell0.getParagraphs().get(0);
	     	    	 XWPFRun headRun0 = p.createRun();
	                 headRun0.setText(strings1);
	                 headRun0.setFontSize(8);
	                 headRun0.setBold(false);
//	                 headRun0.setFontFamily("仿宋");
	                 p.setVerticalAlignment(TextAlignment.CENTER);
	                 p.setAlignment(ParagraphAlignment.CENTER);
	             }
	    	}
	    	return document;
    }
    
    public static void mergeCells (XWPFTable table, int col, int fromRow, int toRow){
    	 for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++)
         {
             XWPFTableCell cell = table.getRow(rowIndex).getCell(col);

             CTTc cttc = cell.getCTTc();
             if (cttc.getTcPr() == null)
             {
                 cttc.addNewTcPr();
             }


             //第一个合并单元格用重启合并值设置
             if (rowIndex == fromRow)
             {
//            	 cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART); 
//               cell.getCTTc().addNewTcPr().addNewVMerge().val = ST_Merge.restart;

             }
             else
             {
                 //合并第一个单元格的单元被设置为“继续”
//            	 cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE); 

             }

         }
    	
    }
    
    public static void main(String[] args) throws Exception {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("projectName","合规性分析测试");
		param.put("SUBSIDIARY","总体规划");
		param.put("nonConstrArea","25438834.17");
		param.put("constrArea","0.00");
		Map<String,Object> header = new HashMap<String, Object>();
		header.put("width", 556);
		header.put("height", 230);
		header.put("type", "png");
		header.put("content", "e:\\aa.png");//图片路径
		param.put("IMAGE1",header);
		//1.替换模板中的文字
		XWPFDocument doc = WordUtil.generateWord(param, "D:\\primeton\\111\\apache-tomcat-9.0.27\\apache-tomcat-9.0.27\\webapps\\default\\excel-config\\退场人员导出台账.docx");
		
		//2.获取指定表格并追加行(setTable方法默认获取第一个表格从第一行开始追加数据)
		List<List<String>> dataList=null;
        doc = setTable(doc, dataList);
		
		
		FileOutputStream fopts = new FileOutputStream("D:\\test.docx");
		doc.write(fopts);
		fopts.close();
	}

    
}



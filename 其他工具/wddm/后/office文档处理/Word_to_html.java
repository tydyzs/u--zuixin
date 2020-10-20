package com.tgb.sm_test;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.lang.model.util.Elements;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.usermodel.Document;
import org.springframework.util.ResourceUtils;
import org.springframework.web.util.HtmlUtils;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.tgb.util.WordExcel_html_util.CustomXWPFDocument;
import com.tgb.util.WordExcel_html_util.OfficeUtil;

public class WordExcel_html
{

 //将html字符串生成word文件
 public static String writeWordFile(String content) {
     String path = "D:/wordFile";
     Map<String, Object> param = new HashMap<String, Object>();

     if (!"".equals(path)) {
         File fileDir = new File(path);
         if (!fileDir.exists()) {
             fileDir.mkdirs();
         }
         content = HtmlUtils.htmlUnescape(content);
         try {
             // 生成doc格式的word文档，需要手动改为docx
             byte by[] = content.getBytes("gbk");
             ByteArrayInputStream bais = new ByteArrayInputStream(by);
             POIFSFileSystem poifs = new POIFSFileSystem();
             DirectoryEntry directory = poifs.getRoot();
             DocumentEntry documentEntry = directory.createDocument("WordDocument", bais);
             FileOutputStream ostream = new FileOutputStream("D:\\test.doc");
             poifs.writeFilesystem(ostream);
             bais.close();
             ostream.close();

         } catch (Exception e) {
             e.printStackTrace();
         }

     }
     return "D:/wordFile/final.docx";
 }
	 //html文件获取html字符串
 public static String readfile(String filePath){
	         File file = new File(filePath);  
	         InputStream input = null;
	         try {
	             input = new FileInputStream(file);
	         } catch (FileNotFoundException e) {
	             e.printStackTrace();
	         }  
	         StringBuffer buffer = new StringBuffer();  
	         byte[] bytes = new byte[1024];
	         try {
	             for(int n ; (n = input.read(bytes))!=-1 ; ){  
	                 buffer.append(new String(bytes,0,n,"GBK"));  
	             }
	         } catch (IOException e) {
	             e.printStackTrace();
	         }
	 //        System.out.println(buffer);
	         return buffer.toString();  
	     }
 public static void main(String[] args) {
	 try {
		 String str=readfile("D:\\bbb.html");//获取html内容
		 System.out.println(str);
		 writeWordFile(str);//html转换成word
	} catch (Exception e1) {
		e1.printStackTrace();
	}
	 
	 }
}


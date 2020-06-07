package cn.com.servyou.qysds.flgl.flglbsk.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;

import cn.com.jdls.foundation.dao.DAOResult;
import cn.com.jdls.foundation.dao.DataRow;
import cn.com.jdls.foundation.dao.DataSet;
import cn.com.jdls.foundation.dao.IDAO;
import cn.com.jdlssoft.rbac.core.Group;
import cn.com.servyou.components.fileio.driver.bean.imp.ImpParam;
import cn.com.servyou.components.fileio.driver.bean.imp.ImpResult;
import cn.com.servyou.components.fileio.imp.fileparse.IFileParser;
import cn.com.servyou.components.fileio.imp.resulthandle.savedata.SimpleSaveDataHandle;
import cn.com.servyou.qysds.flgl.flglbsk.handler.excel_util.Import_Excel;
import cn.com.servyou.qysds.hxgl.util.DaoUtil;

/**
 * <p>
 * 标题: 
 * </p>
 * <p>
 * 描述: 处理各种文件上传
 * </p>
 * <p>
 * 版权:税友软件集团股份有限公司
 * </p>
 * <p>
 * 创建时间: 2018-4-17
 * </p>
 * <p>
 * 作者：shc
 * </p>
 */
public class ExcelUploadLogicHandler extends SimpleSaveDataHandle implements IFileParser {
    /**
     * 记录日志
     */
    private static final Logger LOG = Logger
            .getLogger(ExcelUploadLogicHandler.class);
    
    
    
    
    
    
    
    
    IDAO dao = DaoUtil.getProxyDAO();

    @Override
    public ImpResult parse(ImpParam param) {
        ImpResult ir = new ImpResult();
        File impFile = new File(param.getImpFilePath());
        long fileSize = impFile.length();
        String file_id="";
        String filePath="";
        String file_path="";
        String user_id=param.getModelPath();
        try {
            JSONObject joParam = new JSONObject();
            if(fileSize > 1024 * 1024 * 50) {
                joParam.put("resMsg", "附件大小超过50M限制。");
                FileUtils.deleteQuietly(impFile);
            } else if(param.getImpFileName().length() > 100) {
                joParam.put("resMsg", "附件名称不能超过100个字符。");
            } else {
            	file_path=impFile.getAbsolutePath();
            	file_path = file_path.replaceAll("\\\\", "/");//   /components/fileio/impfile/152600612929529196441/风险模型需求模板.xlsx
            	file_path=file_path.replaceAll("/impfile/", "/impfile/"+user_id+"_");//目录追加user，方便删除文件操作
            	filePath=file_path.substring(file_path.indexOf("components") - 1);
                filePath=filePath.replaceAll("/impfile/", "/mxxq_impfile/");//方案二保存到另一目录:复制后的path
                joParam.put("filePath", filePath);
                joParam.put("resMsg", "");
                joParam.put("filepaths", file_path);//保存全路径方便删除
                file_id=filePath.substring(filePath.indexOf("impfile/")+8,filePath.lastIndexOf("/"));
            }
            
            InputStream is = new FileInputStream(impFile);
            String parames=param.getImpTaskName();
            Map map_parame=joParam.parseObject(parames);
            String type=(String) map_parame.get("type");
            if("save_enclosure".equals(type)){//保存附件到数据库
            // ir=save_enclosure(param,impFile, ir,file_id);//方案1上传到数据库
             ir=save_enclosure1(param,impFile, ir,file_id);//方案二保存到另一目录
             ir.setResultJSON(JSONObject.toJSONString(joParam, SerializerFeature.UseSingleQuotes));
             ir.setHandleMessage(ir.getResultJSON());//ResultJSON返回不到客户端
            }else if("Imp_excel".equals(type)){//解析excel
             ir=ImportExcel(parames, impFile, ir);
            }
        } catch (Exception e) {
            LOG.error("附件上传失败：" + e.getMessage(), e);
            ir.setErrorMessage("附件上传失败。");
        } 
        return ir;
    }
    
    @Override
    public void handle(ImpResult res) {
        System.out.println(111);
    }
    //保存附件
    public ImpResult save_enclosure(ImpParam param,File impFile,ImpResult ir,String fileid){
    	   Map<String,String> result = new HashMap<String, String>();
        //测试上传到数据库   
           //fileid=param.getImpParamStr();
           try {
        	   FileInputStream in=new FileInputStream(impFile);
               String filename=param.getImpFileName();
                filename=impFile.getAbsolutePath();
               
            String driverclass="oracle.jdbc.driver.OracleDriver";
       		String url="jdbc:oracle:thin:@150.12.58.239:1521:gdltfxgl";
       		String username="fxgl";
       		String password="fxgl";
       		Connection con=null;
       		PreparedStatement ps=null;
       		String sql="insert into MXXQ_FILE values (?,?,?)";
       		 Class.forName(driverclass) ;
       		 con=DriverManager.getConnection(url, username, password);
       		 ps=con.prepareStatement(sql);
       		 ps.setString(1,fileid);
       		 ps.setString(2,filename);
       		 ps.setBinaryStream(3,in, in.available());
       		 int rs=ps.executeUpdate();
       		ps.close();
    		con.close();
    		in.close();
    		 result.put("msg","上传成功");
		} catch (Exception e) {
			result.put("msg","上传失败");
		}
          
           String json_str=JSONObject.toJSONString(result, SerializerFeature.UseSingleQuotes);
           ir.setResultJSON(json_str);
          ir.setHandleMessage(ir.getResultJSON());
           return ir;
           
    }
    
    //保存附件1
    public ImpResult save_enclosure1(ImpParam param,File impFile,ImpResult ir,String fileid){
    	   Map<String,String> result = new HashMap<String, String>();
        //保存到另一个文件夹 
    	   try {
        	   FileInputStream in=new FileInputStream(impFile);
               String filename=param.getImpFileName();
               String user_id=param.getModelPath();
               filename=impFile.getAbsolutePath();
                
                
         	    String filePath = impFile.getAbsolutePath();
                filePath = filePath.replaceAll("\\\\", "/");
                filePath=filePath.replaceAll("/impfile/", "/mxxq_impfile/"+user_id+"_");//目录追加user，方便删除文件操作
                String file_mkdir=filePath.substring(0,filePath.lastIndexOf("/"));
                File f=new File(file_mkdir);
                f.mkdirs();//创建一个新的文件夹
                
                
                FileOutputStream out=new FileOutputStream(filePath);
      			//批量读写
      			int b;
      			byte[] by=new byte[1024];
      			while((b=in.read(by))!=-1){
      				out.write(by,0,b);
      			}
      			in.close();
      			out.close();
                
    		 result.put("msg","上传成功");
		} catch (Exception e) {
			result.put("msg","上传失败");
		}
          
    	   
    	 
           
    	   
           String json_str=JSONObject.toJSONString(result, SerializerFeature.UseSingleQuotes);
           ir.setResultJSON(json_str);
          ir.setHandleMessage(ir.getResultJSON());
           return ir;
           
    }
    
    //导入excel
   public ImpResult ImportExcel(String parames,File impFile,ImpResult ir){
	   JSONObject joParam = new JSONObject();
       Map param=joParam.parseObject(parames);
	   String bsk_id=UUID.randomUUID().toString();
	   String bsmc=(String) param.get("bsmc_new");
	   String bsdlid=(String) param.get("bsdl_new");
	   String bsxlid=(String) param.get("bsxl_new");
	   String cjrdm=(String) param.get("user_id");
	   String cjrmc=(String) param.get("user_name");
	   String xgrdm=(String) param.get("user_id");
	   String xgrmc=(String) param.get("user_name");
	   String cjswjgdm=(String) param.get("swjgdm");
	   String swjgmc=(String) param.get("swjgmc");
	   String flglbstj=parames;
	   String ssnd_new=(String) param.get("ssnd_new");
	   String type=(String) param.get("new_type");
	   String bsk_where=(String) param.get("bsk_where");
	   String _bslx=(String) param.get("_bslx");
	   dao.insert("qysds_bsk_insert", DaoUtil.getSqlParam2Dim(
	  bsk_id,bsmc,bsdlid,bsxlid,cjrdm,cjrmc,xgrdm,xgrmc,cjswjgdm,swjgmc,flglbstj,ssnd_new,type,bsk_where,_bslx));
	   
	   Import_Excel ei = new Import_Excel();
		try {
			ei.ExcelImport2(impFile, 1);
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		List<String> list=new ArrayList<String>();
		list.add("xh");list.add("nsrsbh");list.add("nsrmc");
		List<Map<String,String>> list_true=new ArrayList<Map<String,String>>();//保存填写完成的数据
		List<Map<String,String>> list_false=new ArrayList<Map<String,String>>();//必填项未填写
		for (int i = ei.getDataRowNum(); i < ei.getLastDataRowNum()+1; i++) {//开始读取表的每一条（ei.getDataRowNum()-1：从表头开始读取）
			Row row = ei.getRow(i);
			 Map<String,String> result = new HashMap<String, String>();
			 int a=0;
			for (int j = 0; j < ei.getLastCellNum(); j++) {//循环某条数据的每一个值(遍历列）
				String val = ei.getCellValue(row, j)+"";
				String keys=list.get(j);
				val=val.replaceAll(" ", "&nbsp;");
				System.out.print(val+", ");
				result.put(keys, val);
			}
			//result.put("excel_row", i+1+"");//记录excel行数
			String nsrsbh=result.get("nsrsbh");
			DAOResult dr=null;
			dr =dao.select("qysds_find_nsrsbh",DaoUtil.getSqlParam2Dim(nsrsbh));
			Object obj=dr.getResultValue();
			  DataSet ds = dr.toDataSet(0);
			  int counts=ds.getTotalRowNum();
			  if(counts>0){//纳税人识别号存在
				  for (int a1 = 0; a1 < ds.getTotalRowNum(); a1++){
				  DataRow drow = ds.getDataRow(a1);
				  String bskmx_id=UUID.randomUUID().toString();
				  	dao.insert("qysds_bsk_mx_insert", DaoUtil.getSqlParam2Dim(
								bskmx_id,bsk_id
								,drow.getFieldValueByName("NSRSBH"),drow.getFieldValueByName("NSRMC")
								,drow.getFieldValueByName("SWJG_DM"),drow.getFieldValueByName("SWJGMC")
								,bsdlid,bsxlid
								,bsmc,ssnd_new
								,drow.getFieldValueByName("YYSR"),drow.getFieldValueByName("LRZE")
								,drow.getFieldValueByName("SJYNSDSE"),drow.getFieldValueByName("RKJE")
								,drow.getFieldValueByName("NSXYDJ_DM")//,drow.getFieldValueByName("HYSF")
								,drow.getFieldValueByName("DJZCLX_DM"),drow.getFieldValueByName("DJZCLXMC")
								,drow.getFieldValueByName("HY_DM"),drow.getFieldValueByName("HYMC")
								,drow.getFieldValueByName("FDDBRMC"),drow.getFieldValueByName("FDDBRDHHM")
								,drow.getFieldValueByName("CWFZRMC"),drow.getFieldValueByName("CWFZRDHHM")
								,drow.getFieldValueByName("BSRMC"),drow.getFieldValueByName("BSRYDDHHM")
								,drow.getFieldValueByName("ZCDZ"),drow.getFieldValueByName("SCJYDZ")
								,drow.getFieldValueByName("SHXYDM")
								));
				  //String NSRMC=drow.getFieldValueByName("NSRMC"); 
				  }
			  }
			 
			if(counts==0){
				list_false.add(result);
			}else{
				list_true.add(result);
			}
			System.out.print("\n");
		}
		Map<String,Object> map_result=new HashMap<String,Object>();
		map_result.put("list_false",list_false);
		map_result.put("list_true",list_true);
        String json_str=JSONObject.toJSONString(map_result, SerializerFeature.UseSingleQuotes);
        ir.setResultJSON(json_str);
       //ir.setHandleMessage(ir.getResultJSON());//
        ir.setHandleMessage("导入成功");//
       FileUtils.deleteQuietly(impFile); 
       return ir;
   }

}

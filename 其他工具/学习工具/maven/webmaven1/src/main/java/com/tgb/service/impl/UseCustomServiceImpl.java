package com.tgb.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.model.Include_col;
import com.tgb.model.Old_tables;
import com.tgb.model.S_tables;
import com.tgb.model.Theme;
import com.tgb.model.Tsql;
import com.tgb.model.Tusesql;
import com.tgb.model.Use_col;
import com.tgb.model.Use_order;
import com.tgb.model.Use_subject;
import com.tgb.model.Use_where;
import com.tgb.model.Where_col;
import com.tgb.service.UseCustomService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-03
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UseCustomServiceImpl implements UseCustomService {
	
	@Resource
	private UseCustomThemeMapper usecustomthememapper;
	
    private Include_col include;//提取实体对象：包含表字段
    private S_tables STables; //提取实体对象：主题包含表
    private Where_col where_col;
    private Old_tables old_tables;
    
	public Result findcolName(String themeId){
		Result result=new Result();
		int id=Integer.parseInt(themeId);
		List<Include_col> list1=usecustomthememapper.findcolName(id);
		List<Where_col> list2=findCol_c_name(id);
		
		List<Tsql> sqllist=usecustomthememapper.finsql(Integer.parseInt(themeId));
		
		Map map=new HashMap();
		map.put("list1", list1);
		map.put("list2", list2);
		
		Theme theme=usecustomthememapper.findTheme(Integer.parseInt(themeId));
		result.setStatus(Integer.parseInt(theme.getIs_function()));
		result.setData(map);
		result.setMsg(sqllist.get(0).getSql_content());
		return result;
	}
	
	public List<Where_col> findCol_c_name(int themeId){
		List<Where_col> list=usecustomthememapper.findwhere(themeId);
		return list;
	}
	
	
	
	
	
	//*************   保存--新增使用主题所有关联的数据 （使用主题表已新增）  ***************
	public Result  preservation(String sql,String useThemeName,String str1,String createPerson,String str2,String sorts,String themeId,String typeId,String selecta,String selectb,String operation,String conditionValue,String selectd,String connect){
		Integer useThemeId=usecustomthememapper.selectUseName(useThemeName);//使用主题id
		//---- 保存： 使用主题字段表------
		   //str1：页面的使用主题字段id 通过$分割。
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("useThemeId", useThemeId);
		splitStr(str1,"$","a",map);//使用主题字段表
		//----   保存使用主题排序字段
		   //str2排序字段id。sorts：1--升序  2--降序。
		Map<String,Object> map2=new HashMap<String,Object>();
		map2.put("useThemeId", useThemeId);
		map2.put("sorts", sorts);
		splitStr(str2,"$","b",map2);
		
		
		// ------  保存sql条件  ----
		/* var selecta="";//左括号
		   var selectb="";//条件字段的id
		   var operation="";//操作符
		   var conditionValue="";//条件值       --》    "@*&"
		   var selectd="";//右括号 
		   var connect="";//连接符  (=undefined?:null)
        */
		Map<String,Object> map3=new HashMap<String,Object>();
		map3.put("useThemeId", useThemeId);
		map3.put("selecta", selecta);
		map3.put("operation", operation);
		map3.put("conditionValue", conditionValue);
		map3.put("selectd", selectd);
		map3.put("connect", connect);
		map3.put("subject_id", themeId);
		
		
		splitStr(selectb,"$","c",map3);
		
		
		
		//******   保存sql
		Tusesql tusesql=new Tusesql();
		tusesql.setSql_content(sql);
		tusesql.setUse_subject_id(useThemeId);
		usecustomthememapper.addTusesql(tusesql);
		
		
		
		
		
		
		
		Result result=new Result();
		result.setStatus(0);
		return result;
	}
	
	
	
	
	
	
	
	
	
	  //先新增使用主题表
	public Integer useCustom(String useThemeName,String themeId,String typeId,String createPerson){
		//先查询使用主题是否存在
		Integer i=usecustomthememapper.selectUseName(useThemeName);
		if(i!=null){//如果存在直接return
			return i;
		}
		//如果不存在。新增使用主题数据
		 Use_subject useSubject=new Use_subject();
         useSubject.setSetdate(new Date());
         useSubject.setIs_del(0);
         useSubject.setSetman(createPerson);
         useSubject.setSubject_id(Integer.parseInt(themeId));
         //根据主题id查询主题分类id
         Integer typeIds=usecustomthememapper.queryTypeId(Integer.parseInt(themeId));
         useSubject.setType_id(typeIds);
         useSubject.setUse_subject_name(useThemeName);
         usecustomthememapper.addUseSubject(useSubject);
		return -1;
	}
	
	//若使用主题已经存在。先删除所有关联这个使用主题的数据。然后直接新增
	public Result delUseTheme(Integer useThemeId){
		Result result1=new Result();
		usecustomthememapper.deleteUseName(useThemeId);
		usecustomthememapper.deleteUseName1(useThemeId);
		usecustomthememapper.deleteUseName2(useThemeId);
		usecustomthememapper.deleteUseName3(useThemeId);
		usecustomthememapper.deleteUseName4(useThemeId);
		result1.setStatus(-2);
		return result1;
	}
	
	
	
	//拆分字符串
	public void  splitStr(String str,String symbol,String function,Map map){
		
		if("".equals(str)){
			return;
		}
		int a=str.indexOf(symbol);
		String s=str.substring(0,a);
		
		
	//---分割后的id需要执行的代码
		
		int tableid=0;
		if("a".equals(function)||"b".equals(function)){
			
		//提取：根据字段id查询字段中文名英文名等信息
		include=usecustomthememapper.findInclude(Integer.parseInt(s));//根据表字段id查询表字段所有信息
        //提取表名称id：
		tableid=include.getS_tables_id();
		//根据表名称id查询主题包含表的数据
		STables=usecustomthememapper.findSTables(tableid);
		
		}else{//c
			//提取：根据字段id查询字段中文名英文名等信息
			Map map_shc = new HashMap();
			int col_id = Integer.parseInt(s);
			map_shc.put("col_id", col_id);
			map_shc.put("subject_id", map.get("subject_id"));
			//where_col=usecustomthememapper.findwhere2(Integer.parseInt(s)).get(0);//根据表字段id查询表字段所有信息
			where_col=usecustomthememapper.findwhere3(map_shc).get(0);//根据表字段id查询表字段所有信息
	        //提取表名称id：
			tableid=where_col.getS_tables_id();
			//根据表名称id查询主题包含表的数据
			old_tables=usecustomthememapper.findSTables2(tableid);
		}
		
		
		if("a".equals(function)){//****** 保存使用主题 字段 表 ******
			
		Use_col usecol=new Use_col();
		
		usecol.setCol_c_name(include.getCol_c_name());
		//usecol.setCol_e_name(include.getCol_e_name());
		usecol.setCol_e_name(include.getCol_e_name_alias());
		usecol.setInclude_col_id(include.getInclude_col_id());
		usecol.setS_tables_id(tableid);
		usecol.setSubject_id(include.getSubject_id());
		usecol.setUse_subject_id((Integer) map.get("useThemeId"));
		usecustomthememapper.addUseCol(usecol);
		
		String s1=str.substring(a+1);
		splitStr(s1,symbol,function,map);
		
		}else if("b".equals(function)){//*******  保存排序 字段表  ******
			

			String so=(String) map.get("sorts");//排序字段对应的排序方向
			int b=so.indexOf(symbol);//找到分隔符所在的位置
			String sorft=so.substring(0,b);
			
			Use_order useorder=new Use_order();
			
			useorder.setC_name(STables.getC_name());
			useorder.setE_name(STables.getE_name());
			useorder.setCol_c_name(include.getCol_c_name());
			//useorder.setCol_e_name(include.getCol_e_name());
			useorder.setCol_e_name(include.getCol_e_name_alias());
			useorder.setOrder_col_id(include.getInclude_col_id());
			useorder.setOrder_dct(sorft);
			useorder.setSubject_id(include.getSubject_id());
			useorder.setS_tables_id(tableid);
			useorder.setUse_subject_id((Integer) map.get("useThemeId"));
			usecustomthememapper.addorder(useorder);
			
			String s1=str.substring(a+1);
			String sorft1=so.substring(b+1);
			map.put("sorts", sorft1);
			splitStr(s1,symbol,function,map);
			
			
			
			
		}else if("c".equals(function)){//*******  保存sql条件  ******
			
			String s1=(String) map.get("selecta");//**左括号
			int c1=s1.indexOf(symbol);//找到分隔符所在的位置
			String left=s1.substring(0,c1);
			
			String s2=(String) map.get("operation");//**操作符
			int c2=s2.indexOf(symbol);//找到分隔符所在的位置
			String oper=s2.substring(0,c2);
			
			String s3=(String) map.get("conditionValue");//**条件值
			int c3=s3.indexOf("@*&");//找到分隔符所在的位置
			String value=s3.substring(0,c3);
			
			String s4=(String) map.get("selectd");//**右括号 
			int c4=s4.indexOf(symbol);//找到分隔符所在的位置
			String reght=s4.substring(0,c4);
			
			String s5=(String) map.get("connect");//**连接符
			int c5=s5.indexOf(symbol);//找到分隔符所在的位置
			String con=s5.substring(0,c5).equals("undefined")?"":s5.substring(0,c5);
			
			map.put("selecta", s1.substring(c1+1));
			map.put("operation", s2.substring(c2+1));
			map.put("conditionValue", s3.substring(c3+3));
			map.put("selectd", s4.substring(c4+1));
			map.put("connect", s5.substring(c5+1));
			
			
			Use_where useWhere=new Use_where();
			useWhere.setC_name(old_tables.getC_name());
			useWhere.setCol_c_name(where_col.getCol_c_name());
			//useWhere.setCol_e_name(where_col.getCol_e_name());
			useWhere.setCol_e_name(where_col.getCol_e_name_alias());
			useWhere.setCol_value(value);
			useWhere.setConnector(con);
			useWhere.setE_name(old_tables.getE_name());
			useWhere.setInclude_col_id(where_col.getInclude_col_id());
			useWhere.setL_bracket(left);
			useWhere.setOperator(oper);
			useWhere.setR_bracket(reght);
			useWhere.setS_tables_id(tableid);
			useWhere.setSubject_id(where_col.getSubject_id());
			useWhere.setUse_subject_id((Integer) map.get("useThemeId"));
			
			usecustomthememapper.addWhere(useWhere);
			
			
			String ss=str.substring(a+1);
			splitStr(ss,symbol,function,map);
			
		}
		
		
		
	
	}
	
	
	
	
	
	//**********************       根据使用主题id 查询************
	
	public Result allUseName(Integer useThemeId){
		List<Use_col> usecol=usecustomthememapper.queryCol(useThemeId);
		List<Use_order> useorder=usecustomthememapper.queryOrder(useThemeId);
		List<Use_where> usewhere=usecustomthememapper.queryWhere(useThemeId);
		
		Map map=new HashMap();
		map.put("usecol", usecol);
		map.put("useorder", useorder);
		map.put("usewhere", usewhere);
		Result result=new Result();
		result.setData(map);
		result.setStatus(0);
		return result;
	}
	
	public Result testxx(){
		String usecol=usecustomthememapper.testxx();
		Result result=new Result();
		result.setData(usecol);
		result.setStatus(0);
		return result;		
	}	
	
	
	
	
	
}

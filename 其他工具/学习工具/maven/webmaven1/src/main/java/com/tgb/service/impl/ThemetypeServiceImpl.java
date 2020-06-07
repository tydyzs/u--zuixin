package com.tgb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.ThemetypeDao;
import com.tgb.mapper.UseThemeDao;
import com.tgb.model.Theme;
import com.tgb.model.Themetype;
import com.tgb.service.ThemetypeService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class ThemetypeServiceImpl implements ThemetypeService {
	
	@Resource
	private ThemetypeDao Themetypedao;
	@Resource
	private UseThemeDao usethemedao;
	
	private Integer z=0;

	
	
	
	public Result findtype() {//查询所有生成树
		Result result=new Result();
	    List<Themetype> list=Themetypedao.findtype();
	   /* for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).toString());
		}*/
	    result.setData(list);
	    result.setStatus(0);
		return result;
	}

	public Result find(String id) {//查询子节点生成表
		Result result=new Result();
		int i=Integer.parseInt(id);
	    List<Themetype> list=Themetypedao.find(i);
	    result.setData(list);
	    result.setStatus(0);
			return result;
	}

	public Result save(String pId,String name) {//新增节点
		Themetype type=new Themetype();
		Result result=new Result();
		
		int i=Integer.parseInt(pId);
		//int i1=findId(pId)+1;//子节点数目+1
		//String str=""+i+i1;//拼接一个id
		//int id=Integer.parseInt(str);
		//type.setId(id);
		type.setpId(i);
		//type.setCode(code);
		type.setName(name);
		type.setIs_del(0);
	if(Themetypedao.find2(type)!=0){//name 存在了
			result.setStatus(2);
			return result;
		}else{
		Themetypedao.save(type);
		HashMap map=new HashMap();
		map.put("pId", i);
		map.put("typeName", name);
		int id=Themetypedao.findtypeId(map);
		result.setStatus(0);
		result.setData(id);
		return result;
		}
	}

	//删除分类及所有子分类。如果分类或子分类有其他表关联数据，则不删除
	public Result delete(String id) {//删除
		z=0;
		Result result=new Result();
		check(id);//先查看分类下是否有关联数据
		if(z==1){
			result.setStatus(1);
			return result;	
		}else{
		delId(id);//删除分类及下面所有的分类
		result.setStatus(0);
		return result;
		}
	}

	//删除
	public void delId(String typeId){//下拉框：根据主题类型id查询所有下面的主题名称
		   int i=Integer.parseInt(typeId);
		   Themetypedao.delete(i);//删除当前
			List<Integer> cId=usethemedao.findId(i);//查询所有子id
			int a=cId.size();
			if(a!=0){//子id对应所有名称
				for(int j=0;j<cId.size();j++){
					delId(cId.get(j)+"");
			   }
			}
	}
	//查询分类关联的数据
	public void check(String typeId){//下拉框：根据主题类型id查询所有下面的主题名称
		   int i=Integer.parseInt(typeId);
		  // System.out.println(z);
		   //根据i查询是否有关联数据
		  Integer num= usethemedao.checkdata(i);
		   if(num!=0){
			 z=1;
			 return;
		   }
			List<Integer> cId=usethemedao.findId(i);//查询所有子id
			int a=cId.size();
			if(a!=0){//子id对应所有名称
				for(int j=0;j<cId.size();j++){
					check(cId.get(j)+"");
			   }
			}
	}
	
	
	
	
	
	
	public int findId(String pId) {//查询数目用于生成id
		int i=Integer.parseInt(pId);
		int num=Themetypedao.findId(i);
		return num;
	}

	
	
	public Result updateType(String id,String pId,String name){
		Result result=new Result();
		
		Themetype type=new Themetype();
		type.setId(Integer.parseInt(id));
		type.setpId(Integer.parseInt(pId));
		type.setName(name);
		int num=Themetypedao. updateTypes(type);
		if(num>0){
			result.setStatus(1);
			return result;
		}else{
			Themetypedao. updateType(type);
			result.setStatus(0);
			return result;
		}
		
		
	}

	//根据分类ID查询 分类名称
	public Result findTypeName(String id) {
		Result result=new Result();
		List<String> ty = Themetypedao.findTypeName(Integer.parseInt(id));
		String ty2 = ty.get(0);
		result.setStatus(0);
		result.setMsg(ty2);
		return result;
	}

}

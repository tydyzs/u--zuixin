package com.tgb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UseCustomThemeMapper;
import com.tgb.mapper.UseThemeDao;
import com.tgb.model.Theme;
import com.tgb.model.UseTheme;
import com.tgb.service.UseThemeService;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UseThemeServiceImpl implements UseThemeService {
	
	@Resource
	private UseThemeDao usethemedao;
	@Resource
	private UseCustomThemeMapper usecustomthememapper;
	private List<Theme> listTheme=null;
	private List<UseTheme> listuse=null;
   
	
	public Result findUseTheme(String typeId,String name,String themeId){
		Result result=new Result();
		listuse=new ArrayList();
		listuse=findUseTheme1(typeId,name,themeId);	
		result.setData(listuse);
		result.setStatus(0);
		return result;
	}
	
	
	//使用主题表所有数据加载:查询类型id以及子id所有数据(类型id，主题名称，主题id）
	public List<UseTheme> findUseTheme1(String typeId,String name,String themeId) {
		String themeId1="所有名称".equals(name)?null:themeId;
		Map map=new HashMap();
		Integer i=Integer.parseInt(typeId);
		map.put("typeId", i);
		map.put("themeId", themeId1);
		Result result=new Result();
		listuse.addAll(usethemedao.findUseTheme(map));
		
		for(int j=0;j<listuse.size();j++){//给使用主题表中的主题类型和主题名称负值
			
			if(name.equals("所有名称")){
				String themeName=usethemedao.findthemename(listuse.get(j).getSubject_id());
				listuse.get(j).setThemeName(themeName);
			}else{
				listuse.get(j).setThemeName(name);
			}
			String typename=usethemedao.findtypename(listuse.get(j).getType_id());
			listuse.get(j).setTypeName(typename);
		}
		
		List<Integer> cId=usethemedao.findId(i);//查询所有子id
		int a=cId.size();
		if(a!=0){//子id对应所有名称
			for(int j=0;j<cId.size();j++){
				findUseTheme1(cId.get(j)+"",name,themeId);
		   }
		}
		return listuse;
	}

	
	
	
	//主题名称下拉框
	public Result findname(String typeId){
		listTheme=new ArrayList<Theme>();
		listTheme=findname1(typeId);
		Result result=new Result();
		result.setStatus(0);
		result.setData(listTheme);
		return result;
	}
	
	public List<Theme> findname1(String typeId){//下拉框：根据主题类型id查询所有下面的主题名称
		if(Integer.parseInt(typeId)==0){//如果是所有主题就直接查询所有（用于按照日期排序）
			listTheme.addAll(usethemedao.Alltheme());
			return listTheme;
		}else{
		listTheme.addAll(usethemedao.findName(typeId));//类型id对应所有名称
			Integer i=Integer.parseInt(typeId);
			List<Integer> cId=usethemedao.findId(i);//查询所有子id
			int a=cId.size();
			if(a!=0){//子id对应所有名称
				for(int j=0;j<cId.size();j++){
					findname1(cId.get(j)+"");
			   }
			}
		return listTheme;
		}
	}
	
	
	public Result deleteuse(String useId){
		int id=Integer.parseInt(useId);
		Result result=new Result();
		usethemedao.deleteuse(id);
		result.setStatus(0);
		return result;
	}
	
	//根据使用主题名称查询有所
	public Result queryUseTheme(String useName){
		Result result=new Result();
		List<UseTheme> list=usethemedao.queryUseTheme("%"+useName+"%");
       for(int j=0;j<list.size();j++){//给使用主题表中的主题类型和主题名称负值
			String themeName=usethemedao.findthemename(list.get(j).getSubject_id());
			list.get(j).setThemeName(themeName);
			String typename=usethemedao.findtypename(list.get(j).getType_id());
			list.get(j).setTypeName(typename);
		}
		
		result.setStatus(0);
		result.setData(list);
		return result;
	}

	public Result functions(String themeId){
		Result result=new Result();
		Theme theme=usecustomthememapper.findTheme(Integer.parseInt(themeId));
		result.setStatus(Integer.parseInt(theme.getIs_function()));
		return result;
		
	}
	
	//分页
	//主题名称下拉框
		public Result findname_new(Map map){
			listTheme=new ArrayList<Theme>();
			listTheme=findname1_new(map);
			Result result=new Result();
			result.setStatus(0);
			result.setData(listTheme);
			return result;
		}
		
		public List<Theme> findname1_new(Map map){//下拉框：根据主题类型id查询所有下面的主题名称
			if(Integer.parseInt(map.get("typeId").toString())==0){//如果是所有主题就直接查询所有（用于按照日期排序）
				listTheme.addAll(usethemedao.Alltheme_new(map));
				return listTheme;
			}else{
			listTheme.addAll(usethemedao.findName_new(map));//类型id对应所有名称
				Integer i=Integer.parseInt(map.get("typeId").toString());
				List<Integer> cId=usethemedao.findId(i);//查询所有子id
				int a=cId.size();
				if(a!=0){//子id对应所有名称
					for(int j=0;j<cId.size();j++){
						map.put("typeId", cId.get(j)+"");
						findname1_new(map);
				   }
				}
			return listTheme;
			}
		}
		public Result Alltheme_count(){
			int theme_count = usethemedao.Alltheme_count();
			Result result=new Result();
			result.setStatus(0);
			result.setData(theme_count);
			return result;
		}
		public Result AllUsetheme_count(){
			int theme_count = usethemedao.AllUsetheme_count();
			Result result=new Result();
			result.setStatus(0);
			result.setData(theme_count);
			return result;
		}
		//主题名称下拉框
		public Result findUsename_new(Map map){
			listuse=new ArrayList<UseTheme>();
			listuse=findUsename1_new(map);
			Result result=new Result();
			result.setStatus(0);
			result.setData(listuse);
			return result;
		}
		public List<UseTheme> findUsename1_new(Map map){//下拉框：根据主题类型id查询所有下面的主题名称
			if(Integer.parseInt(map.get("typeId").toString())==0){//如果是所有主题就直接查询所有（用于按照日期排序）
				listuse.addAll(usethemedao.AllUsetheme_new(map));
				return listuse;
			}else{
				listuse.addAll(usethemedao.findUseName_new(map));//类型id对应所有名称
				Integer i=Integer.parseInt(map.get("typeId").toString());
				List<Integer> cId=usethemedao.findId(i);//查询所有子id
				int a=cId.size();
				if(a!=0){//子id对应所有名称
					for(int j=0;j<cId.size();j++){
						map.put("typeId", cId.get(j)+"");
						findUsename1_new(map);
				   }
				}
			return listuse;
			}
		}


		public Result Alltheme_only() {
			Result result = new Result();
			List<Map> map = usethemedao.Alltheme_only();
			result.setStatus(0);
			result.setData(map);
			return result;
		}
		//根据主题ID，查询所有使用主题	
		public Result findUseThemeBySubject_id(Map map){
			Result result = new Result();
			List<UseTheme> map_1 = usethemedao.findUseThemeBySubject_id(map);
			result.setStatus(0);
			result.setData(map_1);
			return result;			
		}
}

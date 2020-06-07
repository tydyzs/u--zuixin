package com.tgb.mapper;

import java.util.HashMap;
import java.util.List;

import com.tgb.model.Themetype;
import com.tgb.util.Result;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface ThemetypeDao {

	public List<Themetype> findtype();//查询用于生成树
	public List<Themetype> find(int id);//查询子节点放入表中
	public void save(Themetype type);//新增
	public int findtypeId(HashMap map); //查看刚才
	public void delete(int id);//删除节点
	public Integer findId(int id);//查询数目，便于新增时生成id
	public Integer find2(Themetype type);
	public int updateTypes(Themetype type);//查询当前父id下除了此id其他名称叫这个的数量
	public void updateType(Themetype type);
	public List<String> findTypeName(int typeId);//根据分类ID查询 分类名称
}

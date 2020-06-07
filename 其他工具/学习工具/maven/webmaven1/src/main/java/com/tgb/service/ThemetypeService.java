package com.tgb.service;

import com.tgb.util.Result;

/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */


public interface ThemetypeService {
	public Result findtype();//查询用于生成树
	public Result find(String id);//查询子节点放入表中
	public Result save(String pId ,String name);//新增
	public Result delete(String id);//删除节点
	public int findId(String pId);//查询数目，便于新增时生成id
	public Result updateType(String id,String pId,String name);
	public Result findTypeName(String id);//根据分类ID查询 分类名称
	
	
}

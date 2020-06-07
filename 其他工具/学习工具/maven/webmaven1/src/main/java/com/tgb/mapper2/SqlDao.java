package com.tgb.mapper2;

import java.util.List;
import java.util.Map;

import com.tgb.model.Zspm_data;
import com.tgb.model2.zsxm;
/**
 * 
 * @author 沈焕成
 * date 2016-06-01
 *
 */
public interface SqlDao {

	public List<Object> implementsql(Map map);
	public Integer findnumber(Map map);
	public List<Object> implementsql1(Map map);//单句sql查询加了分页
	public List<zsxm> findzsxm();//添加功能查询树状征收项目
	public List<zsxm> findzspm();//添加功能查询树状征收品目
	public List<zsxm> findgljg();//添加功能查询树状管理机关
	
	public List<String> findtype (Map map);
}

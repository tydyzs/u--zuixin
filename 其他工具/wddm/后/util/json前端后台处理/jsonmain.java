package TestJson;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.google.gson.Gson;

public class jsonmain {

	public static void main(String[] args) {//测试     对象  与  json  之间的转换
		
		Map map=new HashMap();
		map.put("姓名", "张三");
		map.put("年龄", 28);
		map.put("性别", "男");
		
		
		
		
		
		String json=inStr(map);//1.对象 转换成json字符传
		                             //2.json字符串转换成map
		Object map1 = inobj(json);

	}
	
	
	public static String inStr(Object obj){
		Gson gson=new Gson();
		String json=gson.toJson(obj);
		return json;
	}
	
	
	public static Object inobj(String json){
		Object map1 = JSONObject.toBean(JSONObject.fromObject(json),HashMap.class);
		return map1;
	}
	

}

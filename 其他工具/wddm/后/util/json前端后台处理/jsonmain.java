package TestJson;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.google.gson.Gson;

public class jsonmain {

	public static void main(String[] args) {//����     ����  ��  json  ֮���ת��
		
		Map map=new HashMap();
		map.put("����", "����");
		map.put("����", 28);
		map.put("�Ա�", "��");
		
		
		
		
		
		String json=inStr(map);//1.���� ת����json�ַ���
		                             //2.json�ַ���ת����map
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

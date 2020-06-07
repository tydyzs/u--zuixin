package com.tgb.util;

import java.util.HashMap;
import java.util.Map;

public class Is_excel {
	public static Map map=new HashMap();//保存正在导出excel的用户ip和excelname
	public static Map map1=new HashMap();//保存ip和进度
	public static Map getMap() {
		return map;
	}
	public static void setMap(Map map) {
		Is_excel.map = map;
	}
	public static Map getMap1() {
		return map1;
	}
	public static void setMap1(Map map1) {
		Is_excel.map1 = map1;
	}

}

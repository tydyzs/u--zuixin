package com.tgb.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64 {
	 // 解密  
    public  String getStr(String s) {  
        byte[] b = null;  
        String result = null;  
        if (s != null) {  
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return result;  
    }  

    //加密
    public String getBase64(String str){
    	byte[] b=null;
    	String s=null;
    	try {
			b=str.getBytes("utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
    	if(b!=null){
    		s=new BASE64Encoder().encode(b);
    	}
    	return s;
    }
    
}
